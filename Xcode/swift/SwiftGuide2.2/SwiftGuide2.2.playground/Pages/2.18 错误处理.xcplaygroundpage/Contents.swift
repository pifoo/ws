//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 错误的表示
    2. 捕捉和处理错误
    3. 禁止错误传播
    4. 收尾操作
 */
/*:
    错误处理是响应错误以及从错误中返回的过程
 
    swift提供的语法安全机制：
    - 只有使用Optional才能处理空值nil
    - switch...case...必须处理所有的请求
 */
//: ## 1. 错误的表示
/*:
    错误用符合 ErrorType 协议的值表示
 */
// 操作自动贩卖机会出现的错误：
enum VendingMachineError1111111111: ErrorType {
    case InvalidSelection                       // 请求的物品不存在
    case InsufficientFunds(required: Double)    // 请求的物品的价格高于已投入金额
    case OutOfStock                             // 请求的物品已经卖完了
}

enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)


/*:
    错误抛出
    throws关键字，表明这个函数或方法可以抛出错误，并指定一个返回值
 */
func canThrowErrors() throws -> String {
    // ...
    return ""
}
func cannotThrowErrors() -> String  {
    // ...
    return ""
}

// e.g
struct Item {       // 定义货物清单属性
    var price: Int
    var count: Int
}
var inventory = [   // 货物清单
    "Candy Bar": Item(price: 12, count: 7),
    "Chips": Item(price: 10, count: 4),
    "Pretzels": Item(price: 7, count: 11)
]
var amountDeposited = 1  // 投入金额
/**
 贩卖机售货
 
 - itemNamed: 商品名称
 - throws: 物品存在，库存足够以及投入金额足够，物品才会出售
 */

/*
func vend(itemNamed name: String) throws {      // 出售  1. throws
    guard var item = inventory[name] else {     // 绑定item常量和count变量到在库存中对应的值
        throw VendingMachineError.InvalidSelection // 物品不在库存将  抛出错误     2. throw
    }
    
    guard item.count > 0 else {                 // 物品不足<=0 将抛出错误
        throw VendingMachineError.OutOfStock
    }
    
    
    guard item.count > 0 else {
        throw VendingMachineError.OutOfStock
    }
    
    guard item.price <= coinsDeposited else {
        throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
    }
    
    coinsDeposited -= item.price
    
    var newItem = item
    newItem.count -= 1
    inventory[name] = newItem
    
    dispenseSnack(name)
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String) throws {   // 查找某人最喜欢的零食，然后尝试买给他
    let snackName = favoriteSnacks[person] ?? "Candy Bar"  // 没有喜欢的零食，就会购买Candy Bar
    //print("本次购买到的商品:\(snackName)")
    try vend(itemNamed: snackName)     //   vend函数可能会抛出错误   3. try

    // 因为buyFavoriteSnack函数也是一个抛出函数，所以vend函数抛出的任何错误都会向上传递到buyFavoriteSnack被调用的地方
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

*/

//: ## 2. 捕捉和处理错误
/*:
    使用do-catch语句来捕获和处理错误 , 如果一个错误被抛出了，这个错误会被传递到外部域，直到被一个catch分句处理
    do {
        try function that throws
        statements
    } catch pattern {
        statements
    }
 */

/*
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
*/



//: ## 3. 禁止错误传播
/*:
    用forced-try表达式来调用抛出函数或方法，即使用try!来代替try
    通过try!来调用抛出函数或方法禁止了错误传送，并且把调用包装在运行时断言，这样就不会抛出错误。如果错误真的抛出了，会触发运行时错误
 
    func willOnlyThrowIfTrue(value: Bool) throws {
        if value { throw someError }
    }
 
    do {
        try willOnlyThrowIfTrue(false)
    } catch {
        // Handle Error
    }
 
    try! willOnlyThrowIfTrue(false)
 */

//: ## 4. 收尾操作
/*:
    使用defer语句来在执行一系列的语句。这样不管有没有错误发生，都可以执行一些必要的收尾操作包;
    括关闭打开的文件描述符以及释放所有手动分配的内存
 
    defer语句把执行推迟到退出当前域的时候。defer语句包括defer关键字以及后面要执行的语句。被推迟的语句可能不包含任何将执行流程转移到外部的代码，比如break或者return语句，或者通过抛出一个错误。被推迟的操作的执行的顺序和他们定义的顺序相反，也就是说，在第一个defer语句中的代码在第二个defer语句中的代码之后执行。
 
    下面这个例子使用了defer语句来保证open有对应的close。这个调用不管是否有抛出都会执行
 
    func processFile(filename: String) throws {
        if exists(filename) {
            let file = open(filename)
            defer {
                close(file)
            }
            while let line = try file.readline() {
                // Work with the file.
            }
            // close(file) is called here, at the end of the scope.
        }
    }
 */

//: [Next](@next)
