<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Group;

class GroupController extends Controller
{
    public function index()
    {
        // Csak az id-t és a nevet kérjük le a mintának megfelelően
        $groups = Group::select('id', 'name')->get();

        return response()->json([
            'data' => $groups,
            'success' => true,
            'message' => ''
        ]);
    }
}
