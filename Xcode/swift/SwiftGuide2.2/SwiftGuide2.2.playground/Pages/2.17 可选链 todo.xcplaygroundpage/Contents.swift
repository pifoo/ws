//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 使用可空链式调用来强制展开
    2. 为可空链式调用定义模型类
    3. 通过可空链式调用访问属性
    4. 通过可空链式调用来调用方法
    5. 通过可空链式调用来访问下标
    6. 访问可空类型的下标
    7. 多层链接
    8. 对返回可空值的函数进行链接
 */
/*:
    可空链式调用（Optional Chaining）
 
    是一种可以 请求 和 调用属性、方法 及 下标 的过程，它的可空性体现于请求或调用的目标当前可能为空（nil）
    如果可空的目标有值，那么调用就会成功；如果选择的目标为空（nil），那么这种调用将返回空（nil）
    多个连续的调用可以被链接在一起形成一个调用链，如果其中任何一个节点为空（nil）将导致整个链调用失败
 */
//: ## 1. 使用可空链式调用来强制展开
/*:
    '?' 定义一个可空链，与（！）来强制展开其中值的区别：当可空值为空时可空链式只是调用失败，然而强制展开将会触发运行时错误; 
    当可空链式调用成功时，一个本应该返回 Int 的类型的结果将会返回  Int? 类型
 */
// 下面几段代码将解释 可空链式调用 和 强制展开的不同
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

// 因为它的residence属性是可空的，john属性将初始化为nil：
let john = Person()
john.residence
// 为nil时，强制解析展开将触发运行时错误
//john.residence!.numberOfRooms // fatal error: unexpectedly found nil while unwrapping an Optional value

// 可空链式调用提供了一种另一种访问numberOfRooms的方法，使用问号（？）来代替原来叹号（！）的位置：
if let roomCount = john.residence?.numberOfRooms { // 在residence不为空的情况下访问numberOfRooms
    print("John's residence has \(roomCount) room(s).", terminator: "")
} else {
    print("Unable to retrieve the number of rooms.", terminator: "")
}

john.residence = Residence()
// john.residence不为nil ,可以正常访问john.residence.numberOfRooms，其值为默认的1，类型为Int?：
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).", terminator: "")
} else {
    print("Unable to retrieve the number of rooms.", terminator: "")
}

//: ## 2. 为可空链式调用定义模型类
/*:
    通过使用 可空链式调 用可以调用多层属性，方法，和下标
 */
class Person1 {
    var residence: Residence?
}

class Residence1 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)", terminator: "")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

//: ## 3. 通过可空链式调用访问属性
/*
    可以通过可空链式调用访问属性的可空值，并且判断访问是否成功;
    下面的代码创建了一个Person实例，然后访问numberOfRooms属性：
 */
let john1 = Person1()
if let roomCount = john1.residence?.numberOfRooms {  // john.residence为nil，可空链式调用失败
    print("John's residence has \(roomCount) room(s).", terminator: "")
} else {
    print("Unable to retrieve the number of rooms.", terminator: "")
}
// 通过可空链式调用来设定属性值：

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
// john1.residence?.address = someAddress // 通过john.residence来设定address属性也是不行的，因为john.residence为nil

//: ## 4. 通过可空链式调用来调用方法
// TODO
// 这个方法没有返回值。但是没有返回值的方法隐式返回Void类型
func printNumberOfRooms() {
    // print("The number of rooms is \(numberOfRooms)")
}
// 如果在可空值上通过可空链式调用来调用这个方法，这个方法的返回类型为Void?，而不是Void，因为通过可空链式调用得到的返回值都是可空的
/*
if john1.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}*/

//: ## 5. 通过可空链式调用来访问下标
/*
    通过可空链式调用，我们可以用下标来对可空值进行读取或写入，并且判断下标调用是否成功
 */
// 下面这个例子用下标访问john.residence中rooms数组中第一个房间的名称，因为john.residence为nil，所以下标调用毫无疑问失败了：
/*
if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
john1.residence?[0] = Room(name: "Bathroom")
let johnsHouse = Residence1()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// prints "The first room name is Living Room."
*/

//: ## 6. 访问可空类型的下标
/*
    如果下标返回可空类型值，比如Swift中Dictionary的key下标。可以在下标的闭合括号后面放一个问号来链接下标的可空返回值：
 */
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72  // key“Brian”在字典中不存在，所以第三个调用失败
testScores


//: ## 7. 多层链接
/*
    可以通过多个链接多个可空链式调用来向下访问属性，方法以及下标。但是多层可空链式调用不会添加返回值的可空性。

 也就是说：
    如果你访问的值不是可空的，通过可空链式调用将会放回可空值。
    如果你访问的值已经是可空的，通过可空链式调用不会变得“更”可空。

 因此：
    通过可空链式调用访问一个Int值，将会返回Int?，不过进行了多少次可空链式调用。
    类似的，通过可空链式调用访问Int?值，并不会变得更加可空。
 
 */
// 下面的例子访问john中的residence中的address中的street属性。这里使用了两层可空链式调用，residence以及address，这两个都是可空值。
/*
if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john1.residence?.address = johnsAddress

if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// prints "John's street name is Laurel Street."

*/


//: ## 8. 对返回可空值的函数进行链接
/*
if let buildingIdentifier = john1.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// prints "John's building identifier is The Larches."

if let beginsWithThe =
    john1.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
// prints "John's building identifier begins with "The"."
*/
//: [Next](@next)
