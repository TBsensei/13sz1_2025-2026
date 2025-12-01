CREATE DATABASE IF NOT EXISTS `vasarlas` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `vasarlas`;
DROP TABLE IF EXISTS `tetel`;
CREATE TABLE `tetel` (
  `id` INT NOT NULL,
  `termek` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `datum` DATE,
  `bruttoar` INT,
  `mennyiseg` INT,
  `afa` DECIMAL(4,2),
  `allo` TINYINT(1),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

SELECT id, termek, datum, bruttoar, mennyiseg, afa, allo
FROM tetel
WHERE termek IN ('írható DVD','írható CD')
ORDER BY bruttoar DESC;

SELECT id AS id, termek AS `Állóeszközök`, ROUND(bruttoar / (1 + afa),0) AS `Nettóár`
FROM tetel
WHERE allo = 1;

SELECT datum, termek
FROM tetel
WHERE (allo = 1 AND bruttoar > 80000) OR (allo = 0 AND bruttoar > 30000)
ORDER BY datum;

SELECT termek, MIN(bruttoar) AS `Minimum ár`, MAX(bruttoar) AS `Maximum ár`
FROM tetel
WHERE YEAR(datum) = 2005
GROUP BY termek
ORDER BY termek COLLATE utf8mb4_hungarian_ci;

SELECT SUM(bruttoar * mennyiseg) AS `Toner vásárlás értéke`
FROM tetel
WHERE termek LIKE '%toner%';

INSERT INTO tetel (id, termek, datum, bruttoar, mennyiseg, afa, allo)
VALUES (2000, 'tintapatron', '2025-12-01', 10000, 1, 0.20, 0);