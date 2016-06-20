//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 存储型属性的初始赋值
    2. 自定义构造过程
    3. 默认构造器
    4. 值类型的构造器代理
    5. 类的继承和构造过程
    6. 可失败构造器
    7. 必要构造器
    8. 通过闭包和函数来设置属性的默认值
 
 */
/*:
    构造过程
    是为了使用某个 类、结构体 或 枚举类型 的 实例 而进行的 准备过程:
    - 存储型属性的初始赋值
    - 为其执行必要的准备和初始化任务
 
    构造过程 是通过定义构造器（Initializers）来实现的,这些构造器可以看做是用来 创建 特定类型实例 的 特殊方法
    Swift 的构造器 无需 返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化
    
    类的实例 也可以通过定义析构器（deinitializer）在实例释放之前执行特定的清除工作 - 析构过程
 */
//: ## 1. 存储型属性的初始赋值
/*:
    类和结构体在实例创建时，必须为其所有存储型属性设置合适的初始值
    - 在 构造器中 为存储型属性 赋初值
    - 在 定义属性 时为其设置 默认值
 
    注意：
    当为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观测器（property observers）
 */

/*:
    构造器
    构造器在创建某特定类型的新实例时调用
        init() {
            // 在此处执行构造过程
        }
 */
struct Fahrenheit {
    var temperature: Double
    init() {        // 在 构造器中 为存储型属性 赋初值
        temperature = 32.0
    }
}
var f = Fahrenheit()
f.temperature
/*:
    默认属性值
    在 属性声明时 为其设置 默认值
 */
struct Fahrenheit1 {
    var temperature = 32.0
}
//: ## 2. 自定义构造过程
/*:
    可以通过 输入参数 和 可选属性类型 来定义构造过程，也可以在 构造过程中 修改常量属性
 
    可以在定义构造器时提供构造参数，为其提供自定义构造所需值的类型和名字
    init(fromFahrenheit:)
 */
struct Celsius {
    var temperatureInCelsius: Double = 0.0
    // 构造器初始值时 将华氏温度转换为摄氏度
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
boilingPointOfWater.temperatureInCelsius
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
freezingPointOfWater.temperatureInCelsius
/*:
    参数的 内部名称 和 外部名称
    
    构造器没有可辨别的函数名，可通过 参数名+类型 来确定需要调用的构造器
 */
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
magenta.red
magenta.green
magenta.blue

let halfGray = Color(white: 0.5)
halfGray.red
halfGray.green
halfGray.blue

// let veryGreen = Color(0.0, 1.0, 0.0)     // error: missing argument labels 'red:green:blue:'

/*:
    不带外部名的构造器参数
    不提供提供外部参数名字，可以使用下划线(_)来显示描述它的外部名
 */
struct Celsius2 {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius2(37.0)  // 调用了不带参数名的构造器
bodyTemperature.temperatureInCelsius
/*:
    可选属性类型
    
    可选类型的属性将自动初始化为空 nil，表示这个属性是故意在初始化时设置为空的
 */
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text, terminator: "")
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()    // 输出 "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."
/*:
    构造过程中常量属性的修改
 */
class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {  // 尽管text属性现在是常量，我们仍然可以在其类的构造器中设置它的值
        self.text = text
    }
    func ask() {
        print(text, terminator: "")
    }
}
let beetsQuestion1 = SurveyQuestion1(text: "How about beets?")
beetsQuestion1.ask() // 输出 "How about beets?"
beetsQuestion1.response = "I also like beets. (But not with cheese.)"
//: ## 3. 默认构造器
// 类
class ShoppingListItem {
    // 属性均有默认值
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()  // 无法“访问” 逐一成员构造器
/*:
    结构体的逐一成员构造器
    逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法
 */
// 结构体
struct Size {
    var width = 0.0, height = 0.0
}
let oneByOne = Size() // 默认构造器 init()
let twoByTwo = Size(width: 2.2, height: 2.2) // 逐一成员构造器 init(width:height:)
//: ## 4. 值类型的构造器代理
/*:
    构造器代理 的实现规则和形式在 值类型 和 类类型 中有所 不同
    值类型（结构体和枚举类型）不支持继承
    类(引用类型) 有责任保证其所有继承的 存储型属性 在构造时也能正确的初始化
 
    对于值类型，可以使用 self.init 在自定义的构造器中 引用 其它的属于相同值类型的构造器, 并且只能在构造器内部调用 self.init
 */
// 定义一个用于描述几何体的构造器
struct Size1 {
    var width = 0.0, height = 0.0
}
struct Point1 {
    var x = 0.0, y = 0.0
}
struct Rect1 {
    var origin = Point1()
    var size   = Size1()
    init() {}                               // 自定义/默认构造器1: 使用默认的0值来初始化origin和size属性
    init(origin: Point1, size: Size1) {     // 自定义构造器2: 使用特定的origin和size实例来初始化
        self.origin = origin
        self.size   = size
    }
    
