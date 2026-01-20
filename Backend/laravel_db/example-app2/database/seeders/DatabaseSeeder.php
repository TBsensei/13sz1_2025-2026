<?php

namespace Database\Seeders;

use App\Models\Post; // Ne felejtsd el importálni a Modellt!
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Itt hívjuk meg a Post factory-t
        // 50 darab fake bejegyzést hoz létre és ment az adatbázisba
        Post::factory(50)->create();
    }
}