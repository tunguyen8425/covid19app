<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCovid19Table extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('covid_19', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->string('national_id');
            $table->string('insurance_id');
            $table->string('date_of_birth');
            $table->string('gender');
            $table->string('city');
            $table->string('address');
            $table->string('phone');
            $table->string('email');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('covid_19');
    }
}
