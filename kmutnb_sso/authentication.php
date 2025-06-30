<?php
    // ไฟล์ authentication.php (แก้ไข - ใช้สำหรับการ redirect โดยตรง)
    if (session_status() === PHP_SESSION_NONE) {
        session_name('PHPSESSID');
        ini_set('session.cookie_path', '/');
        ini_set('session.cookie_domain', 'iau.op.kmutnb.ac.th');
        session_start();
    }

    $config = include __DIR__ . '/config.php';

    // ✅ รับ parameter ที่ส่งมา
    $frontendRedirect = $_GET['frontend_redirect'] ?? $config['FRONTEND_URL'] . '/login-success';

    // ✅ เก็บ frontend_redirect ใน session
    if ($frontendRedirect) {
        $_SESSION['frontend_redirect'] = $frontendRedirect;
    }

    require_once 'kmutnbsso.php';

    $sso = new kmutnbsso();
    $sso->getAuthorizationUrl(); // จะ redirect ไปที่ SSO โดยอัตโนมัติ
?>