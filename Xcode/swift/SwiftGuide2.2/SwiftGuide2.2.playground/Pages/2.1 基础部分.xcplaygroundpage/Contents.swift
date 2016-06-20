//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 常量和变量
    2. 声明常量和变量
    3. 类型标注
    4. 常量和变量的命名
    5. 输出常量和变量
    6. 注释
    7. 分号
    8. 整数
    9. 整数范围
    10. Int
    11. UInt
    12. 浮点数
    13. 类型安全和类型推断
    14. 数值型字面量
    15. 数值型类型转换
    16. 整数转换
    17. 数整数和浮点数转换
    18. 类型别名
    19. 布尔值
    20. 元组
    21. 可选
    22. nil
    23. if 语句以及强制解析
    24. 可选绑定
    25. 隐式解析可选类型
    26. 错误处理
    27. 断言
 */
//: ## 1. 常量和变量
/*:
    Swift中的类型:
    Int : 整型值
    Double 和 Float : 浮点型值
    Bool : 是布尔型值
    String : 是文本型数据
    Array、Set 和 Dictionary : 集合类型
 
    Tuple : 元组(高阶数据类型)
    Optional : 可选类型
 */
/*:
    常量的值一旦设定就不能改变，而变量的值可以随意更改
 */
//: ## 2. 声明常量和变量
/*:
    常量和变量必须在使用前声明
    let: 声明常量
    var: 声明变量
 */
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
/*
    一行中声明多个常量或者多个变量，用逗号隔开：
 */
var x = 0.0, y = 0.0, z = 0.0
//: ## 3. 类型标注
/*:
    type annotation
 */
var welcomeMessage: String
welcomeMessage = "Hello"
/*:
    在一行中定义多个同样类型的变量，用逗号分割，并在最后一个变量名之后添加类型标注
 */
var red, green, blue: Double
//: ## 4. 常量和变量的命名
/*:
    可以用任何字符作为常量和变量名，包括 Unicode 字符;
    常量与变量名不能包含数学符号，箭头，保留的（或者非法的）Unicode 码位，连线与制表符。也不能以数字开头，但是可以在常量与变量名的其他地方包含数字
 
 */
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
//: ## 5. 输出常量和变量
/*
    print(_:separator:terminator:)函数用来输出 一个 或 多个 当前 常量 或 变量 的 值
    separator 和 terminator 参数具有默认值，调用时可以忽略
    默认情况下，该函数通过添加换行符来结束当前行
    如果不想换行，可以传一个空字符串给 terminator 参数 -- 例如，print(someValue, terminator:"")
 */
print(friendlyWelcome, terminator:"")
print(friendlyWelcome)
/*:
    字符串插值（string interpolation）
    把 常量名 或者 变量名 当做 占位符 加入到长字符串中,Swift 会用当前常量或变量的值 替换 这些 占位符
 */
print("The current value of friendlyWelcome is \(friendlyWelcome)")
//: ## 6. 注释
/*:
    支持嵌套多行注释
 */

//: ## 7. 分号
/*
    分号可有可无
    同一行内写多条独立的语句时必须用 分号; 分隔
 */
let cat = "🐱"; print(cat)
//: ## 8. 整数
/*:
    有符号整数（正、负、零）
    无符号整数（正、零）
    Swift 提供了 8，16，32 和 64 位的 有符号 和 无符号 整数类型
    UInt8: 8位无符号数
    Int32: 32位有符号数
 */
//: ## 9. 整数范围
/*:
    使用 min 和 max 属性 来获取 对应类型 的 最小值 和 最大值
 */
let minValue = UInt8.min  // minValue 为 0，是 UInt8 类型
let maxValue = UInt8.max  // maxValue 为 255，是 UInt8 类型
let minInt = Int.max
let minUInt = Int64.max   // // Int 默位为 CPU 运算位数
//: ## 10. Int
/*:
    在32位平台上，Int和Int32长度相同
    在64位平台上，Int和Int64长度相同
    一般来说，不需要专门指定整数的长度
 */

//: ## 11. UInt
/*
    在32位平台上，UInt和UInt32长度相同
    在64位平台上，UInt和UInt64长度相同
 */
//: ## 12. 浮点数
/*:
    浮点类型比整数类型表示的范围更大
    - Double表示64位浮点数, 至少有15位数字
    - Float表示32位浮点数, Float最少只有6位数字
 */

