<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    // --- REGISZTRÁCIÓ ---

    public function registerForm()
    {
        return view('auth.register'); // [cite: 67, 68]
    }

    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6|confirmed'
        ]);

        DB::table('users')->insert([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password), // [cite: 74]
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return redirect()->route('login')->with('success', 'Sikeres regisztráció! Jelentkezz be.');
    }

    // --- BEJELENTKEZÉS (LOGIN) ---

    // 1. Űrlap megjelenítése [cite: 77]
    public function loginForm()
    {
        return view('auth.login');
    }

    // 2. Belépés feldolgozása [cite: 81]
    public function login(Request $request)
    {
        // Validáljuk a bejövő adatokat
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required'],
        ]);

        // Megpróbáljuk beléptetni a felhasználót [cite: 82]
        // Az Auth::attempt automatikusan ellenőrzi a hash-elt jelszót
        if (Auth::attempt($credentials)) {
            $request->session()->regenerate(); // Biztonsági lépés (Session Fixation ellen)

            return redirect()->intended('news'); // Visszavisz oda, ahová eredetileg menni akart, vagy a hírekhez
        }

        // Ha sikertelen a belépés:
        return back()->withErrors([
            'email' => 'A megadott adatok helytelenek.',
        ])->onlyInput('email');
    }

    // --- KIJELENTKEZÉS (LOGOUT) --- [cite: 85]

    public function logout(Request $request)
    {
        Auth::logout(); // [cite: 86]

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect('/login');
    }
}
