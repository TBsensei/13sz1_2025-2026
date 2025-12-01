CREATE DATABASE IF NOT EXISTS `focivb` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `focivb`;
DROP TABLE IF EXISTS `csapat`;
CREATE TABLE `csapat` (
  `resztvevoaz` INT NOT NULL,
  `csapat` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `helyezes` INT,
  `ev` INT,
  `helyszin` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  PRIMARY KEY (`resztvevoaz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
SELECT ev, helyszin, helyezes FROM csapat WHERE csapat = 'Magyarország' ORDER BY ev ASC;
SELECT ev, csapat FROM csapat WHERE helyezes = 1 AND ev BETWEEN 1954 AND 1986 ORDER BY ev ASC;
SELECT csapat, COUNT(*) AS reszvetel_szama FROM csapat GROUP BY csapat HAVING COUNT(*) >= 2 ORDER BY reszvetel_szama DESC;
DROP TABLE IF EXISTS `helyszin`;
CREATE TABLE `helyszin` AS SELECT DISTINCT ev, helyszin FROM csapat ORDER BY ev;
SELECT c2.csapat, c2.ev FROM csapat c1 JOIN csapat c2 ON c1.ev = c2.ev WHERE c1.csapat = 'Brazília' AND c1.helyezes = 1 AND c2.helyezes = 2 ORDER BY c2.ev;
SELECT ev, helyezes, csapat, helyszin FROM csapat ORDER BY ev ASC, helyezes ASC;