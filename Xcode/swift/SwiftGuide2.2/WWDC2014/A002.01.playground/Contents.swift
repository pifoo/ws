//: A002.01 WWDC 2014 Swift 进阶        可能值 / 可能值绑定 / 可能值链

import Cocoa

var str = "Hello, playground"

/*
Optional                可能值
Memory management       内存管理
Initialization          初始化函数
Closurse                闭包
Pattern matching        模式匹配
*/


// 1  可能值类型  Optional Type
// 表示可能没有值

// 1.0  String to Integer     字符串到整型转换

// 1.1  非可能值类型  Non-Optional Type
// 任何一个不加 ？的类型，不能设为 nil
var myString: String = "好长的一个字符串"
//var myObject: String = MyClass()

var optionalNumber: Int?            // 默认初始化为 nil
optionalNumber = 6

func findIndexOfString(string: String, array: [String]) -> Int? {       // TODO
/*    for (index, value) in enumerate(array)   {      // TODO
        if value == string {
            return index
        }
    }*/
    return nil
}


// 1.2  Unwrapping Optional    可能值拆包
/* 类型不匹配   TODO
var celebrities = ["aaaa", "bbbb", "cccc", "dddd"]
let index = findIndexOfString("bbbb", celebrities)
if index {
    print("\(celebrities[index]),你好！")
} else{
    print("没查询到...")
}*/


// 1.3  Forced Optional    强制拆包
var celebrities = ["aaaa", "bbbb", "cccc", "dddd"]
let index = findIndexOfString("bbbb", array: celebrities)
if (index != nil) {
    print("\(celebrities[index!]),你好！")
} else{
    print("没查询到...")
}


// 1.4 Optional Binding   可能值绑定

// 检测的同时解包
var celebrities1 = ["aaaa", "bbbb", "cccc", "dddd"]
// let index = findIndexOfString("aaaa", celebrities1)


// 1.5 Optional Chaining   可能值链
// addressNumber = alex.residence?.address?buildingNumber?.toInt()



















