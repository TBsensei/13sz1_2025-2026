<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\NewsController;

Route::get('/', function () {
    return view('welcome');
});

// --- EDDIGI ÚTVONALAK ---
Route::get('/news', [NewsController::class, 'index'])->name('news.index');
Route::get('/news/create', [NewsController::class, 'create'])->name('news.create');
Route::post('/news', [NewsController::class, 'store'])->name('news.store');

// --- ÚJ ÚTVONALAK (A képek alapján) ---

// 1. Részletek megtekintése (SHOW) - 04_02_Show.png
Route::get('/news/{id}', [NewsController::class, 'show'])->name('news.show');

// 2. Szerkesztés űrlap (EDIT)
Route::get('/news/{id}/edit', [NewsController::class, 'edit'])->name('news.edit');

// 3. Frissítés mentése (UPDATE)
// A 05_2 képen a form action="/news", metódus PUT.
// A 06_1 képen a controller $request->id-t használ.
Route::put('/news', [NewsController::class, 'update'])->name('news.update');

// ... az előző útvonalak után ...
Route::put('/news', [NewsController::class, 'update'])->name('news.update');

// ÚJ SOR: Törlés útvonal
Route::delete('/news/{id}', [NewsController::class, 'destroy'])->name('news.destroy');