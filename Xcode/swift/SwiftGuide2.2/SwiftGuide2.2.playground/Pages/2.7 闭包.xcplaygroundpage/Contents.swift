//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 闭包表达式（Closure Expressions）
    2. 尾随闭包（Trailing Closures）
    3. 值捕获（Capturing Values）
    4. 闭包是引用类型（Closures Are Reference Types）
 */
/*:
    闭包
    - 自包含 的 函数代码块，可以在代码中 被传递 和 使用
    
    闭包可以 捕获（capturing） 和 存储 其所在 上下文 中任意 常量 和 变量 的 引用
 
    闭包采取如下三种形式之一：
    - 全局函数 是一个 有名字 但 不会捕获 任何值 的 闭包
    - 嵌套函数 是一个 有名字 并 可以捕获 其 封闭函数域内值 的 闭包
    - 闭包表达式 是一个利用轻量级语法所写的 可以 捕获 其 上下文中 变量   或常量值 的  匿名闭包
 
    Swift 的 闭包表达式 拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下：
    - 利用 上下文 推断参数 和 返回值类型
    - 隐式返回 单表达式 闭包，即 单表达式闭包 可以 省略 return 关键字
    - 参数名称缩写
    - 尾随（Trailing）闭包语法
 */
//: ## 1. 闭包表达式（Closure Expressions）
/*:
    闭包表达式 是一种利用简洁语法构建内联闭包的方式
 */
/*:
    sort 函数（The Sort Function）
 */
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// (逆序)排序闭包 函数类型需为(String, String) -> Bool
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)
/*:
    闭包表达式语法（Closure Expression Syntax）
 
    闭包表达式语法有如下一般形式：
        { (parameters) -> returnType in
            statements
        }
 
    - 闭包表达式语法 可以使用 常量、变量 和 inout 类型作为参数，不提供默认值
    - 可以在参数列表的最后使用可变参数。 元组也可以作为参数和返回值
 */
// backwards函数对应的闭包表达式版本的代码：
reversed = names.sort({ (s1: String, s2: String) -> Bool in // 闭包的函数体部分由关键字 in 引入
    return s1 > s2
})
/*:
    根据上下文推断类型（Inferring Type From Context）
 
    通过内联闭包表达式构造的闭包作为参数传递给函数时，都 可以 推断出 闭包的 参数 和 返回值类型，
    这意味着您几乎 不需要 利用完整格式构造任何内联闭包
 */
reversed = names.sort( { s1, s2 in return s1 > s2 } )
/*:
    单表达式闭包隐式返回（Implicit Return From Single-Expression Clossures）
 
    单行表达式闭包 可以通过 隐藏return 关键字来 隐式返回 单行表达式的结果
 */
reversed = names.sort( { s1, s2 in s1 > s2 } )
/*:
    参数名称缩写（Shorthand Argument Names）
 
    Swift 自动为 内联函数 提供了参数名称缩写功能，可以直接通过$0,$1,$2来顺序调用闭包的参数
    in 关键字也同样可以被省略
 */
reversed = names.sort( { $0 > $1 } )    // $0 和 $1 表示闭包中第一个和第二个String类型的参数
/*:
    运算符函数（Operator Functions）
 
    String类型定义了关于大于号 (>) 的字符串实现，
    其作为一个函数接受两个String类型的参数并返回Bool类型的值  
 
    TODO 运算符函数
 */
reversed = names.sort(>)

//: ## 2. 尾随闭包（Trailing Closures）
/*
    尾随闭包
    是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
 */
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是 不使用 尾随闭包进行函数调用
someFunctionThatTakesAClosure({
    // 闭包主体部分
})

// 以下是 使用 尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}
/*:
    注意： 
    如果函数只需要闭包表达式一个参数，当您使用尾随闭包时，您甚至可以把()省略掉。
    
    在上例中作为sorted函数参数的字符串排序闭包可以改写为：
 */
reversed = names.sort() { $0 > $1 }
/*:
    在 map 方法中使用 尾随闭包 将Int类型数组[16,58,510]
    转换为包含对应String类型的数组["OneSix", "FiveEight", "FiveOneZero"]:
 */
let digitNames = [ // 字典
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map {     // map 接收一个 尾随闭包表达式
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output  // 字典下标返回一个可选值 (optional value)
        number /= 10  // 直到number /= 10为0
    }
    return output
}

//: ## 3. 值捕获（Capturing Values）
/*:
    闭包可以在其定义的上下文中捕获常量或变量
    即使定义这些常量和变量的原域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值
 */
func makeIncrementor(forIncrement amount: Int) -> () -> Int { // 返回函数类型为： () -> Int
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount // 捕获上下文中的变量 runningTotal 和 amount ，捕捉了变量引用，
        return runningTotal
    }
    return incrementor   // makeIncrementor 将 incrementor 作为 闭包返回
}
let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementor(forIncrement: 7)  // incrementBySevne 捕获了一个新的runningTotal变量
incrementBySeven()
// 返回的值为7
incrementByTen()
/*:
    注意：
    如果将闭包赋值给一个类实例的属性，并且该闭包通过指向该实例或其成员来捕获了该实例，将创建一个在闭包和实例间的强引用环。
    Swift 使用捕获列表来打破这种强引用环。
 */

//: ## 4. 闭包是引用类型（Closures Are Reference Types）
/*:
    函数 和 闭包 都是 引用类型
    无论将函数/闭包赋值给一个常量还是变量，实际上都是将常量/变量的值设置为对应函数/闭包的引用
 
    这也意味着如果您将闭包赋值给了两个不同的常量/变量，两个值都会指向同一个闭包：
 */
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()


//: [Next](@next)
