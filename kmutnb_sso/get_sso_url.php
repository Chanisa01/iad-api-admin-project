<?php
    session_start();

    $config = include __DIR__ . '/config.php';
    $allowedOrigins = [$config['FRONTEND_URL']];

    if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowedOrigins)) {
        header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
    }
    header("Access-Control-Allow-Credentials: true");
    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    header('Content-Type: application/json');

    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        http_response_code(204);
        exit;
    }

    require_once 'kmutnbsso.php';

    $sso = new kmutnbsso();
    $ssoUrl = $sso->getAuthorizationUrl(false); // false = ไม่ redirect ทันที

    echo json_encode(['sso_url' => $ssoUrl]);
?>