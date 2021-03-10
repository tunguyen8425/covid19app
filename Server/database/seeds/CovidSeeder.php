<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CovidSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('covid')->insert([
            'code' => "all",
            'confirmed' => '0',
            'recovered' => '0',
            'deaths' => '0',
            'active' => '0',
        ]);
        DB::table('covid')->insert([
            'code' => "vn",
            'confirmed' => '0',
            'recovered' => '0',
            'deaths' => '0',
            'active' => '0',
        ]);
    }
}
