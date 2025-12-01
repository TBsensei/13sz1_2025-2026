CREATE DATABASE IF NOT EXISTS `versenynaptar` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `versenynaptar`;
DROP TABLE IF EXISTS `adatok`;
CREATE TABLE `adatok` (
  `azon` INT NOT NULL,
  `versenynev` VARCHAR(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `tipus` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `esemeny` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `datum` DATE,
  PRIMARY KEY (`azon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
SELECT datum, versenynev, tipus
FROM adatok
WHERE esemeny = 'Nevezés'
ORDER BY datum ASC;
SELECT tipus, COUNT(*) AS esemenyek_szama
FROM adatok
GROUP BY tipus
ORDER BY tipus COLLATE utf8mb4_hungarian_ci;
SELECT azon, versenynev, tipus, esemeny, datum
FROM adatok
WHERE YEAR(datum) = 2005 AND MONTH(datum) = 2 AND esemeny <> 'Nevezés'
ORDER BY datum ASC;
UPDATE adatok
SET datum = '2005-10-07'
WHERE datum = '2004-10-01';
SELECT DISTINCT datum
FROM adatok
WHERE tipus LIKE '9-10%'
ORDER BY datum ASC;