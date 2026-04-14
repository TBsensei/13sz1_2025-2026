<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Group extends Model
{
    protected $fillable = ['name', 'visible'];

    // Kapcsolat a kutyatípusokhoz
    public function types()
    {
        return $this->hasMany(Type::class);
    }
}
