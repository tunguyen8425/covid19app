<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Covid19Controller extends Controller
{
    public function index()
    {
        $covid19s = DB::table('covid_19')->get();

        return response()->json(
            [
                'status' => 'success',
                'covid19s' => $covid19s->toArray()
            ], 200);
    }
    public function new(Request $request)
    {
        $data = $request->all();
        DB::table('covid_19')
            ->insert([
                'name' => $data['name'],
                'national_id' => $data['national_id'],
                'insurance_id' => $data['insurance_id'],
                'date_of_birth' => $data['date_of_birth'],
                'gender' => $data['gender'],
                'city' => $data['city'],
                'address' => $data['address'],
                'phone' => $data['phone'],
                'email' => $data['email'],
            ]);
        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
    public function show(Request $request, $id)
    {
        $covid19 = DB::table('covid_19')->where('id', $id)->first();
        return response()->json(
            [
                'status' => 'success',
                'covid19' => $covid19,
            ], 200);
    }
    public function delete(Request $request, $id)
    {
        DB::table('covid_19')->where('id', $id)->delete();

        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
}
