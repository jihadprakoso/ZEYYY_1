<?php
declare(strict_types=1);

/**
 * Request Harga API - deartbox Packaging
 * Handles quotation form submissions (Short & Advanced forms)
 */

require __DIR__ . '/db.php';

// =====================================================
// Helper Functions
// =====================================================

function rh_strlen(string $value): int {
  if (function_exists('mb_strlen')) return mb_strlen($value, 'UTF-8');
  return strlen($value);
}

function rh_json_response(int $status, array $payload): void {
  http_response_code($status);
  header('Content-Type: application/json; charset=utf-8');
  header('X-Content-Type-Options: nosniff');
  header('Access-Control-Allow-Origin: https://deartbox.com');
  header('Access-Control-Allow-Methods: POST, OPTIONS');
  header('Access-Control-Allow-Headers: Content-Type');
  echo json_encode($payload, JSON_UNESCAPED_UNICODE);
  exit;
}

function rh_normalize_files(array $files): array {
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

function rh_sanitize_string(string $value, int $maxLen = 255): string {
  $value = trim($value);
  if (rh_strlen($value) > $maxLen) {
    $value = mb_substr($value, 0, $maxLen, 'UTF-8');
  }
  return $value;
}

function rh_sanitize_array_to_string($value): string {
  if (is_array($value)) {
    return implode(', ', array_map('trim', $value));
  }
  return trim((string)$value);
}

// =====================================================
// Handle CORS Preflight
// =====================================================

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
  header('Allow: POST, OPTIONS');
  rh_json_response(200, ['ok' => true]);
}

// =====================================================
// Only Allow POST
// =====================================================

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
  rh_json_response(405, ['ok' => false, 'error' => 'METHOD_NOT_ALLOWED']);
}

// =====================================================
// Extract & Validate Form Data
// =====================================================

// Form Type
$formType = trim((string)($_POST['form_type'] ?? 'short'));
if (!in_array($formType, ['short', 'advanced'], true)) {
  $formType = 'short';
}

// Required Fields (Both Forms)
$nama = rh_sanitize_string((string)($_POST['nama'] ?? ''), 120);
$brand = rh_sanitize_string((string)($_POST['brand'] ?? ''), 120);
$whatsapp = trim((string)($_POST['whatsapp'] ?? ''));
$email = trim((string)($_POST['email'] ?? ''));
$jenisPackaging = rh_sanitize_array_to_string($_POST['jenis_packaging'] ?? '');
$deskripsi = rh_sanitize_string((string)($_POST['deskripsi'] ?? ''), 4000);

// Optional Fields (Advanced Form)
$alamat = rh_sanitize_string((string)($_POST['alamat'] ?? ''), 1000);
$ukuran = rh_sanitize_string((string)($_POST['ukuran'] ?? ''), 100);
$quantity = rh_sanitize_string((string)($_POST['quantity'] ?? ''), 50);
$targetHarga = rh_sanitize_string((string)($_POST['target_harga'] ?? ''), 100);
$material = rh_sanitize_string((string)($_POST['material'] ?? ''), 100);
$finishing = rh_sanitize_array_to_string($_POST['finishing'] ?? '');
$statusDesain = rh_sanitize_string((string)($_POST['status_desain'] ?? ''), 100);
$deadline = trim((string)($_POST['deadline'] ?? ''));
$catatan = rh_sanitize_string((string)($_POST['catatan'] ?? ''), 4000);
$sumberInfo = rh_sanitize_string((string)($_POST['sumber_info'] ?? ''), 100);

// =====================================================
// Validation
// =====================================================

// Nama
if (rh_strlen($nama) < 2 || rh_strlen($nama) > 120) {
  rh_json_response(400, ['ok' => false, 'error' => 'INVALID_NAME', 'message' => 'Nama harus 2-120 karakter']);
}

// Brand
if (rh_strlen($brand) < 2 || rh_strlen($brand) > 120) {
  rh_json_response(400, ['ok' => false, 'error' => 'INVALID_BRAND', 'message' => 'Nama brand harus 2-120 karakter']);
}

