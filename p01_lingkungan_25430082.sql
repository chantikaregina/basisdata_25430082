-- p01_lingkungan_25430082.sql
-- Password sengaja diganti penanda. JANGAN commit password asli.
CREATE DATABASE IF NOT EXISTS kopma_082 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_082'@'localhost' IDENTIFIED BY '<password_kerja>'; 
GRANT ALL PRIVILEGES ON kopma_082.* TO 'mhs_082'@'localhost';

CREATE USER IF NOT EXISTS 'tamu_082'@'localhost' IDENTIFIED BY '<password_tamu>';
GRANT SELECT ON kopma_082.* TO 'tamu_082'@'localhost';

CREATE USER IF NOT EXISTS 'dev_082'@'localhost' IDENTIFIED BY '<password_dev>';
GRANT ALL PRIVILEGES ON kopma_082.* TO 'dev_082'@'localhost';

FLUSH PRIVILEGES;