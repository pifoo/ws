//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 术语
    2. 赋值运算符
    3. 算术运算符
    4. 组合赋值运算符（Compound Assignment Operators）
    5. 比较运算符
    6. 三目运算符（Ternary Conditional Operator）
    7. 空合运算符
    8. 区间运算符
    9. 逻辑运算符
 */
//: ## 1. 术语
/*:
    运算符：
        一元运算符   ! ++ --    ...    （分 前置 运算符和 后置运算符
        二元运算符   + -  ...
        三元运算符   :   ?
 */
/*:
 - [高级运算符](http://wiki.jikexueyuan.com/project/swift/chapter2/25_Advanced_Operators.html)
 - [溢出运算符](http://wiki.jikexueyuan.com/project/swift/chapter2/25_Advanced_Operators.html#overflow_operators)
 */
//: ## 2. 赋值运算符
let b = 10
var a = 5
a = b
/*:
    元组赋值 ，元素可以被分解成多个常量或变量：
    ❗️注：if x = y  此句错误, 因为 x = y 并不返回任何值
 */
let (x, y) = (1, 2)         // 现在 x 等于 1, y 等于 2
//: ## 3. 算术运算符
/*:
    加法（+）
    减法（-）
    乘法（*）
    除法（/)
 */
1 + 2       // 等于 3
5 - 3       // 等于 2
2 * 3       // 等于 6
10.0 / 2.5  // 等于 4.0
"hello, " + "world"
/*:
    %
    求余运算符，支持 有符号数、浮点数 取余
 
 */
9 % 4    // 等于 1  （4 x 倍数) + 余数
8 % 2.5  // 等于 0.5
-9 % 4   // 等于 -1
/*:
    ++  --
    自增和自减运算, 其操作对象可以是 整形 和 浮点型
    即可 修改 又可 返回 操作对象的值
 */
var i = 0
++i      // 先自増再返回 ，现在 i = 1    其为 i = i + 1 的缩写
i++      // 先返回再自增 i = 1
i
/*:
    + - ! 
    一元负号运算符
 */
let three = 3
let minusThree = -three       // minusThree 等于 -3
let plusThree = -minusThree   // plusThree 等于 3, 或 "负负3"

let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix 等于 -6

true
!true
//: ## 4. 组合赋值运算符（Compound Assignment Operators）
/*:
    组合加运算（+=）
 - [表达式](http://www.swiftvip.cn/guide/chapter3/04_Expressions.html)
 */
var num = 1
num += 2 // a 现在是 3 , 即 num = num + 2
//: ## 5. 比较运算符
/*:
    等于（a == b）
    不等于（a != b）
    大于（a > b）
    小于（a < b）
    大于等于（a >= b）
    小于等于（a <= b）
 
    恒等=== 和 不恒等!== 这两个比较符来 判断 两个对象 是否 引用同一个对象实例
 */
1 == 1   // true, 因为 1 等于 1
2 != 1   // true, 因为 2 不等于 1
2 > 1    // true, 因为 2 大于 1
1 < 2    // true, 因为 1 小于2
1 >= 1   // true, 因为 1 大于等于 1
2 <= 1   // false, 因为 2 并不小于等于 1

let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
//: ## 6. 三目运算符（Ternary Conditional Operator）
/*:
    问题: Bool ? 答案1 : 答案2
    if question {
        answer1
    } else {
        answer2
    }
 */
let contentHeight = 40
let hasHeader = true

var rowHeight = contentHeight + (hasHeader ? 50 : 20)  // 更简洁

var rowHeight2 = contentHeight
if hasHeader {
    rowHeight2 = rowHeight2 + 50
} else {
    rowHeight2 = rowHeight2 + 20
}
//: ## 7. 空合运算符
/*:
    空合运算符(a ?? b)将对 可选类型a 进行空判断
    有值 则进行 解封，否则就返回一个默认值b.
 
    空合运算符(??)提供了一种更为优雅的方式去 封装条件判断 和 解封 两种行为
 
    这个运算符有两个条件:
    - 表达式a必须是Optional类型
    - 默认值b的类型必须要和a存储值的类型保持一致
 
    空合并运算符是对以下代码的简短表达方法
 */
var aInt: Int? = 12, bInt: Int = 10

(aInt != nil) ? aInt! : bInt

// 使用空合运算符简写：
aInt ?? bInt

/*:
    采用空合运算符，实现了在 默认 颜色名和 可选自定义颜色名之间抉择
 */
let defaultColorName = "red"
var userDefinedColorName: String?   //默认值为 nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 的值为空，所以 colorNameToUse 的值为 "red"

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 非空，因此 colorNameToUse 的值为 "green"
//: ## 8. 区间运算符
/*:
    闭区间运算符（a...b）   数学表达式[a,b]
 */
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)", terminator: "")
}
/*:
    闭区间运算符（a..<b）   数学表达式[a,b)
 */
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)", terminator: "")
}
let names = ["Anna", "Alex", "Brian", "Jack"]
for i in 0..<names.count {
    print("第 \(i + 1) 个人叫 \(names[i])", terminator: "")
}
//: ## 9. 逻辑运算符
/*:
    逻辑运算操作对象后返回的是逻辑布尔值:
    - 逻辑非（!a）
    - 逻辑与（a && b）
    - 逻辑或（a || b）
 */
/*:
    逻辑非
 */
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED", terminator: "")
}
/*:
    逻辑与
 */
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!", terminator: "")
} else {
    print("ACCESS DENIED", terminator: "")
}
/*:
    逻辑或
 */
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!", terminator: "")
} else {
    print("ACCESS DENIED", terminator: "")
}
/*:
    逻辑运算符组合计算
 */
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!", terminator: "")
} else {
    print("ACCESS DENIED", terminator: "")
}



//: [Next](@next)
