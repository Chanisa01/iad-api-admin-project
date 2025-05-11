<?php
$allowedOrigins = ['http://localhost:3000'];

if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowedOrigins)) {
    header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
}
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

// ✔️ ตอบ OPTIONS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// ✔️ Start session หลัง preflight
session_name('PHPSESSID');
session_start();

include 'db_connect.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $category_id = isset($_GET['category_id']) ? $_GET['category_id'] : null;
    if ($category_id) {
        $stmt = $conn->prepare("SELECT d.*, u.prename, u.name, u.surname, c.folder_path
                                FROM document d
                                JOIN users u ON d.updated_by = u.id
                                JOIN categories c ON d.category_id = c.id
                                WHERE d.category_id = ?");
        $stmt->bind_param("i", $category_id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result) {
            $rows = $result->fetch_all(MYSQLI_ASSOC);
            echo json_encode(["success" => true, "documentData" => $rows ?: []]);
        } else {
            echo json_encode(["success" => false, "message" => "เกิดข้อผิดพลาดในการดึงข้อมูล", "error" => $conn->error]);
        }
    }
}

if ($method === 'POST') {
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }

    $action = $_POST['action'] ?? '';
    
    if ($action === 'insert') {
        $title = $_POST['title'] ?? null;
        $updated_at = $_POST['updated_at'] ?? null;
        $category_id = $_POST['category_id'] ?? null;
        $is_active = $_POST['is_active'] ?? 1;
        $updated_by = $_SESSION['sess_iauop_user_id'];

        if (!$title || !$updated_at || !$category_id) {
            echo json_encode(["success" => false, "message" => "Missing required fields"]);
            exit;
        }

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

        if (!isset($_FILES['file_name'])) {
            echo json_encode(["success" => false, "message" => "No file uploaded"]);
            exit;
        }

        $file = $_FILES['file_name'];
        $fileExt = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));

        $allowedTypes = ['pdf', 'doc', 'docx', 'xls', 'xlsx'];
        if (!in_array($fileExt, $allowedTypes) || $file['size'] > 5 * 1024 * 1024) {
            echo json_encode(["success" => false, "message" => "Invalid file type or size"]);
            exit;
        }

        $newFileName = 'document_' . time() . '_' . uniqid() . '.' . $fileExt;
        $filePath = $targetDir . $newFileName;

        if (!move_uploaded_file($file['tmp_name'], $filePath)) {
            echo json_encode(["success" => false, "message" => "File upload failed"]);
            exit;
        }

        $stmt = $conn->prepare("INSERT INTO document (title, file_name, uploaded_at, updated_by, category_id, is_active) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssiii", $title, $newFileName, $updated_at, $updated_by, $category_id, $is_active);
        $success = $stmt->execute();

        echo json_encode(["success" => $success, "message" => $success ? "Insert successful" : "Insert failed"]);

    } elseif ($action === 'update') {
        $title = $_POST['title'] ?? '';
        $uploaded_at = $_POST['uploaded_at'] ?? '';
        $id = $_POST['id'] ?? null;
        $category_id = $_POST['category_id'] ?? null;
        $is_active = isset($_POST['is_active']) ? (int)$_POST['is_active'] : 0;
        $updated_by = $_SESSION['sess_iauop_user_id'];

        if (!$title || !$uploaded_at || !$id || !$category_id) {
            echo json_encode(["success" => false, "message" => "Missing required fields"]);
            exit;
        }

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
            $allowedTypes = ['pdf', 'doc', 'docx', 'xls', 'xlsx'];
            if (!in_array($fileExt, $allowedTypes) || $file['size'] > 5 * 1024 * 1024) {
                echo json_encode(["success" => false, "message" => "Invalid file type or size"]);
                exit;
            }

            $stmt = $conn->prepare("SELECT file_name FROM document WHERE id = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $oldFile = $result->fetch_assoc();
            if ($oldFile && file_exists($targetDir . $oldFile['file_name'])) {
                unlink($targetDir . $oldFile['file_name']);
            }

            $newFileName = 'document_' . time() . '_' . uniqid() . '.' . $fileExt;
            move_uploaded_file($file['tmp_name'], $targetDir . $newFileName);

            $stmt = $conn->prepare("UPDATE document SET title=?, file_name=?, uploaded_at=?, is_active=?, updated_by=? WHERE id=?");
            $stmt->bind_param("sssiii", $title, $newFileName, $uploaded_at, $is_active, $updated_by, $id);
        } else {
            $stmt = $conn->prepare("UPDATE document SET title=?, uploaded_at=?, is_active=?, updated_by=? WHERE id=?");
            $stmt->bind_param("sssii", $title, $uploaded_at, $is_active, $updated_by, $id);
        }

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "Update successful"]);
        } else {
            echo json_encode(["success" => false, "message" => "Update failed", "error" => $stmt->error]);
        }
    } elseif ($action === 'delete') {
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
            echo json_encode(["success" => false, "message" => "ไม่พบข้อมูล"]);
            exit;
        }

        $stmt = $conn->prepare("SELECT folder_path FROM categories WHERE id = ?");
        $stmt->bind_param("i", $document['category_id']);
        $stmt->execute();
        $result = $stmt->get_result();
        $category = $result->fetch_assoc();

        if ($category) {
            $filePath = "document/" . $category['folder_path'] . "/" . $document['file_name'];
            if (file_exists($filePath)) {
                unlink($filePath);
            }
        }

        $stmt = $conn->prepare("DELETE FROM document WHERE id = ?");
        $stmt->bind_param("i", $id);
        $success = $stmt->execute();

        echo json_encode(["success" => $success, "message" => $success ? "ลบสำเร็จ" : "ไม่สามารถลบข้อมูลได้"]);

    } else {
        echo json_encode(["success" => false, "message" => "Invalid action"]);
    }
}
