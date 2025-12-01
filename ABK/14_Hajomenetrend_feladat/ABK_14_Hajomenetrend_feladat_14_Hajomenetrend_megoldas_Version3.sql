CREATE DATABASE IF NOT EXISTS `hajo` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `hajo`;
DROP TABLE IF EXISTS `menetrend`;
CREATE TABLE `menetrend` (
  `azon` INT NOT NULL AUTO_INCREMENT,
  `jarat` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `honnan` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `hova` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `indul` TIME,
  `erkezik` TIME,
  PRIMARY KEY (`azon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

SELECT honnan, indul, hova, erkezik
FROM menetrend
WHERE jarat = 'J1'
ORDER BY TIME(indul) ASC;

SELECT DISTINCT hova
FROM menetrend
WHERE honnan = 'Balatonfüred'
  AND TIME(indul) BETWEEN '11:30:00' AND '12:30:00'
ORDER BY hova COLLATE utf8mb4_hungarian_ci;

SELECT hova AS kikoto, COUNT(*) AS erkezo_hajok
FROM menetrend
GROUP BY hova
ORDER BY erkezo_hajok DESC;

SELECT MAX(erkezik) AS legkesoebb_erkezes
FROM menetrend
WHERE hova = 'Balatonföldvár';

SELECT hova AS vegallomas, erkezik
FROM menetrend
WHERE jarat = 'E2'
  AND erkezik = (
    SELECT MAX(erkezik) FROM menetrend WHERE jarat = 'E2'
  )
LIMIT 1;