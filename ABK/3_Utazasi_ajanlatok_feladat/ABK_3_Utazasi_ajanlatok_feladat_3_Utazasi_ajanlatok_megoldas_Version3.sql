CREATE DATABASE IF NOT EXISTS `utazas` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `utazas`;
DROP TABLE IF EXISTS `ajanlatok`;
CREATE TABLE `ajanlatok` (
  `ajanlataz` INT NOT NULL AUTO_INCREMENT,
  `tajegyseg` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `ejszaka` INT,
  `csalados` TINYINT(1),
  `honap` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `maxfo` INT,
  `foglalt` INT,
  `ar` INT,
  PRIMARY KEY (`ajanlataz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
SELECT tajegyseg, ejszaka, ar
FROM ajanlatok
WHERE csalados = 1 AND honap = 'Július'
ORDER BY ar ASC;
SELECT tajegyseg, honap, ejszaka
FROM ajanlatok
WHERE honap IN ('Március','Április','Május') AND ejszaka > 3
ORDER BY tajegyseg COLLATE utf8mb4_hungarian_ci, honap COLLATE utf8mb4_hungarian_ci;
SELECT ajanlataz, tajegyseg, ejszaka, csalados, honap, maxfo, foglalt, ar
FROM ajanlatok
WHERE tajegyseg = 'Mecsek' AND foglalt >= maxfo
ORDER BY ajanlataz;
SELECT tajegyseg, COUNT(*) AS ajanlatok_szama, ROUND(AVG(ar),0) AS atlag_ar
FROM ajanlatok
GROUP BY tajegyseg
ORDER BY tajegyseg COLLATE utf8mb4_hungarian_ci;
SELECT tajegyseg, FLOOR(ar/10000)*10000 AS ar_csoport, ajanlataz, ejszaka, csalados, honap, maxfo, foglalt, ar
FROM ajanlatok
ORDER BY tajegyseg COLLATE utf8mb4_hungarian_ci, ar_csoport ASC, ar ASC;