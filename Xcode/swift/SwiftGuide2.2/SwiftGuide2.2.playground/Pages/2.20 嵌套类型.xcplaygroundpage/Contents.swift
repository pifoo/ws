//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 嵌套类型实例
    2. 嵌套类型的引用
 */
/*
    可以在 枚举类型、类 和 结构体 中定义支持嵌套的类型
    要在一个类型中嵌套另一个类型，将需要嵌套的类型的定义写在被嵌套类型的区域 {  } 内，而且可以根据需要定义多级嵌套
 */
//: ## 1. 嵌套类型实例
// BlackjackCard结构体包含2个嵌套定义的枚举类型Suit 和 Rank
struct BlackjackCard {
    // 嵌套定义枚举型Suit
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // 嵌套定义枚举型Rank
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
    
    
}
let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)", terminator: "")





//: ## 2. 嵌套类型的引用
// 在外部对嵌套类型的引用，以被嵌套类型的名字为前缀，加上所要引用的属性名：

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
// 红心的符号 为 "♡"




//: [Next](@next)
