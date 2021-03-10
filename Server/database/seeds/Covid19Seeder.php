<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Covid19Seeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('covid_19')->insert([
            'name' => "Hoang Van An",
            'national_id' => '141123123421',
            'insurance_id' => '867758375',
            'date_of_birth' => '14/03/1998',
            'gender' => '1',
            'city' => 'Việt Nam',
            'address' => 'Dong Nai',
            'phone' => '0989857355',
            'email' => 'vanan@gmail.com',
        ]);
    }
}
