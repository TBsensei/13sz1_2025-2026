<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;  // EZ HIÁNYZIK
use Illuminate\Support\Str;         // EZ IS HIÁNYZIK

class NewsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for($i = 0; $i < 10; $i++) {
            DB::table('news')->insert([
                'title' => Str::random(10),
                'body' => Str::random(100),
                'created_at' => now(),      // Opcionális, de ajánlott
                'updated_at' => now(),      // Opcionális, de ajánlott
            ]);
        }
    }
}