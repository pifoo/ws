//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 存储属性（Stored Properties）
    2. 计算属性（Computed Properties）
    3. 属性观察器（Property Observers）
    4. 全局变量和局部变量（Global and Local Variables）
    5 类型属性（Type Properties）
 */
/*:
    属性将值跟特定的类、结构或枚举关联
    存储属性 存储 常量 或 变量 作为实例的一部分
    计算属性 计算（不是存储）一个值
    计算属性 可以用于 类、结构体 和 枚举
    存储属性 只能用于 类 和 结构体
 
    存储属性 和 计算属性 通常与 特定类型的实例 关联
    但是，属性 也可以直接作用于类型本身，这种属性称为 类型属性
 
    属性观察器 可监控属性值的变化，以此来触发一个自定义的操作
    属性观察器 可以添加到 自定义 的 存储属性 上，也可以添加到从 父类 继承的属性上
 */
//: ## 1. 存储属性（Stored Properties）
/*:
    存储属性 就是存储在 特定类 或 结构体 的实例里的一个常量或变量   
    可以是变量(var)存储属性，也可以是常量(let)存储属性
    可以在定义存储属性的时候指定 默认值
    也可以在构造过程中 设置 或 修改 存储属性的值，甚至修改 常量 存储属性的值
 */
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// 该区间表示整数0，1，2
rangeOfThreeItems.firstValue = 6
// 该区间现在表示整数6，7，8
/*:
    常量结构体 的存储属性
    如果创建了一个结构体的实例并将其赋值给一个常量，则 无法修改 该实例的任何属性，即使定义了变量存储属性：
    这种行为是由于结构体（struct）属于值类型, 当值类型的实例被声明为常量的时候，它的所有属性也就成了常量
 
    把一个 引用类型 的实例赋给一个 常量 后，仍然 可以 修改该 实例 的 变量属性
 */
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// 该区间表示整数0，1，2，3
// rangeOfFourItems.firstValue = 6  // 尽管 firstValue 是个变量属性，这里还是会报错
/*:
    延迟存储属性
    延迟存储属性是指当 第一次 被调用的时候才会 计算其 初始值的属性
    在属性声明前使用 lazy 来标示一个延迟存储属性
    
    注意：
    必须将 延迟存储属性 声明成 变量（使用var关键字），因为属性的初始值可能在实例构造完成之后才会得到
    而 常量属性 在 构造过程完成 之前 必须要有初始值，因此无法声明成延迟属性
    
    场景：
    当属性的值依赖于在实例的构造过程结束后才会知道具体值的外部因素时，
    或者当获得属性的初始值需要复杂或大量计算时，可以只在需要的时候计算它
 */
