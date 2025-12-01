CREATE DATABASE IF NOT EXISTS `allamok` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `allamok`;
DROP TABLE IF EXISTS `orszagok`;
CREATE TABLE `orszagok` (
  `allam` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `allamforma` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `terulet` INT,
  `nepesseg` INT,
  `foldresz` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  PRIMARY KEY (`allam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
INSERT INTO orszagok (allam, allamforma, terulet, nepesseg, foldresz) VALUES ('Belize','köztársaság',22965,189,'Közép-Amerika');
SELECT DISTINCT allam, allamforma, terulet, nepesseg, foldresz FROM orszagok WHERE allam LIKE '%szigetek%';
SELECT allam, terulet FROM orszagok WHERE foldresz IN ('Afrika','Dél-Amerika') AND terulet > 500000 ORDER BY terulet DESC;
SELECT allam, nepesseg FROM orszagok ORDER BY terulet ASC LIMIT 3;
SELECT COUNT(*) AS allamok_szama, SUM(terulet) AS ossz_terulet, SUM(nepesseg) AS ossz_nepesseg FROM orszagok WHERE foldresz = 'Afrika';
SELECT foldresz, allamforma, allam, terulet FROM orszagok ORDER BY foldresz COLLATE utf8mb4_hungarian_ci, allamforma COLLATE utf8mb4_hungarian_ci, allam COLLATE utf8mb4_hungarian_ci;
ALTER TABLE orszagok ADD COLUMN Nepsuruseg DOUBLE;
UPDATE orszagok SET Nepsuruseg = (nepesseg * 1000) / NULLIF(terulet,0);
SELECT allam, Nepsuruseg FROM orszagok;