<?php

namespace Database\Seeders;

use App\Models\Type;
use App\Models\Group;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        /*
         * $table->foreignIdFor(DogTypeGroup::class);
            $table->string('name', 50);
            $table->integer('speed');
            $table->integer('weight');
            $table->integer('height');
            $table->string('origin');
            $table->integer('lifetime');
            $table->string('colors');*/

        $d = new Type();
        $d->name = 'Német juhászkutya';
        $d->speed = 48;
        $d->weight = 31;
        $d->height = 60;
        $d->origin = 'Németország';
        $d->lifetime = 11;
        $d->colors = "Fekete, Fehér, Fekete és ezüst, Fekete-cser, Fekete és vörös, Sable, Szürke";
        $d->group_id = Group::where('name', 'Juhász- és pásztorkutyák (kivéve svájci pásztorkutyák)')->first()->id;
        $d->save();


        $d = new Type();
        $d->name = 'Labrador retriever';
        $d->speed = 28;
        $d->weight = 30;
        $d->height = 58;
        $d->origin = 'Egyesült királyság';
        $d->lifetime = 11;
        $d->colors = "Fekete, Csokoládé, Sárga";
        $d->group_id = Group::where('name', 'Retrieverek – hajtókutyák – vízi vadászok')->first()->id;
        $d->save();


        $d = new Type();
        $d->name = 'Szibériai husky';
        $d->speed = 45;
        $d->weight = 22;
        $d->height = 55;
        $d->origin = 'Szibéria';
        $d->lifetime = 14;
        $d->colors = "Fehér, Fekete, Gray & White, Sable & White, Fekete-cser, Silver-gray, Vörös-fehér, Fekete-fehér, Szürke";
        $d->group_id = Group::where('name', 'Spiccek és ősi típusú kutyák')->first()->id;
        $d->save();


        $d = new Type();
        $d->name = 'Kaukázusi juhászkutya';
        $d->speed = 37;
        $d->weight = 55;
        $d->height = 71;
        $d->origin = 'Oroszország';
        $d->lifetime = 12;
        $d->colors = "Fehér, Őzbarna, Krémszínű, Rozsda, Szürke";
        $d->group_id = Group::where('name', 'Pinscherek, schnauzerek – molosszerek – svájci hegyi- és pásztorkutyák')->first()->id;
        $d->save();
    }
}
