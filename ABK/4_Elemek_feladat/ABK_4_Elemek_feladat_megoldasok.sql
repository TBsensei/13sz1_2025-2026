CREATE DATABASE IF NOT EXISTS `elemek` CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `elemek`;
CREATE TABLE IF NOT EXISTS `felfedez` (
  `rendszam` INT NOT NULL,
  `vegyjel` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `elemneve` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `felfedeve` INT,
  `felfedezo` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `gaz` TINYINT(1),
  PRIMARY KEY (`rendszam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
SELECT felfedezo, felfedeve, elemneve FROM felfedez WHERE felfedezo IN ('Hevesy György','Müller Ferenc') ORDER BY felfedezo, felfedeve;
SELECT elemneve, vegyjel, rendszam FROM felfedez WHERE elemneve LIKE '%ium' ORDER BY elemneve ASC;
SELECT DISTINCT rendszam, vegyjel, elemneve, felfedeve, felfedezo, gaz FROM felfedez WHERE felfedeve BETWEEN 1800 AND 1850 ORDER BY felfedeve, rendszam;
SELECT elemneve, felfedeve FROM felfedez WHERE gaz = 1 AND felfedeve = (SELECT MAX(felfedeve) FROM felfedez WHERE gaz = 1 AND felfedeve IS NOT NULL);
SELECT COUNT(*) AS egybetus_szam FROM felfedez WHERE CHAR_LENGTH(vegyjel) = 1;
SELECT elemneve, felfedezo FROM felfedez WHERE felfedeve = (SELECT felfedeve FROM felfedez WHERE elemneve = 'kalcium' LIMIT 1) AND elemneve <> 'kalcium' ORDER BY elemneve;
```