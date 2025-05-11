<?php
class SSOClient {
    private $clientId = 'm4F26kNf1gavGOtbdzdagO1FbZj0aR68';
    private $clientSecret = 'RBqsfWeDJmCXnSSImZCAsrvHMUgUy6qP1hUlsjYh3vzCSHl5LK072fFp5IONHlIi';
    private $redirectUri = 'http://localhost/API_iauop/kmutnb_sso/callback.php';

    private $authUrl = 'https://sso.kmutnb.ac.th/auth/authorize';
    private $tokenUrl = 'https://sso.kmutnb.ac.th/auth/token';
    private $resourceUrl = 'https://sso.kmutnb.ac.th/resources/userinfo';

    private $scope = 'profile';
    private $verifySSL = true;
    private $accessToken = null;

    public function getLoginUrl() {
        $state = bin2hex(random_bytes(16));

        $_SESSION['oauth2state'] = $state;
        $params = http_build_query([
            'client_id' => $this->clientId,
            'response_type' => 'code',
            'redirect_uri' => $this->redirectUri,
            'scope' => $this->scope,
            'state' => $state
        ]);
        return $this->authUrl . '?' . $params;
    }

    public function handleCallback($code, $state) {
        if (!isset($_SESSION['sso_state']) || $state !== $_SESSION['sso_state']) {
            throw new Exception('Invalid state parameter');
        }
        unset($_SESSION['sso_state']);
        $postData = http_build_query([
            'client_id' => $this->clientId,
            'client_secret' => $this->clientSecret,
            'code' => $code,
            'grant_type' => 'authorization_code',
            'redirect_uri' => $this->redirectUri,
        ]);
        $options = [
            'http' => [
                'method'  => 'POST',
                'header'  => "Content-Type: application/x-www-form-urlencoded",
                'content' => $postData,
            ],
        ];
        $context = stream_context_create($options);
        $response = file_get_contents($this->tokenUrl, false, $context);
        if (!$response) throw new Exception('Failed to fetch access token');
        $data = json_decode($response, true);
        if (!isset($data['access_token'])) throw new Exception('Invalid token response');
        $this->accessToken = $data['access_token'];
        $_SESSION['sso_token'] = $this->accessToken;
        return $this->accessToken;
    }

    public function getUserInfo() {
        $token = $this->accessToken ?? $_SESSION['sso_token'] ?? null;
        if (!$token) {
            error_log("❌ ไม่มี access token");
            return null;
        }
    
        $headers = ["Authorization: Bearer {$token}"];
        $opts = ['http' => ['method' => "GET", 'header' => implode("\r\n", $headers)]];
        $context = stream_context_create($opts);
        $response = file_get_contents($this->resourceUrl, false, $context);
    
        error_log("🔎 getUserInfo response: " . $response); // ✅ เพิ่ม debug ตรงนี้
    
        if (!$response) {
            return null;
        }
    
        return json_decode($response, true);
    }
    
}
