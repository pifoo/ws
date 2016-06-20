//: A001.03 WWDC2014 Swift入门 类初始化属性方法

import Cocoa

var str = "Hello, playground"


// 1. Classes  类
class SuperClass {
    // properties 属性
    // methods 方法
    // initializers 初始化
    // ...
    
    // 1.1 Stored Properties     储值属性
    var numberOfWhells = 0
    
    // 1.2 Computed Properties   算值属性
    var description: String {
        //get {                   // 只读   可以省略get
            return "\(numberOfWhells)个轮子..."
        /*}
        set {                   // get,set 读写
            // 在这里可能通过 newValue 变量访问新值
            newValue
        }*/
    }
    
}


// 1.3 初始化
let someInit = SuperClass()  // 类型推导为SuperClass类型，可省略


// 1.4 访问/修改 属性
someInit.numberOfWhells = 2
someInit.description


// 2. 继承
class SubClass: SuperClass {
    // 2.1 给子类初始化
    override init() {
        //super.init()
        //numberOfWhells = 6   // TODO
    }
}
let mySub = SuperClass()    // 实例
mySub.numberOfWhells = 6
mySub.description



// 3. Overriding Properties  属性覆盖 (其实就是覆盖算值属性的set、get两个方法)
class Car {
    var numberOfWhells = 0
    var description: String {
        return "\(numberOfWhells)个轮子..."
    }
    
}
class Jepp: Car {
    var speed = 0.0;
    override init() {
        super.init()
        numberOfWhells = 4
    }
    
    override var description: String {      // 无法覆写只读属性
        return super.description + ", 每小时\(speed)英里."
    }
}
let myJeep = Jepp()
myJeep.speed = 40.5
myJeep.description



// 4. Property Observers        属性观察(储值属性可添加属性观察)
class ParentsCar: SuperClass {
    override var numberOfWhells: Int {      // 对储值属性进行补充：属性观察(父类须实现了set、get  ？ TODO)
        willSet {
            // 在这里可能通过 newValue 变量访问新值
            if newValue > 10 {
                print("车轮为\(newValue)")
            }
            
        }
        didSet {
            // 在这里可能通过 oldValue 变量访问新旧值
        }
    }
}
let myParCar = ParentsCar()
myParCar.numberOfWhells = 11



// 5. Methods   方法
class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func incrementBy(amount: Int) -> (Int) {
        return count + amount
    }
    
    func resetToCount(count: Int) {
        self.count = count
    }
}























