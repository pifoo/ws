//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 自动引用计数的工作机制
    2. 自动引用计数实践
    3. 类实例之间的循环强引用
    4. 解决实例之间的循环强引用
    5. 闭包引起的循环强引用
    6. 解决闭包引起的循环强引用
 */
/*:
    注意:
    引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。
 */
//: ## 1. 自动引用计数的工作机制
/*: 
    参考: http://www.devtf.cn/?p=462
    1. 强引用      strong    适用于父对象指向子对象，但反过来不能用强引用(e.g 父亲拥有儿子，反之则不成立)，默认是都是strong引用
    2. 弱引用      weak      当两个实例是optionally关联在一起的，确保其中一个实例是用 weak 弱引用指 向另一个实例
    3. 无主引用    unowned   两个实例A和B，如果实例A必须在实例B存在的前提下才能存在，那么实例A必须用unowned无主引用指向实例B。也就是说，有强制依赖性的那个实例必须对另一个实例持有无主引用
 
 注：以上三种引用只适用于引用类型，不适用于值类型
 */
/*
    自动引用计数（ARC）就是对内存管理的一种提炼, 通过清除内存中不用的 类实例 来释放内存空间所采用的一种方法;
    
    1. strong强引用
    所有的引用在没有特殊说明之前都是strong强引用。
    在Swift中，当你声明一个变量或是常量时，默认就是strong强引用，所以不用在前面添加strong
 
    在ARC中，只有当指向一个类实例的所有 strong强引用 都被断开了，那么这个类实例才会被清除，内存才会被释放
    - 当指向某一实例的变量被设为nil
    - 当持有一个子类实例引用的父类变量被设为nil，这样会同时断开父类和子类之间的相互引用
    - 当变量或常量离开了自己的作用域，比如在if/else或者for循环中初始化了某些变量，当程序执行完这些控制流语句时，相关引用就断开了，同时ARC会释放内存
    ARC中内存管理的所有事情都取决于到底有几个strong强引用指向实例。当指向一个实例的strong强引用为零的时候，那么就是这个实例被清除，所占据内存空间被释放的时候
 
    2. weak弱引用和unowned无主引用
    (描述 类实例 与 类实例 之间的关系，就应该要想到weak弱引用和unowned无主引用)
 */


//: ## 2. 自动引用计数实践
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized", terminator: "")
    }
    deinit {                    // 析构函数 实例被销毁时调用
        print("\(name) is being deinitialized", terminator: "")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

// 强引用
reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1
// 只留下一个强引用
reference1 = nil
reference2 = nil
// 断开最后一个强引用，ARC 才会销毁实例，从而释放内存
reference3 = nil

//: ## 3. 类实例之间的循环强引用
/*:
    strong强引用：层级类关系中,strong强引用方向都一致：从父类指向子类
    strong强引用 的产生:
 */
class Persones {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized", terminator: "") }
}

class Apartment {
    let number: Int
    init(number: Int) { self.number = number }
    var tenant: Persones?
    deinit { print("Apartment #\(number) is being deinitialized", terminator: "") }
}

var john: Persones?
var number73: Apartment?

john = Persones(name: "John Appleseed")
number73 = Apartment(number: 73)
// 将两个实例联系在一起, 两个实例关联后会产生一个循环强引用
john!.apartment = number73
number73!.tenant = john
// 没有任何一个析构函数被调用, 循环强引用会一直阻止Person和Apartment类实例的销毁，这就在你的应用程序中造成了内存泄漏
john = nil
number73 = nil

//: ## 4. 解决 实例之间的 循环强引用
/*:
    解决实例之间的循环强引用
    - 弱引用（weak reference）     : 对于生命周期中会变为 nil 的实例使用弱引用
    - 无主引用（unowned reference） : 对于初始化赋值后再也不会被赋值为nil的实例，使用 无主引用
    弱引用 和 无主引用 允许循环引用中的一个实例引用另外一个实例而不保持强引用
 */

/*:
    弱引用
    weak 关键字表明这是一个 弱引用
    注意:
    弱引用 必须被声明为 变量，表明其值能在运行时被修改。弱引用 不能 被声明为 常量
    弱引用可以没有值，必须将每一个 弱引用 声明为 可选类型
    弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁
 
    可选，相互依赖的关系:
    允许某一个实例在不持有其他实例引用的情况下也能够存在
 */
class Person1 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment1?
    deinit { print("\(name) is being deinitialized", terminator: "") }
}

class Apartment1 {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: Person1?   // Apartment的tenant属性被声明为弱引用
    deinit { print("Apartment #\(number) is being deinitialized", terminator: "") }
}

// 建立两个变量（john和number73）之间的强引用，并关联两个实例：
var john1: Person1?
var number731: Apartment1?

john1             = Person1(name: "John Appleseed")
number731         = Apartment1(number: 73)

john1!.apartment  = number731
number731!.tenant = john1
john1             = nil
// prints "John Appleseed is being deinitialized"
number731         = nil
// prints "Apartment #73 is being deinitialized"

/*:
    无主引用
    和弱引用不同的是，无主引用是永远有值的
    无主引用 总是被定义为 非可选类型（non-optional type）,总是可以被直接访问
    ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil
 
    unowned 表示这是一个无主引用
 
    强制，单向依赖关系:
    - 两个类实例是相互有联系的，但是其中一个实例必须要在另一个实例存在的前提下才能存在
    - 有强制依赖性的那个实例必须对另一个实例持有无主引用
 */

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized", terminator: "") }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer // 由于信用卡总是关联着一个客户，因此将customer属性定义为无主引用，用以避免循环强引用：
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized", terminator: "") }
}
var john2: Customer?

john2 = Customer(name: "John Appleseed")
john2!.card = CreditCard(number: 1234_5678_9012_3456, customer: john2!)

john2 = nil
// prints "John Appleseed is being deinitialized"
// prints "Card #1234567890123456 is being deinitialized"

/*:
    无主引用 以及 隐式解析 可选属性
    存在一种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil
    在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性；
    这使两个属性在初始化完成后能被直接访问（不需要可选展开），同时避免了循环引用
 */
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)", terminator: "")
// prints "Canada's capital city is called Ottawa"

//: ## 5. 闭包引起的循环强引用
/*:
    闭包捕获列表（closuer capture list）
 
    因为闭包和类相似，都是引用类型。当把一个闭包赋值给某个属性时，也把一个引用赋值给了这个闭包
    实质上，这跟之前的问题是一样的－两个强引用让彼此一直有效。但是，和两个类实例不同，这次一个是类实例，另一个是闭包
 
 
 */
// 下面的例子为展示了当一个闭包引用了self后是如何产生一个循环强引用的
class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized", terminator: "")
    }
    
}
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML(), terminator: "")
// prints"hello, world"
paragraph = nil


//: ## 6. 解决闭包引起的循环强引用   TODO



/*:
    定义捕获列表
 */
/*
lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}

lazy var someClosure: Void -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // closure body goes here
}*/

/*:
    弱引用和无主引用
 
 */
/*
class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// prints "<p>hello, world</p>"

paragraph = nil
// prints "p is being deinitialized"
*/
//: [Next](@next)
