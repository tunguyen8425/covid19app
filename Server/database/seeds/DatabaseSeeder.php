<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(SettingsSeeder::class);
        $this->call(UserSeeder::class);
        $this->call(CovidSeeder::class);
        $this->call(Covid19Seeder::class);
        $this->call(HospitalSeeder::class);
        $this->call(SurveySeeder::class);
    }
}
