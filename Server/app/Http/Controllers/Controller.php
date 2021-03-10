<?php

namespace App\Http\Controllers;

use Facebook\WebDriver\Remote\DesiredCapabilities;
use Facebook\WebDriver\Remote\RemoteWebDriver;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\DB;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
    public function covid(){
        $covid = DB::table('covid')->get();
        return response()->json($covid, 200);;
    }
    public function cron(){
        $lambdaTest = new LambdaTest();
        $source = $lambdaTest->getCovid();
        $re = '/<span class="font24"[^>]*>(.*?)<\/span>/m';
        preg_match_all($re, $source, $matches, PREG_SET_ORDER, 0);

        DB::table('covid')
            ->where('code', 'vn')
            ->update([
                'confirmed' => $matches[0][1],
                'active' => $matches[1][1],
                'recovered' => $matches[2][1],
                'deaths' => $matches[3][1]
            ]);
        DB::table('covid')
            ->where('code', 'all')
            ->update([
                'confirmed' => $matches[4][1],
                'active' => $matches[5][1],
                'recovered' => $matches[6][1],
                'deaths' => $matches[7][1]
            ]);
        echo "done!";
    }
}
class LambdaTest{
    protected static $driver;

    public function getCovid() {
        # username: Username can be found at automation dashboard
        $LT_USERNAME = "1410529";

        # accessKey:  AccessKey can be generated from automation dashboard or profile section
        $LT_APPKEY = "pxQ9slVCTKSZigYJNYYO5XV0wHM4bsFqZJXHYFwIT9Midpg9aT";

        $LT_BROWSER = "chrome";
        $LT_BROWSER_VERSION ="63.0";
        $LT_PLATFORM = "windows 10";

        # URL: https://{username}:{accessToken}@hub.lambdatest.com/wd/hub
        $url = "https://". $LT_USERNAME .":" . $LT_APPKEY ."@hub.lambdatest.com/wd/hub";

        # setting desired capabilities for the test
        $desired_capabilities = new DesiredCapabilities();
        $desired_capabilities->setCapability('browserName',$LT_BROWSER);
        $desired_capabilities->setCapability('version', $LT_BROWSER_VERSION);
        $desired_capabilities->setCapability('platform', $LT_PLATFORM);
        $desired_capabilities->setCapability('name', "Php");
        $desired_capabilities->setCapability('build', "Php Build");
        $desired_capabilities->setCapability('network', true);
        $desired_capabilities->setCapability('visual', true);
        $desired_capabilities->setCapability('video ', true);
        $desired_capabilities->setCapability('console', true);

        self::$driver = RemoteWebDriver::create($url, $desired_capabilities);

        self::$driver->get("https://ncov.moh.gov.vn");

        $source = self::$driver->getPageSource();

        self::$driver->quit();
        return $source;
    }
}
