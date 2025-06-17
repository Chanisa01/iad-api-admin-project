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
    // เปิดการแสดง Error (สำหรับ Debug)
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    $method = $_SERVER['REQUEST_METHOD'];
    if ($method === 'GET') {
        $activities_id = isset($_GET['activities_id']) ? $_GET['activities_id'] : null;
        if ($activities_id) {
            // $sql = "SELECT ai.*, a.title
            //         FROM activities_images ai
            //         JOIN activities a ON ai.activities_id = a.id
            //         WHERE ai.activities_id = $activities_id";
            // $result = $conn->query($sql);

            $stmt = $conn->prepare("SELECT ai.*, a.title 
                                    FROM activities_images ai 
                                    JOIN activities a ON ai.activities_id = a.id 
                                    WHERE ai.activities_id = ?");
            $stmt->bind_param("i", $activities_id);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result) {
                $rows = $result->fetch_all(MYSQLI_ASSOC);
                echo json_encode(["success" => true, "ImagesData" => $rows ?: []]);
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

            // ตรวจสอบว่าไฟล์ถูกอัปโหลดหรือไม่
            // if (!isset($_FILES['image']) || $_FILES['image']['error'] !== UPLOAD_ERR_OK) {
            //     echo json_encode(["success" => false, "message" => "Upload failed"]);
            //     exit;
            // }

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

            if (!isset($_FILES['images'])) {
                echo json_encode(["success" => false, "message" => "No files uploaded"]);
                exit;
            }

            // สร้าง path และชื่อไฟล์
            $uploadDir = "img/" . $activities['folder_path'];
            if (!is_dir($uploadDir)) {
                mkdir($uploadDir, 0777, true);
            }

            $successCount = 0;
            $errors = [];

            foreach ($_FILES['images']['tmp_name'] as $key => $tmpName) {
                $originalName = $_FILES['images']['name'][$key];
                $error = $_FILES['images']['error'][$key];
        
                if ($error !== UPLOAD_ERR_OK) {
                    $errors[] = "เกิดข้อผิดพลาดในการอัปโหลดไฟล์: $originalName";
                    continue;
                }
        
                $extension = pathinfo($originalName, PATHINFO_EXTENSION);
                $newFileName = uniqid('img_') . '.' . $extension;
                $targetPath = $uploadDir . $newFileName;
        
                if (!move_uploaded_file($tmpName, $targetPath)) {
                    $errors[] = "ไม่สามารถบันทึกไฟล์: $originalName";
                    continue;
                }
        
                // บันทึกลงฐานข้อมูล
                $stmt = $conn->prepare("
                    INSERT INTO activities_images (activities_id, original_name, image_name)
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
                    "message" => "อัปโหลดสำเร็จ $successCount รูปภาพ",
                    "errors" => $errors
                ]);
            } else {
                echo json_encode([
                    "success" => false,
                    "message" => "ไม่สามารถอัปโหลดรูปภาพได้",
                    "errors" => $errors
                ]);
            }
            // $originalName = $_FILES['image']['name'];
            // $extension = pathinfo($originalName, PATHINFO_EXTENSION);
            // $newFileName = uniqid('img_') . '.' . $extension;
            // $targetPath = $uploadDir . $newFileName;

            // // ย้ายไฟล์
            // if (!move_uploaded_file($_FILES['image']['tmp_name'], $targetPath)) {
            //     echo json_encode(["success" => false, "message" => "ไม่สามารถบันทึกไฟล์ได้"]);
            //     exit;
            // }

            // // บันทึกข้อมูลลง DB
            // $stmt = $conn->prepare("
            //     INSERT INTO activities_images (activities_id, original_name, image_name)
            //     VALUES (?, ?, ?)
            // ");
            // $stmt->bind_param("iss", $activities_id, $originalName, $newFileName);

            // if ($stmt->execute()) {
            //     echo json_encode(["success" => true, "message" => "อัปโหลดรูปภาพสำเร็จ"]);
            // } else {
            //     echo json_encode(["success" => false, "message" => "บันทึกลงฐานข้อมูลล้มเหลว"]);
            // }
        } elseif ($action === 'delete'){
            $id = $_POST['id'] ?? null;

            if (!$id) {
                echo json_encode(["success" => false, "message" => "Missing ID"]);
                exit;
            }
    
            $stmt = $conn->prepare("
                SELECT ai.id AS image_id, ai.original_name, ai.activities_id, ai.image_name, a.title, a.category_id, c.folder_path
                FROM activities_images ai
                JOIN activities a ON ai.activities_id = a.id
                JOIN categories c ON a.category_id = c.id
                WHERE ai.id = ?
            ");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $imageData = $result->fetch_assoc();

            if (!$imageData) {
                echo json_encode(["success" => false, "message" => "ไม่พบข้อมูลภาพ"]);
                exit;
            }

            $filePath = "img/" . $imageData['folder_path'] . $imageData['image_name'];

            if (file_exists($filePath)) {
                unlink($filePath);
            }

            $deleteStmt = $conn->prepare("DELETE FROM activities_images WHERE id = ?");
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
