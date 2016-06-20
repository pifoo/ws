//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 函数定义与调用（Defining and Calling Functions）
    2. 函数参数与返回值（Function Parameters and Return Values）
    3. 函数参数名称（Function Parameter Names）
    4. 函数类型（Function Types）
    5. 函数嵌套（Nested Functions）
 */

//: ## 1. 函数定义与调用（Defining and Calling Functions）
/*:
    函数定义
    func <#name#>(<#parameters#>) -> <#return type#> {
       <#function body#>
    }
 */
func sayHello(personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}
sayHello("pifoo")
sayHello(_:"asum")
sayHello(_:)

func sayHelloAgain(personName: String) -> String {
    return "Hello again, " + personName + "!"
}
sayHelloAgain("Anna")
//: ## 2. 函数参数与返回值（Function Parameters and Return Values）
/*:
    多重输入参数（Multiple Input Parameters）
    下面这个函数用一个半开区间的开始点和结束点，计算出这个范围内包含多少数字：
 */
func halfOpenRangeLength(start: Int, end: Int) -> Int {
    return end - start
}
halfOpenRangeLength(1, end: 10)
/*:
    无参函数（Functions Without Parameters）
    函数可以没有参数
    下面这个函数就是一个无参函数，当被调用时，它返回固定的 String 消息：
 */
func sayHelloWorld() -> String {
    return "hello, world"
}
sayHelloWorld()
/*:
    多参量函数 (Functions With Multiple Parameters)
 */
func sayHello(personName: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return sayHelloAgain(personName)
    } else {
        return sayHello(personName)
    }
}
sayHello("Tim", alreadyGreeted: true)
sayHello(_:alreadyGreeted:)
/*:
    无返回值函数（Functions Without Return Values）
    没有定义返回类型的函数会返回特殊的值，叫 Void , 它其实是一个 空元组，写成 ()
 */
func sayGoodbye1(personName: String) {  // Void 或 () 可省略
    print("Goodbye, \(personName)!", terminator: "")
}
sayGoodbye1("Dave")

func sayGoodbye2(personName: String) -> Void {  // Void 或 () 可省略
    print("Goodbye, \(personName)!", terminator: "")
}
sayGoodbye2("Dave")

func sayGoodbye3(personName: String) -> () {  // Void 或 () 可省略
    print("Goodbye, \(personName)!", terminator: "")
}
sayGoodbye3("Dave")

sayGoodbye1(_:)
/*:
    多重返回值函数（Functions with Multiple Return Values）
 
    可以用元组（tuple）类型让多个值作为一个复合值从函数中返回
 */
/*:
    在一个Int数组中找出最小值与最大值
 */
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax([8, -6, 2, 109, 3, 71])
bounds.min
bounds.max
/*:
    可选元组返回类型(Optional Tuple Return Types)
    
    如果函数返回的 元组类型 含“没有值 or nil” ,可以通过在元组类型的右括号后放置一个问号来定义一个可选元组
    例如(Int,Int)?或(String,Int,Bool)?
 
    注意：
    可选元组类型 如(Int,Int)? 与 元组包含可选属性 如(Int?,Int?) 是不同的；
    可选元组类型，整个数组是可选的，而不只是元组中的每个元素值.
 */
func minMax2(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
minMax2([])
if let bounds2 = minMax2([8, -6, 2, 109, 3, 71]) {  // 可选绑定
    print("min is \(bounds2.min) and max is \(bounds2.max)", terminator: "")
}
//: ## 3. 函数参数名称（Function Parameter Names）
/*:
    函数参数都有一个 外部参数名(external parameter name) 和一个 本地参数名(local parameter name);
    - 外部参数名 用来标记传递给函数调用的参数,
    - 本地参数名 在实现函数的时候使用.
 */
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    /*
        一般情况下,第一个参数省略其外部参数名,第二个以后的参数使用其本地参数名作为自己的外部参数名.
        所有参数需要有不同的本地参数名,但可以共享相同的外部参数名.
     */
}
someFunction(1, secondParameterName: 2)
/*:
    指定外部参数名(Specifying External Parameter Names)
 
    在本地参数名前指定外部参数名,中间以空格分隔
    如果提供了外部参数名，那么函数在被调用时，必须使用外部参数名
 */
func someFunction(externalParameterName localParameterName: Int) {

}
func sayHello(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)!"
}// 一般情况下，可省略参数1的外部参数名
sayHello(to: "Bill", and: "Ted") // 两个参数都必须被标记出来
sayHello(to:and:)
/*:
    忽略外部参数名(Omitting External Parameter Names)
 
    如果不想为 第二个 及 后续 的参数设置参数名,用一个下划线(_)代替一个明确地参数名.
    swift函数 第一个参数默认忽略其外部参数名称，明确写下划线是多余的
 */
func someFunction1(_: Int, _: Int) {

}
someFunction1(1, 2)

func someFunction2(_: Int, _ secondParameterName: Int) {
    
}
someFunction2(1, 2)

