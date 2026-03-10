## Projekt Telepítése és Futtatása (Setup Guide)

Ez az útmutató lépésről lépésre bemutatja, hogyan tudod elindítani a Kézműves Webshop backend (Laravel) projektjét a saját számítógépeden.

### Előfeltételek (Prerequisites)
A projekt futtatásához a következő programoknak kell telepítve lenniük a gépeden:
* **XAMPP** (vagy hasonló helyi szerver környezet, ami biztosítja a PHP-t és a MySQL-t)
* **Composer** (PHP csomagkezelő)
* **Git** (a projekt letöltéséhez)

### Telepítési Lépések

**1. A projekt letöltése (Clone)**
Nyiss egy terminált, és töltsd le a projektet a GitHubról:
```bash
git clone <IDE_JÖN_A_GITHUB_REPO_LINKED>
cd vizsgaremek_BE_test
```

**2. Függőségek telepítése**
A Laravel működéséhez szükséges csomagok telepítése a Composer segítségével:
```bash
composer install
```

**3. Környezeti változók beállítása (.env)**
A Laravel a beállításokat egy `.env` fájlban tárolja. Mivel ez nem kerül fel a GitHubra (biztonsági okokból), a letöltés után létre kell hoznod a minta alapján:
```bash
cp .env.example .env
```

**4. Applikációs kulcs generálása**
Generálj egy új titkosító kulcsot a projekthez:
```bash
php artisan key:generate
```

**5. Adatbázis beállítása**
1. Indítsd el a **XAMPP** vezérlőpultján az Apache és MySQL modulokat.
2. Nyisd meg a böngészőben a phpMyAdmin-t (`http://localhost/phpmyadmin`).
3. Hozz létre egy új, üres adatbázist **`kezmuves_db`** néven (Illesztés: `utf8mb4_unicode_ci`).
4. Nyisd meg a projekt gyökerében található `.env` fájlt, és állítsd be az adatbázis-kapcsolatot az alábbiak szerint:
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=kezmuves_db
DB_USERNAME=root
DB_PASSWORD=
```

**6. Migrációk és Tesztadatok betöltése (Database Seeding)**
Futtasd le az alábbi parancsot a terminálban, ami felépíti a táblákat és feltölti a rendszert tesztadatokkal (pl. admin felhasználóval és termékekkel):
```bash
php artisan migrate:fresh --seed
```

**7. A szerver elindítása**
Indítsd el a Laravel beépített fejlesztői szerverét:
```bash
php artisan serve
```

A backend API most már fut, és elérhető a `http://127.0.0.1:8000` címen! A termékek teszteléséhez nyisd meg a `http://127.0.0.1:8000/api/products` végpontot a böngésződben.