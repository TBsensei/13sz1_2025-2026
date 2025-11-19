# HTTP, CORS, Promise és AJAX

## HTTP

### Mi az a HTTP?

A HTTP (HyperText Transfer Protocol) a web alap **kliens-szerver** kommunikacios protokollja.  
A bongeszo (kilens) **kerest** (request) kuld a szervernek, a szerver **valaszt** (response) ad.

---

### A keres felepitese (egyszerusitve):

1. Indulas: `METHOD PATH HTTP/1.1` (pl.: `GET /products HTTP/1.1`)
2. Fejlecek (Headers): metaadatok (pl.: `Accept`, `Content-Type`, `Authorization`, `Cookie`)
3. Torzs (Body): opcionalis (pl.: JSON, urlapadat, fajl)

### Valasz felepites:

1. Status line: `Protokol, Status kod Staus leiras` (pl.: `HTTP/1.1 200 OK`)
2. Fejlecek: pl.: `Content-Type`, `Cache-Control`, `Set-Cookie`, `Location`
3. Torzs: a tartalom (HTML/JSON/kep stb.)

### Gyakori HTTP-modszerek:

* GET: adat lekerese, biztonsagos
* POST: uj eroforras/muvelet
* PUT: teljes eroforras csere
* PATCH: reszleges modositas
* DELETE: torles
* HEAD/OPTIONS: meta/eloellenorzes

---

## HTTP statuszkodok:

A kodok 1xx - 5xx tartomanyba sorolodnak

### 1xx - Informacios

| Kod es neve             | Mukodese                         |
|-------------------------|----------------------------------|
| 100 Continue            | oke, folytathato a kuldes        |
| 101 Switching Protocols | protokollvaltas (pl.: WebSocket) |
| 103 Early Hints         | elozetes eroforras-tippek        |

### 2xx - Siker

| Kod es neve         | Mukodese                         |
|---------------------|----------------------------------|
| 200 OK              | sikeres valasz                   |
| 201 Created         | eroforras letrejott              | 
| 202 Accepted        | elfogadva, meg feldolgozas alatt |
| 204 No Content      | siker, de nincs torzs            | 
| 206 Partial Content | reszleges tartalom               |

### 3xx - Atiranyitas

| Kod es neve            | Mukodese                                           |
|------------------------|----------------------------------------------------|
| 301 Moved Permanently  | vegleges                                           |
| 302 Found              | atmeneti (inkabb a 303 vagy 307 hasznalata a jobb) |
| 303 See Other          | POST utan atiranyitas GET-re                       |
| 304 Not Modified       | cache ervenyes, nincs uj tartalom                  |
| 307 Temporary Redirect | atmeneti, metodus megmarad                         |
| 308 Permanent Redirect | vegleges, metodus megmarad                         |

### 4xx - Klienshiba

| Kod es neve                | Mukodese                               |
|----------------------------|----------------------------------------|
| 400 Bad Request            | hibas keres (szintaxis/validacio)      |
| 401 Unauthorized           | autentikacio kell (pl.: Bearer token)  |
| 403 Forbidden              | tilos jogosultsag hiany miatt          |
| 404 Not Found              | nincs ilyen eroforas                   |
| 405 Method Not Allowed     | metodus nem engedelyezett              |
| 408 Request Timeout        | kliens tul lassu                       |
| 409 Conflict               | utkozes  (verzio vagy allapot utkozes) |
| 410 Gone                   | az eroforras vegleg eltunt             |
| 413 Payload Too Large      | tul nagy torzs                         |
| 415 Unsupported Media Type | nem tamogatott Content-Type            |
| 422 Unprocessable Entity   | validacios hiba                        | 
| 429 Too Many Requests      | rate limit                             |

### 5xx - Szerverhiba

| Kod es neve               | Mukodese                                                   |
|---------------------------|------------------------------------------------------------|
| 500 Internal Server Error | altalanos hiba                                             |
| 501 Not Implemented       | nem tamogatott funkcio                                     |
| 502 Bad Gateway           | koztes proxy/gateway hiba                                  |
| 503 Service Unavailable   | szolgaltatas nem elerheto (pl.: karbantartas, tulterheles) |
| 504 Gateway Timeout       | upstream idotulepes                                        |

---

## CORS

### Mi az a CORS?

