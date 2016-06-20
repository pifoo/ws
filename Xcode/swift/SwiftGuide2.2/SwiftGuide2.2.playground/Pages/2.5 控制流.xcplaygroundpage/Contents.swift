//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. For 循环
    2. While 循环
    3. 条件语句
    4. 控制转移语句（Control Transfer Statements）
 */
/*:
    for、for-in
    while(while-do)、repeat-while(do-while)
    if、guard、switch
 
    break、continue
    case、where
 */
//: ## 1. For 循环
/*:
    for-in
    for
 */
for index in 1...5 {            // index 隐式声明 即可
    print("\(index) times 5 is \(index * 5)")
}

// 不需要知道区间内每一项的值，使用下划线（_）替代变量名来忽略对值的访问：
let base = 3
let power = 10
var answer = 1
for _ in 1...10 {
    answer = answer * base      // 3的10次幂
}
print("\(base) to the power of \(power) is \(answer)")

// for-in遍历一个 数组 所有元素：
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

// for-in遍历一个字典
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

// 条件判断 和 递增方法 样式的 for 循环
for var index = 0; index < 3; ++index { // index只在for循环的生命周期里有效,想在for结束后访问，则在for前先声明
    print("index is \(index)")
}
//: ## 2. While 循环
/*:
    场景：这类循环适合使用在第一次迭代前迭代次数未知的情况下
    - while循环，每次在循环开始时计算条件是否符合
    - repeat-while循环，每次在循环结束时计算条件是否符合
 */
/*:
    While 循环格式:
    while condition { statements }
 
 */
// https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Art/snakesAndLadders_2x.png

// 游戏盘面固定的 25 个方格
let finalSquare = 25   // 用来初始化数组和检测最终胜利条件
// 游戏盘面由 26 个 Int 0 值初始化，而不是 25 个（由0到25，一共 26 个）
var board = [Int](count: finalSquare+1, repeatedValue: 0)
board.count

// 一些方块被设置成有蛇或者梯子的指定值
// 梯子 底部的方块是一个 正值，使你可以 向上 移动，蛇头 处的方块是一个 负值，会让你 向下 移动：
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

// 玩家由左下角编号为 0 的方格开始游戏。一般来说玩家第一次掷骰子后才会进入游戏盘面：
var square = 0
var diceRoll = 0
while square < finalSquare {
    // 掷骰子
    if ++diceRoll == 7 { diceRoll = 1 }
    // 根据点数移动
    square += diceRoll
    if square < board.count {
        // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
}
print("Game over!")

print(board[25])
print(board[20..<25])
print(board[15..<20])
print(board[10..<15])
print(board[5..<10])
print(board[0..<5])

var i = 1
var j = 0
while j <= 10 {
    i += 1
    j += i
}

/*:
    repeat-while 循环的格式
    repeat { statements } while condition
 */
let finalSquare2 = 25
var board2 = [Int](count: finalSquare2 + 1, repeatedValue: 0)
board2[03] = +08; board2[06] = +11; board2[09] = +09; board2[10] = +02
board2[14] = -10; board2[19] = -11; board2[22] = -02; board2[24] = -08
var square2 = 0
var diceRoll2 = 0

repeat {
    // 顺着梯子爬上去或者顺着蛇滑下去
    square2 += board2[square2]
    // 掷骰子
    if ++diceRoll2 == 7 { diceRoll2 = 1 }
    // 根据点数移动
    square2 += diceRoll2
} while square2 < finalSquare2
print("Game over!")
/*: ## 3. 条件语句
    条件语句
    if
    switch
 */
/*:
    If 
    else if
 */
var temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
/*:
    Switch 格式
    switch some value to consider { 
        case value 1: 
            respond to value 1 case value 2
        case value 3: 
            respond to value 2 or 3
        default: 
            otherwise, do something else 
    }
 */
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
// 输出 "e is a vowel"
/*:
    不存在隐式的贯穿（No Implicit Fallthrough）
    不需要在 case 分支中显式地使用break语句,当匹配的 case 分支中的代码执行完毕后，程序会终止switch语句
    每一个 case 分支都必须包含至少一条语句
    
    注意： 如果想要贯穿至特定的 case 分支中，请使用fallthrough语句，详情请参考贯穿（Fallthrough）
 */
let anotherCharacter: Character = "a"
switch anotherCharacter {
// case "a": // break
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// this will report a compile-time error
/*:
    区间匹配
    case 分支的模式也可以是一个值的区间
    注意： 闭区间操作符(...)以及半开区间操作符(..<)功能被重载去返回 IntervalType 或 Range
 */
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
/*:
    元组（Tuple）
 */
/*:
    下面的例子展示了如何使用一个(Int, Int)类型的元组来分类下图中的点(x, y)：
    使用下划线（_）来匹配所有可能的值
 */
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
// 输出 "(1, 1) is inside the box"
/*:
    值绑定（Value Bindings）
    case 分支的模式允许将匹配的值绑定到一个临时的常量或变量
 */
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// 输出 "on the x-axis with an x value of 2"
/*:
    where
    case 分支的模式可以使用where语句来判断额外的条件
 */
// 把点(x, y)进行了分类：
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// 输出 "(1, -1) is on the line x == -y"
//: ## 4. 控制转移语句（Control Transfer Statements）
/*:
    控制转移语句改变代码的执行顺序，通过它你可以实现代码的跳转
    Swift有四种控制转移语句:
    - continue
    - break
    - fallthrough
    - return
    - throw
 */
/*:
    continue
    告诉一个循环体立刻停止本次循环迭代，重新开始下次循环迭代
 
    注意： 
    在一个带有条件和递增的for循环体中，调用continue语句后，迭代增量仍然会被计算求值
    循环体继续像往常一样工作，仅仅只是循环体中的执行代码会被跳过
 */
// 把一个小写字符串中的元音字母和空格字符移除
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)
/*:
    break
    会立刻结束整个控制流的执行
 
    循环体中使用break时，会立刻中断该循环体的执行
 
    switch代码块中使用break时，会立即中断该switch代码块的执行
 */
let numberSymbol: Character = "三"  // 简体中文里的数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}
// 输出 "The integer value of 三 is 3."
/*:
    贯穿（Fallthrough）
    匹配到 case 分支并执行 且 贯穿 到下一个分支
 */
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// 输出 "The number 5 is a prime number, and also an integer."
/*:
    带标签的语句
    label name: while condition { statements }
 */
var l = 0
stop: while l < 10 {
    switch l{
    case 1...5:
        print("1...5")
        break stop   // 中断循环，只执行了一次，而不是中断switch代码块
    default :
        break
    }
    l++
}
/*:
    guard 
    早退（提前退出
    guard 的执行取决于一个表达式的布尔值
    一个 guard 语句总是有一个 else 分句，如果条件 不为真 则 执行else分局 中的代码
 */
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(["name": "John"])
greet(["name": "Jane", "location": "Cupertino"])
/*:  
    #available
    检测API是否可用
    
    if #available(`platform name` `version`, `...`, *) {
        `statements to execute if the APIs are available`
    } else {
        `fallback statements to execute if the APIs are unavailable`
    }


 */
if #available(iOS 9, OSX 10.10, *) { // 参数 * 是必须的，指定在任何其它平台
    // 在 iOS 使用 iOS 9 APIs , 并且在 OS X 使用 OS X v10.10 APIs
} else {
    // 回滚至早前 iOS and OS X 的API
}

//: [Next](@next)