//: ## 13. 类型安全和类型推断
/*:
    类型安全（type safe）
    类型 不能 隐式转换，变量 重新赋值 类型须一致
 */
/*:
    类型推断（type inference）
    没有显式声明 类型标注，编译器 根据 初始值 字面量（literal value 或 literal）即可触发 类型推断 进行 类型推导
 */
let meaningOfLife = 42  // meaningOfLife 会被推测为 Int 类型
let pi = 3.14159        // pi 会被推测为 Double 类型
let anotherPi = 3 + 0.14159     // 表达式中同时出现了整数和浮点数，会被推断为Double类型
//: ## 14. 数值型字面量
/*:
    整数字面量可以被写作：
    - 一个 十 进制数，没有前缀
    - 一个 二 进制数，前缀是 0b
    - 一个 八 进制数，前缀是 0o
    - 一个 十六 进制数，前缀是 0x
    下面的所有整数字面量的十进制值都是17:
 */
let decimalInteger = 17
let binaryInteger = 0b10001       // 二进制的17
let octalInteger = 0o21           // 八进制的17
let hexadecimalInteger = 0x11     // 十六进制的17
/*:
    十进制浮点数通过指数大写或者小写的 e 来指定
    十六进制浮点数通过指数大写或者小写的 p 来指定
 */
1.25e2  // 表示 1.25 × 10^2，等于 125.0
1.25e-2 // 表示 1.25 × 10^-2，等于 0.0125

0xFp2   // 表示 15 × 2^2，等于 60.0
0xFp-2  // 表示 15 × 2^-2，等于 3.75

/*:
    下面的这些浮点字面量都等于十进制的12.1875：
 */
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
/*:
    增强可读性
    整数和浮点数都可以添加额外的零并且包含下划线，并不会影响字面量：
 */
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
//: ## 15. 数值型类型转换

//: ## 16. 整数转换
/*:
    如果数字超出了常量或者变量可存储的范围，编译的时候会报错：
 */
// let cannotBeNegative: UInt8 = -1    // UInt8 类型不能存储负数，所以会报错
// let tooBig: Int8 = Int8.max + 1     // Int8 类型不能存储超过最大值的数，所以会报错
/*:
    常量twoThousand是UInt16类型，然而常量one是UInt8类型。它们不能直接相加
 */
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
//: ## 17. 整数和浮点数转换
/*:
    整数和浮点数的转换必须显式指定类型：
 */
let three = 3
let pointOneFourOneFiveNine = 0.14159
let 𝜋 = Double(three) + pointOneFourOneFiveNine    // 𝜋 等于 3.14159，所以被推测为 Double 类型
/*:
    浮点数到整数的反向转换同样行，整数类型可以用Double或者Float类型来初始化：
 */
let integerPi = Int(𝜋)     // integerPi 等于 3，所以被推测为 Int 类型
//: ## 18. 类型别名
/*:
    类型别名（type aliases）
    就是给现有类型定义另一个名字
 */
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min     // maxAmplitudeFound 现在是 0
//: ## 19. 布尔值
/*:
    true、false
    逻辑上的值
 */
// 类型推导为 Bool
let orangesAreOrange = true
let turnipsAreDelicious = false
let i = 1
if i == 1 {
    // 这个例子会编译成功
}
//: ## 20. 元组
/*:
    元组（tuples）
    把多个值组合成一个复合值(无序), 元组内的值可以是 任意类型，并不要求是相同类型
 */
let http404Error = (404, "Not Found") // http404Error 的类型是 (Int, String)，值是 (404, "Not Found")
let http404Error1: (Int, String) = (404, "Not Found")
let (statusCode0, statusMessage0) =  (404, "Not Found")
http404Error1.0
statusCode0
/*:
    元组的内容分解（decompose）成单独的常量和变量，然后就可以正常使用它们了：
 */
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")   // 输出 "The status code is 404"
print("The status message is \(statusMessage)") // 输出 "The status message is Not Found"
/*:
    如果只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记：
 */
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")    // 输出 "The status code is 404"
/*:
    通过下标来访问元组中的单个元素，下标从零开始：
 */
print("The status code is \(http404Error.0)")   // 输出 "The status code is 404"
print("The status message is \(http404Error.1)")    // 输出 "The status message is Not Found"
/*:
    定义元组的时候给单个元素命名：
 */
