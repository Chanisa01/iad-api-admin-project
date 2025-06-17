<?php
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

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

session_name('PHPSESSID');
session_start();
include 'db_connect.php';
error_reporting(E_ALL);
ini_set('display_errors', 1);

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $category_id = $_GET['category_id'] ?? null;
    if ($category_id) {
        $stmt = $conn->prepare("
            SELECT d.*, u.prename, u.name, u.surname, c.folder_path 
            FROM document_composition d
            JOIN users u ON d.updated_by = u.id
            JOIN categories c ON d.category_id = c.id
            WHERE d.category_id = ?
        ");
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
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }

    $action = $_POST['action'] ?? null;
    if (!$action) {
        echo json_encode(["success" => false, "message" => "Missing action"]);
        exit;
    }

    $updated_by = $_SESSION['sess_iauop_user_id'];

    if ($action === 'insert') {
        $title = $_POST['title'] ?? null;
        $uploaded_at = $_POST['uploaded_at'] ?? null;
        $category_id = $_POST['category_id'] ?? null;
        $is_active = $_POST['is_active'] ?? 0;
        $group_year_start = $_POST['group_year_start'] ?? null;
        $group_year_end = $_POST['group_year_end'] ?? null;

        if (!$title || !$uploaded_at || !$category_id || !$group_year_start || !$group_year_end) {
            echo json_encode(["success" => false, "message" => "Missing required fields"]);
            exit;
        }

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
        if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);

        $newFileName = 'document_' . time() . '_' . uniqid() . '.' . $fileExt;
        $filePath = $targetDir . $newFileName;
        if (!move_uploaded_file($file['tmp_name'], $filePath)) {
            echo json_encode(["success" => false, "message" => "File upload failed"]);
            exit;
        }

        $stmt = $conn->prepare("INSERT INTO document_composition 
            (title, file_name, uploaded_at, category_id, is_active, group_year_start, group_year_end, updated_by) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssiiiii", $title, $newFileName, $uploaded_at, $category_id, $is_active, $group_year_start, $group_year_end, $updated_by);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "Insert successful"]);
        } else {
            echo json_encode(["success" => false, "message" => "Insert failed", "error" => $stmt->error]);
        }
        exit;
    }

    elseif ($action === 'delete') {
        $id = $_POST['id'] ?? null;
        if (!$id) {
            echo json_encode(["success" => false, "message" => "Missing ID"]);
            exit;
        }

        $stmt = $conn->prepare("SELECT file_name, category_id FROM document_composition WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $document = $stmt->get_result()->fetch_assoc();
        if (!$document) {
            echo json_encode(["success" => false, "message" => "Document not found"]);
            exit;
        }

        $stmt = $conn->prepare("SELECT folder_path FROM categories WHERE id = ?");
        $stmt->bind_param("i", $document['category_id']);
        $stmt->execute();
        $folder = $stmt->get_result()->fetch_assoc();
        $filePath = "document/" . $folder['folder_path'] . "/" . $document['file_name'];
        if (file_exists($filePath)) unlink($filePath);

        $stmt = $conn->prepare("DELETE FROM document_composition WHERE id = ?");
        $stmt->bind_param("i", $id);
        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "Delete successful"]);
        } else {
            echo json_encode(["success" => false, "message" => "Delete failed"]);
        }
        exit;
    }

    else {
        // ✅ update
        $id = $_POST['id'] ?? null;
        $title = $_POST['title'] ?? null;
        $uploaded_at = $_POST['uploaded_at'] ?? null;
        $category_id = $_POST['category_id'] ?? null;
        $is_active = $_POST['is_active'] ?? 0;
        $group_year_start = $_POST['group_year_start'] ?? null;
        $group_year_end = $_POST['group_year_end'] ?? null;

        if (!$id || !$title || !$uploaded_at || !$category_id) {
            echo json_encode(["success" => false, "message" => "Missing required fields"]);
            exit;
        }

        $stmt = $conn->prepare("SELECT folder_path FROM categories WHERE id = ?");
        $stmt->bind_param("i", $category_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $folder = $result->fetch_assoc();

        $targetDir = "document/" . $folder['folder_path'] . "/";
        if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);

        if (!empty($_FILES['file_name']['name'])) {
            $file = $_FILES['file_name'];
            $fileExt = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
            if ($fileExt !== 'pdf' || $file['size'] > 5 * 1024 * 1024) {
                echo json_encode(["success" => false, "message" => "Invalid file type or size"]);
                exit;
            }

            // ลบไฟล์เดิม
            $stmt = $conn->prepare("SELECT file_name FROM document_composition WHERE id = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $old = $result->fetch_assoc();
            if ($old && file_exists($targetDir . $old['file_name'])) {
                unlink($targetDir . $old['file_name']);
            }

            $newFileName = 'document_' . $id . '_' . uniqid() . '.' . $fileExt;
            $filePath = $targetDir . $newFileName;
            if (!move_uploaded_file($file['tmp_name'], $filePath)) {
                echo json_encode(["success" => false, "message" => "File upload failed"]);
                exit;
            }

            $stmt = $conn->prepare("UPDATE document_composition 
                SET title=?, file_name=?, uploaded_at=?, is_active=?, group_year_start=?, group_year_end=?, updated_by=?
                WHERE id=? AND category_id=?");
            $stmt->bind_param("sssiiiiii", $title, $newFileName, $uploaded_at, $is_active, $group_year_start, $group_year_end, $updated_by, $id, $category_id);
        } else {
            $stmt = $conn->prepare("UPDATE document_composition 
                SET title=?, uploaded_at=?, is_active=?, group_year_start=?, group_year_end=?, updated_by=?
                WHERE id=? AND category_id=?");
            $stmt->bind_param("ssiiiiii", $title, $uploaded_at, $is_active, $group_year_start, $group_year_end, $updated_by, $id, $category_id);
        }

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "Update successful"]);
        } else {
            echo json_encode(["success" => false, "message" => "Update failed", "error" => $stmt->error]);
        }
        exit;
    }
}

echo json_encode(["success" => false, "message" => "Invalid request method"]);
exit;
?>
