<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\NewsController;
use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Mail;
use App\Mail\DemoMail;

// --- FŐOLDAL ---
Route::get('/', function () {
    return redirect()->route('news.index');
});

// --- AUTHENTIKÁCIÓ (Bárki elérheti) ---

// Regisztráció
Route::get('/register', [AuthController::class, 'registerForm'])->name('register');
Route::post('/register', [AuthController::class, 'register'])->name('register.submit');

// Bejelentkezés
Route::get('/login', [AuthController::class, 'loginForm'])->name('login');
Route::post('/login', [AuthController::class, 'login'])->name('login.submit');


// --- HÍREK LISTÁZÁSA (Publikus) ---
Route::get('/news', [NewsController::class, 'index'])->name('news.index');


// --- VÉDETT ÚTVONALAK (Csak bejelentkezve!) ---
Route::middleware(['auth'])->group(function () {

    // 1. Létrehozás (Create)
    Route::get('/news/create', [NewsController::class, 'create'])->name('news.create');
    Route::post('/news', [NewsController::class, 'store'])->name('news.store');

    // 2. Szerkesztés (Edit & Update)
    Route::get('/news/{id}/edit', [NewsController::class, 'edit'])->name('news.edit');
    Route::put('/news/{id}', [NewsController::class, 'update'])->name('news.update');

    // 3. Törlés (Delete)
    Route::delete('/news/{id}', [NewsController::class, 'destroy'])->name('news.destroy');

    // 4. Kijelentkezés
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

    // 5. E-mail küldés
    Route::get('/send-mail', function () {
        $mailData = [
            'title' => 'Szia! Ez egy teszt levél.',
            'body' => 'Ez a levél a Laravel alkalmazásodból érkezett a Mailtrap segítségével.'
        ];

        Mail::to('teszt@example.com')->send(new DemoMail($mailData));

        return 'Az e-mail sikeresen elküldve! Ellenőrizd a Mailtrap fiókodat.';
    })->name('mail.send');
});


// --- MEGTEKINTÉS (Show) - Ez legyen a végén! ---
Route::get('/news/{id}', [NewsController::class, 'show'])->name('news.show');
