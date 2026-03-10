<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    // Ezeket a mezőket engedjük tömegesen kitölteni
    protected $fillable = ['category_id', 'name', 'description', 'price', 'image_url'];

    // Kapcsolat a kategóriával (Egy termék egy kategóriához tartozik)
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}
