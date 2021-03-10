<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HospitalController extends Controller
{
    public function index()
    {
        $hospitals = DB::table('hospitals')->get();
        $arr = $hospitals->toArray();
        array_multisort(array_column($arr, 'far'), SORT_ASC, $arr);
        return response()->json(
            [
                'status' => 'success',
                'hospitals' => $arr
            ], 200);
    }
    public function far(Request $request, $id)
    {
        $data = $request->all();

        DB::table('hospitals')
            ->where('id', $id)
            ->update([
                'far' => $data['far'],
            ]);

        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
    public function new(Request $request)
    {
        $data = $request->all();
        DB::table('hospitals')->insert([
            'name' => $data['name'],
            'address' => $data['address'],
            'map_address' => $data['mapaddress'],
            'description' => $data['description'],
        ]);

        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
    public function show(Request $request, $id)
    {
        $hospital = DB::table('hospitals')->where('id', $id)->first();

        return response()->json(
            [
                'status' => 'success',
                'hospital' => $hospital
            ], 200);
    }
    public function update(Request $request, $id)
    {
        $data = $request->all();

        DB::table('hospitals')
            ->where('id', $id)
            ->update([
            'name' => $data['name'],
            'address' => $data['address'],
            'map_address' => $data['mapaddress'],
            'description' => $data['description'],
        ]);

        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
    public function delete(Request $request, $id)
    {
        DB::table('hospitals')->where('id', $id)->delete();

        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
}
