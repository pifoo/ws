//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页内容包括:
    1. 简单值（Simple Values）
    2. 控制流（Control Flow）
    3. 函数和闭包（Functions and Closures）
    4. 对象和类（Objects and Classes）
    5. 枚举和结构体（Enumerations and Structures）
    6. 协议和扩展（Protocols and Extensions）
    7. 泛型（Generics）
 */
//: ## 1. 简单值（Simple Values）
/*:
    let: 定义常量
    var: 定义变量
 */
/*:
    定义变量,常量
 */
var myVariable     = 42                 // 根据初始值 类型推导 -> Int
let implicitDouble = 70.0           // 类型推导  -> Double
/*:
    显式声明类型 并 赋初值
 */
let explicitDouble: Double = 3.1415
/*:
    ❗️值永远不会被隐式转换为其他类型
 */
// myVariable = "string"               // 类型不一致，无法重新赋值
/*:
    显式转换
 */
let label      = "The width is "
let width      = 94
let widthLabel = label + String(width)
/*:
    ❗️\() 字符串插值(值->字符串转换)
 */
let apples       = 3
let oranges      = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
/*:
    [] 创建数组 和 字典，使用下标 或 键（key）来访问元素
 */
/*:
    数组
 */
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1]  = "bottle of water"
/*:
    字典
 */
var occupations      = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
/*:
    创建 空数组 或 字典，使用初始化语法
 */
let emptyArray      = [String]()
let emptyDictionary = [String: Float]()
/*:
    [] 和 [:]
    类型可推导 来创建空数组和空字典 —— 就像声明变量或者给函数传参数时一样
 */
shoppingList = []
occupations  = [:]
//: ## 2. 控制流（Control Flow）
/*:
    条件操作: if、switch
    循环操作: for-in、for、while、repeat-while
    ❕包裹条件 和 循环变量 括号可以省略,但是语句体的大括号是必须的
 */
/*:
    for、for-in
 */
let individualScores = [75, 43, 103, 87, 12]
var teamScore        = 0
for score in individualScores { // 条件必须是一个布尔表达式
    if score > 50 {
        teamScore += 3
        print(teamScore)
    } else {
        teamScore += 1
        print(teamScore)
    }
}
print(teamScore)
/*:
    可选值(一个具体的值 或 nil-值缺失)
 */
var optionalString: String? = "Hello" // 类型后面加 ？来表示
print(optionalString == nil)
/*:
    if - let
    处理值缺失的情况, 这些值可由可选值来代表
 */
//var optionalName: String? = "John Appleseed"
var optionalName: String?

var greeting = "Hello!"
if let name = optionalName { // 如果变量的可选值是nil，条件会判断为false
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello"
}
/*:
    switch
    支持 任意类型的数据 以及 各种比较操作 —— 不仅仅是整数以及测试相等
 */
let vegetable = "red pepper"
switch vegetable {
case "celery":
    let vegetableComment = "Add some raisins and make ants on a log."
case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper"):
    let vegetableComment = "Is it a spicy \(x)?"
default:
    let vegetableComment = "Everything tastes good in soup."
}
/*:
    for-in 遍历字典
 */
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest            = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > 10 {
            //largest = number
            largest += 1    // 大于10的数值个数
            print(number)   // 输出大于 10 的数据
        }
    }
}
print(largest)
/*:
    repeat-while 
    重复运行一段代码直到不满足条件
    循环条件也可以在结尾，保证能至少循环一次
 */
var i = 0, n = 2
while n < 10 {
    n = n * 2
    print(i++ , n)
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 10
print(m)
/*:
    表示范围
    ..<  半开区间[...)
    ...  闭区间[...]
 */
for i in 0 ..< 3 {
    i
}
//: ## 3. 函数和闭包（Functions and Closures）
/*:
    func 声明一个函数
    ->  指定函数返回值的类型
 */
func greet(name: String, day: String) -> String { // 参数 name、day 为 内部名字(InnerName)
    return "Hello \(name), today is \(day)."
}
greet("Bob", day: "Tuesday") // ❗️除第一个参数，内部参数名不能省略（如果给参数指定了OuterName，则在调用函数的时候，就必须使用指定的OutName了）
/*:
    使用元组来让一个函数返回多个值
    该元组的元素可以用名称或数字来表示
 */
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.min, statistics.max, statistics.sum)
print(statistics.2)
/*:
    可变个数的参数
    这些参数在函数内表现为数组的形式
 */
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42, 597, 12)
/*:
    函数嵌套
    被嵌套的函数可以访问外侧函数的变量
 */
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()
/*:
    函数作为另一个函数的返回值
    函数是第一等类型
 */
func makeIncrementer() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)
/*:
    函数作为参数 传入 另一个函数
 */
func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, condition: lessThanTen)
/*:
    {   } 来创建一个匿名闭包
    使用 in 将 参数 和 闭包函数体、返回值类型声明  进行分离
 */
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
/*:
    如果一个闭包的类型已知，比如作为一个回调函数，你可以忽略参数的类型和返回值。
    单个语句闭包会把它语句的值当做结果返回
 */