// 下面的例子使用了延迟存储属性来避免复杂类中不必要的初始化
class DataImporter {
    /*
     DataImporter 是一个将外部文件中的数据导入的类
     这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"
    // 这是提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()  // 延迟存储属性来避免复杂类中不必要的初始化,当第一次用到DataImporter的时候才去创建它
    var data = [String]()
    // 这是提供数据管理功能
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter 实例的 importer 属性还没有被创建
print(manager.importer.fileName)
// 注意：
// 如果一个被标记为lazy的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次
/*:
    存储属性和实例变量
    
    Swift 中的属性没有对应的实例变量，属性的后端存储也无法直接访问
    一个类型中属性的全部信息——包括命名、类型和内存管理特征——都在唯一一个地方（类型定义中）定义
 */

//: ## 2. 计算属性（Computed Properties）
/*:
    除存储属性外，类、结构体 和 枚举 可以定义计算属性
    计算属性不直接存储值，而是提供一个 getter 和一个 可选的 setter，来间接获取和设置其他属性或变量的值。
 */
// 定义了三个结构体用于描述几何形状
struct Point {                          // Point封装了一个(x, y)的坐标
    var x = 0.0, y = 0.0
}
struct Size {                           // Size封装了一个width和一个height
    var width = 0.0, height = 0.0
}
struct Rect {                           // Rect表示一个有原点和尺寸的矩形
    var origin = Point()
    var size = Size()
    var center: Point {                 // 计算属性
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
//let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)

square.origin.x
square.origin.y

square.size.width
square.size.height

square.center.x         // 通过计算得到新的坐标
square.center.y
/*:
    便捷 setter 声明
    如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue
 */
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set { // set (newValue)
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
/*
    只读计算属性
    只有 getter 没有 setter 的计算属性就是只读计算属性
    只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值
 
    注意：
    必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的
    let 关键字只用来声明常量属性，表示初始化后再也无法修改的值
    
    只读计算属性的声明可以去掉get关键字和花括号：
 */
struct Cuboid {     // 描述了一个立方体
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {        // 只读 计算属性
        //get {  可以省略
        return width * height * depth  // 返回体积
        //}
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
fourByFiveByTwo.volume
//: ## 3. 属性观察器（Property Observers）
/*:
    属性观察器 监控 和 响应属性值 的变化，
    每次属性被设置值的时候都会调用属性观察器，甚至新的值和现在的值相同的时候也不例外
 
    可以为除了延迟存储属性之外的其他存储属性添加属性观察器
    也可以通过重载属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器
 
    注意：
    不需要为 非重载 的计算属性添加属性观察器，因为可以通过它的 setter 直接监控和响应值的变化
 
    可以为属性添加如下的一个或全部观察器：
      -  willSet 在新的值被设置之前 调用
         ( willSet观察器会将新的属性值作为常量参数传入，在willSet的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称newValue表示 )
      -  didSet 在新的值被设置之后 立即调用
         ( didSet观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名oldValue )
 
    注意：
    父类的属性在子类的构造器中被赋值时，它在父类中的willSet和didSet观察器会被调用
 */
/*:
    以下使用 willSet 和 didSet 的实际例子
    定义了一个名为StepCounter的类，用来统计当人步行时的总步数
    这个类可以跟计步器或其他日常锻炼的统计装置的输入数据配合使用
 
    注意：
    如果在一个属性的didSet观察器里为它赋值，这个值会替换该观察器之前设置的值
 */
class StepCounter {
    var totalSteps: Int = 0 {  // totalSteps为存储属性，包含willSet和didSet观察器
        willSet(newTotalSteps) { // 将表示新值的参数自定义为newTotalSteps
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  { // 默认值oldValue表示旧值的参数名,也可以自定义
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
// 当totalSteps设置新值的时候，willSet和didSet观察器都会被调用，甚至当新的值和现在的值完全相同也会调用
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896
stepCounter.totalSteps = 897
//: ## 4. 全局变量和局部变量（Global and Local Variables）
/*:
    计算属性和属性观察器所描述的模式也可以用于全局变量和局部变量
    全局变量是在函数、方法、闭包或任何类型之外定义的变量
    局部变量是在函数、方法或闭包内部定义的变量
 
    在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器
    计算型变量跟计算属性一样，返回一个计算的值而不是存储值，声明格式也完全一样
 
    注意：
    全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记lazy特性
    局部范围的常量或变量不会延迟计算
 */

//: ## 5 类型属性（Type Properties）
/*:
    实例的属性属于一个特定类型实例，每次类型实例化后都拥有自己的一套属性值，实例之间的属性相互独立
 
    类型属性
    也可以为类型本身定义属性，不管类型有多少个实例，这些属性都只有唯一一份
 
    类型属性 用于定义特定类型所有实例 共享的数据
 
    值类型 的存储型类型属性可以是 变量 或 常量
    计算型 类型属性跟实例的计算属性一样只能定义成 变量属性
    
    注意：
    跟实例的存储属性不同，必须给存储型类型属性指定默认值，因为类型本身无法在初始化过程中使用构造器给类型属性赋值
 */
/*:
    类型属性语法
    static 关键字 来定义 类型属性
 
    下面的例子演示了 存储型 和 计算型 类型属性 的语法
    注意：
    例子中的计算型类型属性是只读的，但也可以定义可读可写的计算型类型属性，跟实例计算属性的语法类似
 */
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
/*:
    获取和设置类型属性的值
    通过 点 语法访问： 类型属性是通过类型本身来获取和设置，而不是通过实例
 */
SomeStructure.storedTypeProperty
SomeStructure.init()
SomeStructure.computedTypeProperty

SomeEnumeration.computedTypeProperty

SomeClass.overrideableComputedTypeProperty


//: [Next](@next)
