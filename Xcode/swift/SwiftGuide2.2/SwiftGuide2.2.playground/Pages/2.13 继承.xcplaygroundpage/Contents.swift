//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 定义一个基类（Base class）
    2. 子类生成（Subclassing）
    3. 重写（Overriding）
    4. 防止重写
 */
/*:
    在 Swift 中，类可以调用和访问超类的 方法，属性 和 下标脚本（subscripts），
    并且可以 重写（override）这些方法，属性和下标脚本来优化或修改它们的行为
 
    可以为类中继承来的属性添加属性观察器（property observers），当属性值改变时，类就会被通知到。
    可以为任何属性添加属性观察器，无论它原本被定义为存储型属性（stored property）还是计算型属性（computed property）
 */
//: ## 1. 定义一个基类（Base class）
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // 什么也不做-因为车辆不一定会有噪音
    }
}
let someVehicle = Vehicle()  // 用初始化方法创建实例
someVehicle.description
//: ## 2. 子类生成（Subclassing）
/*:
    class SomeClass: SomeSuperclass {
        // 类的定义
    }
 */
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
bicycle.description


class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
tandem.description
//: ## 3. 重写（Overriding）
/*:
    重写（overriding）
 
    子类可以为继承来的 实例方法（instance method），类方法（class method），实例属性（instance property），
    或 下标脚本（subscript）提供自己定制的实现（implementation）
 */
/*:
    super
    访问 超类 的 方法，属性 及 下标脚本
 
    super.someMethod()
    super.someProperty
    super[someIndex]
 */
/*:
    重写方法
 */
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo", terminator: "")
    }
}
let train = Train()
train.makeNoise()
/*:
    重写属性
    可以重写继承来的 实例属性 或 类属性，提供自己定制的getter和setter，或添加属性观察器使重写的属性可以观察属性值什么时候发生改变
 */

/*:
    重写属性的Getters和Setters
    可以 提供定制的 getter（或 setter）来重写任意继承来的属性
    不可以 将一个继承来的读写属性重写为一个只读属性
 */
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
car.description
/*:
    重写属性观察器（Property Observer）
    可以 在属性重写中为一个继承来的属性添加属性观察器
    不可以 为继承来的 常量存储型属性 或继承来的 只读计算型属性 添加属性观察器
    不可以 同时提供 重写的 setter 和 重写的 属性观察器
 */
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
automatic.description
//: ## 4. 防止重写
/*:
    final 来防止被重写
    final var
    final func
    final class func
    final subscript
 
    注：final class 类不可继承
 */

//: [Next](@next)
