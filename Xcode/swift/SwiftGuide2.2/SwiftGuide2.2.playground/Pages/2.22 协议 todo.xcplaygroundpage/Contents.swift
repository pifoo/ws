//: [Previous](@previous)
import Foundation
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 协议的语法（Protocol Syntax）
    2. 对属性的规定（Property Requirements）
    3. 对方法的规定（Method Requirements）
    4. 对Mutating方法的规定（Mutating Method Requirements）
    5. 对构造器的规定（Initializer Requirements）
    6. 协议类型（Protocols as Types）
    7. 委托(代理)模式（Delegation）
    8. 在扩展中添加协议成员（Adding Protocol Conformance with an Extension）
    9. 通过扩展补充协议声明（Declaring Protocol Adoption with an Extension）
    10. 集合中的协议类型（Collections of Protocol Types）
    11. 协议的继承（Protocol Inheritance）
    12. 类专属协议（Class-Only Protocol）
    13. 协议合成（Protocol Composition）
    14. 检验协议的一致性（Checking for Protocol Conformance）
    15. 对可选协议的规定（Optional Protocol Requirements）
    16. 协议扩展（Protocol Extensions）
 */
/*:
    协议定义了一个蓝图，规定了用来实现某一特定工作或者功能所必需的方法和属性。
    类，结构体或枚举类型都可以遵循协议，并提供具体实现来完成协议定义的方法和功能。任意能够满足协议要求的类型被称为遵循(conform)这个协议
 */
//: ## 1. 协议的语法（Protocol Syntax）
/*:
    协议的定义方式与类，结构体，枚举的定义非常相似。

    protocol SomeProtocol {
        // 协议内容
    }

    如果类在遵循协议的同时拥有父类，应该将父类名放在协议名之前，以逗号分隔:
    class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
        // 类的内容
    }
 */
//: ## 2. 对属性的规定（Property Requirements）
/*:
    协议中的通常用var来声明属性，在类型声明后加上{ set get }来表示属性是可读可写的，只读属性则用{ get }来表示
 */
protocol SomeProtocol {
    var mustBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
/*:
    在协议中定义类属性(type property)时，总是使用static关键字作为前缀。
    当协议的遵循者是类时，可以使用class或static关键字来声明类属性，但是在协议的定义中，仍然要使用static关键字。
 */
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
/*:
    如下所示，这是一个含有一个实例属性要求的协议
 */
protocol FullyNamed {
    var fullName: String { get }
}

// 下面是一个遵循FullyNamed协议的简单结构体

struct Person: FullyNamed{
    var fullName: String
}
let john = Person(fullName: "John Appleseed")

// 下面是一个更为复杂的类，它采用并遵循了FullyNamed协议:

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"

//: ## 3. 对方法的规定（Method Requirements）
/*:
    协议可以要求其遵循者实现某些指定的实例方法或类方法;
    这些方法作为协议的一部分，像普通的方法一样放在协议的定义中，但是不需要大括号和方法体;
    但是在协议的方法定义中，不支持参数默认值。
 */
/*:
    protocol SomeProtocol {
        static func someTypeMethod()  无默认参数,无方法体
    }
 */

// 下面的例子定义了含有一个实例方法的协议

protocol RandomNumberGenerator {
    func random() -> Double
}
// 如下是一个遵循了RandomNumberGenerator协议的类
// 该类实现了一个叫做 线性同余生成器(linear congruential generator)的伪随机数算法
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
generator.random()
generator.random()

//: ## 4. 对Mutating方法的规定（Mutating Method Requirements）
/*:
    如果在协议中定义了一个方法旨在改变遵循该协议的实例，那么在协议定义时需要在方法前加mutating关键字
    这使得结构和枚举遵循协议并满足此方法要求
 
    注意:
    用类实现协议中的mutating方法时，不用写mutating关键字;
    用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字
 */
protocol Togglable {
    mutating func toggle()  // 使用mutating关键字标记，这表明当它被调用时该方法将会改变协议遵循者实例的状态
}
/*:
    当使用枚举或结构体来实现Togglable协议时，需要提供一个带有mutating前缀的toggle方法
    类 则不需要
 */
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
//: ## 5. 对构造器的规定（Initializer Requirements）
/*:
    协议可以要求它的遵循者实现指定的构造器 , 不需要写花括号和构造器的实体：

    protocol SomeProtocol {
        init(someParameter: Int)
    }
 */
/*:
    协议构造器规定在类中的实现
 
    可以在遵循该协议的类中实现构造器，并指定其为类的指定构造器(designated initializer)或者便利构造器(convenience initializer)。在这两种情况下，都必须给构造器实现标上"required"修饰符：
 
    class SomeClass: SomeProtocol {
        required init(someParameter: Int) {
            //构造器实现
        }
    }
    使用required修饰符可以保证：所有的遵循该协议的子类，同样能为构造器规定提供一个显式的实现或继承实现
 
    注意
    如果类已经被标记为final，那么不需要在协议构造器的实现中使用required修饰符。因为final类不能有子类
 
 */
/*:
    如果一个子类重写了父类的指定构造器，并且该构造器遵循了某个协议的规定，
    那么该构造器的实现需要被同时标示 required 和 override 修饰符

    protocol SomeProtocol {
        init()
    }


    class SomeSuperClass {
        init() {
            // 构造器的实现
        }
    }


    class SomeSubClass: SomeSuperClass, SomeProtocol {
        // 因为遵循协议，需要加上"required"; 因为继承自父类，需要加上"override"
        required override init() {
            // 构造器实现
        }
    }
 */
/*:
    可失败构造器的规定
    如果在协议中定义一个可失败构造器，则在遵顼该协议的类型中必须添加同名同参数的可失败构造器或非可失败构造器
    如果在协议中定义一个非可失败构造器，则在遵循该协议的类型中必须添加同名同参数的非可失败构造器或隐式解析类型的可失败构造器（init!）
 */
//: ## 6. 协议类型（Protocols as Types）
/*:
    尽管协议本身并不实现任何功能，但是协议可以被当做类型来使用
 
    协议可以像其他普通类型一样使用，使用场景:
    - 作为函数、方法或构造器中的参数类型或返回值类型
    - 作为常量、变量或属性的类型
    - 作为数组、字典或其他容器中的元素类型
    
    注意
    协议是一种类型，因此协议类型的名称应与其他类型(Int，Double，String)的写法相同，使用大写字母开头的驼峰式写法，例如(FullyNamed和RandomNumberGenerator)
 
    如下所示，这个示例中将协议当做类型来使用:
 */
class Dice {  // Dice 类用来定义代表桌游中的拥有N个面的骰子
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())", terminator: "")
}


