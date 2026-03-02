-- =====================================================
-- SQL Schema untuk Request Harga / Quotation Requests
-- deartbox Packaging
-- =====================================================

-- Buat tabel quotation_requests
CREATE TABLE IF NOT EXISTS `quotation_requests` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  
  -- Tipe Form
  `form_type` ENUM('short', 'advanced') NOT NULL DEFAULT 'short',
  
  -- Informasi Kontak (Required)
  `nama` VARCHAR(120) NOT NULL,
  `brand` VARCHAR(120) NOT NULL,
  `whatsapp` VARCHAR(20) NOT NULL,
  `email` VARCHAR(190) NOT NULL,
  `alamat` TEXT DEFAULT NULL,
  
  -- Kebutuhan Packaging
  `jenis_packaging` VARCHAR(255) NOT NULL COMMENT 'JSON array atau comma-separated',
  `deskripsi` TEXT DEFAULT NULL,
  
  -- Detail Produk (Advanced Form)
  `ukuran` VARCHAR(100) DEFAULT NULL COMMENT 'P x L x T cm',
  `quantity` VARCHAR(50) DEFAULT NULL,
  `target_harga` VARCHAR(100) DEFAULT NULL,
  
  -- Material & Finishing (Advanced Form)
  `material` VARCHAR(100) DEFAULT NULL,
  `finishing` VARCHAR(255) DEFAULT NULL COMMENT 'JSON array atau comma-separated',
  
  -- Desain & Timeline (Advanced Form)
  `status_desain` VARCHAR(100) DEFAULT NULL,
  `deadline` DATE DEFAULT NULL,
  
  -- Informasi Tambahan
  `catatan` TEXT DEFAULT NULL,
  `sumber_info` VARCHAR(100) DEFAULT NULL COMMENT 'Bagaimana mengetahui kami',
  
  -- File Uploads (JSON)
  `files_json` JSON DEFAULT NULL,
  
  -- Metadata
  `ip` VARCHAR(45) NOT NULL,
  `user_agent` VARCHAR(255) DEFAULT NULL,
  `status` ENUM('new', 'contacted', 'quoted', 'won', 'lost', 'cancelled') NOT NULL DEFAULT 'new',
  `notes_internal` TEXT DEFAULT NULL COMMENT 'Catatan internal tim',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  INDEX `idx_email` (`email`),
  INDEX `idx_whatsapp` (`whatsapp`),
  INDEX `idx_status` (`status`),
  INDEX `idx_form_type` (`form_type`),
  INDEX `idx_created_at` (`created_at`),
  INDEX `idx_ip_created` (`ip`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Contoh Query untuk Admin Panel (opsional)
-- =====================================================

-- Lihat semua request terbaru
-- SELECT * FROM quotation_requests ORDER BY created_at DESC LIMIT 50;

-- Lihat request berdasarkan status
-- SELECT * FROM quotation_requests WHERE status = 'new' ORDER BY created_at DESC;

-- Update status request
-- UPDATE quotation_requests SET status = 'contacted', notes_internal = 'Sudah dihubungi via WA' WHERE id = 1;

-- Statistik per bulan
-- SELECT 
--   DATE_FORMAT(created_at, '%Y-%m') AS bulan,
--   COUNT(*) AS total_request,
--   SUM(CASE WHEN form_type = 'short' THEN 1 ELSE 0 END) AS short_form,
--   SUM(CASE WHEN form_type = 'advanced' THEN 1 ELSE 0 END) AS advanced_form
-- FROM quotation_requests
-- GROUP BY DATE_FORMAT(created_at, '%Y-%m')
-- ORDER BY bulan DESC;
