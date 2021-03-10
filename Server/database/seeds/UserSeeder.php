<?php

use App\User;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'name' => 'Admin',
            'email' => 'admin@gmail.com',
            'gender' => '1',
            'phone' => '01234567890',
            'password' => Hash::make('1'),
            'role' => 2
        ]);

        User::create([
            'name' => 'User',
            'email' => 'user@gmail.com',
            'gender' => '2',
            'phone' => '09987413254',
            'password' => Hash::make('1'),
            'role' => 1
        ]);
    }
}
