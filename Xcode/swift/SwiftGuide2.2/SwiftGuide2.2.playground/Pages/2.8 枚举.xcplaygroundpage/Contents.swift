//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页内容包含：
    1. 枚举语法（Enumeration Syntax）
    2. 匹配枚举值与Swith语句（Matching Enumeration Values with a Switch Statement）
    3. 相关值（Associated Values）
    4. 原始值（Raw Values）
    5. 递归枚举（Recursive Enumerations）
 */
/*:
    在 Swift 中，枚举类型是一等公民（first-class）, 很多特征与类的定义一致
    每个枚举定义了一个全新的类型,名称须首字母大写
 */
//: ## 1. 枚举语法（Enumeration Syntax）
/*:
    enum SomeEnumeration {
        // enumeration definition goes here
    }
 */
enum CompassPoint {
    case North  // 成员/成员值
    case South
    case East
    case West
}

// 多个成员值 可以出现在同一行上，用逗号隔开：
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
var directionToHead = CompassPoint.West

// 一旦directionToHead被声明为一个CompassPoint，可以使用一个缩写语法（.）将其设置为 另一个 CompassPoint的值：
// directionToHead的类型已知时，再次为其赋值可以省略枚举名
directionToHead = .East
//: ## 2. 匹配枚举值与Swith语句（Matching Enumeration Values with a Switch Statement）
// 使用switch语句匹配单个枚举值：
directionToHead = .South
switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}

// 当不需要匹配每个枚举成员的时候，可以提供一个默认default分支来涵盖所有未明确被提出的枚举成员：
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//: ## 3. 相关值（Associated Values）
/*:
    Swift 的枚举可 存储 任何类型的 相关值
    每个成员的数据类型可以是各不相同的
 */

// 定义两种商品条码（条形码，二维码）的枚举：
// (理解：定义一个名为Barcode的枚举类型，它可以是UPCA的一个相关值（Int，Int，Int，Int），或者是QRCode的一个字符串类型（String）相关值)
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

// 然后可以使用任何一种条码类型创建新的条码，如：
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3) // 赋给Barcode.UPCA的相关元组值(8, 85909, 51226, 3)
//同一个商品可以被分配给一个不同类型的二维码，如：
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

switch productBarcode { // TODO
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

// 如果一个枚举成员的所有相关值被提取为常量，或者它们全部被提取为变量，为了简洁，你可以只放置一个var或者let标注在成员名称前：
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
    print("QR code: \(productCode).")
}

//: ## 4. 原始值（Raw Values）
/*:
    枚举成员可以被默认值（称为原始值）赋值，其中这些原始值具有相同的类型
    每个原始值在它的枚举声明中必须是唯一的
    原始值和相关值是不相同的
    相关值是在创建一个基于枚举成员的新常量或变量时才会被设置
 */

// 一个枚举成员存储 ASCII 码的例子：
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
/*:
    原始值的隐式赋值（Implicitly Assigned Raw Values）
 */
// Plants.Mercury赋了初值1，Planet.Venus会拥有隐式赋值2，依次类推
enum Planets: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
// 当使用字符串作为枚举类型的初值时，每个枚举成员的隐式初值则为该成员的名称
enum CompassPoints: String {
    case North, South, East, West
}

// 使用枚举 成员的 rawValue 属性可以访问该枚举成员的原始值
let earthsOrders = Planets.Earth.rawValue
let sunsetDirections = CompassPoints.West.rawValue
/*:
    使用原始值来初始化(Initializing from a Raw Value)
    使用原始值初始化枚举变量（Initializing from a Raw Value）
 */
/*:
    如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法将原始值类型作为参数，返回枚举成员或者nil
    原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。TODO    可失败构造器

    使用这种初始化方法来创建一个新的枚举变量:
 */
let possiblePlanets = Planets(rawValue: 7)

// 试图寻找一个位置为9的行星，通过参数为rawValue构造函数返回的可选Planet值将是nil：
let positionToFind = 9
if let somePlanet = Planets(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

//: ## 5. 递归枚举（Recursive Enumerations）
/*:
    递归枚举 是一种枚举类型
 
    表示它的枚举中，有一个或多个枚举成员拥有该枚举的其他成员作为相关值
    用递归枚举时，编译器会插入一个 中间层。可以在枚举成员前加上 indirect 来表示这成员 可递归
 */
/*:
    下面的例子，枚举类型存储了简单的算数表达式：
 */
enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

/*:
    也可以在枚举类型开头加上indirect关键字来表示它的所有成员都是可递归的：
 */
indirect enum ArithmeticExpression1 {
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
}
/*:
    递归函数 可以很直观地使用具有递归性质的数据结构
    例如，下面是一个计算算数表达式的函数：
 */
func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

// 计算 (5 + 4) * 2
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product))



















//: [Next](@next)
