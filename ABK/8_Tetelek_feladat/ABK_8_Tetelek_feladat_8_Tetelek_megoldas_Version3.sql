CREATE DATABASE IF NOT EXISTS `tetelek` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `tetelek`;
DROP TABLE IF EXISTS `kidolgoz`;
CREATE TABLE `kidolgoz` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `emailcim` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `targy` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `tetel` INT,
  `hatarido` DATE,
  `leadas` DATE,
  `ertek` INT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
SELECT tetel, hatarido
FROM kidolgoz
WHERE emailcim = 'tercsi@citrommail.net' AND targy = 'magyar'
ORDER BY leadas;
SELECT targy, tetel
FROM kidolgoz
WHERE emailcim LIKE '%@freemai.net' AND hatarido < '2005-02-01'
ORDER BY targy, tetel;
SELECT targy, ROUND(AVG(ertek),2) AS atlag
FROM kidolgoz
GROUP BY targy
ORDER BY atlag DESC
LIMIT 1;
SELECT DISTINCT emailcim
FROM kidolgoz
WHERE ertek < 60 AND YEAR(leadas) = 2005;
SELECT targy, tetel, hatarido, leadas
FROM kidolgoz
WHERE targy IN ('magyar','történelem') AND leadas > hatarido
ORDER BY targy, tetel;
ALTER TABLE kidolgoz ADD COLUMN `jeles` TINYINT(1) DEFAULT 0;
UPDATE kidolgoz SET jeles = 1 WHERE ertek >= 80;
SELECT id, emailcim, targy, tetel, hatarido, leadas, ertek, jeles FROM kidolgoz;