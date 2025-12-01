CREATE DATABASE IF NOT EXISTS `vizallas` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `vizallas`;
DROP TABLE IF EXISTS `meres`;
CREATE TABLE `meres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE,
  `vizallas` INT,
  `varos` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `folyo` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
SELECT varos, vizallas
FROM meres
WHERE datum = '2002-12-31'
ORDER BY varos COLLATE utf8mb4_hungarian_ci;
SELECT DISTINCT varos
FROM meres
ORDER BY varos COLLATE utf8mb4_hungarian_ci;
SELECT COUNT(*) AS alkalom
FROM meres
WHERE folyo = 'Tisza' AND vizallas > 900;
SELECT datum, vizallas
FROM meres
WHERE varos = 'Budapest' AND vizallas = (
  SELECT MAX(vizallas) FROM meres WHERE varos = 'Budapest'
);
SELECT varos, vizallas, datum
FROM meres
WHERE folyo = 'Duna' AND datum IN (
  SELECT DISTINCT datum FROM meres WHERE vizallas = 928
)
ORDER BY varos COLLATE utf8mb4_hungarian_ci;