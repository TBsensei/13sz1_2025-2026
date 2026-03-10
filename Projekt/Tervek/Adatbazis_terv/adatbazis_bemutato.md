# Kézműves Webshop — Adatbázis-terv és Műszaki Dokumentáció

## 1. A szoftver célja és az adatbázis szerepe
[cite_start]A Kézműves Webshop projekt egy életszerű, valódi problémára nyújt megoldást[cite: 30], célja a kézműves termékek online értékesítésének és adminisztrációjának támogatása. [cite_start]A rendszer a vizsgakövetelményeknek megfelelően komplex adattárolási és -kezelési funkciókat valósít meg[cite: 31]. [cite_start]Az adatbázis-terv a letisztult, Minimum Viable Product (MVP) megközelítést alkalmazza, amely zökkenőmentesen kiszolgálja a RESTful architektúrának megfelelő szerver oldali komponenseket[cite: 32].

## 2. Tervezési alapelvek
* **Biztonság és Hitelesítés:** A rendszer a Laravel Sanctum segítségével biztonságos, token-alapú hitelesítést használ az API kommunikációhoz. A felhasználókat egy dedikált `role` oszlop alapján különböztetjük meg (`admin`, `customer`).
* [cite_start]**Tiszta kód (Clean Code):** A táblák és oszlopok elnevezései következetesek (angol nyelvűek) és egyértelműen tükrözik a funkciójukat, betartva a tiszta kód elveit[cite: 37].
* **Normalizáció:** Az adatintegritás megőrzése és a redundancia elkerülése a táblák szétválasztásával és relációs összekötésével valósult meg.

## 3. Főbb entitások és táblák leírása
A rendszer a következő 6 fő táblára épül:

1. **`users`**: A rendszer felhasználóit tárolja. Itt kapott helyet a `role` mező, amellyel elkülönítjük a webshop kezelőit (admin) a vásárlóktól.
2. **`personal_access_tokens`**: A Vue.js frontend kliens és a Laravel REST API közötti biztonságos kommunikációhoz szükséges titkosított munkamenet-tokenek tárolója.
3. **`categories`**: A kézműves termékek kategóriarendszerének (pl. kerámia, ékszer) nyilvántartása.
4. **`products`**: A megvásárolható termékek alapadatai (név, ár, leírás, kép). Idegen kulccsal (`category_id`) kapcsolódik a kategóriákhoz.
5. **`orders`**: A vásárlók rendeléseinek fejadatait rögzíti (rendelés állapota, szállítási cím, végösszeg, valamint a vásárló `user_id`-ja).
6. **`order_items`**: Kapcsolótábla a rendelések és a termékek között. Azt tárolja, hogy egy adott rendelésben (`order_id`) melyik termékből (`product_id`) mekkora mennyiséget és milyen egységáron vásároltak.

## 4. Adatbázismodell-diagram (ER Diagram)
[cite_start]Az alábbi ábra bemutatja az adatbázis logikai felépítését, az entitásokat és a közöttük lévő kapcsolatokat (pl. idegen kulcsok, 1:N relációk, `ON DELETE CASCADE` szabályok).

[KÉP HELYE: Ide illeszd be az ER diagram képet (pl. PNG, JPG vagy SVG formátumban)]

*(Ha Markdownban dolgozol, használd ezt a kódot a kép beillesztéséhez: `![Adatbázis ER Diagram](eleresi_ut/a/kephez.png)`)*