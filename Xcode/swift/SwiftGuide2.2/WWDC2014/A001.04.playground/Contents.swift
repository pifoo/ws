//: A001.04 WWDC 2014 Swift 入门   结构体 / 常量与变量 / 枚举 / 扩展 / 泛型


var str = "Hello, playground"

// 1. Structures     结构体

// 定义结构体
struct Point {
    var x, y: Double
}
struct Size {
    var width, height: Double
}
struct Rect {
    var origin: Point
    var size: Size
    
    // 为结构体增加算值属性
    var area: Double{
        return size.width * size.height
    }
    
    // 为结构体增加方法
    func isBiggerThanRect(other: Rect) -> Bool {
        return self.area > other.area
    }
}

// 初始化
var point = Point(x: 0.0, y: 0.0)
var size = Size(width: 10.0, height: 10.0)
var rect = Rect(origin: point, size: size)




// 2. Structures and Classes     结构体 与 类
class Window {
    var r: Int = 10
    var titile: String = "title"
    var frame: Rect = Rect(origin: point, size: size)
}

// 2.1 结构体 与 类 的区别
// 1）结构体不可继承
// 2) 结构体：值传递(内部)， 类：引用传递


// 3. Constants an Variables: Reference Types    引用类型的 常量 和 变量
let window = Window()    // window 不可修改，但其属性可以
window.titile = "窗口标题"
window.titile


// 4. Constants an Variables: Value Types    值类型的 常量 和 变量
var point1 = Point(x: 0.0, y: 0.0)
point1.x = 5  // 可修改
let point2 = Point(x: 0.0, y: 0.0)
// point2.x = 5  // 不可修改



// 5. Mutating a Structure      修改一个结构体
struct Point1 {
    var x, y: Double
    mutating func moveToTheRightBy(dx: Double) { // mutating : 试图修改内部属性
        x += dx
    }
}
var pointX = Point1 (x: 0.0, y: 0.0)
pointX.moveToTheRightBy(50)
pointX.x
pointX.y



// 5. Enumeration   枚举
enum Day: Int {
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 4
    case Friday = 5
    case Saturday = 6
    case Sunday = 7
}
enum Day1: Int {
    case Monday = 1, Tuesday = 2, Wednesday = 3, Thursday = 4, Friday = 5, Saturday = 6, Sunday = 7
}
enum Day2: Int {
    case Monday = 1, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}
let day = Day2.Tuesday      // 推导为枚举 Day 类型



// 5.1 Enumerations: Raw Values     行值
let dayNumber = Day2.Tuesday.rawValue       // 推导为其内部存储 Int 类型

enum IllegalCharacter: Character {
    case Tab        = "\t"
    case Return     = "\n"
    case Underline  = "_"
    case Dot        = "."
    case WhiteSpace = " "
    
}

enum Direction {
    case North, South, East, West
}
var direction = Direction.North         // direction 被推导为 Direction 类型
direction = Direction.East
direction = .East                       // 与上行代码等价

/*
let label = UILabel()
label.textAlignment = .Right
*/


// 5.2  Enumerations: Associated Values    关联值
enum TrainStatus {
    case OnTime
    case Delayed(Int)
    
    // 5.2.1 枚举： 初始化
    init() {
        self = OnTime
    }
    
    // 5.2.2 增加算值属性（不可增加储值属性）           TODO
    var description: String {
        switch self {
            case OnTime:
                print("准时到达")
            case Delayed(let minutes):
                print("延误\(minutes)分钟")
            default:
                print("没有符合条件的信息")
        }
        
        return "需要 return ?? "      // TODO
    }
    
}

var status = TrainStatus.OnTime     // status 被推导为 TrainStatus 类型
status = .Delayed(45)
status.description

var status1 = TrainStatus().description



// 6. Nested Types      类型嵌套
class Train {
    enum Status {               // *
        case OnTime, Delayed(Int)
        init() {
            self = OnTime
        }
        
        var description0: String {
            print(" ")
            
            return "需要 return ?? "      // TODO
        }
        
    }
    
    var status = Status()       // *
    
}




// 7. Extensions      扩展
extension Size {        // 对处定义的 Size 进行扩展
    mutating func increaseByFactory(factory: Double) {
        width *= factory
        height *= factory
    }
}
/*
extension CGSize {        // 对系统 CGSize 进行扩展
    mutating func increaseByFactory(factory: Double) {
        width *= factory
        height *= factory
    }
}*/

extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0...self {
            task()
        }
    }
}

5.repetitions({
    print("pifoo")
})

2.repetitions {
    print("2")
}


// 8. 泛型                            // TODO
// 8.1   一个非泛型化的栈结构的结构体
struct IntStack {
    var elements = [1,2,3]    // Int[]()   ???
    
    mutating func push(element: Int) {
        elements.append(element)
    }
    
    mutating func pop() -> Int {
        return elements.removeLast()
    }
    
}
var at = IntStack()
at.elements
at.push(4)
at.elements
at.pop()


// 8.1.1  泛型化的栈结构的结构体
/*
struct IntStack1<T> {
    var elements = T   // ???
    
    mutating func push(element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T {
        return elements.removeLast()
    }
    
}
 */


// 8.2  泛型化的栈结构的结构体   TODO
struct Stack<T> {
    
    
}
/*
var intStack = Stack<Int>()
intStack.push(50)
let lastIn = intStack.pop()

var stringStack = Stack<String>()
stringStack.push("hello")
stringStack.pop()
*/















































