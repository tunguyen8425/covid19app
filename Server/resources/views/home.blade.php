<!doctype html>
<html lang="{{ app()->getLocale() }}">
    <head>
        <meta charset="utf-8">
        <title>Health Pro Admin</title>
        <link rel="stylesheet" href="{{asset('vendors/iconfonts/simple-line-icon/css/simple-line-icons.css').config('version_files.html.js') }}">
        <link rel="stylesheet" href="{{asset('vendors/iconfonts/flag-icon-css/css/flag-icon.min.css').config('version_files.html.js') }}">
        <link rel="stylesheet" href="{{asset('css/style.css').config('version_files.html.js') }}">
        <!-- Main styles for this application -->
        <link href="{{ mix('css/app.css').config('version_files.html.js') }}" rel="stylesheet">
        <meta id="csrf-token" name="csrf-token" value="{{ csrf_token() }}">
    </head>
    <body>
        <div id="app">
          <index></index>
        </div>
        <script src="{{ mix('js/app.js').config('version_files.html.js') }}"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    </body>
</html>
