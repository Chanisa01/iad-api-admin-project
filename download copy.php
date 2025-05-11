<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: GET, POST");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    header("Content-Type: application/json; charset=UTF-8");

    include 'db_connect.php';
    // เปิดการแสดง Error (สำหรับ Debug)
    // error_reporting(E_ALL);
    // ini_set('display_errors', 1);

    $method = $_SERVER['REQUEST_METHOD'];

    if ($method === 'GET') {
        $category_id = isset($_GET['category_id']) ? $_GET['category_id'] : null;
        // var_dump('category_id:' .$category_id);
        if ($category_id) {
            // var_dump('category_id:' .$category_id);
            $sql = "SELECT d.*, u.prename, u.name, u.surname, c.folder_path
                    FROM document d
                    JOIN users u ON d.updated_by = u.id
                    JOIN categories c ON d.category_id = c.id
                    WHERE d.category_id = $category_id";
            $result = $conn->query($sql);

            if ($result) {
                $rows = $result->fetch_all(MYSQLI_ASSOC);
                echo json_encode(["success" => true, "documentData" => $rows ?: []]);
            } else {
                echo json_encode(["success" => false, "message" => "เกิดข้อผิดพลาดในการดึงข้อมูล", "error" => $conn->error]);
            }
        }
    }

    if ($method === 'POST') {
        $action = $_POST['action'] ?? '';
        if($action === 'update'){
            $title = $_POST['title'] ?? null;
            $category_id = $_POST['category_id'] ?? null;
            $id = $_POST['id'] ?? null;
            // var_dump('ID: '.$id);
            $uploaded_at = $_POST['uploaded_at'] ?? null;
            $updated_by = $_POST['updated_by'] ?? null;
    
            if (!$category_id || !$id || !$uploaded_at || !$updated_by) {
                echo json_encode(["success" => false, "message" => "Missing required fields"]);
                exit;
            }
            
            // ค้นหา folder_path
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
    
            // ตรวจสอบการอัปโหลดไฟล์
            if (!empty($_FILES['file_name']['name'])) {
                $file = $_FILES['file_name'];
                $fileExt = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    
                $allowedTypes = ['pdf', 'doc', 'docx', 'xls', 'xlsx'];
                if (!in_array($fileExt, $allowedTypes) || $file['size'] > 2 * 1024 * 1024) {
                    echo json_encode(["success" => false, "message" => "Invalid file type or size"]);
                    exit;
                }
                
    
                // ค้นหาชื่อไฟล์เก่า
                $stmt = $conn->prepare("SELECT file_name FROM document WHERE id = ?");
                $stmt->bind_param("i", $id);
                $stmt->execute();
                $result = $stmt->get_result();
                $oldFile = $result->fetch_assoc();
    
                if ($oldFile && file_exists($targetDir . $oldFile['file_name'])) {
                    unlink($targetDir . $oldFile['file_name']);
                }
    
                // กำหนดชื่อไฟล์ใหม่
                $newFileName = 'document_' . $id . '_' . uniqid() . '.' . $fileExt;
                $filePath = $targetDir . $newFileName;
    
                if (!move_uploaded_file($file['tmp_name'], $filePath)) {
                    echo json_encode(["success" => false, "message" => "File upload failed"]);
                    exit;
                }
    
                // อัปเดตฐานข้อมูล
                $stmt = $conn->prepare("UPDATE document SET title = ?, file_name = ?, uploaded_at = ?, updated_by = ? 
                                        WHERE id = ? AND category_id = ?");
                $stmt->bind_param("ssssii", $title, $newFileName, $uploaded_at, $updated_by, $id, $category_id);
                $success = $stmt->execute();
                if (!$success) {
                    error_log("SQL Error: " . $stmt->error);
                    echo json_encode(["success" => false, "message" => "Update failed", "error" => $stmt->error]);
                    exit;
                }
            } else {
                $stmt = $conn->prepare("UPDATE document SET title = ?, uploaded_at = ?, updated_by = ? WHERE id = ? AND category_id = ?");
                $stmt->bind_param("sssii", $title, $uploaded_at, $updated_by, $id, $category_id);
                $success = $stmt->execute();
                if (!$success) {
                    error_log("SQL Error: " . $stmt->error);
                    echo json_encode(["success" => false, "message" => "Update failed", "error" => $stmt->error]);
                    exit;
                }
                
            }
            
            if ($success) {
                echo json_encode(["success" => true, "message" => "Update successful"]);
            } else {
                echo json_encode(["success" => false, "message" => "Update failed"]);
            }
        } elseif($action === 'insert'){
             // รับค่าจากฟอร์ม
            $title = $_POST['title'] ?? null;
            $updated_at = $_POST['updated_at'] ?? null;
            $updated_by = $_POST['updated_by'] ?? null;
            $uploaded_by = $_POST['uploaded_by'] ?? null;
            $category_id = $_POST['category_id'] ?? null;

            // ตรวจสอบค่าว่าง
            if (!$title || !$updated_at || !$updated_by || !$category_id) {
                echo json_encode(["success" => false, "message" => "Missing required fields"]);
                exit;
            }

            // ตรวจสอบ Category ID และดึงโฟลเดอร์ที่ต้องเก็บไฟล์
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

            // สร้างโฟลเดอร์ถ้ายังไม่มี
            if (!is_dir($targetDir)) {
                mkdir($targetDir, 0777, true);
            }

            // ตรวจสอบไฟล์ที่อัปโหลด
            if (!isset($_FILES['file_name'])) {
                echo json_encode(["success" => false, "message" => "No file uploaded"]);
                exit;
            }

            $file = $_FILES['file_name'];
            $fileExt = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));

            // ตรวจสอบประเภทและขนาดไฟล์
            $allowedTypes = ['pdf', 'doc', 'docx', 'xls', 'xlsx'];
            if (!in_array($fileExt, $allowedTypes) || $file['size'] > 2 * 1024 * 1024) {
                echo json_encode(["success" => false, "message" => "Invalid file type or size"]);
                exit;
            }

            // ตั้งชื่อไฟล์ใหม่ (ใช้ timestamp + random ID)
            $newFileName = 'document_' . time() . '_' . uniqid() . '.' . $fileExt;
            $filePath = $targetDir . $newFileName;

            // ย้ายไฟล์ไปยังโฟลเดอร์ที่ต้องการ
            if (!move_uploaded_file($file['tmp_name'], $filePath)) {
                echo json_encode(["success" => false, "message" => "File upload failed"]);
                exit;
            }

            // บันทึกข้อมูลลงฐานข้อมูล
            $stmt = $conn->prepare("INSERT INTO document 
                                    (title, file_name, uploaded_at, updated_by, uploaded_by, category_id) 
                                    VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("sssiii", $title, $newFileName, $updated_at, $updated_by, $uploaded_by, $category_id);
            $success = $stmt->execute();

            if ($success) {
                echo json_encode(["success" => true, "message" => "Insert successful"]);
            } else {
                error_log("SQL Error: " . $stmt->error);
                echo json_encode(["success" => false, "message" => "Insert failed", "error" => $stmt->error]);
            }
        } elseif($action === 'delete'){
            $id = $_POST['id'] ?? null;

            if (!$id) {
                echo json_encode(["success" => false, "message" => "Missing ID"]);
                exit;
            }

            // ตรวจสอบชื่อไฟล์ก่อนลบจริง (ลบไฟล์ในระบบด้วย)
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

            if (!$category) {
                echo json_encode(["success" => false, "message" => "ไม่พบ category"]);
                exit;
            }

            $filePath = "document/" . $category['folder_path'] . "/" . $document['file_name'];

            // ลบไฟล์
            if (file_exists($filePath)) {
                unlink($filePath);
            }

            // ลบข้อมูลในฐานข้อมูล
            $stmt = $conn->prepare("DELETE FROM document WHERE id = ?");
            $stmt->bind_param("i", $id);

            if ($stmt->execute()) {
                echo json_encode(["success" => true, "message" => "ลบสำเร็จ"]);
            } else {
                echo json_encode(["success" => false, "message" => "ไม่สามารถลบข้อมูลได้"]);
            }
        }else {
            echo json_encode(["success" => false, "message" => "Invalid action"]);
        }
    }
?>