    // 先通过center和size的值计算出origin的坐标。
    // 然后再调用（或代理给）init(origin:size:)构造器来将新的origin和size值赋值到对应的属性中
    init(center: Point1, size: Size1) {     // 自定义构造器3: 使用特定的center和size来初始化
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point1(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect1()  // basicRect 的原点是 (0.0, 0.0)，尺寸是 (0.0, 0.0)

let originRect = Rect1(origin: Point1(x: 2.0,y: 2.0), size: Size1(width: 5.0, height: 5.0))
// originRect 的原点是 (2.0, 2.0)，尺寸是 (5.0, 5.0)

let centerRect = Rect1(center: Point1(x: 4.0, y: 4.0),
                      size: Size1(width: 3.0, height: 3.0))
// centerRect 的原点是 (2.5, 2.5)，尺寸是 (3.0, 3.0)
//: ## 5. 类的继承和构造过程
/*:
    类里面的所有存储型属性--包括所有继承自父类的属性--都必须在构造过程中设置初始值
    Swift 提供了两种类型的类构造器来确保所有类实例中存储型属性都能获得初始值:
    - 指定构造器
    - 便利构造器
 */

/*:
    指定构造器 和 便利构造器
 
    指定构造器
    - 是类中最主要的构造器
      一个指定构造器将 初始化 类中提供的 所有属性，并根据 父类链 往上调用父类的构造器来实现父类的初始化
    - 每一个类都必须拥有至少一个指定构造器
 
    便利构造器
    - 是类中比较次要的、辅助型的构造器
      便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值
      也可以定义便利构造器来创建一个特殊用途或特定输入的实例
 */

/*:
    指定构造器 和 便利构造器的语 法
 
    类的 指定构造器 的写法跟 值类型 简单构造器一样：
        init(parameters) {
            statements
        }
    
    便利构造器 需要在 init 关键字之前放置 convenience 关键字:
        convenience init(parameters) {
            statements
        }
 */

/*:
    类的构造器代理规则:
 
    为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：
    规则 1
        指定构造器必须调用其直接父类的的指定构造器(构造器链)。
    规则 2
        便利构造器必须调用同一类中定义的其它构造器。
    规则 3
        便利构造器必须最终以调用一个指定构造器结束。
 
    一个更方便记忆的方法是：
    - 指定构造器必须总是向上代理
    - 便利构造器必须总是横向代理
 */

/*:
    两段式构造过程
    - 第一阶段，通过类的构造器来设置初始值
    - 第二阶段，每一个存储型属性值被确定后，给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性
 
    两段式构造过程
    - 可以防止属性值在初始化之前被访问；
    - 也可以防止属性被另外一个构造器意外地赋予不同的值
 */

/*:
    Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程能顺利完成
    ...
 */

/*:
    构造器 的 继承 和 重写
    Swift 中的子类不会默认继承父类的构造器
    注意：
    - 父类的构造器仅在确定和安全的情况下被继承
    - 子类可以在初始化时修改继承变量属性，但是不能修改继承过来的常量属性
 */
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
vehicle.description

class Bicycle: Vehicle {
    override init() {   // 定义了一个自定义指定构造器init()
        super.init()    // 与父类的指定构造器相匹配
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
bicycle.description
/*:
    自动构造器的继承
    父类的构造器仅在确定和安全的情况下被继承
    
    假设要为子类中引入的任意新属性提供默认值，请遵守以下2个规则：
    - 如果子类 没有定义 任何指定构造器，它将自动继承所有父类的指定构造器
    - 如果子类 提供了 所有父类 指定构造器 的 实现
        --不管是通过规则1继承过来的，还是通过自定义实现的--它将自动 继承 所有父类的 便利构造器
    注：子类可以通过部分满足规则2的方式，使用子类便利构造器来实现父类的指定构造器
 */

/*:
    指定构造器和便利构造器操作
    
    下面的例子将在操作中展示 指定构造器、便利构造器 和 自动构造器 的继承
 */
class Food {
    var name: String
    init(name: String) {                    // 指定构造器，确保所有新Food实例的中存储型属性都被初始化
        self.name = name
    }
    convenience init() {                    // 便利构造器，为新实例提供了一个默认的占位名字，通过代理调用同一类中定义的指定构造器init(name: String)并给参数name传值[Unnamed]来实现：
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItemes: RecipeIngredient { // 所有属性都提供了默认值，并且没有定义任何构造器，ShoppingListItemes将自动继承所有父类中的指定构造器和便利构造器
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name.lowercaseString)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
// 使用全部三个继承来的构造器来创建ShoppingListItemes的新实例：
var breakfastList = [
    ShoppingListItemes(),
    ShoppingListItemes(name: "Bacon"),
    ShoppingListItemes(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description, terminator: "")
}
// 1 x orange juice ✔
// 1 x bacon ✘
// 6 x eggs ✘
//: ## 6. 可失败构造器
/*:
    类，结构体 或 枚举类型的对象,如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等
    在构造自身的过程中有可能失败 , 为了妥善处理这种构造过程中可能会失败的情况,可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器
 
    语法：
    在init关键字后面加添问号(init?)
 
    注意： 
    可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其类型相同
 */
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
// someCreature 的类型是 Animal? 而不是 Animal
someCreature?.species
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)", terminator: "")
}// 打印 "An animal was initialized with a species of Giraffe"


let anonymousCreature = Animal(species: "")
// anonymousCreature 的类型是 Animal?, 而不是 Animal
anonymousCreature?.species
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized", terminator: "")
}// 打印 "The anonymous creature could not be initialized"
/*:
    枚举类型 的 可失败构造器
 */
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.", terminator: "")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.", terminator: "")
}
// 打印 "This is not a defined temperature unit, so initialization failed."
/*:
    带 原始值 的 枚举类型 的可失败构造器
    
    带原始值的枚举类型会自带一个可失败构造器init?(rawValue:),
    该可失败构造器有一个名为rawValue的默认参数,其类型和枚举类型的原始值类型一致，
    如果该参数的值能够和枚举类型成员所带的原始值匹配，则该构造器构造一个带此原始值的枚举成员，否则构造失败。
 
    因此上面的 TemperatureUnit的例子可以重写为：
 
    带原始值的枚举类型会自带一个可失败构造器init?(rawValue:),该可失败构造器有一个名为rawValue的默认参数,其类型和枚举类型的原始值类型一致
 */
enum TemperatureUnits: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnits = TemperatureUnits(rawValue: "F") // 如果该 rawValue 默认参数的值能够和枚举类型成员所带的原始值匹配，则该构造器构造一个带此原始值的枚举成员，否则构造失败
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.", terminator: "")
}
// prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnits = TemperatureUnits(rawValue: "X")
if unknownUnits == nil {
    print("This is not a defined temperature unit, so initialization failed.", terminator: "")
}
// prints "This is not a defined temperature unit, so initialization failed."

/*:
    类 的 可失败构造器
 
    值类型（如结构体或枚举类型）的可失败构造器，对何时何地触发构造失败这个行为没有任何的限制
    类 的可失败构造器只能在所有的类属性被初始化后和所有类之间的构造器之间的代理调用发生完后触发失败行为
 */
class Product {
    let name: String!    // 隐式解析可选类型
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

if let bowTie = Product(name: "bow tie") {
    // 不需要检查 bowTie.name == nil
    print("The product's name is \(bowTie.name)", terminator: "")
} // 打印 "The product's name is bow tie"

/*:
    构造失败的传递
 
    无论是向上代理还是横向代理，如果你代理的可失败构造器，在构造过程中触发了构造失败的行为，整个构造过程都将被立即终止，接下来任何的构造代码都将不会被执行
 
    注意： 可失败构造器也可以代理调用其它的非可失败构造器。通过这个方法，你可以为已有的构造过程加入构造失败的条件
 
    可失败构造器总是先向上代理调用基类,Product的构造器 init(name:)。这满足了可失败构造器在触发构造失败这个行为前必须总是执行构造代理调用这个条件
 */
class CartItem: Product {
    var quantity: Int!
    init?(name: String, quantity: Int) {
        super.init(name: name)
        if quantity < 1 { return nil }
        self.quantity = quantity
    }
}
// 如果你构造了一个CartItem对象，并且该对象的name属性不为空以及quantity属性为1或者更多，则构造成功：
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)", terminator: "")
} // 打印 "Item: sock, quantity: 2"

// 如果你构造一个CartItem对象，其quantity的值0, 则CartItem的可失败构造器触发构造失败的行为:
    
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)", terminator: "")
} else {
    print("Unable to initialize zero shirts", terminator: "")
}
// 打印 "Unable to initialize zero shirts"


