CREATE DATABASE IF NOT EXISTS `naprendszer` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `naprendszer`;
DROP TABLE IF EXISTS `bolygohold`;
CREATE TABLE `bolygohold` (
  `elnevezes` VARCHAR(200) NOT NULL,
  `holkering` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `tavolsag` INT,
  `direktirany` TINYINT(1),
  `atmero` INT,
  `felfedezo` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `felfedezeseve` INT,
  PRIMARY KEY (`elnevezes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
INSERT INTO `bolygohold` (`elnevezes`,`holkering`,`tavolsag`,`direktirany`,`atmero`,`felfedezo`,`felfedezeseve`) VALUES ('Hold','Föld',384,1,3476,NULL,NULL);
SELECT elnevezes, holkering, tavolsag, direktirany, atmero, felfedezo, felfedezeseve FROM bolygohold WHERE holkering IN ('Neptunusz','Szaturnusz') AND felfedezeseve IS NOT NULL AND felfedezeseve > 1945 ORDER BY felfedezeseve ASC;
SELECT elnevezes FROM bolygohold WHERE holkering = 'Jupiter' AND tavolsag IS NOT NULL ORDER BY tavolsag ASC LIMIT 2;
SELECT holkering AS bolygo, COUNT(*) AS holdak_szama FROM bolygohold WHERE holkering IS NOT NULL AND holkering <> 'Nap' GROUP BY holkering ORDER BY holdak_szama DESC;
DROP TABLE IF EXISTS `bolygo`;
CREATE TABLE `bolygo` AS SELECT elnevezes, atmero, tavolsag, felfedezeseve FROM bolygohold WHERE holkering = 'Nap';
SELECT holkering AS kozpont, elnevezes, atmero, felfedezeseve, felfedezo FROM bolygohold ORDER BY holkering COLLATE utf8mb4_hungarian_ci, elnevezes COLLATE utf8mb4_hungarian_ci;