//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

for i in -20 ... 20{
    var j = i*i
    var k = j*i
}

// 简单值
// let来声明常量，使用var来声明变量

var myVariable = 42
myVariable = 50
let PI = 3.1415926



// 从前
/*
let a = "10".toInt()
let b = "5".toInt()
let c = "3".toInt()

if let a = a {
if let b = b {
if let c = c {
if c != 0 {
print("(a + b) / c = \((a + b) / c)")
}
}
}
}*/

// 现在
/*if let a = a, b = b, c = c where c != 0 {
print("(a + b) / c = \((a + b) / c)")     // (a + b) / c = 5
}*/

for i in -20 ... 20{
    var j = i * i;
    var k = j * i;
    var l = k * i;
}

func fizzBuzz(number: Int) -> String {
    switch (number % 3, number % 5) {
    case (0, 0):
        // number既能被3整除又能被5整除
        return "FizzBuzz!"
    case (0, _):
        // number能被3整除
        return "Fizz!"
    case (_, 0):
        // number能被5整除
        return "Buzz!"
    case (_, _):
        // number既不能被3整除也不能被5整除
        return "\(number)"
    }
}
for i in 1 ... 100 {
    print(fizzBuzz(i))
}


var m = -6.28;
while m < 6.28 {
    var s1 = 4*sin(m) / 3.14
    var s2 = 4*sin(3*m) / (3*3.14)
    var s3 = 4*sin(5*m) / (5*3.14)
    var s4 = 4*sin(7*m) / (7*3.14)
    
    s1
    s1 + s2
    s1 + s2 + s3
    s1 + s2 + s3 + s4
    
    m += 0.1
}