// 如果你构造一个CartItem对象，但其name的值为空, 则基类Product的可失败构造器将触发构造失败的行为，整个CartItem的构造行为同样为失败：
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)", terminator: "")
} else {
    print("Unable to initialize one unnamed product", terminator: "")
}
// 打印 "Unable to initialize one unnamed product"
/*:
    重写一个可失败构造器
 
    注意： 可以用一个非可失败构造器重写一个可失败构造器，但反过来却行不通
 */
class Document {
    var name: String?
    // 该构造器构建了一个name属性值为nil的document对象
    init() {}
    // 该构造器构建了一个name属性值为非空字符串的document对象
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
// AutomaticallyNamedDocument用一个非可失败构造器init(name:),重写了基类的可失败构造器init?(name:)。因为子类用不同的方法处理了name属性的值为一个空字符串的这种情况。所以子类将不再需要一个可失败的构造器

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

/*:
    可失败构造器 init!
    该可失败构造器将会构建一个 特定类型 的 隐式解析可选类型 的对象
 */

//: ## 7. 必要构造器
/*:
    在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器：
 */
class SomeClass {
    required init() {
        // 在这里添加该必要构造器的实现代码   
    }
}
// 当子类重写基类的必要构造器时，必须在子类的构造器前同样添加required修饰符以确保当其它类继承该子类时，该构造器同为必要构造器。在重写基类的必要构造器时，不需要添加override修饰符：
class SomeSubclass: SomeClass {
    required init() {
        // 在这里添加子类必要构造器的实现代码
    }
}
// 注意： 如果子类继承的构造器能满足必要构造器的需求，则无需显示的在子类中提供必要构造器的实现。
//: ## 8. 通过闭包和函数来设置属性的默认值
/*:
    
    下面列举了闭包如何提供默认值的代码概要：
    class SomeClass {
        let someProperty: SomeType = {
            // 在这个闭包中给 someProperty 创建一个默认值
            // someValue 必须和 SomeType 类型相同
            return someValue
        }()  // ()表示 需要立刻执行此闭包
    }

 */

struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}
let board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1), terminator: "")
// 输出 "true"
print(board.squareIsBlackAtRow(9, column: 9), terminator: "")
// 输出 "false"


//: [Next](@next)
