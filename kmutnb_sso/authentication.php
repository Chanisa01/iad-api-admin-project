<?php
session_start();
require_once __DIR__ . '/SSOClient.php';
$config = include __DIR__ . '/config.php';

$redirectUri = $_GET['redirect_uri'] ?? null;
$frontendRedirect = $_GET['frontend_redirect'] ?? $config['FRONTEND_URL'] . '/login-success';

session_start();
if ($frontendRedirect) {
    $_SESSION['frontend_redirect'] = $frontendRedirect;
}

$sso = new SSOClient($redirectUri);
header("Location: " . $sso->getLoginUrl());
exit;
?>
