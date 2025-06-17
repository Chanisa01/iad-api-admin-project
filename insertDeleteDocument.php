<?php
// ✅ 1. ตั้งค่า CORS อย่างถูกต้อง
$config = include __DIR__ . '/config_cors.php';
$allowedOrigins = $config['ALLOWED_ORIGINS'];

$origin = $_SERVER['HTTP_ORIGIN'] ?? '';

if (in_array(rtrim($origin, '/'), $allowedOrigins)) {
    header("Access-Control-Allow-Origin: $origin");
}
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

// ✅ 2. ถ้าเป็น OPTIONS (preflight request) ให้ตอบ 204 แล้วจบตรงนี้
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// ✅ 3. Start session หลังจากผ่าน preflight
session_name('PHPSESSID');
session_start();
include 'db_connect.php';

// ✅ 4. เปิดการแสดง Error (สำหรับ Debug)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// ✅ 5. เช็ก Method ต้องเป็น POST เท่านั้น
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["success" => false, "message" => "Invalid request method"]);
    exit;
}

// ✅ 6. เช็กว่ามี session ผู้ใช้งานอยู่ไหม
if (!isset($_SESSION['sess_iauop_user_id'])) {
    echo json_encode(["success" => false, "message" => "No active session"]);
    exit;
}

// ✅ 7. เริ่มการทำงานหลัก
$action = $_POST['action'] ?? null;

if (!$action) {
    echo json_encode(["success" => false, "message" => "Missing action"]);
    exit;
}

if ($action === 'insert') {
    // 📋 กรณี Insert ข้อมูลใหม่
    $title = $_POST['title'] ?? null;
    $updated_at = $_POST['updated_at'] ?? null;
    $category_id = $_POST['category_id'] ?? null;
    $is_active = $_POST['is_active'];
    $updated_by = $_SESSION['sess_iauop_user_id'];
    $uploaded_by = $updated_by; // คนเดียวกัน

    // เช็กข้อมูลจำเป็น
    if (!$title || !$updated_at || !$category_id) {
        echo json_encode(["success" => false, "message" => "Missing required fields"]);
        exit;
    }

    // เช็กไฟล์
    if (!isset($_FILES['file_name'])) {
        echo json_encode(["success" => false, "message" => "No file uploaded"]);
        exit;
    }

    $file = $_FILES['file_name'];
    $fileExt = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));

    if ($fileExt !== 'pdf' || $file['size'] > 5 * 1024 * 1024) {
        echo json_encode(["success" => false, "message" => "Invalid file type or size"]);
        exit;
    }

    // หาโฟลเดอร์ปลายทาง
    $stmt = $conn->prepare("SELECT folder_path FROM categories WHERE id = ?");
    $stmt->bind_param("i", $category_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $folder = $result->fetch_assoc();

    if (!$folder) {
        echo json_encode(["success" => false, "message" => "Invalid category ID"]);
        exit;
    }

    $targetDir = "document/" . $folder['folder_path'] . "/";
    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0777, true);
    }

    $newFileName = 'document_' . time() . '_' . uniqid() . '.' . $fileExt;
    $filePath = $targetDir . $newFileName;

    if (!move_uploaded_file($file['tmp_name'], $filePath)) {
        echo json_encode(["success" => false, "message" => "File upload failed"]);
        exit;
    }

    // Insert ข้อมูล
    $stmt = $conn->prepare("INSERT INTO document 
        (title, file_name, uploaded_at, updated_by, uploaded_by, category_id, is_active) 
        VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssiiii", $title, $newFileName, $updated_at, $updated_by, $uploaded_by, $category_id, $is_active);
    $success = $stmt->execute();

    if ($success) {
        echo json_encode(["success" => true, "message" => "Insert successful"]);
    } else {
        echo json_encode(["success" => false, "message" => "Insert failed", "error" => $stmt->error]);
    }
    exit;
}

elseif ($action === 'delete') {
    // 📋 กรณี Delete
    $id = $_POST['id'] ?? null;

    if (!$id) {
        echo json_encode(["success" => false, "message" => "Missing ID"]);
        exit;
    }

    $stmt = $conn->prepare("SELECT file_name, category_id FROM document WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    $document = $result->fetch_assoc();

    if (!$document) {
        echo json_encode(["success" => false, "message" => "Document not found"]);
        exit;
    }

    $stmt = $conn->prepare("SELECT folder_path FROM categories WHERE id = ?");
    $stmt->bind_param("i", $document['category_id']);
    $stmt->execute();
    $result = $stmt->get_result();
    $category = $result->fetch_assoc();

    if (!$category) {
        echo json_encode(["success" => false, "message" => "Category not found"]);
        exit;
    }

    $filePath = "document/" . $category['folder_path'] . "/" . $document['file_name'];
    if (file_exists($filePath)) {
        unlink($filePath);
    }

    $stmt = $conn->prepare("DELETE FROM document WHERE id = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Delete successful"]);
    } else {
        echo json_encode(["success" => false, "message" => "Delete failed"]);
    }
    exit;
}

// ถ้าไม่ตรง action ที่รองรับ
echo json_encode(["success" => false, "message" => "Invalid action"]);
exit;
?>
