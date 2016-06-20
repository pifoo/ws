//: A001.01 WWDC2014 Swift入门 变量字符串集合循环

import Cocoa

var str = "Hello, playground"

//: 1. Constants and Variables (常量 与 变量
let languageName: String = "Swift"
var languageAge: Int = 20



//: 2. String
let someString = "Swift"       // 推导为String类型

let components = "~/Users/pifoo".componentsSeparatedByString("/")



//: 3. Combining Strings and Characters  (合并字 符串 和 字符
let china = "🇨🇳"
let video = "📹"
let chineseVideo = china + video + "好开心"


//: 4. Building Comples Strings 构建复杂字条串
let a = 3, b = 5
let mathResult = "\(a) 乘以 \(b) 等于 \(a*b)"


//: 5. String Mutability 字符串相关操作
var variableStr = "小明"
variableStr += "和小红"

let constantStr = "Hello"
// constantStr += ",World."    // 不能修改


//: 6. Array and Dictionary     数组 和 字典
let components1 = "~/Users/pifoo".componentsSeparatedByString("/")      // Array 类型，而非 NSArray 类型

//: 6.1 Array and Dictionary Literals     数组 和 字典的字面量
var path = ["~", "Users", "pifoo"]      // 数组
var numberOfLegs = ["ant":6, "snake":0, "dog":4]        // 字典(字符串类型为键，整型为值)


//: 7. Typed Collections    类型化集合
var path1 = ["~", "Users", "pifoo", 2.2]
var path2: [String] = ["~", "Users", "pifoo"]   // 字符串类型数组,不能插入其它类型值

var numberOfLegs1: [String:Int] = ["ant":6, "snake":0, "dog":4]



//: 8. Loops    循环
for character in "Pifoo".characters {
    print(character)
}

for number in 1...5 {
    print("\(number) * \(number) = \(number * number)")
}


for number in 1..<5 {
    print("\(number) * \(number) = \(number * number)")
}


for (s,i) in numberOfLegs {     // 遍历字典
    print("\(s) : \(i)")
}


// 8. Modifying an Array    操作数组
var shoppingList = ["鸡蛋", "鸡"]
shoppingList[0]
shoppingList += ["牛"]
shoppingList[1...2] = ["牛奶"]
shoppingList


// 9. Modifying a Dictionary    操作字典
var numberOfLegs2 = ["ant":6, "snake":0, "dog":4]
numberOfLegs2["蜘蛛"] = 50     // add
numberOfLegs2["蜘蛛"] = 5
numberOfLegs2






