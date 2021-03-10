<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class SurveyController extends Controller
{
    public function index()
    {
        $surveys = DB::table('surveys')->get();
        $user = [];
        foreach ($surveys as $sur){
            $user[intval($sur->user_id)] = User::where('id' , intval($sur->user_id))->first();
        }
        return response()->json(
            [
                'status' => 'success',
                'surveys' => $surveys->toArray(),
                'user' => $user
            ], 200);
    }
    public function list()
    {
        $currentUser = Auth::user();
        $surveys = DB::table('surveys')
            ->where('user_id', $currentUser->id)
            ->get();
        return response()->json(
            [
                'status' => 'success',
                'surveys' => $surveys,
            ], 200);
    }
    public function new(Request $request)
    {
        $data = $request->all();
        $currentUser = Auth::user();
        DB::table('surveys')->insert([
            'user_id' => $currentUser->id,
            'title' => $data['title'],
            'created_at' => date("Y/m/d"),
        ]);
        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
    public function show(Request $request, $id)
    {
        $survey = DB::table('surveys')->where('id', $id)->first();
        $user = User::where('id' , intval($survey->user_id))->first();
        return response()->json(
            [
                'status' => 'success',
                'survey' => $survey,
                'user' => $user
            ], 200);
    }
    public function delete(Request $request, $id)
    {
        DB::table('surveys')->where('id', $id)->delete();

        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
}
