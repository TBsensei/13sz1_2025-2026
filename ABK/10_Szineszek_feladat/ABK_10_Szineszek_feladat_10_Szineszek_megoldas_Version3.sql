CREATE DATABASE IF NOT EXISTS `filmek` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `filmek`;
DROP TABLE IF EXISTS `szineszek`;
CREATE TABLE `szineszek` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nev` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `ferfi` TINYINT(1),
  `szulido` DATE,
  `szulhely` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `szulorsz` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `filmszam` INT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

SELECT nev, filmszam
FROM szineszek
WHERE szulhely = 'New York'
ORDER BY szulido ASC;

SELECT nev, ferfi, filmszam
FROM szineszek
WHERE ferfi = 0 OR (ferfi = 1 AND filmszam > 60)
ORDER BY nev COLLATE utf8mb4_hungarian_ci;

SELECT nev, szulido
FROM szineszek
WHERE szulorsz <> 'USA'
ORDER BY szulido DESC
LIMIT 1;

SELECT szulhely, COUNT(*) AS szineszek_szama
FROM szineszek
GROUP BY szulhely
HAVING COUNT(*) >= 2
ORDER BY szulhely COLLATE utf8mb4_hungarian_ci;

SELECT nev, szulorsz
FROM szineszek
WHERE szulorsz = (
  SELECT szulorsz FROM szineszek WHERE nev = 'Kelly, Grace' LIMIT 1
)
ORDER BY nev COLLATE utf8mb4_hungarian_ci;