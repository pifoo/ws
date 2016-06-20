//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 字符串字面量
    2. 初始化空字符串
    3. 字符串可变性
    4. 字符串是值类型
    5. 使用字符
    6. 连接字符串和字符
    7. 字符串插值
    8. Unicode
    9. 计算字符数量
    10. 访问和修改字符串
    11. 比较字符串
    12 字符串的 Unicode 表示形式
 
 */
//: ## 1. 字符串字面量
"Some string literal value"
//: ## 2. 初始化空字符串
var emptyString = ""               // 空字符串字面量
var anotherEmptyString = String()  // 初始化方法
// 两个字符串均为空并等价。

if emptyString.isEmpty {
    print("Nothing to see here")
}
//: ## 3. 字符串可变性
var variableString = "Horse"
variableString += " and carriage"
// variableString 现在为 "Horse and carriage"

let constantString = "Highlander"
// constantString += " and another Highlander"
// 这会报告一个编译错误 (compile-time error) - 常量字符串不可以被修改
//: ## 4. 字符串是值类型
/*:
    Swift 的 String类型是 值类型
    如果创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝
 */
//: ## 5. 使用字符
for character in "Dog!🐶".characters {
    print(character)
}

let exclamationMark: Character = "!"
exclamationMark.hashValue

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]  // 字符数组
let catString = String(catCharacters)                        // 类型转换
print(catString)


//: ## 6. 连接字符串和字符
/*:
    不能将一个字符串或者字符添加到一个 已存在 的 字符变量 上，因为字符变量只能包含一个字符
 */
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

let exclamationChar: Character = "!"
welcome.append(exclamationChar) // append()方法将一个 字符 附加到一个 字符串变量 的 尾部
//: ## 7. 字符串插值
/*:
    \()
    字符串插值是一种构建新字符串的方式，可以在其中包含 常量、变量、字面量 和 表达式
 */

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
//: ## 8. Unicode
/*:
    Unicode 是一个国际标准，用于文本的编码和表示
 */
/*:
    Unicode 标量（Unicode Scalars）
    Swift 的String类型是基于 Unicode 标量 建立的; Unicode 标量是对应字符或者修饰符的唯一的21位数字
    Unicode 码位(code poing) 的范围是U+0000到U+D7FF或者U+E000到U+10FFFF
    Unicode 标量不包括 Unicode 代理项(surrogate pair) 码位，其码位范围是U+D800到U+DFFF
 */
/*:
    字符串字面量的特殊字符 (Special Characters in String Literals)
 
    字符串字面量可以包含以下特殊字符：
    - 转义字符\0(空字符)
    - \\(反斜线)
    - \t(水平制表符) 
    - \n(换行符)
    - \r(回车符)
    - \"(双引号)
    - \'(单引号)
 
    Unicode 标量，写成\u{n}(u为小写)，其中n为任意 一到八位 十六进制数 且可用的 Unicode 位码
 */
/*:
    下面的代码为各种特殊字符的使用示例
    wiseWords常量包含了两个双引号
    dollarSign、blackHeart和sparklingHeart常量演示了三种不同格式的 Unicode 标量
 */
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"             // $, Unicode 标量 U+0024
let blackHeart = "\u{2665}"           // ♥, Unicode 标量 U+2665
let sparklingHeart = "\u{1F496}"      // 💖, Unicode 标量 U+1F496

/*:
    可扩展的字形群集(Extended Grapheme Clusters)
 
    每一个 Swift 的Character类型代表一个可扩展的字形群
    一个可扩展的字形群是一个或多个可生成人类可读的字符 Unicode 标量的有序排列
 */
/*:
    在这两种情况中，字母é代表了一个单一的 Swift 的Character值，同时代表了一个可扩展的字形群
    在第一种情况，这个字形群包含一个单一标量；
    而在第二种情况，它是包含两个标量的字形群
 */
let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上  ́
/*:
    可扩展的字符群集是一个灵活的方法，用许多复杂的脚本字符表示单一的Character值
    例如，来自朝鲜语字母表的韩语音节能表示为组合或分解的有序排列。 
    在 Swift 都会表示为同一个单一的Character值：
 */
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
("\u{1112}", "\u{1161}", "\u{11AB}")
// precomposed 是 한, decomposed 是 한
/*:
    可拓展的字符群集可以使包围记号(例如COMBINING ENCLOSING CIRCLE或者U+20DD)的标量包围其他 Unicode 标量，
    作为一个单一的Character值：
 */
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute 是 é⃝
/*:
    局部的指示符号的 Unicode 标量可以组合成一个单一的Character值，例如REGIONAL INDICATOR SYMBOL LETTER U(U+1F1FA)和REGIONAL INDICATOR SYMBOL LETTER S(U+1F1F8)：
 */
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS 是 🇺🇸
//: ## 9. 计算字符数量
/*:
    String.characters.count
    获得一个字符串中Character值的数量
 */
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
//: ## 10. 访问和修改字符串
/*:
    字符串索引 (String Indices)
    String.Index，
    它对应着字符串中的每一个Character的位置
    - startIndex
    - endIndex
    - String.Index.predecessor() 得到前面一个索引
    - String.Index.successor()   得到后面一个索引
    - String.Index.advancedBy(_:)
 */
