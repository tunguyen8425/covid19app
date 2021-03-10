<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::prefix('auth')->group(function () {
    Route::post('register', 'AuthController@register');
    Route::post('login', 'AuthController@login');
    Route::get('refresh', 'AuthController@refresh');

    Route::group(['middleware' => 'auth:api'], function(){
        Route::get('user', 'AuthController@user');
        Route::post('logout', 'AuthController@logout');
    });
});

Route::post('covid19', 'Covid19Controller@new');
Route::get('hospitals', 'HospitalController@index');
Route::get('hospital/{id}', 'HospitalController@show');
Route::put('hospital/{id}/far', 'HospitalController@far');
Route::group(['middleware' => 'auth:api'], function(){
    Route::get('settings_list', 'SettingsController@index')->middleware('isAdmin');
    Route::post('settings_list', 'SettingsController@update')->middleware('isAdmin');

    // Users
    Route::get('users', 'UserController@index')->middleware('isAdmin');
    Route::delete('user/{id}', 'UserController@delete')->middleware('isAdmin');
    Route::post('user', 'UserController@new')->middleware('isAdmin');
    Route::put('user/{id}', 'UserController@update')->middleware('isAdmin');
    Route::get('user/{id}', 'UserController@show')->middleware('isAdmin');

    //Hospitals
//    Route::get('hospitals', 'HospitalController@index')->middleware('isAdmin');
    Route::delete('hospital/{id}', 'HospitalController@delete')->middleware('isAdmin');
    Route::post('hospital', 'HospitalController@new')->middleware('isAdmin');
    Route::put('hospital/{id}', 'HospitalController@update')->middleware('isAdmin');

//    Route::get('hospital/{id}', 'HospitalController@show')->middleware('isAdmin');

    //Surveys
    Route::get('surveys', 'SurveyController@index')->middleware('isAdmin');
    Route::get('survey/{id}', 'SurveyController@show')->middleware('isAdmin');
    Route::delete('survey/{id}', 'SurveyController@delete')->middleware('isAdmin');
    Route::post('survey', 'SurveyController@new');
    Route::get('surveys_list', 'SurveyController@list');

    //Covid19
    Route::get('covid19s', 'Covid19Controller@index')->middleware('isAdmin');
    Route::get('covid19/{id}', 'Covid19Controller@show')->middleware('isAdmin');

    Route::delete('covid19/{id}', 'Covid19Controller@delete')->middleware('isAdmin');

});
