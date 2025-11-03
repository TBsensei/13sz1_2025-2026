# Kézműves Kincsek - Webshop Projekt Összefoglaló

## Projekt célja és bemutatása

A **Kézműves Kincsek** webshop egy modern e-kereskedelmi platform, amely összeköti a helyi kézműveseket és kisvállalkozókat a vásárlókkal, lehetőséget teremtve egyedi, kézzel készült termékek online értékesítésére. A platform célja, hogy támogassa a helyi gazdaságot és megőrizze a hagyományos mesterségeket azáltal, hogy könnyű hozzáférést biztosít ezekhez a különleges termékekhez. 

A nyitóoldal kiemelt kézműveseket, ajánlott termékeket és kategóriákat jelenít meg vonzó vizuális elrendezésben. A felhasználók kategóriák szerint böngészhetnek (pl. kerámia, textil, fa termékek, ékszerek, élelmiszerek), részletes szűrési és keresési lehetőségekkel. Minden termékoldal részletes leírást, több képet, árakat és a készítő kézműves profilját tartalmazza, ahol a vásárlók megismerhetik a mester történetét és más alkotásait. 

A kosár funkció lehetővé teszi több kézműves termékeinek együttes megrendelését, intelligens szállítási költség kalkulációval. A regisztrált felhasználók nyomon követhetik rendeléseiket, értékelhetik a termékeket és kedvencek listát kezelhetnek. A kézművesek saját admin felületen keresztül kezelhetik termékeiket, feltölthetnek új termékeket képekkel, kezelhetik készleteket és áttekinthetik rendeléseiket. 

A platform admin felülete lehetővé teszi a felhasználók, kézművesek és termékek moderálását, statisztikák megtekintését és a platform általános beállításainak kezelését. A rendszer automatikus értesítéseket küld emailben a rendelések állapotváltozásairól. A fizetési modul több fizetési módot támogat (bankkártya, PayPal, utánvét), míg a szállítási opciók között szerepel házhoz szállítás és csomagpontok. 

A kézművesek értékelési rendszere segíti a minőség fenntartását és a bizalom építését. A mobilbarát, reszponzív dizájn biztosítja, hogy az oldal minden eszközön kényelmesen használható legyen. A platform tartalmaz egy blog szekciót is, ahol kézművesek bemutathatják munkájukat és a készítési folyamatokat. A fejlett keresési funkció lehetővé teszi termékek, kézművesek és kategóriák kombinált keresését kulcsszavak alapján.

---

## Főbb funkciók és aloldalak

### Nyilvános felhasználói felület

#### 1. Nyitóoldal (Landing Page)
- Hero szekció kiemelt üzenettel és Call-to-Action gombbal
- Kategória böngésző (Kerámia, Textil, Fa termékek, Ékszerek, Élelmiszerek, Festmények)
- Kiemelt kézművesek szekciója
- Akciós és új termékek megjelenítése
- Hírlevél feliratkozás

#### 2. Terméklistázó oldal
- Termékek megjelenítése rácsos elrendezésben
- Részletes szűrési lehetőségek (ár, értékelés, helyszín, kategória)
- Rendezési opciók (népszerűség, ár, újdonság, értékelés)
- Oldalazás és "lazy loading"
- Gyorsmegtekintés funkció

#### 3. Termék részletes oldal
- Több képes termék galéria (zoom funkció)
- Részletes termékleírás és specifikációk
- Kézműves profil linkje
- Hasonló termékek ajánlása
- Értékelések és vélemények megjelenítése
- Kosárba helyezés és mennyiség választás
- Készlet állapot kijelzése

#### 4. Kategória oldalak
- Kategóriánkénti termék böngészés
- Alkategóriák és címkék
- Kategória specifikus szűrők

#### 5. Kézműves profil oldal
- Bemutatkozás és történet
- Termékportfólió
- Értékelések és visszajelzések
- Kapcsolatfelvételi lehetőség
- Közösségi média linkek

#### 6. Kosár oldal
- Kosárban lévő termékek listája
- Mennyiség módosítás
- Termék eltávolítás
- Végösszeg kalkuláció (szállítási költséggel)
- Tovább a pénztárhoz gomb

#### 7. Pénztár (Checkout)
- Szállítási cím megadása
- Számlázási cím
- Fizetési mód kiválasztása
- Rendelés összegzése
- Rendelés visszaigazolás

#### 8. Blog oldal
- Kézműves történetek
- Készítési folyamatok bemutatása
- Tippek és ötletek
- Kategorizálás és címkék

#### 9. Keresés oldal
- Általános keresés termékekben
- Kézművesek keresése
- Szűrési lehetőségek
- Keresési előzmények

#### 10. Kapcsolat oldal
- Kapcsolati űrlap
- GYIK (Gyakran Ismételt Kérdések)
- Elérhetőségek
- Térkép integráció (ha van fizikai üzlet)

---

### Regisztrált felhasználói felület

#### 11. Bejelentkezés / Regisztráció
- Email/jelszó alapú bejelentkezés
- Közösségi média login (Google, Facebook opcionálisan)
- Regisztrációs űrlap
- Elfelejtett jelszó funkció

#### 12. Felhasználói profil
- Személyes adatok szerkesztése
- Jelszó módosítás
- Profilkép feltöltés

#### 13. Rendeléseim oldal
- Rendelési előzmények listája
- Rendelés részletek megtekintése
- Nyomon követés
- Visszaigazoló email újraküldése
- Számla letöltés

