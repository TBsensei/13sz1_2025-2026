

# 🚀 Hogyan futtasd a Hírportál Projektet a saját gépeden?

Sziasztok! Itt van a lépésről-lépésre útmutató, hogyan tudjátok elindítani a projektet, létrehozni a saját adatbázisotokat és beállítani a levelezést.

### 🛠️ 0. Előfeltételek (Ezeknek fent kell lenniük a gépeden)

* **XAMPP** (vagy más PHP/MySQL környezet) - A szerverhez és adatbázishoz.
* **Composer** - A PHP csomagkezelő (ez tölti le a hiányzó fájlokat).
* **Git** - A letöltéshez.

---

### 📥 1. A projekt letöltése

Nyisd meg a terminált (vagy Git Bash-t), menj abba a mappába, ahová a projektet szeretnéd, és futtasd le:

```bash
git clone [IDE_ILLESZD_BE_A_GITHUB_LINKET]
cd [A_PROJEKT_MAPPA_NEVE]

```

---

### 📦 2. Hiányzó csomagok telepítése

A GitHubon nincsenek fent a "vendor" mappák (túl nagyok), ezeket le kell töltened:

```bash
composer install
npm install

```

---

### ⚙️ 3. A környezet beállítása (.env)

A beállításokat tartalmazó fájl (`.env`) titkos, ezért nincs fent GitHubon. Létre kell hoznod egy sajátot a minta alapján.

1. Másold le a `.env.example` fájlt, és nevezd át `.env`-re.
* Vagy parancssorban: `cp .env.example .env` (Windows: `copy .env.example .env`)


2. Generálj egy titkos kulcsot az alkalmazáshoz:
```bash
php artisan key:generate

```



---

### 🗄️ 4. Adatbázis létrehozása

Mivel mindenki a saját gépén dolgozik, saját adatbázis kell.

1. Indítsd el a **XAMPP**-ban a **MySQL**-t és az **Apache**-t.
2. Menj a `http://localhost/phpmyadmin` oldalra.
3. Hozz létre egy új adatbázist ezzel a névvel: **`news_db`** (vagy amilyen nevet szeretnél).
4. Nyisd meg a projektedben a **`.env`** fájlt, és ellenőrizd ezeket a sorokat:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=news_db  <-- Ez legyen az adatbázisod neve!
DB_USERNAME=root     <-- XAMPP alapértelmezett
DB_PASSWORD=         <-- XAMPP-nál általában üres

```

5. Futtasd le a migrációt (ez hozza létre a táblákat):
```bash
php artisan migrate

```



---

### 📧 5. Mailtrap (Email) beállítása

Hogy tesztelni tudjátok az email küldést, mindenkinek szüksége van egy saját (ingyenes) Mailtrap fiókra.

1. Regisztrálj: [https://mailtrap.io](https://mailtrap.io)
2. Menj ide: **Email Testing** -> **Inboxes** -> **My Inbox**.
3. Kattints a **"Show Credentials"** gombra.
4. A listából válaszd ki: **Laravel 9+**.
5. Másold ki a kódokat, és illeszd be a **`.env`** fájlodba a `MAIL_...` kezdetű sorok helyére:

```env
MAIL_MAILER=smtp
MAIL_HOST=sandbox.smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=ide_jon_a_te_felhasznaloneved
MAIL_PASSWORD=ide_jon_a_te_jelszavad
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

```

---

### 🚀 6. Indítás!

Ha mindez megvan, indítsd el a fejlesztői szervert:

```bash
php artisan serve

```

Most már megnyithatod a böngészőben: **[http://127.0.0.1:8000](http://127.0.0.1:8000)**

Jó munkát! 🎉
