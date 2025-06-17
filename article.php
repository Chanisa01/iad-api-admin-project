<?php
// ✅ รองรับ CORS
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

// ✅ ถ้าเป็น OPTIONS (preflight) ให้ตอบ 204 แล้วจบเลย
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// ✅ Start session หลังผ่าน preflight
session_name('PHPSESSID');
session_start();

include 'db_connect.php';

$method = $_SERVER['REQUEST_METHOD'];

if (!isset($_SESSION['sess_iauop_user_id'])) {
    echo json_encode(['success' => false, 'message' => 'ไม่ได้เข้าสู่ระบบ']);
    exit;
}

$updated_by = $_SESSION['sess_iauop_user_id'];

if ($method === 'GET') {
    $category_id = $_GET['category_id'] ?? null;

    if (!$category_id) {
        echo json_encode(['success' => false, 'message' => 'ไม่พบ category_id']);
        exit;
    }

    $sql = "SELECT * FROM article WHERE category_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $category_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $article = $result->fetch_assoc();

    if ($article) {
        echo json_encode(['success' => true, 'information' => $article]);
    } else {
        echo json_encode(['success' => false, 'message' => 'ไม่พบข้อมูล']);
    }

    exit;
}

if ($method === 'POST') {
    // รับข้อมูล POST แบบ JSON หรือ FormData
    $category_id = $_POST['category_id'] ?? null;

    if (!$category_id) {
        echo json_encode(['success' => false, 'message' => 'กรุณาระบุ category_id']);
        exit;
    }

    if ((int)$category_id === 16) {
        // 📁 อัปโหลดรูปเท่านั้น (id_article = 5)
        if (!isset($_FILES['image'])) {
            echo json_encode(['success' => false, 'message' => 'ไม่ได้ส่งไฟล์ภาพ']);
            exit;
        }

        $upload_dir ='img/structure/';
        $original_name = $_FILES['image']['name'];
        $ext = pathinfo($original_name, PATHINFO_EXTENSION);
        $new_name = uniqid('structure_') . '.' . $ext;
        $target_file = $upload_dir . $new_name;

        // 🔄 ลบไฟล์เดิมก่อน
        $sql_select = "SELECT image_name FROM article WHERE category_id = 16";
        $result = $conn->query($sql_select);
        if ($result && $row = $result->fetch_assoc()) {
            $old_image = $row['image_name'];
            $old_path = $upload_dir . $old_image;
            if ($old_image && file_exists($old_path)) {
                unlink($old_path);
            }
        }

        if (move_uploaded_file($_FILES['image']['tmp_name'], $target_file)) {
            $sql = "UPDATE article SET image_name = ?, original_name = ?, updated_at = NOW(), updated_by = ? WHERE category_id = 16";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ssi", $new_name, $original_name, $updated_by);

            if ($stmt->execute()) {
                echo json_encode(['success' => true, 'message' => 'อัปโหลดภาพสำเร็จ']);
            } else {
                echo json_encode(['success' => false, 'message' => 'ไม่สามารถอัปเดตข้อมูลได้']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'อัปโหลดไฟล์ไม่สำเร็จ']);
        }

        exit;
    } else {
        // 📝 กรณีทั่วไป: อัปเดต description_th
        $description_th = $_POST['description_th'] ?? null;

        $sql = "UPDATE article SET description_th = ?, updated_at = NOW(), updated_by = ? WHERE category_id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sii", $description_th, $updated_by, $category_id);

        if ($stmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'บันทึกข้อมูลเรียบร้อยแล้ว']);
        } else {
            echo json_encode(['success' => false, 'message' => 'ไม่สามารถอัปเดตข้อมูลได้']);
        }

        exit;
    }
}

echo json_encode(['success' => false, 'message' => 'ไม่รองรับ method นี้']);