//: ## 7. 委托(代理)模式（Delegation）
/*:
    委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能交由(委托)给其他的类型的实例。
    委托模式的实现很简单: 定义协议来封装那些需要被委托的函数和方法， 使其遵循者拥有这些被委托的函数和方法。委托模式可以用来响应特定的动作或接收外部数据源提供的数据，而无需要知道外部数据源的类型信息。
 
    下面的例子是两个基于骰子游戏的协议:
 */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self,didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders", terminator: "")
        }
        print("The game is using a \(game.dice.sides)-sided dice", terminator: "")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)", terminator: "")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns", terminator: "")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


//: ## 8. 在扩展中添加协议成员（Adding Protocol Conformance with an Extension）
protocol TextRepresentable {
    func asText() -> String
}

extension Dice: TextRepresentable {
    func asText() -> String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12,generator: LinearCongruentialGenerator())
print(d12.asText(), terminator: "")

extension SnakesAndLadders: TextRepresentable {
    func asText() -> String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.asText(), terminator: "")




//: ## 9. 通过扩展补充协议声明（Declaring Protocol Adoption with an Extension）
/*:
    当一个类型已经实现了协议中的所有要求，却没有声明为遵循该协议时，可以通过扩展(空的扩展体)来补充协议声明:
    注意
    即使满足了协议的所有要求，类型也不会自动转变，因此你必须为它做出显式的协议声明
 */
struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {  }
// 从现在起，Hamster的实例可以作为TextRepresentable类型使用
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.asText(), terminator: "")

//: ## 10. 集合中的协议类型（Collections of Protocol Types）
/*:
    协议类型可以在集合使用，表示集合中的元素均为协议类型，
    下面的例子创建了一个类型为TextRepresentable的数组:
 */
let things: [TextRepresentable] = [game,d12,simonTheHamster]
// 如下所示，things数组可以被直接遍历，并打印每个元素的文本表示:
for thing in things {
    print(thing.asText(), terminator: "")
} // thing被当做是TextRepresentable类型而不是Dice，DiceGame，Hamster等类型。因此能且仅能调用asText方法


//: ## 11. 协议的继承（Protocol Inheritance）
/*
    协议能够继承一个或多个其他协议，可以在继承的协议基础上增加新的内容要求
     protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
        // 协议定义
     }
 */
