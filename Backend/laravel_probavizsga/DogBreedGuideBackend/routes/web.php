<?php

use Illuminate\Support\Facades\Route;
use App\Models\Group;

Route::get('/', function () {
    // Csak a visible = true csoportokat kérjük le, a hozzájuk tartozó típusokkal együtt
    $groups = Group::where('visible', true)->with('types')->get();

    return view('breeds', compact('groups'));
});
