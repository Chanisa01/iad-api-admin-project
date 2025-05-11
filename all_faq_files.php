<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

include 'db_connect.php';

$targetDir = "document/faqs/";
$method = $_SERVER['REQUEST_METHOD'];

function cleanFilename($filename) {
    return uniqid() . "_" . preg_replace("/[^A-Za-z0-9\-_\.]/", '_', basename($filename));
}

// ✅ GET: แสดงเอกสารทั้งหมดของคำถาม
if ($method === 'GET') {
    $faq_id = $_GET['faq_id'] ?? null;

    if ($faq_id) {
        $sql = "SELECT id, faq_id, file_name, original_name, uploaded_at FROM faq_files WHERE faq_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $faq_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $data = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(["success" => true, "FilesData" => $data]);
    } else {
        echo json_encode(["success" => false, "message" => "กรุณาระบุ faq_id"]);
    }
    exit;
}

// ✅ POST
if ($method === 'POST') {
    $action = $_POST['action'] ?? '';

    // ลบไฟล์
    if ($action === 'delete') {
        $file_id = $_POST['id'] ?? 0;

        $res = $conn->query("SELECT file_name FROM faq_files WHERE id = $file_id");
        if ($row = $res->fetch_assoc()) {
            $filepath = $targetDir . $row['file_name'];
            if (file_exists($filepath)) {
                unlink($filepath);
            }
        }

        $conn->query("DELETE FROM faq_files WHERE id = $file_id");
        echo json_encode(["success" => true]);
        exit;
    }

    // เพิ่มไฟล์ใหม่
    if ($action === 'insert') {
        $faq_id = $_POST['faq_id'] ?? null;

        if (!$faq_id || empty($_FILES['files']['name'])) {
            echo json_encode(["success" => false, "message" => "ข้อมูลไม่ครบ"]);
            exit;
        }

        foreach ($_FILES['files']['name'] as $index => $original_name) {
            $tmp_name = $_FILES['files']['tmp_name'][$index];
            $new_name = cleanFilename($original_name);

            if (move_uploaded_file($tmp_name, $targetDir . $new_name)) {
                $conn->query("INSERT INTO faq_files (faq_id, file_name, original_name, uploaded_at)
                              VALUES ($faq_id, '$new_name', '$original_name', NOW())");
            }
        }

        echo json_encode(["success" => true]);
        exit;
    }

    echo json_encode(["success" => false, "message" => "ไม่พบ action ที่รองรับ"]);
}
