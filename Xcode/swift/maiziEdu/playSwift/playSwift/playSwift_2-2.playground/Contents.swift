//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


// constants and variables
let maxNum = 32;
var index = 0;

var x = 0.0 , y = 0.0 , z = 0.0;

// 声明类型
var websiteName:String;
websiteName = "pifoo";
var Name:String = "pifoo";

var red , green , blue : Double;

// 常用基础类型：Int , Double , Float , String

let decimalInt:Int = 0b10001;
let float_a = 1.2e-2;
let bignum = 1_0000_000;





//
// Tuples 元组
//
// let netResult = (404 , "Not Found");
// let (state , msg) = netResult;

let netResult = (state:404 , msg:"Not Found");

netResult.state
netResult.msg

netResult.0 // => netResult.state
netResult.1

// 使用‘_’忽略部分值
// let isLogin = (true , "登陆成功")
let isLogin:(Bool , String) = (true , "登陆成功")
let (loginState , _ ) = isLogin
if loginState {
    print("登陆成功")
}



let num_a:Int = 3
let num_b:Double = 0.1415926
let pi:Double = Double(num_a) + num_b

var a:Int;
a = 1


