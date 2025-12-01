CREATE DATABASE IF NOT EXISTS `felveteli` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `felveteli`;
DROP TABLE IF EXISTS `jelentkezes`;
CREATE TABLE `jelentkezes` (
  `jaz` INT NOT NULL AUTO_INCREMENT,
  `nev` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `intezmeny` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `szak` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `felev` INT,
  `hanyadik` INT,
  PRIMARY KEY (`jaz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
SELECT nev FROM jelentkezes WHERE felev = 6;
SELECT nev, intezmeny, szak, felev, hanyadik
FROM jelentkezes
WHERE (hanyadik IN (1,2) AND szak LIKE '%közgazdász%')
   OR (szak LIKE '%tanár%');
SELECT nev, COUNT(*) AS beadott_jelentkezesek_szama
FROM jelentkezes
GROUP BY nev
ORDER BY beadott_jelentkezesek_szama DESC
LIMIT 1;
ALTER TABLE jelentkezes ADD COLUMN `BSc` TINYINT(1) DEFAULT 0;
UPDATE jelentkezes SET `BSc` = 1 WHERE szak LIKE '%BSc%';
SELECT jaz, nev, intezmeny, szak, felev, hanyadik, BSc FROM jelentkezes;