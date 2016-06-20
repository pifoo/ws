//: S002.01 从 OC 转移到 Swift - 01 环境与变量

//: 1. 基本语法
var intVar1: Int = 20


//: 2. Constants and Variables (常量 与 变量
let languageName: String = "Swift"
var languageAge: Int = 20


//: 3. 变量类型
var intVar2: Int
// Int 随系统32/64位变化，UInt/Int8/UInt32
// Double / Float
// String
// Boolean
// Type Inference

//: 3.1 Type Inference (类型推导
let name1 = "Swift"     // 推导为 String 类型
var versin = 2.1        // 推导为 Double 类型
let year = 2016         // 推导为 Int 类型
let isAwesome = true    // 推导为 Boolean 类型


//: 4. Type Saftey (类型安全
// 类型一旦确定，就不能更改
// intVar1 = 2.0  错误: 类型不一致
intVar1 = -9


//: 5. 初始化
// 任何值必须先初始化后再使用，swift没有默认值
var intVar4: Int
// var result = intVar4    // 错误：intCon没有初始化,不能使用
intVar4 = 2
var result1 = intVar4

let intCon1: Int = 10
let result2 = intCon1


//: 6. Numeric Literals (数值字面量
let color: Int = 0xFF0000
let binary: Int = 0b00110
let population: Int = 13_0000_0000



//: 7. Numeric Type Conversion （数值类型转换
// 7.1 自己数值不能越界
// var max :Int = Int.max + 1      //数值淡出


// 7.2 类型间不能自动转换
// var result3 = versin + year
var result3 = versin + Double(year)














