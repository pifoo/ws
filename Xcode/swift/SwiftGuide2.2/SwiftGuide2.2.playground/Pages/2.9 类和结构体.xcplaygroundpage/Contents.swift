//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 类和结构体对比
    2. 结构体和枚举是值类型
    3. 类是引用类型
    4. 类和结构体的选择
    5. 字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
 
 */
/*:
    类和结构体是人们构建代码所用的一种通用且灵活的构造体
    我们可以使用完全相同的语法规则来为类和结构体定义属性（常量、变量）和添加方法，从而扩展类和结构体的功能
 
    通常一个类的实例被称为对象
 */
//: ## 1. 类和结构体对比
/*:
    Swift 中类和结构体有很多共同点。共同处 在于：
    - 定义 属性 用于 存储值
    - 定义 方法 用于提供 功能
    - 定义 附属脚本 用于 访问值
    - 定义 构造器 用于生成 初始化值
    - 通过 扩展 以增加默认实现的功能
    - 实现 协议 以提供某种标准功能
 
    与结构体相比，类 还有如下的附加功能：
    - 继承 允许一个类继承另一个类的特征
    - 类型转换 允许在运行时 检查 和 解释 一个类实例的类型
    - 解构器 允许一个 类实例 释放 任何其所被分配的资源
    - 引用计数 允许对一个类的多次引用
 
    注意：
    结构体 总是通过 被复制 的方式在代码中 传递，因此 不要 使用引用计数
 */
/*:
    定义
    类和结构体有着类似的定义方式
    通过关键字 class 和 struct 来分别表示 类 和 结构体，并在一对大括号中定义它们的具体内容：
    注意：定义一个新类或者结构体的时候，实际上是有效地定义了一个新的 Swift 类型
 */
class SomeClass {
    // class definition goes here
}

struct SomeStructure {
    // structure definition goes here
}
/*:
    以下是 定义结构体 和 定义类 的示例：
 */
struct Resolution {
    var width = 0       // 存储属性 - 存储属性是捆绑和存储在类或结构体中的常量或变量
    var height = 0
}
class VideoMode {
    var resolution = Resolution()        // 被初始化为 Resolution 结构体的实例
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
/*:
    类和结构体实例
    为了描述一个特定的分辨率或者视频模式，生成结构体和类实例的语法非常相似：
    结构体和类都使用 构造器语法 来生成新的实例 ( 通过这种方式所创建的类或者结构体实例，其属性均会被初始化为默认值
 */
let someResolution = Resolution()
let someVideoMode = VideoMode()
/*:
    属性访问
    实例名后面紧跟属性名，两者通过点号(.)连接 ：  instanceName.attributeName
 */
someResolution.width
someVideoMode.name
someVideoMode.resolution.height         // 访问子属性

// 使用点语法为属性变量赋值：
someVideoMode.resolution.width = 1280   // Swift 允许直接设置结构体属性的子属性
someVideoMode.resolution.width
/*:
    结构体类型 的 成员逐一构造器(Memberwise Initializers for Structure Types)
    
    所有结构体 都有一个 自动生成 的 成员逐一构造器
    用于 初始化 新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中：
 
    注： 与结构体不同，类实例 没有 默认的成员逐一构造器
 */
let vga = Resolution(width:640, height: 480)
//: ## 2. 结构体和枚举是值类型
/*:
    值类型 被赋予给一个 变量、常量 或者本身 被 传递给一个 函数 的时候，实际上操作的是其的拷贝
 
    在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且都是以结构体的形式在后台所实现
    
    所有的 结构体 和 枚举类型 都是 值类型 , 这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制
 */
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
// cinema的值其实是hd的一个拷贝副本，在后台中，它们是两个完全 不同 的 实例
cinema.width = 2048
hd.width
cinema.width

// 枚举也遵循相同的行为准则：
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West", terminator: "")
}
//: ## 3. 类是引用类型
/*:
    与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，操作的是引用，其并不是拷贝
    因此，引用的是已存在的实例本身而不是其拷贝
 */
// 下面这个示例，其使用了之前定义的VideoMode类：
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty       // 引用的是相同的VideoMode实例
alsoTenEighty.frameRate = 30.0

alsoTenEighty.frameRate
tenEighty.frameRate
/*:
    类 是 引用类型，有可能有多个常量和变量在后台 同时引用 某一个类实例
 
    恒等运算符：
    - 等价于 （ === ）
    - 不等价于 （ !== ）
    判定两个 常量 或者 变量 是否引用同一个类实例
 
    “=== 等价于” 表示两个 类类型（class type）的常量或者变量引用同一个类实例   TODO  等价操作符
    “== 等于” 表示两个实例的 值“相等”或“相同”
 */
tenEighty === alsoTenEighty  // 是否引用了同一个实例
/*
    指针
    Swift 常量或者变量引用一个引用类型的实例与 C 语言中的指针类似，不同的是并不直接指向内存中的某个地址
    而且也不要求使用星号（*）来表明在创建一个引用
    Swift 中这些引用与其它的常量或变量的定义方式相同
 */
//: ## 4. 类和结构体的选择
/*:
    结构体实例 总是通过 值传递，类实例 总是通过 引用传递
 
    按照通用的准则，当符合一条或多条以下条件时，请考虑构建 结构体：
    + 结构体的主要目的是用来封装少量相关简单数据值。
    + 有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
    + 任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
    + 结构体不需要去继承另一个已存在类型的属性或者行为。
 
    举例来说，以下情境中适合使用结构体：
    + 几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
    + 一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
    + 三维坐标系内一点，封装x，y和z属性，三者均为Double类型。

 
    在所有其它案例中，定义一个类，生成一个类的实例，并通过引用来管理和传递
    实际中，这意味着绝大部分的自定义数据构造都应该是类，而非结构体
 */

//: ## 5. 字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
/*:
    Swift 中字符串（String）,数组（Array）和字典（Dictionary）类型均以 结构体 的形式实现
    String，Array，Dictionary类型数据被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会发生拷贝行为（值传递方式)
 
    Objective-C中字符串（NSString）,数组（NSArray）和字典（NSDictionary）类型均以 类 的形式实现
    这与 Swfit 中以值传递方式是 不同的
 
    NSString，NSArray，NSDictionary在发生赋值或者传入函数（或方法）时，不会发生值拷贝，而是传递已存在实例的引用
 
    注意：
    在 Swift 的后台中，只有确有必要，实际（actual）拷贝才会被执行
    Swift 管理所有的值拷贝以确保性能最优化的性能（实际赋值由系统管理优化）
 */

//: [Next](@next)
