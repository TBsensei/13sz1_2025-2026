<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class PostFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            // A 'title' mezőbe egy véletlenszerű mondatot generálunk
            'title' => $this->faker->sentence(),
            
            // A 'content' mezőbe egy véletlenszerű bekezdést teszünk
            'content' => $this->faker->paragraph(),
            
            // Az 'is_published' mezőbe véletlenszerűen true vagy false kerül
            'is_published' => $this->faker->boolean(),
            
            // Dátum generálása az elmúlt 1 évből
            'created_at' => $this->faker->dateTimeBetween('-1 year', 'now'),
        ];
    }
}