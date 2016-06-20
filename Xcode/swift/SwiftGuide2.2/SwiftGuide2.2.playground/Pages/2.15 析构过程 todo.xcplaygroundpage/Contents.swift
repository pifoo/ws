//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 析构过程原理
    2. 析构器操作
 */

/*:
    析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用
    析构器用关键字 deinit 来标示，类似于构造器要用init来标示
 */

//: ## 1. 析构过程原理
/*:
    在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数，如下所示：
    deinit {
        // 执行析构过程
    }
 
    析构器是在实例释放发生前被自动调用。析构器是不允许被主动调用的。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用
 
    直到实例的析构器被调用时，实例才会被释放，所以析构器可以访问所有请求实例的属性，并且根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）
 */
//: ## 2. 析构器操作
struct Bank {
    static var coinsInBank = 10_000   // 静态属性   当前它拥有的硬币数量
    static func vendCoins(var numberOfCoinsToVend: Int) -> Int {  // 静态方法  处理硬币的分发
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receiveCoins(coins: Int) {      // 处理硬币的收集
        coinsInBank += coins
    }
}
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit {
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins", terminator: "")
// 输出 "A new player has joined the game with 100  coins"
print("There are now \(Bank.coinsInBank) coins left   in the bank", terminator: "")
// 输出 "There are now 9900 coins left in the bank"

playerOne!.winCoins(2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins", terminator: "")
// 输出 "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left", terminator: "")
// 输出 "The bank now only has 7900 coins left"

playerOne = nil
print("PlayerOne has left the game", terminator: "")
// 输出 "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins", terminator: "")
// 输出 "The bank now has 10000 coins"

//: [Next](@next)
