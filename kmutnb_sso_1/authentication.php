<?php
session_start();

$client_id = 'm4F26kNf1gavGOtbdzdagO1FbZj0aR68';
$redirect_uri = 'http://localhost/API_iauop/kmutnb_sso/callback.php';
$response_type = 'code';
$state = bin2hex(random_bytes(16));

$_SESSION['sso_state'] = $state;

$sso_url = "https://sso.kmutnb.ac.th/api/v1/authorize"
         . "?client_id=" . urlencode($client_id)
         . "&response_type=" . urlencode($response_type)
         . "&redirect_uri=" . urlencode($redirect_uri)
         . "&state=" . urlencode($state);

header("Location: $sso_url");
exit;
?>