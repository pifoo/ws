<?php

namespace App\Http\Controllers;

use App\Article;

class AboutController extends Controller
{
    //
    public function index()
    {
        // return view('welcome');

        // 将变量传递给视图

        $first = 'famly : panda & pifoo & muxin';
        $last = '<p style="color: #5bc0de">Dev</p>';

        $data = [];
        $data['first'] = $first;
        $data['last'] = $last;

        // e.g.1 单个变量输出
        // return view('about.about')->with('first', $first); // key 作为视图中的变量名

        // e.g.2 输出数组到视图
//        return view('about.about', $data); // 变量作为第二个参数输出到视图

        // e.g.3 多个变量输出
/*        return view('about.about') -> with([
            'first' => $first,
            'last' => $last
        ]);*/

        // e.g.3 compact 输出
        return view('about.about', compact('first','last'));

    }

    /**
     * 读取数据库中的数据
     */
    public function data(){
        $articles = Article::all();
        return $articles;

    }
}