let http200StatusX = (statusCode: 200, description: "OK")
/*:
    通过名字来获取这些元素的值：
 */
print("The status code is \(http200StatusX.statusCode)") // 输出 "The status code is 200"
print("The status message is \(http200StatusX.description)") // 输出 "The status message is OK"
//: ## 21. 可选
/*:
    可选类型（optionals）
    来处理值可能缺失的情况。可选类型表示：
        有值, 等于 x
    或者
        没有值, nil
 */
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 被推测为类型 "Int?"， 或者类型 "optional Int"

/*:
    opt != nil ? opt! : b
 */
//: ## 22. nil
/*:
    可以给可选变量赋值为 nil 来表示它没有值：
 */
var serverResponseCode: Int? = 404
// serverResponseCode 包含一个可选的 Int 值 404
serverResponseCode = nil
// serverResponseCode 现在不包含值
/*:
    如果声明一个可选常量或者变量但是 没有赋值，会自动被设置为 nil：
 */
var surveyAnswer: String?
// surveyAnswer 被自动设置为 nil
//: ## 23. if 语句以及强制解析
/*:
    如果可选类型有值，它将不等于nil:
 */
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// 输出 "convertedNumber contains some integer value."
/*:
    可选值的强制解析（forced unwrapping)
    确定可选类型确实包含值之后，可以在可选的名字后面加一个感叹号（!）来获取值
*/
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// 输出 "convertedNumber has an integer value of 123."


//: ## 24. 可选绑定
/*:
    可选绑定（optional binding）
    用来判断可选类型是否包含值， 如果包含就把值赋给一个 临时 常量或者变量
 */
let msg: String? = "message"
if let message = msg {
    print(message)
}

if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}
// 输出 "'123' has an integer value of 123"
/*:
    多个可选绑定可以用逗号分隔，作为一列表达式出现在一个if语句中
    if let constantName = someOptional, anotherConstantName = someOtherOptional {
        //statements
    }
 */

//: ## 25. 隐式解析可选类型
/*:
    隐式解析可选类型（implicitly unwrapped optionals）
    可选类型后跟 ! 声明一个隐式解析可选类型
    下面展示了 可选类型String 和 隐式解析可选类型String 之间的区别：
 */
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要惊叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号

// 当做普通可选类型来判断是否包含值
if assumedString != nil {   // true
    print(assumedString)
}

//  隐式解析可选绑定
if let definiteString = assumedString {
    print(definiteString)
}
//: ## 26. 错误处理
/*:
    错误处理(error handling)
    throws
    try...catch...
 */
// 1. 函数在声明中添加 throws 关键词来抛出错误消息
func canThrowAnErrow() throws {
    // 这个函数有可能抛出错误
}
// 2. 当函数能抛出错误消息时, 应在表达式中前置try关键词
do { // do语句创建了一个新的包含作用域,使得错误能被传播到一个或多个catch从句
    try canThrowAnErrow()
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}
/*:
    错误处理如何用来应对不同错误条件
 */
func makeASandwich() throws {
    // ...
}
// 抛出，捕捉，以及传播错误
do {
    try makeASandwich()
        // eatASandwich()
    //} catch Error.OutOfCleanDishes {
        // washDishes()
    //} catch Error.MissingIngredients(let ingredients) {
    // buyGroceries(ingredients)
}
//: ## 27. 断言
/*:
    assert(_:_:)
    向assert(_:_:)函数传入一个结果为 true 或者 false 的 表达式 以及 一条信息（断言信息不需要可以省略）
    当表达式的结果为 false 的时候这条信息会被显示
 */
/*:
    使用断言进行调试
 */
let age = -3
assert(age <= 0, "A person's age cannot be less than zero")     // 因为 age < 0，所以断言不会触发
/*:
    何时使用断言:
    - 当条件可能为假时使用断言，但是最终一定要保证条件为真，这样你的代码才能继续运行
    断言的适用情景:
    - 整数类型的下标索引被传入一个自定义下标脚本实现，但是下标索引值可能太小或者太大
    - 需要给函数传入一个值，但是非法的值可能导致函数不能正常执行
    - 一个可选值现在是nil，但是后面的代码运行需要一个非nil值
 */
//: [Next](@next)