let sortedNumbers = numbers.sort { $0 > $1 } // $0 ....
print(sortedNumbers)
//: ## 4. 对象和类（Objects and Classes）
/*:
    class
    类中属性的声明和常量、变量声明一样，唯一的区别就是它们的上下文是类
 */
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
/*:
    创建一个类的实例，在类名后面加上括号
    使用点语法来访问实例的属性和方法。
 */
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
print(shapeDescription)
/*:
    以上这个版本的Shape类缺少了一些重要的东西：
    一个构造函数来初始化类实例
    使用init来创建一个构造器
 */
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name   // ❗️注意self被用来区别实例变量
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
/*:
    如果你需要在删除对象之前进行一些清理工作
    则使用 deinit 创建一个析构函数
 */
/*:
    子类
    定义方法是在它们的类名后面加上父类的名字，用冒号分割
    override 重写父类方法
 */
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides   = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()
/*:
    除了储存简单的属性之外，属性可以有 getter 和 setter
    1. 储值属性
    2. 计算属性
 */
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
            // 在 perimeter 的 setter 中，新值的名字是 newValue; 可以在set之后显式的设置一个名字
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)
/*:
    EquilateralTriangle 类的构造器执行了三步：
    1.设置子类声明的属性值
    2.调用父类的构造器
    3.改变父类定义的属性值;
 
    其他的工作比如调用方法、getters和setters也可以在这个阶段完成
 
    如果不需要计算属性，但是仍然需要在设置一个 新值之前 或者 之后运行代码，使用 willSet 和 didSet
 
    比如，下面的类确保三角形的边长总是和正方形的边长相同:
 */
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
/*:
    处理变量是 可选值 时，可以在操作（比如方法、属性和子脚本）之前加 ?
    如果?之前的值是nil，?后面的东西都会被忽略，并且整个表达式返回nil；否则，?之后的东西都会被运行
    在这两种情况下，整个表达式的值也是一个可选值
 */
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
//: ## 5. 枚举和结构体（Enumerations and Structures）
/*:
    enum
    创建一个枚举, 就像 类 和其他所有 命名类型 一样，枚举可以包含方法
 */
enum Rank: Int {
case Ace        = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace         = Rank.Ace
let aceRawValue = ace.rawValue
/*:
    使用 rawValue 来访问一个枚举成员的原始值
    使用init?(rawValue:)构造器来从原始值中枚举一个例子
 */
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
/*:
    枚举的成员值是实际值，并不是原始值的另一种表达方法。
    实际上，以防原始值没有意义，不需要设置。
 */
enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
    
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()
/*:
    注意，有两种方式可以引用Hearts成员：
    给hearts常量赋值时，枚举成员Suit.Hearts需要用全名来引用，因为常量没有显式指定类型
    在switch里，枚举成员使用缩写.Hearts来引用，因为self的值已经知道是一个suit。已知变量类型的情况下你可以使用缩写
 */
/*:
    struct
    创建一个结构体。结构体 和 类 有很多相同的地方，比如 方法 和 构造器
    它们之间最大的一个 区别 就是 结构体 是 传值，类是 传 引用
 */
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
/*:
    一个枚举成员的实例可以有实例值
    相同 枚举成员的实例可以有 不同 的值,创建实例的时候传入值即可。
    实例值 和 原始值 是 不同 的：枚举成员 的 原始值 对于 所有实例 都是 相同 的，而且你是在定义枚举的时候设置 原始值

    例如，考虑从服务器获取日出和日落的时间。服务器会返回正常结果或者错误信息。
 */

enum ServerResponse {
    case Result(String, String)
    case Error(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Error("Out of cheese.")

switch success {
case let .Result(sunrise, sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Error(error):
    let serverResponse = "Failure...  \(error)"
}
/*:
    注意如何从ServerResponse中提取日升和日落时间并用得到的值用来和switch的情况作比较
 */
//: ## 6. 协议和扩展（Protocols and Extensions）
/*:
    protocol
    声明一个协议
 */
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust() // ❗️mutating 关键字用来标记一个 会修改结构体 的方法
}
/*:
    类、枚举 和 结构体 都可以实现协议
 */
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription


struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
/*:
    extension 
    为现有的 类型 添加 功能，比如新的方法和参数
 */
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)
/*:
    可以像使用其他命名类型一样使用协议名——例如，创建一个有不同类型但是都实现一个协议的对象集合。
    当你处理类型是协议的值时，协议外定义的方法不可用。
    (即使protocolValue变量运行时的类型是simpleClass，编译器会把它的类型当做ExampleProtocol。
     这表示你不能调用类在它实现的协议之外实现的方法或者属性)
 */
let protocolValue: ExampleProtocol = a
protocolValue.simpleDescription
//protocolValue.anotherProperty  // Uncomment to see the error
//: ## 7. 泛型（Generics）
/*:
    在 尖括号<Name> 里写一个名字来创建一个 泛型函数 或者 类型
 */
func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0 ..< numberOfTimes {
        result.append(item)
    }
    return result
}
repeatItem("knock", numberOfTimes:4)
repeatItem(3.14, numberOfTimes:4)
/*:
    也可以 创建 泛型函数、方法、类、枚举 和 结构体
 */

// Reimplement the Swift standard library's optional type
enum OptionalValue<T> {
    case None
    case Some(T)
}
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)
/*:
    在类型名后面使用where来指定对类型的需求
    比如，限定类型实现某一个协议，限定两个类型是相同的，或者限定某个类必须有一个特定的父类
 */
func anyCommonElements <T, U where T: SequenceType, U: SequenceType, T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, _ rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1, 2, 3], [3])
/*:
    简单起见，可以忽略where，只在冒号后面写协议或者类名
    <T: Equatable> 和 <T where T: Equatable> 是等价的
 */
//: [Next](@next)
