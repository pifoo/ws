//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 实例方法(Instance Methods)
    2. 类型方法(Type Methods)
 */
/*:
    方法是与某些特定类型相关联的函数
    类、结构体、枚举都可以定义 实例方法
 
    类型方法 与类型本身相关联
 */

//: ## 1. 实例方法(Instance Methods)
/*:
    实例方法是属于某个特定类、结构体或者枚举类型实例的方法
    实例方法 是被类型的某个实例调用的方法
 
    - 实例方法 能够隐式访问它所属类型的所有的其他实例方法和属性
    - 实例方法 只能被它所属的类的某个特定实例调用
    - 实例方法 不能脱离于现存的实例而被调用
 */
class Counter {
    var count = 0
    func increment() -> Int {      // 定义实例方法
        return ++count
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
// 用点语法（dot syntax）调用实例方法：
let counter = Counter() // 初始计数值是0
counter.increment()     // 计数值现在是1
counter.incrementBy(5)  // 计数值现在是6
counter.reset()         // 计数值现在是0
/*:
    方法的 局部参数名称 和 外部参数名称(Local and External Parameter Names for Methods)
    
    Swift 默认仅给方法的第一个参数名称一个局部参数名称
 */
class Counters {
    var count: Int = 0
    // 默认情况下，Swift 只把 amount 当作一个局部名称，但是把 numberOfTimes 即看作局部名称又看作外部名称
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}
let counters = Counters()
counters.incrementBy(5, numberOfTimes: 3)
/*:
    修改方法的 外部参数名称(Modifying External Parameter Name Behavior for Methods)
 
    可以添加一个 显式的 外部名称 或者 用一个井号（#）作为第一个参数的前缀来把这个局部名称当作外部名称使用
    详细参考 2.6 函数
 */
class Counter1 {
    var count: Int = 0
    // 默认情况下，Swift 只把 amount 当作一个局部名称，但是把 numberOfTimes 即看作局部名称又看作外部名称
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}
let counter1 = Counter1()
counter1.incrementBy(5, numberOfTimes: 3)
/*:
    self 属性(The self Property)
 
    类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身
    可以使用self属性来区分参数名称和属性名称
 */
// 下面的例子中，self消除方法参数x和实例属性x之间的歧义：
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x // 区分方法参数x 与 实例属性x , self.x 指函数参数x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0", terminator: "")
}
/*:
    在实例方法中修改值类型(Modifying Value Types from Within Instance Methods)
 
    结构体和枚举是值类型。一般情况下，值类型的属性不能在它的实例方法中被修改
    如果确定要修改，使用 变异(mutating) 这个方法，然后就可以从方法内部改变它的属性
 
    并且它做的任何改变在方法结束时还会保留在原始结构中
    此方法还可以给它隐含的self属性赋值一个全新的实例
    这个新实例在方法结束后将替换原来的实例
 */
struct Point1 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) { // 变异方法
        x += deltaX   // 使用 mutating，在实例方法中修改值类型的属性
        y += deltaY
    }
}
var somePoint1 = Point1(x: 1.0, y: 1.0)
somePoint1.x
somePoint1.y

somePoint1.moveByX(2.0, y: 3.0)  // 值类型属性在它的实例方法中被修改
somePoint1.x
somePoint1.y
/*:
    不能在结构体类型常量上调用变异方法，因为常量的属性不能被改变，
    即使想改变的是常量的变量属性也不行，详情参见存储属性和实例变量：
 */
let fixedPoint = Point(x: 3.0, y: 3.0)
// fixedPoint.moveByX(2.0, y: 3.0)
/*:
    在变异方法中给self赋值(Assigning to self Within a Mutating Method)
    变异方法能够赋给隐含属性self一个全新的实例。上面Point的例子可以用下面的方式改写：
 */
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaX, y: y + deltaY)
    }
}
/*:
    枚举的 变异方法 可以把 self 设置为 相同 的 枚举类型 中不同的成员：
 */
// 下面的例子中定义了一个三态开关的枚举。每次调用next方法时，开关在不同的电源状态（Off，Low，High）之间循环切换
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 现在等于 .High
ovenLight.next()
// ovenLight 现在等于 .Off
//: ## 2. 类型方法(Type Methods)
/*:
    类型方法
    类型本身调用的方法
    声明结构体和枚举的类型方法，在方法的func关键字之前加上关键字 static
    类可能会用关键字 class 来允许子类重写父类的实现方法
    
    可以为所有的 类、结构体 和 枚举定义类型方法：每一个类型方法都被它所支持的类型显式包含
 
    在类型方法的方法体（body）中, self指向这个类型本身，而不是类型的某个实例
    对于结构体和枚举来说，这意味着你可以用self来消除静态属性和静态方法参数之间的歧义
 */
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod() // 在类型层面调用方法

/*  ++++++++++++++++++++++++++++++++++++++++++++++++++++++  */
struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)", terminator: "")

player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    print("player is now on level 6", terminator: "")
} else {
    print("level 6 has not yet been unlocked", terminator: "")
}
//: [Next](@next)
