/*:
 * 《Swift iOS应用开发实战》
 * Foundationz: 基础框架，包括了一些基本的类，如数字、字符串、数组、字典等
 * Cocoa:
 * AppKit:
 * UIKit:   iOS图形用户界面开发框架，包括常见的视图和视图控制器等
 */


let π = 3.14159

var string: String = "Hello" + ", " + "Playground"

//: 闭区间 [0,5]
for i in 0...5 {
    string += "\(i)"    // 插值
}
string

//: 半闭区间 [0,20)
for i in 0..<20 {
    var j = i % 4
    //print("\(i) % 4 = \(j)")
}

let j = 20
//: 常量一经定义不能自改数值
//:        j = 25
//: print(j)

/*:
 * 强大的单行代码 
 * by http://swift.gg/2016/04/18/10-Swift-One-Liners-To-Impress-Your-Friends/
 */

//: 1 将数组中每个元素的值乘以 2
(1...1024).map{$0 * 2}

//: 2 求一组数字的和
(1...1024).reduce(0,combine: +)

//: 3 证明字符串中含有某个单词


8 % 2.5
8 % (-3) == 8 % 3

for character in "Dog!🐶".characters {
    print(character)
}

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)


catString.lowercaseString
catString.characters
catString.characters.count
catString[catString.startIndex]


let somePoint = (1, 1)
switch somePoint {
    case (0, 0):
        print("(0, 0) is at the origin")
    case (_, 0):
        print("(\(somePoint.0), 0) is on the x-axis")
    case (0, _):
        print("(0, \(somePoint.1)) is on the y-axis")
    case (-2...2, -2...2):
        print("(\(somePoint.0), \(somePoint.1)) is inside the box")
    default:
        print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}



func sayHelloAgain(personName: String) -> String {
    return "Hello again, " + personName + "!"
}

debugPrint(sayHelloAgain("Anna"))









