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

$targetDir = "document/information/faqs/";
$method = $_SERVER['REQUEST_METHOD'];

// $updated_by = 58; //sso พัง เดี๋ยวมาลบ


function cleanFilename($filename) {
    return uniqid() . "_" . preg_replace("/[^A-Za-z0-9\-_\.]/", '_', basename($filename));
}

if ($method === 'GET') {
    if (isset($_GET['faq_id'])) {
        $faq_id = $_GET['faq_id'];
        $sql = "SELECT id, faq_id, file_name, original_name, uploaded_at FROM faq_files WHERE faq_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $faq_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(["success" => true, "FilesData" => $data]);
        exit; 
    }

    $sql = "SELECT f.*, u.prename, u.name, u.surname FROM faqs f JOIN users u ON u.id = f.updated_by";
    $result = $conn->query($sql);
    if ($result) {
        $data = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(["success" => true, "faqData" => $data]);
    } else {
        echo json_encode(["success" => false, "message" => "Query error", "error" => $conn->error]);
    }
}

if ($method === 'POST') {
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }
    $updated_by = $_SESSION['sess_iauop_user_id'];
    $action = $_POST['action'] ?? '';

    if ($action === 'insert') {
        $title = $_POST['title'];
        $description = $_POST['description'];
        $uploaded_at = $_POST['uploaded_at'];
        $is_active = $_POST['is_active'] ?? 1;

        $stmt = $conn->prepare("INSERT INTO faqs (title, description, uploaded_at, updated_by, is_active) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssii", $title, $description, $uploaded_at, $updated_by, $is_active);
        if ($stmt->execute()) {
            $faq_id = $stmt->insert_id;

            if (!empty($_FILES['files']['name'])) {
                foreach ($_FILES['files']['name'] as $index => $original_name) {
                    $tmp_name = $_FILES['files']['tmp_name'][$index];
                    $new_name = cleanFilename($original_name);
                    if (move_uploaded_file($tmp_name, $targetDir . $new_name)) {
                        $conn->query("INSERT INTO faq_files (faq_id, file_name, original_name, uploaded_at) VALUES ($faq_id, '$new_name', '$original_name', NOW())");
                    }
                }
            }

            echo json_encode(["success" => true]);
        } else {
            echo json_encode(["success" => false, "message" => "Insert failed"]);
        }
    }

    if ($action === 'update') {
        $id = $_POST['id'];
        $title = $_POST['title'];
        $description = $_POST['description'];
        $uploaded_at = $_POST['uploaded_at'];
        $is_active = $_POST['is_active'] ?? 1;

        $stmt = $conn->prepare("UPDATE faqs SET title=?, description=?, uploaded_at=?, updated_by=?, is_active=? WHERE id=?");
        $stmt->bind_param("sssiii", $title, $description, $uploaded_at, $updated_by, $is_active, $id);
        $success = $stmt->execute();

        echo json_encode(["success" => $success]);
    }

    if ($action === 'delete') {
        $id = $_POST['id'];
        $files = $conn->query("SELECT file_name FROM faq_files WHERE faq_id = $id");
        while ($row = $files->fetch_assoc()) {
            $filepath = $targetDir . $row['file_name'];
            if (file_exists($filepath)) unlink($filepath);
        }
        $conn->query("DELETE FROM faq_files WHERE faq_id = $id");
        $conn->query("DELETE FROM faqs WHERE id = $id");
        echo json_encode(["success" => true]);
    }

    if ($action === 'delete_file') {
        $file_id = $_POST['id'];
        $file = $conn->query("SELECT file_name FROM faq_files WHERE id = $file_id")->fetch_assoc();
        if ($file) {
            $filepath = $targetDir . $file['file_name'];
            if (file_exists($filepath)) unlink($filepath);
        }
        $conn->query("DELETE FROM faq_files WHERE id = $file_id");
        echo json_encode(["success" => true]);
    }

    if ($action === 'insert_files') {
        $faq_id = $_POST['faq_id'];
        foreach ($_FILES['files']['name'] as $index => $original_name) {
            $tmp_name = $_FILES['files']['tmp_name'][$index];
            $new_name = cleanFilename($original_name);
            if (move_uploaded_file($tmp_name, $targetDir . $new_name)) {
                $conn->query("INSERT INTO faq_files (faq_id, file_name, original_name, uploaded_at) VALUES ($faq_id, '$new_name', '$original_name', NOW())");
            }
        }
        echo json_encode(["success" => true]);
    }
}
