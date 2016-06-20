//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 定义一个类层次作为例子
    2. 检查类型
    3. 向下转型（Downcasting）
    4. Any和AnyObject的类型转换
 */
/*:
    类型转换在 Swift 中使用 is 和 as 操作符实现
 
 */


//: ## 1. 定义一个类层次作为例子
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

/*:
    Swift的类型检测器能够推理出 Movie 和 Song 有共同的父类 MediaItem，
    所以它推断出 [MediaItem] 类作为 library 的类型;
    在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的;
    但是，若迭代它，依次取出的实例会是 MediaItem 类型的，而不是 Movie 和 Song 类型。
    为了让它们作为原本的类型工作，需要检查它们的类型或者向下转换它们到其它类型
 */
let library = [ // the type of "library" is inferred to be [MediaItem],
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//: ## 2. 检查类型
/*:
    类型检查操作符(is)来检查一个实例是否属于特定子类型
    若实例属于那个子类型，类型检查操作符返回 true，否则返回 false
 */
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        ++movieCount
    } else if item is Song {
        ++songCount
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs", terminator: "")

//: ## 3. 向下转型（Downcasting）
/*:
    某类型的一个常量或变量可能在幕后实际上属于一个子类;
    当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符(as? 或 as!)
 
    因为向下转型可能会失败，类型转型操作符带有两种不同形式 :
    条件形式（conditional form） as? 
    - 返回一个试图向下转成的类型的可选值（optional value）;
    强制形式 as! 
    - 把试图向下转型和强制解包（force-unwraps）结果作为一个混合动作
 
    注意：
    转换没有真的改变实例或它的值。潜在的根本的实例保持不变；只是简单地把它作为它被转换成的类来使用。
 */
/*:
    数组中的每一个 item 可能是 Movie 或 Song;
    事前不知道每个 item 的真实类型，所以这里使用条件形式的类型转换(as?)去检查循环里的每次下转
 */
for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)", terminator: "")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)", terminator: "")
    }
}
//: ## 4. Any和AnyObject的类型转换
/*:
    Swift为不确定类型提供了两种特殊类型别名：
    - AnyObject 可以代表任何class类型的实例
    - Any 可以表示任何类型，包括方法类型（function types）
 
    注意：
    只有当明确的需要它的行为和功能时才使用Any和AnyObject
 */
/*
    AnyObject 类型
 */
// 下面的示例定义了一个 [AnyObject] 类型的数组并填入三个Movie类型的实例：
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
// 因为知道这个数组只包含 Movie 实例，你可以直接用(as!)下转并解包到不可选的Movie类型：
for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)", terminator: "")
}
// 为了变为一个更短的形式，下转someObjects数组为[Movie]类型来代替下转数组中每一项的方式
for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)", terminator: "")
}

/*:
    Any 类型
 */
// 以下示例，使用 Any 类型来和混合的不同类型一起工作，包括方法类型和非 class 类型。
var things = [Any]()        // 创建了一个可以存储Any类型的数组 things
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append([3.0, 5.0])
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

/*:
    注意：
    在一个switch语句的case中使用强制形式的类型转换操作符（as, 而不是 as?）来检查和转换到一个明确的类型。
    在 switch case 语句的内容中这种检查总是安全的
 */

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int", terminator: "")
    case 0 as Double:
        print("zero as a Double", terminator: "")
    case let someInt as Int:
        print("an integer value of \(someInt)", terminator: "")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)", terminator: "")
    case is Double:
        print("some other double value that I don't want to print", terminator: "")
    case let someString as String:
        print("a string value of \"\(someString)\"", terminator: "")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)", terminator: "")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)", terminator: "")
    case let stringConverter as String -> String:
        print(stringConverter("Michael"), terminator: "")
    default:
        print("something else", terminator: "")
    }
}

//: [Next](@next)
