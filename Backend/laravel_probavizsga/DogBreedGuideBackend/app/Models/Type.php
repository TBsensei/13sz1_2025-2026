<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Type extends Model
{
    protected $fillable = [
        'group_id', 'name', 'speed', 'height', 'weight', 'origin', 'lifetime', 'colors'
    ];

    // Kapcsolat a csoporthoz
    public function group()
    {
        return $this->belongsTo(Group::class);
    }
}
