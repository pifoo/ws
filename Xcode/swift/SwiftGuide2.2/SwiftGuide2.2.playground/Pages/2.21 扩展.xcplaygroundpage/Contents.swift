//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 扩展语法
    2. 计算型属性
    3. 构造器
    4. 方法
    5. 下标
    6. 嵌套类型
 */
/*:
    扩展就是向一个已有的 类、结构体、枚举类型 或者 协议类型 添加新功能（functionality）
    Swift 中的扩展可以：
    - 添加计算型属性和计算型静态属性
    - 定义实例方法和类型方法
    - 提供新的构造器
    - 定义下标
    - 定义和使用新的嵌套类型
    - 使一个已有类型符合某个协议
 
    注意：
    扩展可以对一个类型添加新的功能，但是不能重写已有的功能。
 */
//: ## 1. 扩展语法
/*:
    声明一个扩展使用关键字extension：
 
    extension SomeType {
        // 加到SomeType的新功能写到这里
    }
 
    extension SomeType: SomeProtocol, AnotherProctocol {
        // 协议实现写到这里
    }

    注意：
    如果定义了一个扩展向一个已有类型添加新功能，那么这个新功能对该类型的所有已有实例中都是可用的，即使它们是在你的这个扩展的前面定义的
 */

//: ## 2. 计算型属性
/*
    扩展可以向已有类型添加 计算型实例属性 和 计算型类型属性
 
    注意：
    扩展可以添加新的 计算属性，但是 不可以 添加 存储属性，也 不可以 向已有属性添加 属性观测器(property observers)
 
    下面的例子向 Swift 的内建Double类型添加了5个计算型实例属性，从而提供与距离单位协作的基本支持
 */
extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters", terminator: "")
// 打印输出："One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters", terminator: "")
// 打印输出："Three feet is 0.914399970739201 meters"

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long", terminator: "")

//: ## 3. 构造器
/*:
    扩展能向类中 添加 新的 便利构造器，但是它们 不能 向类中添加新的 指定构造器 或 析构器;
    指定构造器 和 析构器必须 总是由 原始 的类实现来提供
    
    注意：
    如果你使用扩展向一个值类型添加一个构造器，在该值类型已经向所有的存储属性提供默认值，而且没有定义任何定制构造器（custom initializers）时，你可以在值类型的扩展构造器中调用默认构造器(default initializers)和逐一成员构造器(memberwise initializers)。
 
    正如在值类型的构造器代理中描述的，如果你已经把构造器写成值类型原始实现的一部分，上述规则不再适用。
 */
// 下面的例子定义了一个用于描述几何矩形的定制结构体Rect
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
// 因为结构体Rect提供了其所有属性的默认值，所以正如默认构造器中描述的，它可以自动接受一个默认构造器和一个逐一成员构造器。这些构造器可以用于构造新的Rect实例：
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))
// 可以提供一个额外的使用特殊中心点和大小的构造器来扩展Rect结构体：
extension Rect {        // 扩展 Rect 的构造器
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)
/*
    注意：
    如果使用扩展提供了一个新的构造器，你依旧有责任保证构造过程能够让所有实例完全初始化
 */
//: ## 4. 方法
/*:
    扩展可以向已有类型添加新的 实例方法 和 类型方法
    下面的例子向Int类型添加一个名为repetitions的新实例方法：
 */
// 扩展了一个执行self次的函数
extension Int {
    func repetitions(task: () -> ()) { // repetitions方法使用了一个  () -> ()  类型的单参数（single argument），表明函数没有参数而且没有返回值
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions { 
    print("Hello", terminator: "")
}

/*:
    修改实例方法（Mutating Instance Methods）
 
    通过扩展添加的实例方法也可以修改该实例本身。
    结构体和枚举类型中修改self或其属性的方法必须将该实例方法标注为mutating，正如来自原始实现的修改方法一样。
 
    下面的例子向Swift的Int类型添加了一个新的名为square的修改方法，来实现一个原始值的平方计算：
 */
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt 现在值是 9
//: ## 5. 下标
/*
    扩展可以向一个已有类型添加新下标。
    这个例子向Swift内建类型Int添加了一个整型下标, 该下标[n]返回十进制数字从右向左数的第n个数字
 
    123456789[0]返回9
    123456789[1]返回8
 */
extension Int {
    subscript(var digitIndex: Int) -> Int {
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            --digitIndex
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7

//如果该Int值没有足够的位数，即下标越界，那么上述实现的下标会返回0，因为它会在数字左边自动补0：
746381295[9]
//returns 0, 即等同于：
0746381295[9]
//: ## 6. 嵌套类型
/*
    扩展可以向已有的类、结构体和枚举添加新的嵌套类型：
 
 */
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}
func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    print("", terminator: "")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// prints "+ + - 0 - 0 +"























//: [Next](@next)
