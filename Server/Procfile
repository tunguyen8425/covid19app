web: nohup bash -c "php artisan queue:restart && php artisan queue:work --tries=3 2>&1 &" && vendor/bin/heroku-php-apache2 public/
