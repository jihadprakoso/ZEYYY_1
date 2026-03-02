<?php
declare(strict_types=1);

function rfq_get_pdo(): PDO {
  $host = getenv('RFQ_DB_HOST') ?: 'localhost';
  $dbName = getenv('RFQ_DB_NAME') ?: 'CHANGE_ME_DB_NAME';
  $user = getenv('RFQ_DB_USER') ?: 'CHANGE_ME_DB_USER';
  $pass = getenv('RFQ_DB_PASS') ?: 'CHANGE_ME_DB_PASS';

  $dsn = "mysql:host={$host};dbname={$dbName};charset=utf8mb4";

  $options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
  ];

  return new PDO($dsn, $user, $pass, $options);
}

