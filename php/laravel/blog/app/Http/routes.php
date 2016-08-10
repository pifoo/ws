<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
 */



// by ： https://segmentfault.com/bookmark/1230000005098951
//       https://laravist.com/series/laravel-5-basic/episodes/2


// e.g.1    直接使用 匿名函数 来返回字符串 或 加载视图

Route::get('/', function () {
    // return 'Hello World';
    return view('welcome');
});

Route::auth();

Route::get('/home', 'HomeController@index');

// 注册路由  接收传参（可选参数 、默认值）
Route::get('user/{name?}', function ($name = 'null') {
    return 'Hello , ' . $name;
});

/* Route::get('about', function () {
     // return 'about';
     return view('about.about'); // about/about
 });*/



// e.g.2     使用控制器方式访问 http://blog.dev/about

Route::get('/about', 'AboutController@index'); // 调用此控制器中的 index()
// 创建AboutController : php artisan make:controller AboutController

Route::get('/data', 'AboutController@data');