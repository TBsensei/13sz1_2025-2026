<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; // Ez elengedhetetlen a képek alapján!

class NewsController extends Controller
{
    // 1. Hírek listázása (Index) - PDF 3. oldal és 03_1 kép
    public function index()
    {
        // Adatok lekérése a Query Builderrel
        $news = DB::table('news')->get();

        // Debuggolás (a képen kikommentezve látható: //dd($news); )
        // dd($news);

        // Nézet visszaadása az adatokkal
        // A 03_4 kép alapján a 'news.index' nézetet hívjuk meg
        return view('news.index', ['news' => $news]);
    }

    // 2. Létrehozó űrlap megjelenítése (Create) - PDF 4. oldal és 03_4 kép
    public function create()
    {
        // Csak visszaadjuk az űrlap nézetét
        return view('news.create');
    }

    // 3. Adatok mentése (Store) - PDF 5. oldal
    // Ez még nem volt a képeken, de a PDF kéri a "Store new news" funkciót
    public function store(Request $request)
    {
        // Validáció (Opcionális, de ajánlott a PDF 5. oldal alapján)
        /*
        $request->validate([
            'title' => 'required',
            'body' => 'required',
        ]);
        */

        // Adat beszúrása Query Builderrel
        DB::table('news')->insert([
            'title' => $request->title,
            'body' => $request->body, // FIGYELEM: A képen 'body' a mező neve, nem 'content'!
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Visszairányítás a listához
        return redirect('/news');
    }

    // ... a store metódus után ...

    // SHOW: Egy hír megjelenítése (04_1_Show.png)
    public function show($id)
{
    $news = DB::table('news')->where('id', $id)->first();

    // --- ÚJ RÉSZ: HIBAKEZELÉS ---
    if (!$news) {
        // Ha nincs ilyen hír, dobjunk egy 404-es "Nem található" hibát
        abort(404);
        
        // VAGY: Visszairányíthatod a listára is:
        // return redirect('/news'); 
    }
    // ----------------------------

    return view('news.show', ['news' => $news]);
}

    // EDIT: Szerkesztő űrlap betöltése (05-1_Edit.png)
    public function edit($id)
    {
        // Ugyanúgy lekérjük az adatot, hogy kitölthessük vele az űrlapot
        $news = DB::table('news')->where('id', $id)->first();

        return view('news.edit', ['news' => $news]);
    }

    // UPDATE: Adatok frissítése az adatbázisban (06_1_Update.png)
    public function update(Request $request)
    {
        // Validáció
        $validated = $request->validate([
            'title' => 'required',
            'body' => 'required',
        ]);

        // Frissítés Query Builderrel
        // FIGYELEM: A 06_1 képen $request->id van használva a where feltételben!
        $affected = DB::table('news')
            ->where('id', $request->id) 
            ->update([
                'title' => $request->title,
                'body' => $request->body,
            ]);
            
        // Visszairányítás a részletes nézetre
        return redirect('/news/' . $request->id);
    }

// ... az update metódus után ...

    // DESTROY: Adat törlése az adatbázisból (07_1_Destroy.png)
    public function destroy($id)
    {
        // Törlés Query Builderrel
        $deleted = DB::table('news')->where('id', $id)->delete();

        // Visszairányítás a főoldalra (listához)
        return redirect('/news');
    }
} // Itt záródik a NewsController osztály