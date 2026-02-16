<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class NewsController extends Controller
{
    // Hírek listázása
    public function index(Request $request)
    {
        $search = $request->input('search');
        $query = DB::table('news');

        if ($search) {
            $query->where('title', 'like', "%{$search}%");
        }

        $news = $query->paginate(5);

        return view('news.index', ['news' => $news, 'search' => $search]);
    }

    // Létrehozás űrlap
    public function create()
    {
        return view('news.create');
    }

    // Mentés (ITT VOLT A HIBA)
    public function store(Request $request)
    {
        // 1. Validáció
        $request->validate([
            'title' => 'required',
            'content' => 'required',
        ]);

        // 2. Mentés
        DB::table('news')->insert([
            'title' => $request->input('title'),
            'content' => $request->input('content'),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return redirect()->route('news.index')->with('success', 'A hír sikeresen létrehozva!');
    }

    // Megtekintés
    public function show($id)
    {
        $newsItem = DB::table('news')->where('id', $id)->first();
        return view('news.show', ['news' => $newsItem]);
    }

    // Szerkesztés
    public function edit($id)
    {
        $newsItem = DB::table('news')->where('id', $id)->first();
        return view('news.edit', ['news' => $newsItem]);
    }

    // Frissítés
    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required',
            'content' => 'required',
        ]);

        DB::table('news')->where('id', $id)->update([
            'title' => $request->input('title'),
            'content' => $request->input('content'),
            'updated_at' => now(),
        ]);

        return redirect()->route('news.index')->with('success', 'Hír sikeresen frissítve!');
    }

    // Törlés
    public function destroy($id)
    {
        DB::table('news')->where('id', $id)->delete();
        return redirect()->route('news.index')->with('success', 'Hír törölve!');
    }
}
