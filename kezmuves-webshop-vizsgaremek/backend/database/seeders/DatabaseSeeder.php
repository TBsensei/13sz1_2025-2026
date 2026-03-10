<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Admin felhasználó létrehozása
        User::create([
            'name' => 'Fő Admin',
            'email' => 'admin@webshop.hu',
            'password' => Hash::make('password'), // Titkosított jelszó
            'role' => 'admin',
        ]);

        // 2. Kategóriák létrehozása
        $keramia = Category::create([
            'name' => 'Kerámiák',
            'description' => 'Kézzel készített egyedi kerámiák.'
        ]);

        $ekszer = Category::create([
            'name' => 'Ékszerek',
            'description' => 'Egyedi tervezésű nyakláncok és karkötők.'
        ]);

        // 3. Termékek létrehozása
        Product::create([
            'category_id' => $keramia->id,
            'name' => 'Kék mázas bögre',
            'description' => 'Fél literes, kézzel festett kék mázas kerámia bögre.',
            'price' => 4500,
            'image_url' => 'kek_bogre.jpg'
        ]);

        Product::create([
            'category_id' => $ekszer->id,
            'name' => 'Gyöngyház nyaklánc',
            'description' => 'Elegáns nyaklánc valódi gyöngyház berakással.',
            'price' => 8900,
            'image_url' => 'gyongyhaz_nyaklanc.jpg'
        ]);
    }
}
