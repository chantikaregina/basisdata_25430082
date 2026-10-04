-- p01_lingkungan_25430082.sql
-- Password sengaja diganti penanda. JANGAN commit password asli.
CREATE DATABASE perpus_082
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'mhs_082'@'localhost' IDENTIFIED BY '<password_kerja>';
GRANT ALL PRIVILEGES ON perpus_082.* TO 'mhs_082'@'localhost';