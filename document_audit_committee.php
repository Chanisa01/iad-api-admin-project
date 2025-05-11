<?php
// ✅ รองรับ CORS
$allowedOrigins = ['http://localhost:3000'];

if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowedOrigins)) {
    header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
}
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

// ✅ ถ้าเป็น OPTIONS (preflight) ให้ตอบ 204 แล้วจบเลย
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// ✅ Start session หลังผ่าน preflight
session_name('PHPSESSID');
session_start();

include 'db_connect.php';

// ✅ เปิด error
error_reporting(E_ALL);
ini_set('display_errors', 1);

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $category_id = isset($_GET['category_id']) ? $_GET['category_id'] : null;
    if ($category_id) {
        $sql = "SELECT d.*, u.prename, u.name, u.surname, c.folder_path
                FROM document d
                JOIN users u ON d.updated_by = u.id
                JOIN categories c ON d.category_id = c.id
                WHERE d.category_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $category_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $rows = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(["success" => true, "documentData" => $rows ?: []]);
    } else {
        echo json_encode(["success" => false, "message" => "Missing category_id"]);
    }
    exit;
}

if ($method === 'POST') {
    // ✅ ต้องมี session user ก่อน
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }

    $title = $_POST['title'] ?? null;
    $category_id = $_POST['category_id'] ?? null;
    $id = $_POST['id'] ?? null;
    $uploaded_at = $_POST['uploaded_at'] ?? null;
    $updated_by = $_SESSION['sess_iauop_user_id'];
    $is_active = $_POST['is_active'];

    if (!$category_id || !$id || !$uploaded_at) {
        echo json_encode(["success" => false, "message" => "Missing required fields"]);
        exit;
    }

    // หาที่เก็บไฟล์
    $stmt = $conn->prepare("SELECT folder_path FROM categories WHERE id = ?");
    $stmt->bind_param("i", $category_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $folder = $result->fetch_assoc();

    if (!$folder) {
        echo json_encode(["success" => false, "message" => "Invalid category_id"]);
        exit;
    }

    $targetDir = "document/" . $folder['folder_path'] . "/";
    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0777, true);
    }

    if (!empty($_FILES['file_name']['name'])) {
        $file = $_FILES['file_name'];
        $fileExt = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));

        if ($fileExt !== 'pdf' || $file['size'] > 5 * 1024 * 1024) {
            echo json_encode(["success" => false, "message" => "Invalid file type or size"]);
            exit;
        }

        // หาไฟล์เก่า
        $stmt = $conn->prepare("SELECT file_name FROM document WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $oldFile = $result->fetch_assoc();

        if ($oldFile && file_exists($targetDir . $oldFile['file_name'])) {
            unlink($targetDir . $oldFile['file_name']);
        }

        // ตั้งชื่อไฟล์ใหม่
        $newFileName = 'document_' . $id . '_' . uniqid() . '.' . $fileExt;
        $filePath = $targetDir . $newFileName;

        if (!move_uploaded_file($file['tmp_name'], $filePath)) {
            echo json_encode(["success" => false, "message" => "File upload failed"]);
            exit;
        }

        $stmt = $conn->prepare("UPDATE document SET title = ?, file_name = ?, uploaded_at = ?, updated_by = ?, is_active = ? WHERE id = ? AND category_id = ?");
        $stmt->bind_param("sssiiii", $title, $newFileName, $uploaded_at, $updated_by, $is_active, $id, $category_id);
    } else {
        $stmt = $conn->prepare("UPDATE document SET title = ?, uploaded_at = ?, updated_by = ?, is_active = ?  WHERE id = ? AND category_id = ?");
        $stmt->bind_param("sssiii", $title, $uploaded_at, $updated_by, $is_active, $id, $category_id);
    }

    $success = $stmt->execute();

    if ($success) {
        echo json_encode(["success" => true, "message" => "Update successful"]);
    } else {
        echo json_encode(["success" => false, "message" => "Update failed", "error" => $stmt->error]);
    }
    exit;
}

// ไม่ตรง GET หรือ POST
echo json_encode(["success" => false, "message" => "Invalid request method"]);
exit;
?>