// Email
if (!filter_var($email, FILTER_VALIDATE_EMAIL) || rh_strlen($email) > 190) {
  rh_json_response(400, ['ok' => false, 'error' => 'INVALID_EMAIL', 'message' => 'Format email tidak valid']);
}

// WhatsApp
$whatsappClean = preg_replace('/[^\d+]/', '', $whatsapp);
if ($whatsappClean === null) $whatsappClean = '';
if (rh_strlen($whatsappClean) < 8 || rh_strlen($whatsappClean) > 20) {
  rh_json_response(400, ['ok' => false, 'error' => 'INVALID_WHATSAPP', 'message' => 'Nomor WhatsApp tidak valid']);
}

// Jenis Packaging
if (rh_strlen($jenisPackaging) < 2) {
  rh_json_response(400, ['ok' => false, 'error' => 'INVALID_PACKAGING', 'message' => 'Pilih minimal 1 jenis packaging']);
}

// Deskripsi (required for short form)
if ($formType === 'short' && rh_strlen($deskripsi) < 10) {
  rh_json_response(400, ['ok' => false, 'error' => 'INVALID_DESCRIPTION', 'message' => 'Deskripsi minimal 10 karakter']);
}

// Advanced Form Validations
if ($formType === 'advanced') {
  if (rh_strlen($ukuran) < 3) {
    rh_json_response(400, ['ok' => false, 'error' => 'INVALID_SIZE', 'message' => 'Ukuran box harus diisi']);
  }
  if (rh_strlen($quantity) < 1) {
    rh_json_response(400, ['ok' => false, 'error' => 'INVALID_QUANTITY', 'message' => 'Quantity harus diisi']);
  }
  if (rh_strlen($material) < 2) {
    rh_json_response(400, ['ok' => false, 'error' => 'INVALID_MATERIAL', 'message' => 'Pilih jenis material']);
  }
  if (rh_strlen($statusDesain) < 2) {
    rh_json_response(400, ['ok' => false, 'error' => 'INVALID_DESIGN_STATUS', 'message' => 'Pilih status desain']);
  }
}

// Validate deadline format if provided
$deadlineDate = null;
if (!empty($deadline)) {
  $d = DateTime::createFromFormat('Y-m-d', $deadline);
  if ($d && $d->format('Y-m-d') === $deadline) {
    $deadlineDate = $deadline;
  }
}

// =====================================================
// Metadata
// =====================================================

$ip = (string)($_SERVER['REMOTE_ADDR'] ?? '');
$userAgent = (string)($_SERVER['HTTP_USER_AGENT'] ?? '');
if (rh_strlen($userAgent) > 255) $userAgent = substr($userAgent, 0, 255);

// =====================================================
// File Upload Configuration
// =====================================================

$maxFiles = 5;
$maxFileSize = 50 * 1024 * 1024; // 50MB
$allowedMimes = [
  'image/jpeg' => 'jpg',
  'image/png' => 'png',
  'image/webp' => 'webp',
  'image/gif' => 'gif',
  'application/pdf' => 'pdf',
];

$fileMetas = [];
$incomingFiles = rh_normalize_files($_FILES['files'] ?? []);
if (count($incomingFiles) > $maxFiles) {
  rh_json_response(400, ['ok' => false, 'error' => 'TOO_MANY_FILES', 'message' => 'Maksimal 5 file']);
}

// =====================================================
// Database & File Processing
// =====================================================

