                            -- Tóth Balázs, Krupa Levente, Chrenkó Balázs --


-- 9.0 Külső kulcs hozzáadása utólag
ALTER TABLE turnus 
ADD CONSTRAINT fk_turnus_utazas 
FOREIGN KEY (utazas_id) REFERENCES utazas(id);

-- 9.1 Országonként városok száma
SELECT orszag, COUNT(varos) AS varosok_szama
FROM utazas
GROUP BY orszag
ORDER BY varosok_szama DESC;

-- 9.2 Első tíz legtávolabbi úticél
SELECT orszag, varos, tavolsag
FROM utazas
ORDER BY tavolsag DESC
LIMIT 10;

-- 9.3 Úticélok 120.000 Ft alatt
SELECT orszag, varos, alapar
FROM utazas
WHERE alapar < 120000
ORDER BY alapar;

-- 9.4 Felhasználónként megrendelt utak száma
SELECT f.nev, f.felhasznalonev, COUNT(u.turnus_id) AS megrendelt_utak_szama
FROM felhasznalo f
LEFT JOIN utazik u ON f.id = u.felh_ID
GROUP BY f.id, f.nev, f.felhasznalonev
ORDER BY megrendelt_utak_szama DESC;

-- 9.5 Felhasználók, akik több útra is elmentek
SELECT f.nev, f.felhasznalonev, COUNT(u.turnus_id) AS utak_szama
FROM felhasznalo f
INNER JOIN utazik u ON f.id = u.felh_ID
GROUP BY f.id, f.nev, f.felhasznalonev
HAVING COUNT(u.turnus_id) > 1
ORDER BY utak_szama DESC;

-- 9.6 Top 3 felhasználó költések alapján
SELECT f.nev, f.felhasznalonev, 
       SUM(ut.alapar + um.ar + um.jarulekos_koltseg) AS osszkoltseg
FROM felhasznalo f
INNER JOIN utazik u ON f.id = u.felh_ID
INNER JOIN turnus t ON u.turnus_id = t.id
INNER JOIN utazas ut ON t.utazas_id = ut.id
INNER JOIN utazasi_mod um ON t.mod_id = um.id
WHERE u.fizetve = 1
GROUP BY f.id, f.nev, f.felhasznalonev
ORDER BY osszkoltseg DESC
LIMIT 3;

-- 9.7 Legnépszerűbb úticél(ok) és indulási időpont
-- Legnépszerűbb úticélok
SELECT ut.orszag, ut.varos, COUNT(u.felh_ID) AS utazok_szama
FROM utazas ut
INNER JOIN turnus t ON ut.id = t.utazas_id
INNER JOIN utazik u ON t.id = u.turnus_id
GROUP BY ut.id, ut.orszag, ut.varos
HAVING COUNT(u.felh_ID) = (
    SELECT MAX(utazo_szam) 
    FROM (
        SELECT COUNT(u2.felh_ID) AS utazo_szam
        FROM utazas ut2
        INNER JOIN turnus t2 ON ut2.id = t2.utazas_id
        INNER JOIN utazik u2 ON t2.id = u2.turnus_id
        GROUP BY ut2.id
    ) AS max_utazok
);

-- Legtöbben melyik indulási időpontban indulnak
SELECT t.indulasi_ido, COUNT(u.felh_ID) AS utazok_szama
FROM turnus t
INNER JOIN utazik u ON t.id = u.turnus_id
GROUP BY t.indulasi_ido
ORDER BY utazok_szama DESC
LIMIT 1;

-- 9.8 Nézettábla utazások bevételeire
CREATE VIEW utazas_bevetel AS
SELECT 
    ut.id AS utazas_id,
    ut.orszag,
    ut.varos,
    t.indulasi_ido,
    SUM(CASE WHEN u.fizetve = 1 
        THEN ut.alapar + um.ar + um.jarulekos_koltseg 
        ELSE 0 END) AS osszbevetel
FROM utazas ut
LEFT JOIN turnus t ON ut.id = t.utazas_id
LEFT JOIN utazasi_mod um ON t.mod_id = um.id
LEFT JOIN utazik u ON t.id = u.turnus_id
GROUP BY ut.id, ut.orszag, ut.varos, t.indulasi_ido
ORDER BY ut.orszag, ut.varos, t.indulasi_ido;

-- 9.9 Utak, amelyekből nem indulnak turnusok
SELECT ut.orszag, ut.varos, ut.alapar
FROM utazas ut
LEFT JOIN turnus t ON ut.id = t.utazas_id
WHERE t.utazas_id IS NULL
ORDER BY ut.orszag ASC, ut.varos ASC, ut.alapar DESC;

-- 9.10 2014 augusztusi turnusok utazásonként
SELECT ut.orszag, ut.varos, COUNT(t.id) AS turnusok_szama
FROM utazas ut
INNER JOIN turnus t ON ut.id = t.utazas_id
WHERE YEAR(t.indulasi_ido) = 2014 AND MONTH(t.indulasi_ido) = 8
GROUP BY ut.id, ut.orszag, ut.varos
ORDER BY turnusok_szama DESC;