#### 14. Kedvencek oldal
- Kedvenc termékek listája
- Gyors kosárba helyezés
- Értesítés ár változáskor

#### 15. Szállítási címek
- Több cím mentése
- Alapértelmezett cím beállítása
- Cím szerkesztés és törlés

#### 16. Értesítések
- Email értesítési beállítások
- Push értesítések (mobil)
- Hírlevél feliratkozás kezelés

---

### Kézműves Admin Felület

#### 17. Kézműves Dashboard
- Statisztikai áttekintő (eladások, látogatók, bevétel)
- Legutóbbi rendelések
- Termék teljesítmény
- Értékelések összesítője

#### 18. Termékeim kezelése
- Termékek listája (szerkesztés, törlés)
- Új termék hozzáadása
- Többképes termék galéria feltöltés
- Készlet kezelés
- Kategorizálás és címkézés
- Ár és akció beállítások

#### 19. Rendelések kezelése
- Beérkezett rendelések listája
- Rendelés részletek
- Státusz frissítés (feldolgozás, csomagolás, kiszállítva)
- Szállítólevelek generálása
- Üzenetek a vásárlónak

#### 20. Értékelések
- Termék értékelések megtekintése
- Válaszolás lehetősége
- Moderálási javaslatok

#### 21. Profilom (Kézműves)
- Műhely bemutatkozás szerkesztése
- Portfólió képek
- Elérhetőségek
- Nyitvatartási idő (ha releváns)
- Közösségi média linkek

#### 22. Pénzügyek
- Eladási statisztikák
- Bevételi riportok
- Kifizetések áttekintése
- Számlák letöltése

---

### Platform Admin Felület (Moderátor/Tulajdonos)

#### 23. Platform Admin Dashboard
- Teljes platform statisztikák
- Felhasználói aktivitás
- Forgalmi adatok
- Rendszer állapot

#### 24. Felhasználók kezelése
- Regisztrált felhasználók listája
- Felhasználói szerepkörök
- Tiltás/aktiválás
- Felhasználói aktivitás megtekintése

#### 25. Kézművesek moderálása
- Jóváhagyásra váró kézműves jelentkezések
- Kézművesek listája
- Profil ellenőrzés
- Felfüggesztés/aktiválás

#### 26. Termékek moderálása
- Összes termék áttekintése
- Nem megfelelő tartalom eltávolítása
- Kiemelt termékek kezelése

#### 27. Rendelések áttekintése
- Összes rendelés listája
- Problémás rendelések kezelése
- Visszatérítések
- Statisztikák

#### 28. Kategóriák és címkék
- Kategória hierarchia kezelése
- Új kategóriák hozzáadása
- Kategória képek
- SEO beállítások

#### 29. Blog kezelés
- Blog bejegyzések moderálása
- Új bejegyzés létrehozása (admin által)
- Kézműves blogok jóváhagyása

#### 30. Értékelések moderálása
- Összes értékelés áttekintése
- Spam/nem megfelelő értékelések törlése
- Válaszok moderálása

#### 31. Rendszer beállítások
- Általános beállítások (oldal név, leírás, logo)
- Fizetési gateway beállítások
- Szállítási díjszabás
- Email sablonok
- SEO beállítások
- Analitika integráció

#### 32. Riportok
- Eladási riportok
- Felhasználói riportok
- Forgalmi riportok
- Exportálási lehetőségek (CSV, PDF)

---

## Menürendszer

### Főmenü (Header)
- Kezdőlap
- Kategóriák (legördülő)
- Kézművesek
- Blog
- Kapcsolat
- Keresés (ikon)
- Kedvencek (ikon)
- Kosár (ikon + darabszám)
- Profil/Bejelentkezés (ikon)

### Lábléc (Footer)
- Rólunk
- GYIK
- Szállítási információk
- Visszaküldési feltételek
- Adatvédelem
- ÁSZF
- Kapcsolat
- Közösségi média linkek
- Hírlevél feliratkozás

### Mobil alsó navigáció
- Kezdőlap
- Keresés
- Kedvencek
- Profil

---

## Technikai megvalósítás szempontjai

### Backend (RESTful API)
- Node.js + Express / Python + Django / PHP + Laravel
- JWT alapú autentikáció
- Role-based access control (User, Artisan, Admin)
- Adatbázis: MySQL / PostgreSQL / MongoDB

### Frontend
- React.js / Vue.js / Angular
- Reszponzív dizájn (Mobile-first)
- Progressive Web App (PWA) képességek
- State management (Redux/Vuex/NgRx)

### További funkciók
- Email értesítések (rendelés, státusz változás)
- Képfeltöltés és optimalizálás
- Fizetési gateway integráció (Stripe, PayPal, SimplePay)
- Google Maps integráció
- Teljesítmény optimalizálás (caching, CDN)
- SEO optimalizálás
- Analytics integráció (Google Analytics)

---

## Összegzés

A Kézműves Kincsek platform egy komplex, teljes körű e-kereskedelmi megoldás, amely három felhasználói szintet szolgál ki: a végfelhasználókat (vásárlókat), a kézműveseket (eladókat) és a platform adminisztrátorokat. A rendszer modern technológiákkal készül, biztosítva a skálázhatóságot, biztonságot és kiváló felhasználói élményt minden eszközön.