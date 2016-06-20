//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 集合的可变性（Mutability of Collections）
    2. 数组（Arrays）
    3. 集合（Sets）
    4. 字典（Dictionaries）
 */
/*:
    - 数组 是 有序 数据的集
    - 集合 是 无序 无重复 数据的集
    - 字典 是 无序 的 键值对 的集
    
    Arrays、Sets和Dictionaries中存储的数据值 类型必须明确
    注意： Swift 的Arrays、Sets和Dictionaries类型被实现为泛型集合
 */

//: ## 1. 集合的可变性（Mutability of Collections）
/*:
    如果创建一个 Arrays、Sets 或 Dictionaries 并且把它分配成一个变量，这个集合将会是可变的
 */
//: ## 2. 数组（Arrays）
/*:
    数组 使用有序列表存储同一类型的多个值,相同值可以多次出现在一个数组的不同位置
 
    Swift 数组的简单语法
    - 循像 Array<T> 的形式，其中 T 是这个数组中唯一允许存在的数据类型
    - [T]
 */
/*:
    创建一个空数组
 */
// 1.
var someInts = [Int]()
someInts.count

someInts.append(3)
// someInts 现在包含一个Int值

someInts = []
// someInts 现在是空数组，但是仍然是[Int]类型的

// 2.   TODO
var arr1: [Int]
arr1 = []
arr1.count

// 3.   TODO
var arr2: Array<Int>
arr2 = []
arr2.count

/*:
    创建一个带有默认值的数组
 */
var threeDoubles = [Double](count: 3, repeatedValue:0.0)
/*:
    通过两个数组相加创建一个数组
 */
var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)
var sixDoubles = threeDoubles + anotherThreeDoubles
/*:
    用字面量构造数组
 */
var shoppingList: [String] = ["Eggs", "Milk"]
var shoppingList1 = ["Eggs", "Milk"]
/*:
    访问和修改数组
    Array.count             - 获取数组所包含的数据项个数
    Array.isEmpty           - 是否为空数组
    Array.append()          - 追加数据项
    Array.insert(_:atIndex:)    - 在某个具体索引值之前添加数据项
    Array.removeAtIndex(atIndex)    - 返回被移除的数据项
    Array.removeLast()              - 移除最后一项
 */
if (shoppingList.count == 0) || shoppingList.isEmpty {
    print("The shopping list is empty.", terminator: "")
} else {
    print("The shopping list is not empty.", terminator: "")
}

shoppingList.append("Flour")        // 追加数据项
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread","Cheese","Butter"]

var firstItem = shoppingList[0...2] // 通过索引取值

shoppingList[0] = "Six eggs"        // 修改数据项
shoppingList[4...6] = ["Bananas", "Apples"]
// 注意： 不可以用下标访问的形式去在数组尾部添加新项

shoppingList.insert("Maple Syrup", atIndex: 0)

let mapleSyrup = shoppingList.removeAtIndex(0) // 返回被移除的项
shoppingList
let apples = shoppingList.removeLast() // 返回被移除的项
shoppingList
/*:
    数组的遍历
    - for-in
    - enumerate()
        分解返回的元组(index,value)
 */
for item in shoppingList {
    print(item, terminator: "")
}

// enumerate()返回一个由每一个数据项索引值和数据值组成的元组
for (index, value) in shoppingList.enumerate() {
    print("Item \(String(index + 1)): \(value)")
}
//: ## 3. 集合（Sets）
/*:
    Set类型的哈希值
    存储在集合中，该类型必须是可哈希化的-也就是说，该类型必须提供一个方法来计算它的哈希值
    比如a==b,它遵循的是a.hashValue == b.hashValue
    Swift 的所有基本类型(比如String,Int,Double和Bool)默认都是可哈希化的
    
    对于a,b,c三个值来说，==的实现必须满足下面三种情况：
    a==a(自反性)
    a==b意味着b==a(对称性)
    a==b&&b==c意味着a==c(传递性)
 */
/*:
    Set类型语法
    Set<T>
    这里的 T 表示Set中允许存储的类型，和数组不同的是，集合没有等价的简化形式
 */
/*:
    创建和构造一个空的Set
    你可以通过构造器语法创建一个特定类型的空集合：
 */
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.", terminator: "")

letters.insert("a") // letters 现在含有1个Character类型的值
letters = []    // letters 现在是一个空的Set, 但是它依然是 Set<Character> 类型
/*:
    用数组字面量创建集合
    Set类型不能从数组中字面量中独立地被推断出来，因此 Set类型 必须显式声明
 */
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
/*:
    如果使用一个数组字面量构造一个Set并且该数组字面量中的所有元素类型相同
    那么无须写出Set的具体类型
 */
var favoriteGenres1: Set = ["Rock", "Classical", "Hip hop"]
/*:
    访问和修改一个Set
    Set.count   - 获取集合项
    Set.isEmpty
    Set.insert(_:)  - 插入数据
    Set.remove(_:)  - 删除一个元素
    contains(_:)    - 去检查Set中是否包含一个特定的值
 */
