<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
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

// ✔️ ตอบ OPTIONS preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// ✔️ Start session หลัง preflight
session_name('PHPSESSID');
session_start();

include 'db_connect.php';

$targetDir = "img/banner/";
$method = $_SERVER['REQUEST_METHOD'];

// $updated_by = 58;

if ($method === 'GET') {
    // $sql = "SELECT b.*, u.prename, u.name, u.surname
    //         FROM banner b
    //         JOIN users u ON u.id = b.updated_by";
    $sql = "SELECT b.*, u.prename, u.name, u.surname
        FROM banner b
        JOIN users u ON u.id = b.updated_by
        ORDER BY b.display_order ASC";
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
        $is_active = $_POST['is_active'];
        $url = $_POST['url'] ?? '';
        $originalName = $file['name'] ?? $newFileName;

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
        $newFileName = uniqid('banner_') . '.' . $ext;

        $targetPath = $targetDir . $newFileName;

        if (!move_uploaded_file($file['tmp_name'], $targetPath)) {
            echo json_encode(["success" => false, "message" => "ไม่สามารถบันทึกไฟล์ได้"]);
            exit;
        }
        $result = $conn->query("SELECT MAX(display_order) AS max_order FROM banner");
        $row = $result->fetch_assoc();
        $nextOrder = ($row['max_order'] ?? 0) + 1;
    
        // ✅ เพิ่ม display_order ลงตาราง
        $stmt = $conn->prepare("INSERT INTO banner (image_name, original_name, is_active, updated_by, display_order, url) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssiiis", $newFileName, $originalName, $is_active, $updated_by, $nextOrder, $url);
    
        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "เพิ่มแบนเนอร์สำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "เพิ่มแบนเนอร์ไม่สำเร็จ"]);
        }
    }

    // if ($action === 'update') {
    //     $id_banner = $_POST['id_banner'];
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
    //         $res = $conn->query("SELECT image_name FROM banner WHERE id_banner = $id_banner");
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

    //         // $originalName = $file['name'];
    //         $original_name = $_POST['original_name'] ?? null;

    //         $newFileName = uniqid('banner_') . '.' . $ext;

    //         $targetPath = $targetDir . $newFileName;

    //         if (!move_uploaded_file($file['tmp_name'], $targetPath)) {
    //             echo json_encode(["success" => false, "message" => "ไม่สามารถอัปโหลดไฟล์ภาพใหม่ได้"]);
    //             exit;
    //         }

    //         // ✅ update พร้อมรูป
    //         $stmt = $conn->prepare("UPDATE banner SET image_name = ?, original_name = ?, is_active = ?, updated_by = ? WHERE id_banner = ?");
    //         $stmt->bind_param("ssiii", $newFileName, $original_name, $is_active, $updated_by, $id_banner);
    //     } else {
    //         // ✅ update เฉพาะสถานะ ไม่แก้ไขรูป
    //         $stmt = $conn->prepare("UPDATE banner SET is_active = ?, updated_by = ? WHERE id_banner = ?");
    //         $stmt->bind_param("iii", $is_active, $updated_by, $id_banner);
    //     }

    //     if ($stmt->execute()) {
    //         echo json_encode(["success" => true, "message" => "อัปเดตแบนเนอร์เรียบร้อยแล้ว"]);
    //     } else {
    //         echo json_encode(["success" => false, "message" => "ไม่สามารถอัปเดตข้อมูลได้", "error" => $stmt->error]);
    //     }
    // }

    if ($action === 'toggle_status') {
        $id_banner = $_POST['id_banner'];
        $is_active = $_POST['is_active'];
    
        if (!isset($_SESSION['sess_iauop_user_id'])) {
            echo json_encode(["success" => false, "message" => "No active session"]);
            exit;
        }
    
        $updated_by = $_SESSION['sess_iauop_user_id'];
    
        $stmt = $conn->prepare("UPDATE banner SET is_active = ?, updated_by = ? WHERE id_banner = ?");
        $stmt->bind_param("iii", $is_active, $updated_by, $id_banner);
    
        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "อัปเดตสถานะแบนเนอร์สำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "อัปเดตสถานะแบนเนอร์ไม่สำเร็จ", "error" => $stmt->error]);
        }
    }

    if ($action === 'update_order') {
        // if (!isset($_SESSION['sess_iauop_user_id'])) {
        //     echo json_encode(["success" => false, "message" => "No active session"]);
        //     exit;
        // }
    
        $orderList = json_decode($_POST['orderList'] ?? '[]', true);
        if (!is_array($orderList)) {
            echo json_encode(["success" => false, "message" => "ข้อมูลไม่ถูกต้อง"]);
            exit;
        }
    
        $conn->begin_transaction();
        try {
            foreach ($orderList as $item) {
                $id = intval($item['id_banner']);
                $order = intval($item['display_order']);
    
                $stmt = $conn->prepare("UPDATE banner SET display_order = ? WHERE id_banner = ?");
                $stmt->bind_param("ii", $order, $id);
                $stmt->execute();
            }
            $conn->commit();
            echo json_encode(["success" => true, "message" => "อัปเดตลำดับเรียบร้อย"]);
        } catch (Exception $e) {
            $conn->rollback();
            echo json_encode(["success" => false, "message" => "อัปเดตลำดับไม่สำเร็จ", "error" => $e->getMessage()]);
        }
    }
    
    
    

    // ✅ DELETE
    if ($action === 'delete') {
        $id_banner = $_POST['id_banner'];

        // ลบภาพเก่า
        $res = $conn->query("SELECT image_name FROM banner WHERE id_banner = $id_banner");
        $row = $res->fetch_assoc();
        if ($row && $row['image_name']) {
            @unlink($targetDir . $row['image_name']);
        }

        $stmt = $conn->prepare("DELETE FROM banner WHERE id_banner = ?");
        $stmt->bind_param("i", $id_banner);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "ลบสำเร็จ"]);
        } else {
            echo json_encode(["success" => false, "message" => "ลบไม่สำเร็จ"]);
        }
    }
}
?>