<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Type;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TypeController extends Controller
{
    // GET /api/types
    public function index()
    {
        $types = Type::with('group')->get()->map(function ($type) {
            return [
                'id' => $type->id,
                'dog_type_group' => [
                    'id' => $type->group->id,
                    'name' => $type->group->name
                ],
                'name' => $type->name,
                'colors' => $type->colors
            ];
        });

        return response()->json([
            'data' => $types,
            'success' => true,
            'message' => ''
        ]);
    }

    // GET /api/types/{id}
    public function show($id)
    {
        $type = Type::with('group')->find($id);

        if (!$type) {
            return response()->json([
                'success' => false,
                'message' => 'A keresett kutyafajta nem található.'
            ], 404);
        }

        return response()->json([
            'data' => [
                'id' => $type->id,
                'dog_type_group' => [
                    'id' => $type->group->id,
                    'name' => $type->group->name
                ],
                'name' => $type->name,
                'speed' => $type->speed,
                'weight' => $type->weight,
                'height' => $type->height,
                'origin' => $type->origin,
                'lifetime' => $type->lifetime,
                'colors' => $type->colors
            ],
            'success' => true,
            'message' => ''
        ]);
    }

    // POST /api/types
    public function store(Request $request)
    {
        // 1. Validáció a feladatleírás alapján
        $validator = Validator::make($request->all(), [
            'group_id' => 'required|exists:groups,id',
            'name'     => 'required|string|max:50',
            'speed'    => 'required|integer|min:1|max:70',
            'height'   => 'required|integer',
            'weight'   => 'required|integer|min:1|max:100',
            'origin'   => 'required|string|max:255',
            'lifetime' => 'required|integer|min:1|max:25',
            'colors'   => 'required|string|max:255',
        ]);

        // 2. Ha a validáció elbukik, a kért hiba formátumot adjuk vissza
        if ($validator->fails()) {
            return response()->json([
                'data' => $validator->errors(),
                'success' => false,
                'message' => 'Validation error'
            ], 422);
        }

        // 3. Ha minden rendben, létrehozzuk az új rekordot
        $type = Type::create($request->all());

        // 4. Visszaadjuk a 201-es kódot és a 'Created' üzenetet
        return response()->json([
            'data' => $type,
            'success' => true,
            'message' => 'Created'
        ], 201);
    }
}
