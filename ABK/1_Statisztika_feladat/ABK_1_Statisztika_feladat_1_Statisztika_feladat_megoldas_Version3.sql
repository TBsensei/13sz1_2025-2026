CREATE DATABASE IF NOT EXISTS `statisztika` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `statisztika`;
DROP TABLE IF EXISTS `telepules`;
CREATE TABLE `telepules` (
  `telepaz` INT NOT NULL,
  `megnevezes` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `rang` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `kisterseg` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `terulet` INT,
  `nepesseg` INT,
  `lakas` INT,
  PRIMARY KEY (`telepaz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
SELECT megnevezes AS Megnevezes, nepesseg AS Nepesseg
FROM telepules
WHERE rang = 'község' AND nepesseg < 1000
ORDER BY megnevezes ASC;
SELECT megnevezes
FROM telepules
WHERE kisterseg IN ('Makói', 'Csongrádi')
ORDER BY terulet ASC
LIMIT 1;
SELECT megnevezes, FLOOR(nepesseg/terulet) AS Nepsuruseg_per_hektar
FROM telepules
WHERE terulet IS NOT NULL AND terulet > 0 AND (nepesseg/terulet) > 1
ORDER BY Nepsuruseg_per_hektar DESC;
SELECT kisterseg AS kisterseg, COUNT(*) AS telepulesek_szama, SUM(nepesseg) AS ossz_nepesseg
FROM telepules
GROUP BY kisterseg
ORDER BY kisterseg COLLATE utf8mb4_hungarian_ci;
DROP TABLE IF EXISTS telepules2;
CREATE TABLE telepules2 AS SELECT * FROM telepules;
DELETE FROM telepules2 WHERE lakas BETWEEN 200 AND 400;
SELECT COUNT(*) AS telepules2_sorok FROM telepules2;
SELECT telepaz, megnevezes, rang, kisterseg, terulet, nepesseg, lakas
FROM telepules
ORDER BY kisterseg COLLATE utf8mb4_hungarian_ci, megnevezes COLLATE utf8mb4_hungarian_ci;