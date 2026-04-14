<?php

namespace Database\Seeders;

use App\Models\Group;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class GroupSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $groups = [
            'Juhász- és pásztorkutyák (kivéve svájci pásztorkutyák)',
            'Pinscherek, schnauzerek – molosszerek – svájci hegyi- és pásztorkutyák',
            'Terrierek',
            'Tacskók',
            'Spiccek és ősi típusú kutyák',
            'Kopók és rokon fajták',
            'Vizslák és szetterek',
            'Retrieverek – hajtókutyák – vízi vadászok',
            'Társasági kutyák',
            'Agarak',
        ];

        foreach ($groups as $group){
            $g = new Group();
            $g->name = $group;
            $g->save();
        }
    }
}
