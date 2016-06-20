//: A001.02 WWDC2014 Swift入门 元组闭包可能值

import Cocoa

var str = "Hello, playground"

// 1. 从字典中取值
let numberOfLegs = ["ant":6, "snake":0, "dog":4]
let possibleLegCount = numberOfLegs["章鱼"]


// 2. Querying an Optional      查询可能值
let possibleLegCount1: Int? = numberOfLegs["章鱼"]     // 可能值(可能有Int值，可能什么都没)
if possibleLegCount1 == nil {
    print("没有\'章鱼'的数据。")
} else {
    let legCount: Int = possibleLegCount1!   // ! 强制解包（有值则取出）
    print("一只章鱼\(legCount)条腿")
}


let possibleLegCount2: Int? = numberOfLegs["ant"]

if possibleLegCount2 != nil {
    let legCount: Int = possibleLegCount2!
    print("一只章鱼\(legCount)条腿")
}

if let letCount3: Int = possibleLegCount2 {  // TODO
    // print("一只章鱼\(legCount3)条腿")
}



// 3. if
let flag: Int = 0
if flag == 0 {
    print("蹲蹲蹲")
} else {
    print("蹭蹭蹭")
}

// 4. switch
// default不能少
let flag1: Int = 0

switch flag1 {
    case 0:
        print("蹲蹲蹲....")
    case 1:
        print("蹲蹲蹲")
    default:
        print("蹲蹲蹲")
}

switch flag1 {
case 0,1,2:
    print("蹲蹲蹲....")
    break
case 3...5:
    print("蹲蹲蹲")
default:
    print("蹲蹲蹲")
}

let sender: String = "button"
switch sender {
case "button":
    print("点了按钮....")
case "event":
    print("蹲蹲蹲")
default:
    print("蹲蹲蹲")
}



// 5. Function
func say() {                    // 无参
    print("Hello.")
}
say()

func say1(name: String) {       // 有参
    print("Hello.\(name)")
}
say1("pifoo")

func say2(name: String = "He") { // 默认值（没有传参则取其值）
    print("Hello.\(name)")
}
say2()
say2("aasum")


func say3(name: String) -> String {     // 返回值
    return name + "你好"
}
let a = say3("pifoo，")
print(a)

func refresh() -> (Int,String) {     // 多返回值
    return (200,"success")
}
print(refresh())


// 6. Tuples    元组
(3.79, 4.0, 5)
(404, "Not Found")

// 6.1 元组操作
let (statusCode, message) = refresh()
statusCode
message

func refreshPage() -> (code: Int, msg: String) {     // 元组值命名
    return (200,"success")
}
let status = refreshPage()
status.code
status.msg


// 7. 闭包
// 无参无返回值的代码块 赋给变量
let greetingPrinter: () -> () = {
    // func greetingPrinter() -> () = { 与无参无返回值函数的区别：swift会把闭包当作一个匿名函数处理
// let greetingPrinter = {
    print("value")
}
greetingPrinter()       // 调用闭包


// 闭包作为参数 
// TODO
/*
func repeat(count: Int, task: () -> ()){
    for i in 0...count {
        task()
    }
}
repeat(2, {
    println("Hello,World.")
})
 // 与之等价
repeat(2) {
    println("Hello,World.")
})

 
*/



























