# StudentScheduler - Diák Időbeosztás Szervező

## Leírás
Egy c# WPF alkalmazás, amely segít a tanulmányi feladatok, 
órarend és határidők kezelésében. Háromféle szerepkörrel rendelkezik:
Admin, Tanár és Diák.

## Funkciók

### Admin
- Felhasználók kezelése (hozzáadás, szerkesztés, törlés)
- Tantárgyak kezelése
- Órarend összeállítása
- Teljes rendszer áttekintés

### Tanár
- Saját tantárgyak megtekintése
- Feladatok kiadása diákoknak
- Határidők beállítása
- Prioritások megadása

### Diák
- Órarend megtekintése
- Feladatok megtekintése
- Feladat állapot módosítása (Nem kezdett/Folyamatban/Kész)
- Jegyzet hozzáadása feladatokhoz
- Statisztikák megtekintése

## Használat

### Első indítás
Az alkalmazás automatikusan létrehoz 3 alapértelmezett felhasználót:
- **admin** / admin123 (Admin)
- **tanar1** / tanar123 (Tanár)
- **diak1** / diak123 (Diák)

### Adatok tárolása
Az adatok JSON formátumban kerülnek mentésre az `AppData` mappában.

## Technológiák
- C# WPF
- JSON fájl alapú adattárolás
- LINQ adatlekérdezések
