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

$method = $_SERVER['REQUEST_METHOD'];

// ✅ อัปเดตสถานะ (POST)
if ($method === 'POST' && isset($_POST['action']) && $_POST['action'] === 'update_status') {
    if (!isset($_SESSION['sess_iauop_user_id'])) {
        echo json_encode(["success" => false, "message" => "No active session"]);
        exit;
    }

    $updated_by = $_SESSION['sess_iauop_user_id'];
    $id = intval($_POST['id']);
    $status = trim($_POST['status']);

    $allowed_statuses = [
        'received', 'Investigating', 'pending_additional_info',
        'in_progress', 'resolved', 'Cancelled'
    ];
    if (!in_array($status, $allowed_statuses)) {
        echo json_encode(['success' => false, 'message' => 'Invalid status']);
        exit;
    }

    $stmt = $conn->prepare("UPDATE complaints SET status = ?, updated_by = ?, updated_at = NOW() WHERE id = ?");
    $stmt->bind_param("sii", $status, $updated_by, $id);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Status updated successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to update status']);
    }

    $stmt->close();
    $conn->close();
    exit;
}

// ✅ GET: ดึงข้อมูลทั้งหมด
$response = [
    "success" => false,
    "stats" => [],
    "complaints" => [],
];

// 📊 ดึงสถิติจำนวนแต่ละสถานะ
$statQuery = "
  SELECT
    COUNT(*) AS all_complaints,
    SUM(status = 'received') AS received,
    SUM(status = 'Investigating') AS Investigating,
    SUM(status = 'pending_additional_info') AS pending_additional_info,
    SUM(status = 'in_progress') AS in_progress,
    SUM(status = 'resolved') AS resolved,
    SUM(status = 'Cancelled') AS Cancelled
  FROM complaints
";
$statResult = mysqli_query($conn, $statQuery);
if ($statResult && $row = mysqli_fetch_assoc($statResult)) {
    $response['stats'] = [
        "all" => (int)$row['all_complaints'],
        "received" => (int)$row['received'],
        "Investigating" => (int)$row['Investigating'],
        "pending_additional_info" => (int)$row['pending_additional_info'],
        "in_progress" => (int)$row['in_progress'],
        "resolved" => (int)$row['resolved'],
        "Cancelled" => (int)$row['Cancelled'],
    ];
}

// 📋 ดึงข้อมูลคำร้องทั้งหมด
$dataQuery = "SELECT * FROM complaints ORDER BY submitted_at DESC";
$dataResult = mysqli_query($conn, $dataQuery);

if ($dataResult) {
    while ($row = mysqli_fetch_assoc($dataResult)) {
        $response['complaints'][] = [
            "id" => (int)$row['id'],
            "full_name" => $row['full_name'],
            "email" => $row['email'],
            "phone_number" => $row['phone_number'],
            "complaint_type" => $row['complaint_type'],
            "description" => $row['description'],
            "acknowledgement" => (bool)$row['acknowledgement'],
            "status" => $row['status'],
            "submitted_at" => $row['submitted_at'],
            "updated_at" => $row['updated_at'],
            "updated_by" => $row['updated_by'],
        ];
    }
}

$response["success"] = true;
echo json_encode($response);
?>
