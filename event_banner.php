<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
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

$targetDir = "img/event_banner/";
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $sql = "SELECT eb.*, u.prename, u.name, u.surname
            FROM event_banner eb
            JOIN users u ON u.id = eb.updated_by";
    $result = $conn->query($sql);

    if ($result) {
        $rows = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode(["success" => true, "bannerData" => $rows ?: []]);
    } else {
        echo json_encode(["success" => false, "message" => "เกิดข้อผิดพลาดในการดึงข้อมูล", "error" => $conn->error]);
    }
}

if ($method === 'POST') {
    $action = $_POST['action'] ?? '';
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }
    $updated_by = $_SESSION['sess_iauop_user_id'];

    // ✅ INSERT
    if ($action === 'insert') {
        if (!isset($_FILES['image']) || $_FILES['image']['error'] !== UPLOAD_ERR_OK) {
            echo json_encode(["success" => false, "message" => "ไม่พบไฟล์ภาพหรืออัปโหลดผิดพลาด"]);
            exit;
        }

        $file = $_FILES['image'];
        $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
        if (!in_array($ext, ['jpg', 'jpeg', 'png'])) {
            echo json_encode(["success" => false, "message" => "รองรับเฉพาะไฟล์ JPG และ PNG เท่านั้น"]);
            exit;
        }

        $originalName = $file['name'];
        $newFileName = uniqid('event_') . '.' . $ext;

        $targetPath = $targetDir . $newFileName;

        if (!move_uploaded_file($file['tmp_name'], $targetPath)) {
            echo json_encode(["success" => false, "message" => "ไม่สามารถบันทึกไฟล์ได้"]);
            exit;
        }

        $stmt = $conn->prepare("INSERT INTO event_banner (image_name, original_name, updated_by) VALUES (?, ?, ?)");
        $originalName = $file['name'] ?? $newFileName; // ถ้าไม่มี name ให้ใช้ชื่อใหม่แทน
        $stmt->bind_param("ssi", $newFileName, $originalName,  $updated_by);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "เพิ่มแบนเนอร์สำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "เพิ่มแบนเนอร์ไม่สำเร็จ"]);
        }
    }

    // if ($action === 'update') {
    //     $id_event = $_POST['id_event'];
    //     $is_active = $_POST['is_active'];

    //     if (!isset($_SESSION['sess_iauop_user_id'])) {
    //         echo json_encode(["success" => false, "message" => "No active session"]);
    //         exit;
    //     }

    //     $updated_by = $_SESSION['sess_iauop_user_id'];
    //     $newFileName = '';
    //     $original_name = '';

    //     // เช็คว่ามีไฟล์ภาพใหม่ไหม
    //     if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
    //         // 🔁 ลบไฟล์ภาพเดิมออก
    //         $res = $conn->query("SELECT image_name FROM banner WHERE id_event = $id_event");
    //         $old = $res->fetch_assoc();
    //         if ($old && $old['image_name']) {
    //             @unlink("img/banner/" . $old['image_name']);
    //         }

    //         $file = $_FILES['image'];
    //         $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    //         if (!in_array($ext, ['jpg', 'jpeg', 'png'])) {
    //             echo json_encode(["success" => false, "message" => "รองรับเฉพาะไฟล์ JPG และ PNG เท่านั้น"]);
    //             exit;
    //         }

    //         $originalName = $file['name'];
    //         $newFileName = uniqid('event_') . '.' . $ext;

    //         $targetPath = $targetDir . $newFileName;

    //         if (!move_uploaded_file($file['tmp_name'], $targetPath)) {
    //             echo json_encode(["success" => false, "message" => "ไม่สามารถอัปโหลดไฟล์ภาพใหม่ได้"]);
    //             exit;
    //         }

    //         // ✅ update พร้อมรูป
    //         $stmt = $conn->prepare("UPDATE event_banner SET image_name = ?, original_name = ?, is_active = ?, updated_by = ? WHERE id_event = ?");
    //         $stmt->bind_param("ssiii", $newFileName, $original_name, $is_active, $updated_by, $id_event);
    //     } else {
    //         // ✅ update เฉพาะสถานะ ไม่แก้ไขรูป
    //         $stmt = $conn->prepare("UPDATE event_banner SET is_active = ?, updated_by = ? WHERE id_event = ?");
    //         $stmt->bind_param("iii", $is_active, $updated_by, $id_event);
    //     }

    //     if ($stmt->execute()) {
    //         echo json_encode(["success" => true, "message" => "อัปเดตแบนเนอร์เรียบร้อยแล้ว"]);
    //     } else {
    //         echo json_encode(["success" => false, "message" => "ไม่สามารถอัปเดตข้อมูลได้", "error" => $stmt->error]);
    //     }
    // }

    if ($action === 'set_active') {
        $id_event = $_POST['id_event'];
    
        $conn->query("UPDATE event_banner SET is_active = 0");
    
        $stmt = $conn->prepare("UPDATE event_banner SET is_active = 1, updated_by = ?, updated_at = NOW() WHERE id_event = ?");
        $stmt->bind_param("ii", $updated_by, $id_event);
    
        echo $stmt->execute()
            ? json_encode(["success" => true])
            : json_encode(["success" => false, "message" => "ไม่สามารถตั้ง active"]);
    }
    
    if ($action === 'clear_active') {
        $stmt = $conn->prepare("UPDATE event_banner SET is_active = 0, updated_by = ?, updated_at = NOW()");
        $stmt->bind_param("i", $updated_by);
    
        echo $stmt->execute()
            ? json_encode(["success" => true])
            : json_encode(["success" => false, "message" => "ไม่สามารถล้าง active"]);
    }
    

    // ✅ DELETE
    if ($action === 'delete') {
        $id_event = $_POST['id_event'];

        // ลบภาพเก่า
        $res = $conn->query("SELECT image_name FROM event_banner WHERE id_event = $id_event");
        $row = $res->fetch_assoc();
        if ($row && $row['image_name']) {
            @unlink($targetDir . $row['image_name']);
        }

        $stmt = $conn->prepare("DELETE FROM event_banner WHERE id_event = ?");
        $stmt->bind_param("i", $id_event);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "ลบสำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "ลบไม่สำเร็จ"]);
        }
    }
}
?>