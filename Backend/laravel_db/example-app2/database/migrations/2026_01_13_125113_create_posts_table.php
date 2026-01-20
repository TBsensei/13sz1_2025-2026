<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
{
    Schema::create('posts', function (Blueprint $table) {
        $table->id();
        
        // Ezeket kell hozzáadnod, hogy illeszkedjen a Factory-hoz:
        $table->string('title');            // A címnek
        $table->text('content');            // A tartalomnak
        $table->boolean('is_published');    // A publikált státusznak
        
        $table->timestamps(); // Ez hozza létre a created_at és updated_at mezőket
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('posts');
    }
};