try {
  $pdo = rfq_get_pdo();

  // Rate Limiting: 5 requests per 15 minutes per IP
  $rateStmt = $pdo->prepare('SELECT COUNT(*) AS cnt FROM quotation_requests WHERE ip = :ip AND created_at >= (NOW() - INTERVAL 15 MINUTE)');
  $rateStmt->execute([':ip' => $ip]);
  $rateCount = (int)($rateStmt->fetch()['cnt'] ?? 0);
  if ($rateCount >= 5) {
    rh_json_response(429, ['ok' => false, 'error' => 'RATE_LIMITED', 'message' => 'Terlalu banyak request. Coba lagi dalam 15 menit.']);
  }

  // Process File Uploads
  if (!empty($incomingFiles)) {
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $uploadDir = __DIR__ . '/../uploads/requestharga';
    if (!is_dir($uploadDir) && !mkdir($uploadDir, 0755, true)) {
      rh_json_response(500, ['ok' => false, 'error' => 'UPLOAD_DIR_FAILED', 'message' => 'Gagal membuat folder upload']);
    }

    foreach ($incomingFiles as $file) {
      $error = (int)$file['error'];
      if ($error === UPLOAD_ERR_NO_FILE) continue;
      if ($error !== UPLOAD_ERR_OK) {
        rh_json_response(400, ['ok' => false, 'error' => 'UPLOAD_ERROR', 'message' => 'Error saat upload file']);
      }

      $size = (int)$file['size'];
      if ($size <= 0 || $size > $maxFileSize) {
        rh_json_response(400, ['ok' => false, 'error' => 'FILE_TOO_LARGE', 'message' => 'Ukuran file maksimal 50MB']);
      }

      $tmpName = (string)$file['tmp_name'];
      $mime = $finfo->file($tmpName) ?: '';
      if (!isset($allowedMimes[$mime])) {
        rh_json_response(400, ['ok' => false, 'error' => 'FILE_TYPE_NOT_ALLOWED', 'message' => 'Tipe file tidak diizinkan. Gunakan JPG, PNG, WEBP, GIF, atau PDF']);
      }

      $ext = $allowedMimes[$mime];
      $storedName = bin2hex(random_bytes(16)) . '.' . $ext;
      $targetPath = $uploadDir . '/' . $storedName;

      if (!move_uploaded_file($tmpName, $targetPath)) {
        rh_json_response(500, ['ok' => false, 'error' => 'UPLOAD_MOVE_FAILED', 'message' => 'Gagal menyimpan file']);
      }

      $fileMetas[] = [
        'originalName' => (string)$file['name'],
        'storedName' => $storedName,
        'mime' => $mime,
        'size' => $size,
        'path' => 'uploads/requestharga/' . $storedName,
      ];
    }
  }

  $filesJson = empty($fileMetas) ? null : json_encode($fileMetas, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

  // Insert to Database
  $stmt = $pdo->prepare('
    INSERT INTO quotation_requests (
      form_type, nama, brand, whatsapp, email, alamat,
      jenis_packaging, deskripsi, ukuran, quantity, target_harga,
      material, finishing, status_desain, deadline,
      catatan, sumber_info, files_json, ip, user_agent
    ) VALUES (
      :form_type, :nama, :brand, :whatsapp, :email, :alamat,
      :jenis_packaging, :deskripsi, :ukuran, :quantity, :target_harga,
      :material, :finishing, :status_desain, :deadline,
      :catatan, :sumber_info, :files_json, :ip, :user_agent
    )
  ');

  $stmt->execute([
    ':form_type' => $formType,
    ':nama' => $nama,
    ':brand' => $brand,
    ':whatsapp' => $whatsappClean,
    ':email' => $email,
    ':alamat' => $alamat ?: null,
    ':jenis_packaging' => $jenisPackaging,
    ':deskripsi' => $deskripsi ?: null,
    ':ukuran' => $ukuran ?: null,
    ':quantity' => $quantity ?: null,
    ':target_harga' => $targetHarga ?: null,
    ':material' => $material ?: null,
    ':finishing' => $finishing ?: null,
    ':status_desain' => $statusDesain ?: null,
    ':deadline' => $deadlineDate,
    ':catatan' => $catatan ?: null,
    ':sumber_info' => $sumberInfo ?: null,
    ':files_json' => $filesJson,
    ':ip' => $ip,
    ':user_agent' => $userAgent,
  ]);

  $id = (int)$pdo->lastInsertId();

  rh_json_response(200, [
    'ok' => true,
    'id' => $id,
    'message' => 'Request berhasil dikirim! Tim kami akan menghubungi Anda dalam 1x24 jam.'
  ]);

} catch (Throwable $e) {
  error_log('Request Harga API error: ' . $e->getMessage());
  rh_json_response(500, ['ok' => false, 'error' => 'SERVER_ERROR', 'message' => 'Terjadi kesalahan server. Silakan coba lagi.']);
}