CORS (Cross-Origin Resource Sharing) egy **bongeszoben ervenyesitett** mechanizmus, ami szabalyozza, hogy egy weboldal (
origin A) **HTTP-kereseket** es **valasz-adatokat** erhete-e el egy **masik originrol** (origin B).  
Alapja a **same-origin policy**: ugyanaz az origin = azonos **scheme** + **host** + **port**. Minden mas "
cross-origin".  
(Fontos: a CORS nem szerver-oldali vedelem a tamadasok ellen, hanem egy kliensoldali bongeszo-szabaly).

### Folyamat attekintese:

1. A bongeszo elkuldi a kerest
2. A szerver CORS fejlecekkel valaszol
3. A bongeszo **ellenorzi** a fejleceket, ha nem oke, **blokkolja a valaszt** a JS elol

### Kliens --> Szerver:

* `Origin`: a kerest indito oldal erdete (pl.: `https://app.example.com`)
* `Access-Control-Request-Method`: a tervezett metodus.
* `Access-Control-Request-Headers`: a tervezett egyedi fejlecek listaja

### Szerver --> Kliens:

* `Access-Control-Allow-Origin`: mely origin(ek) ferhetnek hozza (pl.: `https://app.example.com` vagy `*`)
* `Access-Control-Allow-Methods`: engedelyezett metodusok (pl.: `GET`,`POST`,`PUT`)
* `Access-Control-Allow-Headers`: engedelyezett keres-fejlecek (pl.: `Authorization`, `Content-Type`)
* `Access-Control-Allow-Credentials`: `true` ha hitelesito adat (HTTP auth, cookie) is mehet
* `Access-Control-Expose-Headers`: mely valasz-fejlecek latszanak JS-bol
* `Access-Control-Max-Age`: meddig cache-elheto a **preflight** (masodpercben)
* `Vary: Origin`: ha dinamikusan allitod az `Allow-Origin`-t, kotelezo a helyes cache-eleshez.  
  (Szabaly: `Allow-Credentials: true` mellett nem hasznalhatsz `Allow-Origin: *`. Ilyenkor konkret origin-t kell
  visszairni.)

### CORS != CSRF

* CORS: kliens (bongeszo) olvashatja-e a valaszt?
* CSRF: megtevesztett kliens elindithat-e allapotvaltoztato kerest a felhasznalo neveben?
* CSRF ellen szerver-oldali vedelem kell (pl.: CSRF token, SameStie sutik), CORS nem helyettesiti.

---

## Promise

### Mi az a Promise?

A **Promise** egy objektum, ami egy aszinkron muvelet jovobeni kimenetet kepviseli:

* fuggoben (pending) -> sikeres (fulfiled, `resolve`) vagy sikertelen (rejected, `reject`).
* Eredmenyet a `.then()`, a hibajat a `.catch()`, vegso takaritas `.finally()` kezeli.
* `async/await` csak Promise-szal mukodik: `await` megvarja a Promise beteljesuleset.

### Alap szintaxis

```js
const p = new Promise((resolve, reject) => {
    // ide kerul aszinkron muvelet
    // siker:
    // resolve(eredmeny)
    // hiba:
    // reject(hibaObjektumVagyUzenet)
});
p.then(value => {/*siker*/
})
    .catch(error => {/*hiba*/
    })
    .finally(() => {/*mindenkepp fut*/
    })
```

---

## AJAX

### Mi az AJAX?

Asynchronous JavaScript and XML - gyujtofogalom az aszinkron HTTP-keresekhez kliensoldalon, teljes oldal ujratoltes
nelkul.  
Ma a fromatum leggyakrabban JSON, nem XML.

### Miert XHR ma is?

* Orokolt kodok, nagyon regi bongeszok-tamogatasi igenye
* Preciz esemenyszintu konrtoll.
* Bar a `fetch` a modern default, a XHR meg mindig resze a webes alapmuveleteknek

### `XMLHttpRequest` API es eletciklus:

1. `let xhr = new XMLHttpRequest()`: peldanyositas
2. `xhr.open(method, url, async=true)`: keres elokeszitese
3. `xhr.send(body?)`: keres elkuldese
4. `xhr.readyState`: eletciklus allapotok
    * `0`: UNSENT
    * `1`: OPENED
    * `2`: HEADERS_RECEIVED
    * `3`: LOADING (adatfolyam)
    * `4` DONE (kesz)
5. Alapotok: `xhr.status`, `xhr.response`, `xhr.responseText`, `xhr.responseType`
6. Esemenyei: `load`, `error`, `timeout` `abort`, `progress`, `readyStateChange`

