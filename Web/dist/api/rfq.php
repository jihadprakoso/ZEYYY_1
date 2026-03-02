<?php
declare(strict_types=1);

require __DIR__ . '/db.php';

function rfq_strlen(string $value): int {
  if (function_exists('mb_strlen')) return mb_strlen($value, 'UTF-8');
  return strlen($value);
}

function rfq_json_response(int $status, array $payload): void {
  http_response_code($status);
  header('Content-Type: application/json; charset=utf-8');
  header('X-Content-Type-Options: nosniff');
  echo json_encode($payload, JSON_UNESCAPED_UNICODE);
  exit;
}

function rfq_normalize_files(array $files): array {
  if (!isset($files['name'])) return [];
  if (!is_array($files['name'])) {
    return [[
      'name' => (string)($files['name'] ?? ''),
      'type' => (string)($files['type'] ?? ''),
      'tmp_name' => (string)($files['tmp_name'] ?? ''),
      'error' => (int)($files['error'] ?? UPLOAD_ERR_NO_FILE),
      'size' => (int)($files['size'] ?? 0),
    ]];
  }

  $normalized = [];
  $count = count($files['name']);
  for ($i = 0; $i < $count; $i++) {
    $normalized[] = [
      'name' => (string)($files['name'][$i] ?? ''),
      'type' => (string)($files['type'][$i] ?? ''),
      'tmp_name' => (string)($files['tmp_name'][$i] ?? ''),
      'error' => (int)($files['error'][$i] ?? UPLOAD_ERR_NO_FILE),
      'size' => (int)($files['size'][$i] ?? 0),
    ];
  }

  return $normalized;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
  header('Allow: POST, OPTIONS');
  rfq_json_response(200, ['ok' => true]);
}

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
  rfq_json_response(405, ['ok' => false, 'error' => 'METHOD_NOT_ALLOWED']);
}

$name = trim((string)($_POST['name'] ?? ''));
$email = trim((string)($_POST['email'] ?? ''));
$whatsapp = trim((string)($_POST['whatsapp'] ?? ''));
$message = trim((string)($_POST['message'] ?? ''));

if (rfq_strlen($name) < 2 || rfq_strlen($name) > 120) {
  rfq_json_response(400, ['ok' => false, 'error' => 'INVALID_NAME']);
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL) || rfq_strlen($email) > 190) {
  rfq_json_response(400, ['ok' => false, 'error' => 'INVALID_EMAIL']);
}

$whatsappClean = preg_replace('/[^\d+]/', '', $whatsapp);
if ($whatsappClean === null) $whatsappClean = '';
if (rfq_strlen($whatsappClean) < 8 || rfq_strlen($whatsappClean) > 20) {
  rfq_json_response(400, ['ok' => false, 'error' => 'INVALID_WHATSAPP']);
}

if (rfq_strlen($message) < 10 || rfq_strlen($message) > 4000) {
  rfq_json_response(400, ['ok' => false, 'error' => 'INVALID_MESSAGE']);
}

$ip = (string)($_SERVER['REMOTE_ADDR'] ?? '');
$userAgent = (string)($_SERVER['HTTP_USER_AGENT'] ?? '');
if (rfq_strlen($userAgent) > 255) $userAgent = substr($userAgent, 0, 255);

$maxFiles = 5;
$maxFileSize = 5 * 1024 * 1024;
$allowedMimes = [
  'image/jpeg' => 'jpg',
  'image/png' => 'png',
  'image/webp' => 'webp',
  'application/pdf' => 'pdf',
];

$fileMetas = [];
$incomingFiles = rfq_normalize_files($_FILES['files'] ?? []);
if (count($incomingFiles) > $maxFiles) {
  rfq_json_response(400, ['ok' => false, 'error' => 'TOO_MANY_FILES']);
}

try {
  $pdo = rfq_get_pdo();

  $rateStmt = $pdo->prepare('SELECT COUNT(*) AS cnt FROM rfq_requests WHERE ip = :ip AND created_at >= (NOW() - INTERVAL 15 MINUTE)');
  $rateStmt->execute([':ip' => $ip]);
  $rateCount = (int)($rateStmt->fetch()['cnt'] ?? 0);
  if ($rateCount >= 5) {
    rfq_json_response(429, ['ok' => false, 'error' => 'RATE_LIMITED']);
  }

  if (!empty($incomingFiles)) {
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $uploadDir = __DIR__ . '/../uploads/rfq';
    if (!is_dir($uploadDir) && !mkdir($uploadDir, 0755, true)) {
      rfq_json_response(500, ['ok' => false, 'error' => 'UPLOAD_DIR_FAILED']);
    }

    foreach ($incomingFiles as $file) {
      $error = (int)$file['error'];
      if ($error === UPLOAD_ERR_NO_FILE) continue;
      if ($error !== UPLOAD_ERR_OK) {
        rfq_json_response(400, ['ok' => false, 'error' => 'UPLOAD_ERROR']);
      }

      $size = (int)$file['size'];
      if ($size <= 0 || $size > $maxFileSize) {
        rfq_json_response(400, ['ok' => false, 'error' => 'FILE_TOO_LARGE']);
      }

      $tmpName = (string)$file['tmp_name'];
      $mime = $finfo->file($tmpName) ?: '';
      if (!isset($allowedMimes[$mime])) {
        rfq_json_response(400, ['ok' => false, 'error' => 'FILE_TYPE_NOT_ALLOWED']);
      }

      $ext = $allowedMimes[$mime];
      $storedName = bin2hex(random_bytes(16)) . '.' . $ext;
      $targetPath = $uploadDir . '/' . $storedName;

      if (!move_uploaded_file($tmpName, $targetPath)) {
        rfq_json_response(500, ['ok' => false, 'error' => 'UPLOAD_MOVE_FAILED']);
      }

      $fileMetas[] = [
        'originalName' => (string)$file['name'],
        'storedName' => $storedName,
        'mime' => $mime,
        'size' => $size,
        'path' => 'uploads/rfq/' . $storedName,
      ];
    }
  }

  $filesJson = empty($fileMetas) ? null : json_encode($fileMetas, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

  $stmt = $pdo->prepare('INSERT INTO rfq_requests (name, email, whatsapp, message, files_json, ip, user_agent) VALUES (:name, :email, :whatsapp, :message, :files_json, :ip, :user_agent)');
  $stmt->execute([
    ':name' => $name,
    ':email' => $email,
    ':whatsapp' => $whatsappClean,
    ':message' => $message,
    ':files_json' => $filesJson,
    ':ip' => $ip,
    ':user_agent' => $userAgent,
  ]);

  $id = (int)$pdo->lastInsertId();
  rfq_json_response(200, ['ok' => true, 'id' => $id]);
} catch (Throwable $e) {
  error_log('RFQ API error: ' . $e->getMessage());
  rfq_json_response(500, ['ok' => false, 'error' => 'SERVER_ERROR']);
}

