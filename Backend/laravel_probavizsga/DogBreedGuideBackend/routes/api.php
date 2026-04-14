<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\GroupController;
use App\Http\Controllers\Api\TypeController;

// GET /api/groups
Route::get('/groups', [GroupController::class, 'index']);

// GET /api/types
Route::get('/types', [TypeController::class, 'index']);

// GET /api/types/:id
Route::get('/types/{id}', [TypeController::class, 'show']);

// POST /api/types
Route::post('/types', [TypeController::class, 'store']);