// 如下所示，PrettyTextRepresentable协议继承了TextRepresentable协议,PrettyTextRepresentable协议要求其遵循者提供一个返回值为String类型的asPrettyText方法
protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}
// 如下所示，扩展SnakesAndLadders，让其遵循PrettyTextRepresentable协议:
extension SnakesAndLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0: // 当从数组中取出的元素的值大于0时，用▲表示
                output += "▲ "
            case let snake where snake < 0:   // 当从数组中取出的元素的值小于0时，用▼表示
                output += "▼ "
            default:                          // 当从数组中取出的元素的值等于0时，用○表示
                output += "○ "
            }
        }
        return output
    }
}
// 任意SankesAndLadders的实例都可以使用asPrettyText()方法
print(game.asPrettyText(), terminator: "")
//: ## 12. 类专属协议（Class-Only Protocol）
/*:
    可以在协议的继承列表中,通过添加class关键字,限制协议只能适配到类（class）类型
    (结构体或枚举不能遵循该协议)
 
     // 在以下例子中，协议SomeClassOnlyProtocol只能被类（class）类型适配
     protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
        // class-only protocol definition goes here
     }
 
     注意：
     当协议想要定义的行为，要求（或假设）它的遵循类型必须是引用语义而非值语义时，应该采用类专属协议。关于引用语义，值语义的更多内容，请查看结构体和枚举是值类型和类是引用类型
 */

//: ## 13. 协议合成（Protocol Composition）
/*:
     有时候需要同时遵循多个协议
     可以将多个协议采用protocol<SomeProtocol， AnotherProtocol>这样的格式进行组合，称为协议合成(protocol composition)
     
     注意:
     协议合成并不会生成一个新协议类型，而是将多个协议合成为一个临时的协议，超出范围后立即失效
 */
// 下面的例子中，将Named和Aged两个协议按照上述的语法组合成一个协议:
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) { // wishHappyBirthday函数的形参celebrator的类型为protocol<Named，Aged>。可以传入任意遵循这两个协议的类型的实例
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!", terminator: "")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)


//: ## 14. 检验协议的一致性（Checking for Protocol Conformance）
/*:
    可以使用is和as操作符来检查是否遵循某一协议或强制转化为某一类型:
    - is    操作符用来检查实例是否遵循了某个协议
    - as?   返回一个可选值，当实例遵循协议时，返回该协议类型;否则返回nil
    - as    用以强制向下转型，如果强转失败，会引起运行时错误
 */
// 下面的例子定义了一个HasArea的协议，要求有一个Double类型可读的area:
protocol HasArea {
    var area: Double { get }
}
// 如下所示，定义了Circle和Country类，它们都遵循了HasArea协议 , Circle类把area实现为基于存储型属性radius的计算型属性，Country类则把area实现为存储型属性
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

// 如下所示，Animal是一个没有实现HasArea协议的类
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

// Circle，Country，Animal并没有一个相同的基类，然而，它们都是类，它们的实例都可以作为AnyObject类型的变量，存储在同一个数组中:
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)", terminator: "")
    } else {
        print("Something that doesn't have an area", terminator: "")
    }
}




//: ## 15. 对可选协议的规定（Optional Protocol Requirements）
/*
    在协议中使用optional关键字作为前缀来定义可选成员,
    协议可以含有可选成员，其遵循者可以选择是否实现这些成员, 可选协议在调用时使用可选链，因为协议的遵循者可能没有实现可选内容
    
     注意:
     可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循
     即使不打算和Objective-C有什么交互，如果想要指明协议包含可选属性，那么还是要加上@obj前缀
 */
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: CounterDataSource {
    @objc let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count, terminator: "")
}
//: ## 16. 协议扩展（Protocol Extensions）
/*:
    使用扩展协议的方式可以为遵循者提供方法或属性的实现
    通过这种方式，可以让无需在每个遵循者中都实现一次，无需使用全局函数，可以通过扩展协议的方式进行定义
 
 */
// 例如，可以扩展RandomNumberGenerator协议，让其提供randomBool()方法。该方法使用协议中要求的random()方法来实现:
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
// 通过扩展协议，所有协议的遵循者，在不用任何修改的情况下，都自动得到了这个扩展所增加的方法。
let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator1.random())", terminator: "")
// 输出 "Here's a random number: 0.37464991998171"
print("And here's a random Boolean: \(generator1.randomBool())")
// 输出 "And here's a random Boolean: true"

/*:
    提供默认实现
 */
extension PrettyTextRepresentable  {
    func asPrettyText() -> String {
        return asText()
    }
}


/*:
    为协议扩展添加限制条件
    使用 where 关键字来描述限制情况
 */
extension CollectionType where Generator.Element : TextRepresentable {
    func asList() -> String {
        return "(" + ", ".join(map({$0.asText()})) + ")"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.asList())
//: [Next](@next)