favoriteGenres.count
favoriteGenres.isEmpty
favoriteGenres.insert("Jazz")
favoriteGenres.remove("Rock")   // 返回被删除的元素
favoriteGenres.contains("Classical")
/*:
    遍历一个Set
    for-in
 */
for genre in favoriteGenres {
    print("\(genre)", terminator: "")
}
/*:
    Set类型没有确定的顺序
    按照特定顺序来遍历一个Set中值可以使用sort()
 */
for genre in favoriteGenres.sort() {
    print("\(genre)")
}
/*:
    完成集合操作
    
    基本集合操作：
    - intersect(_:)         - 交集 setA.intersect(setB)
    - exclusiveOr(_:)       - 补集 setA.intersect(setB)   TODO
    - union(_:)             - 并集 setA.intersect(setB)
    - subtract(_:)          - 差集 setA.intersect(setB)
 */
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sort()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersect(evenDigits).sort()
// []
oddDigits.subtract(singleDigitPrimeNumbers).sort()
// [1, 9]
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()
// [1, 2, 9]

/*:
    集合成员关系 和 相等
    - == 判断两个集合是否相等
    - isSubsetOf(_:)                 判断一个集合是否为一个集合的子集
    - isSupersetOf(_:)               判断一个集合是否为一个集合的父集
    - isStrictSubsetOf(_:) 或者 isStrictSupersetOf(_:)
        方法来判断一个集合是否是另外一个集合的子集合或者父集合并且和特定集合不相等
    - 使用isDisjointWith(_:)          判断两个结合是否不含有相同的值
 */
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
houseAnimals.isSubsetOf(farmAnimals)
farmAnimals.isSupersetOf(houseAnimals)
farmAnimals.isDisjointWith(cityAnimals)
//: ## 4. 字典（Dictionaries）
/*:
    字典 是一种以 key-value 方式 无序 存储多个 相同类型 的值的容器
    字典的 Key 类型必须遵循 Hashable 协议，就像Set的值类型
 */
/*:
    字典类型快捷语法
    Dictionary<Key, Value>
    Key, Value分别对应字典的 键-值 类型
 */
/*:
    创建一个空字典
 */
/*:
    像数组一样使用构造语法创建一个拥有确定类型的空字典：
 */
var namesOfIntegers = [Int: String]()   // namesOfIntegers 是一个空的 [Int: String] 字典
namesOfIntegers[16] = "sixteen"         // namesOfIntegers 现在包含一个键值对
namesOfIntegers
namesOfIntegers = [:]                   // namesOfIntegers 又成为了一个 Int, String类型的空字典
/*:
    字典字面量
    [key 1: value 1, key 2: value 2, key 3: value 3]
 */
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
var airports1 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
/*:
    读取 和 修改 字典
    - Dictionary.count           - 获取字典的数据项数量
    - Dictionary.isEmpty         - 是否为空字典
    - updateValue(_:forKey:)     - 设置或者更新特定 键 对应的 值, 返回更新值之前的 原值(可选值)
    - removeValueForKey(_:)      - 方法也可以用来在字典中移除键值对 ,返回被移除的值或者在没有值的情况下返回nil
 */
airports.count
airports.isEmpty

airports["LHR"] = "London"      // 插入新元素(无序)
airports["LHR"] = "London Heathrow"   // 修改已存在的元素

// 如果有值存在于更新前，则这个可选值包含了旧值，否则它将会是nil
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).", terminator: "")
}

if let airportName = airports["DUB"] {          // 返回一个 可选值(原值存在 或 不存在 nil)
    print("The name of the airport is \(airportName).", terminator: "")
} else {
    print("That airport is not in the airports dictionary.", terminator: "")
}

// 使用下标语nil, 移除一个键值对
airports["APL"] = "Apple Internation" // "Apple Internation"不是真的 APL机场, 删除它
airports["APL"] = nil

if let removedValue = airports.removeValueForKey("DUB") {
    print("The removed airport's name is \(removedValue).", terminator: "")
} else {
    print("The airports dictionary does not contain a value for DUB.", terminator: "")
}
airports
/*:
    字典遍历
    for-in
 */
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)", terminator: "")
}
for (_, airportName) in airports {
    print("忽略key: \(airportName)", terminator: "")
}
// 遍历键
for airportCode in airports.keys {
    print("Airport code: \(airportCode)", terminator: "")
}
// 遍历值
for airportName in airports.values {
    print("Airport name: \(airportName)", terminator: "")
}

// 使用keys或者values属性直接构造一个新数组：
let airportCodes = Array(airports.keys)
let airportNames = Array(airports.values)

// 顺序遍历字典的键或值
let airportCodesSort = Array(airports.keys.sort())
let airportNamesSotr = Array(airports.values.sort())
//: [Next](@next)