let greeting = "Guten Tag!"

greeting.startIndex
greeting[greeting.startIndex]

greeting.endIndex
greeting[greeting.endIndex.predecessor()]

greeting[greeting.startIndex.successor()]

let index = greeting.startIndex.advancedBy(7)
greeting[index]
/*:
    String.characters.indices()
    创建一个包含全部索引的范围(Range)，用来在一个字符串中访问单个字符
 */
for index in greeting.characters.indices {
    print("\(greeting[index]) ", terminator: "")
}
/*:
    insert(_:atIndex:)
        在一个字符串的指定索引 插入 一个 字符
    insertContentsOf(_:at:)
        在一个字符串的指定索引 插入 一个 字符串
    removeAtIndex(_:)
        在一个字符串的指定索引 删除 一个 字符
    removeRange(_:)
        在一个字符串的指定索引 删除一个子字符串
 
 */
var welc = "hello"

welc.insert("!", atIndex: welc.endIndex)

welc.insertContentsOf(" there".characters, at: welc.endIndex.predecessor())

welc.removeAtIndex(welc.endIndex.predecessor())

let range = welc.endIndex.advancedBy(-6)..<welc.endIndex
welc.removeRange(range)
//: ## 11. 比较字符串
/*:
    字符串/字符相等 (String and Character Equality)
    字符串/字符可以用等于操作符(==)和不等于操作符(!=)
 */
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
/*:
    可扩展的字形群集是有不同的 Unicode 标量构成的，只要它们有同样的语言意义和外观，就认为它们标准相等
 */
// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
// 打印输出 "These two strings are considered equal"
/*:
    相反，英语中的LATIN CAPITAL LETTER A(U+0041，或者A)不等于俄语中的CYRILLIC CAPITAL LETTER A(U+0410，或者A)
    两个字符看着是一样的，但却有不同的语言意义：
 */
let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}
// 打印 "These two characters are not equivalent"
/*:
    在 Swift 中，字符串和字符并不区分区域
 */
/*:
    前缀/后缀相等 (Prefix and Suffix Equality)
    - hasPrefix(_:)   hasSuffix(_:)
    以上字符串方法用来检查字符串是否拥有特定前缀/后缀
    两个方法均接收一个String类型的参数，并返回一个布尔值
    注：hasPrefix(_:)和hasSuffix(_:)方法都是在每个字符串中逐字符比较其可扩展的字符群集是否标准相等
 */
// 下面的例子以一个字符串数组表示莎士比亚话剧《罗密欧与朱丽叶》中前两场的场景位置：
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

// 调用hasPrefix(_:)方法来计算话剧中第一幕的场景数
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        ++act1SceneCount
    }
}
print("There are \(act1SceneCount) scenes in Act 1")

// 用hasSuffix(_:)方法来计算发生在不同地方的场景数：
var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        ++mansionCount
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        ++cellCount
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// 打印输出 "6 mansion scenes; 2 cell scenes"

//: ## 12 字符串的 Unicode 表示形式
/*:
    当一个 Unicode 字符串被写进文本文件或者其他储存时，字符串中的 Unicode 标量会用 Unicode 定义的几种编码格式编码
    每一个字符串中的小块编码都被称为代码单元
    - UTF-8  编码格式/代码单元集合（编码字符串为8位的代码单元/利用字符串的utf8属性进行访问）
    - UTF-16 编码格式/代码单元集合（编码字符串为16位的代码单元/利用字符串的utf16属性进行访问）
    - UTF-32 编码格式/21位的 Unicode 标量值集合（编码字符串为32位的代码单元/利用字符串的unicodeScalars属性进行访问)
 */
// 以下字符串中的每一个字符代表着一种不同的表示：
let dogString = "Dog‼🐶"
/*:
    UTF-8 表示
    通过遍历String的utf8属性来访问它的UTF-8表示
    其为String.UTF8View类型的属性，UTF8View是无符号8位 (UInt8) 值的集合，每一个UInt8值都是一个字符的 UTF-8 表示
 */
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")
/*:
    UTF-16 表示
    通过遍历String的utf16属性来访问它的UTF-16表示
    其为String.UTF16View类型的属性，UTF16View是无符号16位 (UInt16) 值的集合，每一个UInt16都是一个字符的 UTF-16 表示
 */
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
/*:
    Unicode 标量表示 (Unicode Scalars Representation)
    通过遍历String值的 unicodeScalars 属性来访问它的 Unicode 标量表示    
    其为UnicodeScalarView类型的属性，UnicodeScalarView是UnicodeScalar的集合
    UnicodeScalar是21位的 Unicode 代码点
    每一个UnicodeScalar拥有一个value属性，可以返回对应的21位数值，用UInt32来表示
 */
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
/*:
    作为查询它们的value属性的一种替代方法，每个UnicodeScalar值也可以用来构建一个新的String值，比如在字符串插值中使用：
 */
for scalar in dogString.unicodeScalars {
    print("\(scalar) ", terminator: "   ")
}

//: [Next](@next)
