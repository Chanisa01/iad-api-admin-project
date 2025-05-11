<?php
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
    // เปิดการแสดง Error (สำหรับ Debug)
    // error_reporting(E_ALL);
    // ini_set('display_errors', 1);

    $method = $_SERVER['REQUEST_METHOD'];
    if ($method === 'GET') {
        $activities_id = isset($_GET['activities_id']) ? $_GET['activities_id'] : null;
        if ($activities_id) {
            $sql = "SELECT af.*, a.title, u.prename, u.name, u.surname, c.folder_path
                    FROM activities_files af
                    JOIN activities a ON af.activities_id = a.id
                    JOIN users u ON a.updated_by = u.id
                    JOIN categories c ON a.category_id = c.id
                    WHERE af.activities_id = $activities_id;";
            $result = $conn->query($sql);

            if ($result) {
                $rows = $result->fetch_all(MYSQLI_ASSOC);
                echo json_encode(["success" => true, "FilesData" => $rows ?: []]);
            } else {
                echo json_encode(["success" => false, "message" => "เกิดข้อผิดพลาดในการดึงข้อมูล", "error" => $conn->error]);
            }
        }
    }

    if($method === 'POST'){
        if (!isset($_SESSION['sess_iauop_user_id'])) {
            echo json_encode(["success" => false, "message" => "No active session"]);
            exit;
        }
        // file_put_contents("debug_input.txt", json_encode($input));
        $action = $_POST['action'] ?? '';
        
        if ($action === 'insert') {
            $activities_id = $_POST['activities_id'] ?? null;

            if (!$activities_id) {
                echo json_encode(["success" => false, "message" => "Missing activities_id"]);
                exit;
            }

            if (!isset($_FILES['files'])) {
                echo json_encode(["success" => false, "message" => "No files uploaded"]);
                exit;
            }

            // ตรวจสอบข้อมูลบทความเพื่อหาหมวดหมู่และโฟลเดอร์
            $stmt = $conn->prepare("
                SELECT a.id, a.category_id, c.folder_path
                FROM activities a
                JOIN categories c ON a.category_id = c.id
                WHERE a.id = ?
            ");
            $stmt->bind_param("i", $activities_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $activities = $result->fetch_assoc();

            if (!$activities) {
                echo json_encode(["success" => false, "message" => "ไม่พบบทความนี้"]);
                exit;
            }

            if (!isset($_FILES['files'])) {
                echo json_encode(["success" => false, "message" => "No files uploaded"]);
                exit;
            }

            // สร้าง path และชื่อไฟล์
            $uploadDir = "document/" . $activities['folder_path'];
            if (!is_dir($uploadDir)) {
                mkdir($uploadDir, 0777, true);
            }

            $successCount = 0;
            $errors = [];

            foreach ($_FILES['files']['tmp_name'] as $key => $tmpName) {
                $originalName = $_FILES['files']['name'][$key];
                $error = $_FILES['files']['error'][$key];
        
                if ($error !== UPLOAD_ERR_OK) {
                    $errors[] = "เกิดข้อผิดพลาดในการอัปโหลดไฟล์: $originalName";
                    continue;
                }
                $allowedExtensions = ['pdf'];
                $extension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
                
                if (!in_array($extension, $allowedExtensions)) {
                    $errors[] = "ไฟล์ไม่รองรับ: $originalName";
                    continue;
                }
        
                $newFileName = uniqid('file_') . '.' . $extension;
                $targetPath = $uploadDir . $newFileName;
        
                if (!move_uploaded_file($tmpName, $targetPath)) {
                    $errors[] = "ไม่สามารถบันทึกไฟล์: $originalName";
                    continue;
                }
        
                // บันทึกลงฐานข้อมูล
                $stmt = $conn->prepare("
                    INSERT INTO activities_files (activities_id, original_name, file_name)
                    VALUES (?, ?, ?)
                ");
                $stmt->bind_param("iss", $activities_id, $originalName, $newFileName);
        
                if ($stmt->execute()) {
                    $successCount++;
                } else {
                    $errors[] = "บันทึกฐานข้อมูลล้มเหลว: $originalName";
                }
            }
        
            if ($successCount > 0) {
                echo json_encode([
                    "success" => true,
                    "message" => "อัปโหลดสำเร็จ $successCount ไฟล์",
                    "errors" => $errors
                ]);
            } else {
                echo json_encode([
                    "success" => false,
                    "message" => "ไม่สามารถอัปโหลดไฟล์ได้",
                    "errors" => $errors
                ]);
            }
        } elseif ($action === 'delete'){
            $id = $_POST['id'] ?? null;

            if (!$id) {
                echo json_encode(["success" => false, "message" => "Missing ID"]);
                exit;
            }
    
            $stmt = $conn->prepare("
                SELECT af.id AS file_id, af.*, a.title, a.category_id, c.folder_path
                FROM activities_files af
                JOIN activities a ON af.activities_id = a.id
                JOIN categories c ON a.category_id = c.id
                WHERE af.id = ?
            ");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $fileData  = $result->fetch_assoc();

            if (!$fileData) {
                echo json_encode(["success" => false, "message" => "ไม่พบข้อมูลไฟล์"]);
                exit;
            }

            $filePath = "document/" . $fileData ['folder_path'] . $fileData ['file_name'];

            if (file_exists($filePath)) {
                unlink($filePath);
            }

            $deleteStmt = $conn->prepare("DELETE FROM activities_files WHERE id = ?");
            $deleteStmt->bind_param("i", $id);

            if ($deleteStmt->execute()) {
                echo json_encode(["success" => true, "message" => "ลบภาพเรียบร้อยแล้ว"]);
            } else {
                echo json_encode(["success" => false, "message" => "ลบไม่สำเร็จ"]);
            }

        } else {
            echo json_encode(["success" => false, "message" => "Invalid action"]);
        }
    }

?>
