<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class SettingsController extends Controller
{
    public function index()
    {
        $settings = DB::table('settings')->get();
        return response()->json(
            [
                'status' => 'success',
                'settings' => $settings->toArray(),
            ], 200);
    }
    public function update(Request $request)
    {
        $data = $request->all();
        DB::table('settings')
            ->where('name', 'cron_time')
            ->update([
            'value' => $data['cron_time']
        ]);
        return response()->json(
            [
                'status' => 'success'
            ], 200);
    }
}
