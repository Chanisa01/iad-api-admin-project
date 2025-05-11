<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Credentials: true");
    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
    header("Content-Type: application/json; charset=UTF-8");

session_name('PHPSESSID');
session_start();
// var_dump($_SESSION);
// exit;
include 'db_connect.php';
file_put_contents('debug_request.log', print_r([
    '_POST' => $_POST,
    '_FILES' => $_FILES,
    '_SESSION' => $_SESSION,
    '_COOKIE' => $_COOKIE,
], true));
// เปิดการแสดง Error (สำหรับ Debug)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// $input = file_get_contents("php://input");
// $contentType = $_SERVER["CONTENT_TYPE"] ?? '';

// if (stripos($contentType, 'application/json') !== false) {
//     $_POST = json_decode($input, true) ?? [];
// }

// file_put_contents("log.txt", print_r($_POST, true)); // ดูว่า $_POST มีอะไรบ้าง

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'insert') {
        // รับค่าจากฟอร์ม
        $title = $_POST['title'] ?? null;
        $updated_at = $_POST['updated_at'] ?? null;
        // $updated_by = $_POST['updated_by'] ?? null;
        $uploaded_by = $_POST['uploaded_by'] ?? null;
        $category_id = $_POST['category_id'] ?? null;
        $updated_by = $_SESSION['sess_iauop_user_id'];

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
        if ($fileExt !== 'pdf' || $file['size'] > 5 * 1024 * 1024) {
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
    } elseif ($action === 'delete') {
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
    } else {
        echo json_encode(["success" => false, "message" => "Invalid action"]);
    }
}
?>