func someFunction3(firstParameterName: Int, _ secondParameterName: Int) {
    
}
someFunction3(1, 2)
/*:
    默认参数值（Default Parameter Values）
    
    当默认值被定义后，调用这个函数时可以忽略这个参数
 
    注意：将带有默认值的参数放在函数参数列表的最后。
    这样可以保证在函数调用时，非默认参数的顺序是一致的，同时使得相同的函数在不同情况下调用时显得更为清晰
 */
func someFunction(parameterWithDefault: Int = 12) {

}
someFunction(6) // parameterWithDefault is 6
someFunction()  // parameterWithDefault is 12
/*:
    可变参数（Variadic Parameters）
 
    一个可变参数（variadic parameter）可以接受零个或多个值
    通过在变量类型名后面加入（...）的方式来定义可变参数
    传入可变参数的值在 函数体内 当做这个类型的一个 数组
    
    最多可以有一个可变参数，并放至参数列表最后
 */
// 算术平均数(arithmetic mean)：
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)
/*:
    常量参数和变量参数（Constant and Variable Parameters）
    
    函数参数默认是常量 , 变量参数不是常量
    注意： 
    对变量参数所进行的修改在函数调用结束后便消失了，并且对于函数体外是不可见的
    变量参数仅仅存在于函数调用的生命周期中
 */
// 通过在参数名前加关键字 var 来定义变量参数：
/**
 <#Description#>
 
 - parameter string:      <#string description#>
 - parameter totalLength: <#totalLength description#>
 - parameter pad:         <#pad description#>
 
 - returns: <#return value description#>
 */
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 20, pad: "-")
/*:
    输入输出参数（In-Out Parameters）
 
    场景：
    - 想要一个函数可以修改参数的值
    - 修改在函数调用结束后仍然存在
 
    inout
    - 定义一个输入输出参数
    一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值
 
    只能将 变量 作为 输入输出参数。不能 传入 常量 或者 字面量（literal value）
    调用时，当传入的参数作为输入输出参数时，在参数前加 & 符，表示这个值可以被函数修改
 
    注意： 
    输入输出参数 不能 有默认值，而且可变参数 不能用 inout 标记
    如果用 inout 标记一个参数，这个参数不能被 var 或者 let 标记
 */
// 下面例子，swapTwoInts(_:_:) 函数，有两个分别叫做 a 和 b 的输入输出参数：
func swapTwoInts(inout a: Int, inout _ b: Int) {  // 交换 a 、b 的值
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
// someInt, anotherInt 在函数体外定义，在函数体内修改，输入输出参数是函数对函数体外产生影响的另一种方式
someInt
anotherInt

// 变量在函数内部被修改，外部需要使用其结果值，则定义为 inout
func increment(inout value: Int) {
    value += 1
}
var m = 10
increment(&m)  // 传递一个变量值的引用，而不是变量值本身
m
//: ## 4. 函数类型（Function Types）
/*:
    函数类型，由函数的 参数类型 和 返回类型 组成
 */
// 以下两个函数的类型是 (Int, Int) -> Int
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}
addTwoInts(10, 10)
addTwoInts(_:_:)        // 返回函数的类型
multiplyTwoInts(_:_:)

func printHelloWorld() {    // 没有参数，也没有返回值
    print("hello, world", terminator: "")
}
printHelloWorld             // 这个函数的类型是：() -> void OR () -> ()，或者叫“没有参数，并返回 Void 类型的函数”
/*:
    使用函数类型（Using Function Types）
 */
// 定义一个类型为函数(  (Int, Int) -> Int  )的 常量 或 变量，并将函数赋值给它：
var mathFunction: (Int, Int) -> Int = addTwoInts
mathFunction(10, 20)
mathFunction = multiplyTwoInts
mathFunction(10, 20)

let anotherMathFunction = addTwoInts
/*:
    函数类型 作为 参数类型（Function Types as Parameter Types）
    
    可以用(Int, Int) -> Int这样的函数类型作为另一个函数的参数类型
    这样可以将 函数的一部分 实现 交由给函数的调用者
 
 */
func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))", terminator: "")
}
printMathResult(addTwoInts, 3, 5)
printMathResult(multiplyTwoInts, 3, 5)
/*:
    函数类型 作为 返回类型（Function Type as Return Types）
 */
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)... ", terminator: "")
    currentValue = moveNearerToZero(currentValue)
}
//: ## 5. 函数嵌套（Nested Functions）
/*:
    默认情况，嵌套函数是对外界不可见
    但是可以被他们封闭（包含）的函数（enclosing function）来调用
    一个包含函数也可以返回它的某一个嵌套函数
 */
func chooseStepFunction1(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}
var currentValue1 = -4
let moveNearerToZero1 = chooseStepFunction(currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue1 != 0 {
    print("\(currentValue1)... ", terminator: "")
    currentValue1 = moveNearerToZero1(currentValue1)
}
//: [Next](@next)
