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
    // เปิดการแสดง Error (สำหรับ Debug)
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    $method = $_SERVER['REQUEST_METHOD'];

    if ($method === 'GET') {
        $category_id = isset($_GET['category_id']) ? $_GET['category_id'] : null;
        // var_dump('category_id:' .$category_id);
        if ($category_id) {
            // var_dump('category_id:' .$category_id);
            $sql = "SELECT a.*, u.prename, u.name, u.surname, c.folder_path
                    FROM activities a
                    JOIN users u ON a.updated_by = u.id
                    JOIN categories c ON a.category_id = c.id
                    WHERE a.category_id = $category_id";
            $result = $conn->query($sql);

            if ($result) {
                $rows = $result->fetch_all(MYSQLI_ASSOC);
                echo json_encode(["success" => true, "activitiesData" => $rows ?: []]);
            } else {
                echo json_encode(["success" => false, "message" => "เกิดข้อผิดพลาดในการดึงข้อมูล", "error" => $conn->error]);
            }
        }
    }elseif ($method === 'POST') {
        if (!isset($_SESSION['sess_iauop_user_id'])) {
            echo json_encode(["success" => false, "message" => "No active session"]);
            exit;
        }
        $action = $_POST['action'] ?? '';
        
        if ($action === 'insert') {
            $title = $_POST['title'] ?? '';
            $description = $_POST['description'] ?? '';
            $uploaded_at = $_POST['uploaded_at'] ?? '';
            $category_id = $_POST['category_id'];
            $updated_by = $_SESSION['sess_iauop_user_id'];
            $is_active = $_POST['is_active'];

    
            // ตรวจสอบว่ามีข้อมูล cover ไหม
            if (!isset($_FILES['cover'])) {
                http_response_code(400);
                echo json_encode(["success" => false, "message" => "กรุณาอัปโหลดภาพหน้าปก"]);
                exit;
            }
    
            // ดึง folder_path จาก categories
            $stmt = $conn->prepare("SELECT folder_path FROM categories WHERE id = ?");
            $stmt->bind_param("i", $category_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $category = $result->fetch_assoc();
            $stmt->close();
    
            if (!$category) {
                echo json_encode(["success" => false, "message" => "ไม่พบหมวดหมู่"]);
                exit;
            }
    
            $folder_path = $category['folder_path'];
            $imgFolder = "img/" . $folder_path;
            $docFolder = "document/" . $folder_path;
    
            if (!is_dir($imgFolder)) mkdir($imgFolder, 0777, true);
            if (!is_dir($docFolder)) mkdir($docFolder, 0777, true);
    
            // =========== บันทึก Cover ===========
            $coverFile = $_FILES['cover'];
            $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
            $maxSize = 20 * 1024 * 1024; // 20MB
    
            if (!in_array($coverFile['type'], $allowedTypes) || $coverFile['size'] > $maxSize) {
                http_response_code(400);
                echo json_encode(["success" => false, "message" => "ไฟล์ปกไม่ถูกต้อง (ต้องเป็น JPG, JPEG, PNG และไม่เกิน 20MB)"]);
                exit;
            }
    
            $coverExtension = pathinfo($coverFile['name'], PATHINFO_EXTENSION);
            $newCoverName = uniqid('cover_') . '.' . $coverExtension;
            $coverTargetPath = $imgFolder . $newCoverName;
    
            if (!move_uploaded_file($coverFile['tmp_name'], $coverTargetPath)) {
                http_response_code(500);
                echo json_encode(["success" => false, "message" => "ไม่สามารถบันทึกไฟล์ปกได้"]);
                exit;
            }
    
            // =========== Insert ลงตาราง activities ===========
            $stmt = $conn->prepare("INSERT INTO activities (category_id, title, cover, description, uploaded_at, updated_by, is_active) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("issssii", $category_id, $title, $newCoverName, $description, $uploaded_at, $updated_by, $is_active);
    
            if ($stmt->execute()) {
                $activities_id = $stmt->insert_id; // id ที่พึ่ง insert
                $stmt->close();
    
                // =========== บันทึกไฟล์ภาพกิจกรรม (หลายไฟล์) ===========
                if (isset($_FILES['images'])) {
                    foreach ($_FILES['images']['tmp_name'] as $key => $tmp_name) {
                        if ($_FILES['images']['error'][$key] === UPLOAD_ERR_OK) {
    
                            $originalName = $_FILES['images']['name'][$key];
                            $extension = pathinfo($originalName, PATHINFO_EXTENSION);
                            $newFileName = uniqid('img_') . '.' . $extension;
                            $targetFile = $imgFolder . $newFileName;
    
                            if (move_uploaded_file($tmp_name, $targetFile)) {
                                $stmtImg = $conn->prepare("INSERT INTO activities_images (activities_id, image_name, original_name) VALUES (?, ?, ?)");
                                $stmtImg->bind_param("iss", $activities_id, $newFileName, $originalName);
                                $stmtImg->execute();
                                $stmtImg->close();
                            }
                        }
                    }
                }
    
                // =========== บันทึกไฟล์เอกสารกิจกรรม (หลายไฟล์) ===========
                if (isset($_FILES['files'])) {
                    foreach ($_FILES['files']['tmp_name'] as $key => $tmp_name) {
                        if ($_FILES['files']['error'][$key] === UPLOAD_ERR_OK) {
    
                            $originalName = $_FILES['files']['name'][$key];
                            $extension = pathinfo($originalName, PATHINFO_EXTENSION);
                            $newFileName = uniqid('file_') . '.' . $extension;
                            $targetFile = $docFolder . $newFileName;
    
                            if (move_uploaded_file($tmp_name, $targetFile)) {
                                $stmtFile = $conn->prepare("INSERT INTO activities_files (activities_id, file_name, original_name) VALUES (?, ?, ?)");
                                $stmtFile->bind_param("iss", $activities_id, $newFileName, $originalName);
                                $stmtFile->execute();
                                $stmtFile->close();
                            }
                        }
                    }
                }
    
                echo json_encode(["success" => true, "message" => "เพิ่มข้อมูลกิจกรรมสำเร็จ"]);
    
            } else {
                http_response_code(500);
                echo json_encode(["success" => false, "message" => "ไม่สามารถบันทึกข้อมูลกิจกรรมลงฐานข้อมูล"]);
            }
    
        }elseif ($action === 'update' && isset($_POST['id'])) {
            $id = $_POST['id'] ?? null;
            $title = $_POST['title'] ?? '';
            $description = $_POST['description'] ?? '';
            $uploaded_at = $_POST['uploaded_at'] ?? '';
            $category_id = $_POST['category_id'] ?? '';
            $updated_by = $_SESSION['sess_iauop_user_id'];
            $is_active = $_POST['is_active'];
            $updated_at = $_POST['updated_at'] ?? null;
        
            $stmt = $conn->prepare("
                SELECT a.id, a.category_id, a.cover, c.folder_path
                FROM activities a
                JOIN categories c ON a.category_id = c.id
                WHERE a.id = ?
            ");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $activities = $result->fetch_assoc();
        
            if (!$activities) {
                echo json_encode(["success" => false, "message" => "ไม่พบบทความนี้"]);
                exit;
            }
        
            $old_cover = $activities['cover'];
            $uploadDir = "img/" . $activities['folder_path'] . "/";
            if (!is_dir($uploadDir)) {
                mkdir($uploadDir, 0777, true);
            }
        
            $newFileName = $old_cover;
        
            // ถ้ามีไฟล์ภาพใหม่
            if (isset($_FILES['cover']) && $_FILES['cover']['error'] === UPLOAD_ERR_OK) {
                $file = $_FILES['cover'];
                $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
                $maxSize = 20 * 1024 * 1024;
        
                if (!in_array($file['type'], $allowedTypes)) {
                    http_response_code(400);
                    echo json_encode(["status" => "error", "message" => "อนุญาตเฉพาะไฟล์ JPG, JPEG และ PNG เท่านั้น"]);
                    exit;
                }
        
                if ($file['size'] > $maxSize) {
                    http_response_code(400);
                    echo json_encode(["status" => "error", "message" => "ไฟล์มีขนาดใหญ่เกินไป (สูงสุด 20MB)"]);
                    exit;
                }
        
                // ลบไฟล์เก่า (ถ้ามี)
                $oldImagePath = $uploadDir . $old_cover;
                if (file_exists($oldImagePath) && !empty($old_cover)) {
                    unlink($oldImagePath);
                }
        
                $extension = pathinfo($file['name'], PATHINFO_EXTENSION);
                $newFileName = uniqid('cover_') . '.' . $extension;
                $targetFilePath = $uploadDir . $newFileName;
        
                if (!move_uploaded_file($file['tmp_name'], $targetFilePath)) {
                    http_response_code(500);
                    echo json_encode(["success" => false, "message" => "ไม่สามารถบันทึกไฟล์ได้"]);
                    exit;
                }
            }
        
            // อัปเดตข้อมูล ไม่ว่าจะมีรูปใหม่หรือไม่
                $stmt = $conn->prepare("UPDATE activities SET title=?, description=?, uploaded_at=?, category_id=?, cover=?, updated_at=?, updated_by=?, is_active = ? WHERE id=?");
            $stmt->bind_param("ssssssiii", $title, $description, $uploaded_at, $category_id, $newFileName, $updated_at, $updated_by, $is_active, $id);
        
            if ($stmt->execute()) {
                echo json_encode(["success" => true, "message" => "อัปเดตข้อมูลสำเร็จ"]);
            } else {
                http_response_code(500);
                echo json_encode(["success" => false, "message" => "ไม่สามารถบันทึกข้อมูลลงในฐานข้อมูล"]);
            }
        
            $stmt->close();
        } elseif ($action === 'delete'){
            // รับ ID ของกิจกรรมจากการส่งข้อมูล
            $activity_id = $_POST['activity_id'];  // หรือรับจาก URL หรือวิธีการอื่นๆ

            // เริ่มต้น Transaction เพื่อให้การลบข้อมูลทั้งหมดเสร็จสิ้น
            mysqli_begin_transaction($conn);

            try {
                $sql = "
                            SELECT c.folder_path, af.file_name, ai.image_name, a.*
                            FROM activities a
                            JOIN categories c ON c.id = a.category_id
                            LEFT JOIN activities_files af ON af.activities_id = a.id
                            LEFT JOIN activities_images ai ON ai.activities_id = a.id
                            WHERE a.id = ?
                        ";
                $stmt = mysqli_prepare($conn, $sql);
                mysqli_stmt_bind_param($stmt, "i", $activity_id);
                mysqli_stmt_execute($stmt);
                $result = mysqli_stmt_get_result($stmt);

                // ลบไฟล์จากโฟลเดอร์ document และ img
                while ($row = mysqli_fetch_assoc($result)) {
                    // ลบไฟล์จากโฟลเดอร์ document
                    if ($row['file_name']) {
                        $file_path = 'document/' . $row['folder_path'] . $row['file_name'];
                        if (file_exists($file_path)) {
                            unlink($file_path);
                        }
                    }

                    // ลบภาพกิจกรรมจากโฟลเดอร์ img
                    if ($row['image_name']) {
                        $image_path = 'img/' . $row['folder_path'] . $row['image_name'];
                        if (file_exists($image_path)) {
                            unlink($image_path);
                        }
                    }

                    // ลบภาพปกจากโฟลเดอร์ img
                    if ($row['cover']) {
                        $image_path = 'img/' . $row['folder_path'] . $row['cover'];
                        if (file_exists($image_path)) {
                            unlink($image_path);
                        }
                    }
                }

                // ลบข้อมูลในตาราง activities_files
                $sql_delete_files = "DELETE FROM activities_files WHERE activities_id = ?";
                $stmt_delete_files = mysqli_prepare($conn, $sql_delete_files);
                mysqli_stmt_bind_param($stmt_delete_files, "i", $activity_id);
                mysqli_stmt_execute($stmt_delete_files);

                // ลบข้อมูลในตาราง activities_images
                $sql_delete_images = "DELETE FROM activities_images WHERE activities_id = ?";
                $stmt_delete_images = mysqli_prepare($conn, $sql_delete_images);
                mysqli_stmt_bind_param($stmt_delete_images, "i", $activity_id);
                mysqli_stmt_execute($stmt_delete_images);

                // ลบข้อมูลในตาราง activities
                $sql_delete_activity = "DELETE FROM activities WHERE id = ?";
                $stmt_delete_activity = mysqli_prepare($conn, $sql_delete_activity);
                mysqli_stmt_bind_param($stmt_delete_activity, "i", $activity_id);
                mysqli_stmt_execute($stmt_delete_activity);

                // Commit transaction
                mysqli_commit($conn);
                echo json_encode(["success" => true, "message" => "กิจกรรมถูกลบเรียบร้อยแล้ว"]);
            } catch (Exception $e) {
                // Rollback transaction ในกรณีที่เกิดข้อผิดพลาด
                mysqli_roll_back($conn);
                echo json_encode(["success" => false, "message" => "เกิดข้อผิดพลาด: " . $e->getMessage()]);
            }
        }
        else {
            http_response_code(400);
            echo json_encode(["success" => false, "message" => "Action ไม่ถูกต้อง"]);
        }
    }else {
        http_response_code(405);
        echo json_encode(["success" => false, "message" => "Method Not Allowed"]);
    }

?>
