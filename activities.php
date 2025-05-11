<?php
// ================== Header ==================
$allowedOrigins = ['http://localhost:3000'];

if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowedOrigins)) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
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

// ================== GET Activities ==================
if ($method === 'GET') {
    $category_id = $_GET['category_id'] ?? null;

    if (!$category_id) {
        echo json_encode(["success" => false, "message" => "Missing category_id"]);
        exit;
    }

    $stmt = $conn->prepare("SELECT a.*, u.prename, u.name, u.surname, c.folder_path 
                            FROM activities a 
                            JOIN users u ON a.updated_by = u.id 
                            JOIN categories c ON a.category_id = c.id 
                            WHERE a.category_id = ?");
    if ($stmt === false) {
        echo json_encode(["success" => false, "message" => "Prepare failed", "error" => $conn->error]);
        exit;
    }

    $stmt->bind_param("i", $category_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $activities = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode(["success" => true, "activitiesData" => $activities ?: []]);
    exit;
}

// ================== POST Actions ==================
if ($method === 'POST') {
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }

    $action = $_POST['action'] ?? '';

    if ($action === 'insert' || $action === 'update') {
        $id = $_POST['id'] ?? null;
        $title = $_POST['title'] ?? null;
        $description = $_POST['description'] ?? '';
        $uploaded_at = $_POST['uploaded_at'] ?? null;
        $category_id = $_POST['category_id'] ?? null;
        $is_active = isset($_POST['is_active']) ? intval($_POST['is_active']) : 0;
        $updated_by = $_SESSION['sess_iauop_user_id'];

        if (!$title || !$uploaded_at || !$category_id) {
            echo json_encode(["success" => false, "message" => "Missing required fields"]);
            exit;
        }

        $stmt = $conn->prepare("SELECT folder_path FROM categories WHERE id = ?");
        $stmt->bind_param("i", $category_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $category = $result->fetch_assoc();

        if (!$category) {
            echo json_encode(["success" => false, "message" => "Invalid category"]);
            exit;
        }

        $imgFolder = 'img/' . $category['folder_path'] . '/';
        $docFolder = 'document/' . $category['folder_path'] . '/';

        if (!is_dir($imgFolder)) mkdir($imgFolder, 0777, true);
        if (!is_dir($docFolder)) mkdir($docFolder, 0777, true);

        if ($action === 'insert') {
            if (!isset($_FILES['cover'])) {
                echo json_encode(["success" => false, "message" => "Missing cover image"]);
                exit;
            }
            
            $cover = $_FILES['cover'];
            $coverExt = strtolower(pathinfo($cover['name'], PATHINFO_EXTENSION));
            $newCoverName = uniqid('cover_') . '.' . $coverExt;
            move_uploaded_file($cover['tmp_name'], $imgFolder . $newCoverName);

            $stmt = $conn->prepare("INSERT INTO activities (category_id, title, cover, description, uploaded_at, updated_by, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("issssii", $category_id, $title, $newCoverName, $description, $uploaded_at, $updated_by, $is_active);

            if ($stmt->execute()) {
                $activities_id = $stmt->insert_id;
                handleUploadImagesAndFiles($activities_id, $imgFolder, $docFolder);
                echo json_encode(["success" => true, "message" => "Insert successful"]);
            } else {
                echo json_encode(["success" => false, "message" => "Insert failed", "error" => $stmt->error]);
            }
        } else if ($action === 'update' && $id) {
            // ดึงชื่อภาพเดิมที่ส่งมาจาก React
            $existingCover = $_POST['existing_cover'] ?? '';
            $newCoverName = $existingCover;

            // ถ้ามีการอัปโหลดภาพใหม่
            if (isset($_FILES['cover']) && $_FILES['cover']['error'] === 0) {
                // ลบไฟล์ภาพเก่า
                if (!empty($existingCover)) {
                    $oldCoverPath = $imgFolder . $existingCover;
                    if (file_exists($oldCoverPath)) {
                        unlink($oldCoverPath);
                    }
                }

                // สร้างชื่อใหม่และบันทึกไฟล์ใหม่
                $cover = $_FILES['cover'];
                $coverExt = strtolower(pathinfo($cover['name'], PATHINFO_EXTENSION));
                $newCoverName = uniqid('cover_') . '.' . $coverExt;
                move_uploaded_file($cover['tmp_name'], $imgFolder . $newCoverName);
            }

            // อัปเดตฐานข้อมูล
            $stmt = $conn->prepare("UPDATE activities SET title=?, description=?, uploaded_at=?, category_id=?, cover=?, updated_by=?, is_active=? WHERE id=?");
            $stmt->bind_param("ssssssii", $title, $description, $uploaded_at, $category_id, $newCoverName, $updated_by, $is_active, $id);

            if ($stmt->execute()) {
                echo json_encode(["success" => true, "message" => "Update successful"]);
            } else {
                echo json_encode(["success" => false, "message" => "Update failed", "error" => $stmt->error]);
            }
            exit;
        }
        exit;
    }

    if ($action === 'delete') {
        $activity_id = $_POST['activity_id'] ?? null;

        if (!$activity_id) {
            echo json_encode(["success" => false, "message" => "Missing activity_id"]);
            exit;
        }

        mysqli_begin_transaction($conn);

        try {
            $stmt = $conn->prepare("SELECT c.folder_path, af.file_name, ai.image_name, a.cover FROM activities a JOIN categories c ON a.category_id = c.id LEFT JOIN activities_files af ON af.activities_id = a.id LEFT JOIN activities_images ai ON ai.activities_id = a.id WHERE a.id = ?");
            $stmt->bind_param("i", $activity_id);
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                if ($row['file_name']) unlink('document/' . $row['folder_path'] . '/' . $row['file_name']);
                if ($row['image_name']) unlink('img/' . $row['folder_path'] . '/' . $row['image_name']);
                if ($row['cover']) unlink('img/' . $row['folder_path'] . '/' . $row['cover']);
            }

            $conn->query("DELETE FROM activities_files WHERE activities_id = $activity_id");
            $conn->query("DELETE FROM activities_images WHERE activities_id = $activity_id");
            $conn->query("DELETE FROM activities WHERE id = $activity_id");

            mysqli_commit($conn);
            echo json_encode(["success" => true, "message" => "Delete successful"]);
        } catch (Exception $e) {
            mysqli_rollback($conn);
            echo json_encode(["success" => false, "message" => "Delete failed", "error" => $e->getMessage()]);
        }
        exit;
    }

    echo json_encode(["success" => false, "message" => "Invalid action"]);
    exit;
}

http_response_code(405);
echo json_encode(["success" => false, "message" => "Method Not Allowed"]);
exit;

function handleUploadImagesAndFiles($activities_id, $imgFolder, $docFolder) {
    global $conn;

    if (isset($_FILES['images'])) {
        foreach ($_FILES['images']['tmp_name'] as $key => $tmp_name) {
            if ($_FILES['images']['error'][$key] === 0) {
                $ext = strtolower(pathinfo($_FILES['images']['name'][$key], PATHINFO_EXTENSION));
                $newName = uniqid('img_') . '.' . $ext;
                move_uploaded_file($tmp_name, $imgFolder . $newName);

                $stmtImg = $conn->prepare("INSERT INTO activities_images (activities_id, image_name, original_name) VALUES (?, ?, ?)");
                $stmtImg->bind_param("iss", $activities_id, $newName, $_FILES['images']['name'][$key]);
                $stmtImg->execute();
            }
        }
    }

    if (isset($_FILES['files'])) {
        foreach ($_FILES['files']['tmp_name'] as $key => $tmp_name) {
            if ($_FILES['files']['error'][$key] === 0) {
                $ext = strtolower(pathinfo($_FILES['files']['name'][$key], PATHINFO_EXTENSION));
                $newName = uniqid('file_') . '.' . $ext;
                move_uploaded_file($tmp_name, $docFolder . $newName);

                $stmtFile = $conn->prepare("INSERT INTO activities_files (activities_id, file_name, original_name) VALUES (?, ?, ?)");
                $stmtFile->bind_param("iss", $activities_id, $newName, $_FILES['files']['name'][$key]);
                $stmtFile->execute();
            }
        }
    }
}
?>
