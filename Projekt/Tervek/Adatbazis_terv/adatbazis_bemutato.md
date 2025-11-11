# Kézműves Kincsek — Adatbázis-terv

Mi vagyunk a Kézműves Kincsek csapata. Az adatbázis-tervünk egy e‑kereskedelmi webshop alapjait fedi le. A cél egy átlátható, normalizált relációs séma kialakítása volt, amely támogatja a felhasználókezelést, a kézműves profilokat, a termékek és kategóriák kezelését, a kosár‑ és rendelési folyamatot, valamint az értékeléseket és alap riportokat.

## Alapelvek

- Normalizáció és adatintegritás elsődleges szempontok.  
- Minden tábla egyértelmű felelősséggel rendelkezik.  
- Fontos mezők indexelése a lekérdezési teljesítmény érdekében.  
- A séma reprodukálható, importálható SQL fájl formájában.

## Főbb entitások és rövid leírás

- **roles**: felhasználói szerepkörök kezelése.  
- **users**: regisztrált felhasználók adatai és jogosultságai.  
- **artisans**: kézműves eladói profilok, felhasználókhoz kapcsolva.  
- **categories**: termékkategóriák hierarchiája.  
- **products**: termékek alapadatai, termékszintű információk.  
- **product_images**: termékhez tartozó képek.  
- **cart** és **cart_items**: kosár és kosártételek ideiglenes tárolása.  
- **orders** és **order_items**: leadott rendelések és a rendelés tételei.  
- **product_reviews** és **review_images**: vásárlói értékelések és azok képei.  
- **notifications**, **email_templates**, **settings**, **activity_logs**: értesítések, sablonok, konfiguráció és audit napló.

## Főbb kapcsolatok

- `users.role_id` hivatkozik `roles.id`-re.  
- `artisans.user_id` hivatkozik `users.id`-re.  
- `products.artisan_id` hivatkozik `artisans.id`-re; `products.category_id` hivatkozik `categories.id`-re.  
- `order_items.order_id` hivatkozik `orders.id`-re és `order_items.product_id` hivatkozik `products.id`-re.  

Minden kapcsolat idegen kulccsal van megvalósítva, így a relációs integritás megőrzött.

## Kulcsok és indexek

- Elsődleges kulcs minden táblán: `id`.  
- Egyediség biztosítva a kritikus mezőkön (például `users.email`, `products.slug`).  
- Indexek az olyan gyakori keresési mezőkön, mint `email`, `slug`, `status`, `price`, `created_at` a gyorsabb lekérdezésekért.

## Nézetek (views)

- `product_statistics`: termékszintű eladási és értékelési összesítés.  
- `artisan_statistics`: kézművesenkénti összesítések termékekről, rendelésekről és bevételről.  
- `monthly_sales_statistics`: havi összesítés rendelésekről és bevételekről.  

A nézetek egyszerűsítik a riportok lekérdezését és a dashboardok működtetését.

## Egyszerű adatbázis‑műveletek és automatizmusok

- Tárolt eljárások a gyakori műveletekhez, például a termékértékelés átlagának frissítése vagy a készlet csökkentése rendeléskor.  
- Triggerek egyszerű automatizmusokra, például slug generálása termék létrehozásakor és értesítés létrehozása rendelés felvételekor.  

Ezek az eszközök az adatbázis oldalán segítik az adatkonzisztenciát és az automatizált működést.

## Adatbetöltés és reprodukálhatóság

A `vizsgaremek.sql` fájl tartalmazza a `CREATE DATABASE`, `CREATE TABLE`, indexek, nézetek, tárolt eljárások, triggerek és a minta `INSERT` sorokat.  
Importálás phpMyAdmin segítségével vagy a `mysql` parancssori klienssel egyszerűen elvégezhető.