//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 泛型所解决的问题
    2. 泛型函数
    3. 类型参数
    4. 命名类型参数
    5. 泛型类型
    6. 扩展一个泛型类型
    7. 类型约束
    8. 关联类型
    9. Where语句
 */

//: ## 1. 泛型所解决的问题
// 以下 非泛型 函数，此函数使用写(输)入读(输)出（in-out）参数来交换a和b的值 (便于作用域外访问变量的值)
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
someInt
anotherInt

// 以上示例，只局限于交换Int类型数据 ，如果想要交换其它类型数据，就不得不写更多函数
func swapTwoStrings(inout a: String, inout _ b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(inout a: Double, inout _ b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// swapTwoInts、 swapTwoStrings和swapTwoDoubles(_:_:)函数功能都是相同的，唯一不同之处就在于传入的变量类型不同，分别是Int、String和Double

//: ## 2. 泛型函数
/*:
    泛型函数可以工作于任何类型
    以下是swapTwoInts(_:_:)函数的泛型版本，用于交换两个值：
 */
func swapTwoValues<T>(inout a: T, inout _ b: T) { // 占位类型T是一种类型参数的示例
    let temporaryA = a
    a = b
    b = temporaryA
}
// Int类型
var someInt1 = 3
var anotherInt1 = 107
swapTwoValues(&someInt1, &anotherInt1)
someInt1
anotherInt1
// String类型
var someString2 = "hello"
var anotherString2 = "world"
swapTwoValues(&someString2, &anotherString2)
someString2
anotherString2
//: ## 3. 类型参数
/*:
    被类型参数所代表的占位类型不管函数任何时候被调用
    都会被实际类型所替换（在上面swapTwoValues例子中，当函数第一次被调用时，T被Int替换，第二次调用时，被String替换）
    
    你可支持多个类型参数，命名在尖括号中，用逗号分开
 */

//: ## 4. 命名类型参数
/*:
    通常用一单个字母T来命名类型参数
    始终使用大写字母开头的驼峰式命名法（例如T和Key）来给类型参数命名，以表明它们是类型的占位符，而非类型值
 */

//: ## 5. 泛型类型
/*:
    泛型集类型--Stack（栈）
 
 */
// 以下展示了如何写一个非泛型版本的栈，Int值型的栈：
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
// 以上 IntStack类型只能用于Int值，以下定义一个泛型Stack类（可以处理任何类型值的栈）
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
// 在尖括号里写出栈中需要存储的数据类型来创建并初始化一个Stack实例
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

stackOfStrings

let fromTheTop = stackOfStrings.pop()
//: ## 6. 扩展一个泛型类型
// 下面的例子扩展了泛型Stack类型，为其添加了一个名为topItem的只读计算属性，它将会返回当前栈顶端的元素而不会将其从栈中移除
extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// topItem计算属性现在可以被用来返回任意Stack实例的顶端元素而无需移除它：
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).", terminator: "")
}
//: ## 7. 类型约束
/*:
    类型约束指定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成
 */

/*:
    类型约束语法
 
    在一个类型参数名后面的类型约束，通过冒号分割，来作为类型参数链的一部分
    这种作用于泛型函数的类型约束的基础语法如下所示（和泛型类型的语法相同）：

    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
        // 这里是函数主体
    }
 */

/*:
    类型约束行为
 */
// findStringIndex 非泛型函数，该函数功能是去查找包含一给定String值的数组。若查找到匹配的字符串，findStringIndex(_:_:)函数返回该字符串在数组中的索引值（Int），反之则返回nil：
func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
// indStringIndex(_:_:)函数可以作用于查找一字符串数组中的某个字符串:
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    print("The index of llama is \(foundIndex)", terminator: "")
}

// Swift 标准库中定义了一个Equatable协议，该协议要求任何遵循的类型实现等式符（==）和不等符（!=）对任何两个该类型进行比较。所有的 Swift 标准类型自动支持Equatable协议
// findIndex中这个单个类型参数写做：T: Equatable，也就意味着“任何T类型都遵循Equatable协议”
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// findIndex(_:_:)函数现在则可以成功的编译过，并且作用于任何遵循Equatable的类型，如Double或String:
let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
// doubleIndex is an optional Int with no value, because 9.3 is not in the array
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
// stringIndex is an optional Int containing a value of 2

//: ## 8. 关联类型
/*:
    关联类型被指定为 typealias 关键字
    
    一个关联类型作为协议的一部分，给定了类型的一个占位名（或别名）,作用于关联类型上实际类型在协议被实现前是不需要指定的
 */

/*
    关联类型行为   TODO
 
    以下是一个Container协议的例子，定义了一个ItemType关联类型：
 */
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

// 以下是一个早前IntStack类型的非泛型版本，遵循Container协议：
struct IntStack1: Container {
    // IntStack的原始实现
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // 遵循Container协议的实现
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// 以下是生成遵循Container协议的泛型Stack类型：
struct Stack1<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}

/*:
    扩展一个存在的类型为一指定关联类型
 */

extension Array: Container {}

//: ## 9. Where语句
/*:
    可以在参数列表中通过where语句定义参数的约束
    一个where语句能够使一个关联类型遵循一个特定的协议，以及（或）那个特定的类型参数和关联类型可以是相同的
 */
// TODO
func allItemsMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {
    
    // 检查两个Container的元素个数是否相同
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // 检查两个Container相应位置的元素彼此是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // 如果所有元素检查都相同则返回true
    return true
}

var stackOfStrings1 = Stack<String>()
stackOfStrings1.push("uno")
stackOfStrings1.push("dos")
stackOfStrings1.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

//if allItemsMatch(stackOfStrings1, anotherContainer: arrayOfStrings) {
//    print("All items match.")
//} else {
//    print("Not all items match.")
//}

//: [Next](@next)
