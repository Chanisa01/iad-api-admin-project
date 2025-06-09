<?php
$allowedOrigins = ['http://localhost:3000'];

if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowedOrigins)) {
    header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
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
$uploadDir = 'img/committee/';

function deleteImageIfExists($conn, $id) {
    global $uploadDir;
    $sql = "SELECT image_committee_name FROM audit_committee WHERE id_committee = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($row = $result->fetch_assoc()) {
        $imageName = $row['image_committee_name'];
        $imagePath = $uploadDir . $imageName;
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }
    }
}

if ($method === 'GET') {
    $category_id = $_GET['category_id'] ?? 7;
    $sql = "SELECT * , g.group_name
            FROM audit_committee 
            JOIN audit_committee_group g ON audit_committee.position1 = g.id
            WHERE category_id = ? 
            ORDER BY group_year_start DESC, id_committee DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $category_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    echo json_encode(["success" => true, "audit_committee" => $data]);
    exit;
}

if ($method === 'POST') {
    $action = $_POST['action'] ?? '';
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }
    $updated_by = $_SESSION['sess_iauop_user_id'];


    if ($action === 'insert' || $action === 'update') {
        $id = $_POST['id'] ?? null;
        $prename = $_POST['prename'] ?? '';
        $name = $_POST['name'] ?? '';
        $surname = $_POST['surname'] ?? '';
        $position1 = $_POST['position1'] ?? '';
        $position2 = $_POST['position2'] ?? '';
        $email = $_POST['email'] ?? '';
        $phone = $_POST['phone'] ?? '';
        // $group_year_start = $_POST['group_year_start'] ?? '';
        // $group_year_end = $_POST['group_year_end'] ?? '';
        $group_year_start = $_POST['group_year_start'] !== '' ? $_POST['group_year_start'] : null;
        $group_year_end = $_POST['group_year_end'] !== '' ? $_POST['group_year_end'] : null;

        // $updated_by = $_POST['updated_by'] ?? null;
        $is_active = isset($_POST['is_active']) ? intval($_POST['is_active']) : 0;
        $category_id = $_POST['category_id'] ?? 7;

        $image_committee_name = '';
        if (isset($_FILES['image_committee_name']) && $_FILES['image_committee_name']['error'] === UPLOAD_ERR_OK) {
            $ext = pathinfo($_FILES['image_committee_name']['name'], PATHINFO_EXTENSION);
            $image_committee_name = uniqid() . "." . $ext;
            move_uploaded_file($_FILES['image_committee_name']['tmp_name'], $uploadDir . $image_committee_name);
        }

        if ($action === 'insert') {
            $sql = "INSERT INTO audit_committee (prename, name, surname, position1, position2, email, phone, 
                                                group_year_start, group_year_end, updated_by, is_active, image_committee_name, category_id)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("sssssssiiiisi",
                $prename, $name, $surname, $position1, $position2, $email, $phone,
                $group_year_start, $group_year_end, $updated_by, $is_active, $image_committee_name, $category_id
            );
        } else {
            if ($image_committee_name) {
                deleteImageIfExists($conn, $id);
            }
            $sql = "UPDATE audit_committee SET prename=?, name=?, surname=?, position1=?, position2=?, email=?, phone=?, group_year_start=?, group_year_end=?, updated_by=?, is_active=?";
            if ($image_committee_name) {
                $sql .= ", image_committee_name=?";
            }
            $sql .= " WHERE id_committee = ?";

            if ($image_committee_name) {
                $stmt = $conn->prepare($sql);
                $stmt->bind_param("sssssssiiiisi", $prename, $name, $surname, $position1, $position2, $email, $phone,
                    $group_year_start, $group_year_end, $updated_by, $is_active, $image_committee_name, $id);
            } else {
                $stmt = $conn->prepare($sql);
                $stmt->bind_param("sssssssiiisi", $prename, $name, $surname, $position1, $position2, $email, $phone,
                    $group_year_start, $group_year_end, $updated_by, $is_active, $id);
            }
        }
        // var_dump([
        //     'id' => $id,
        //     'name' => $name,
        //     'surname' => $surname,
        //     'sql' => $sql
        //   ]);

        $success = $stmt->execute();
        echo json_encode(["success" => $success]);
        exit;
    }

    if ($action === 'delete') {
        $id = $_POST['id'] ?? null;
        if ($id) {
            deleteImageIfExists($conn, $id);
            $sql = "DELETE FROM audit_committee WHERE id_committee = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("i", $id);
            $success = $stmt->execute();
            echo json_encode(["success" => $success]);
            exit;
        }
    }
}

echo json_encode(["success" => false, "message" => "Invalid request"]);
exit;
