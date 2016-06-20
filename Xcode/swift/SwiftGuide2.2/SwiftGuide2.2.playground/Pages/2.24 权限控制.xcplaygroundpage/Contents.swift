//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页内容包括：
    1. 模块和源文件
    2. 访问级别
       - 访问级别的使用原则
       - 默认访问级别
       - 单目标应用程序的访问级别
       - Framework的访问级别
       - 单元测试目标的访问级别
    3. 访问控制语法
    4. 自定义类型
       - 元组类型
       - 函数类型
       - 枚举类型
       - 原始值和关联值
       - 嵌套类型
    5. 子类
    6. 常量、变量、属性、下标
       - Getter和Setter
    7. 初始化
       - 默认初始化方法
       - 结构体的默认成员初始化方法
    8. 协议
       - 协议继承
       - 协议一致性
    9. 扩展
       - 协议的扩展
    10. 泛型
    11. 类型别名
 */
/*:
    访问控制 可以限定其他源文件或模块中代码对你代码的 访问级别
 
    可以明确地给单个类型（类、结构体、枚举）设置访问级别，也可以给这些类型的属性、函数、初始化方法、基本类型、下标索引等设置访问级别
 
    注意：简单起见，代码中可以设置访问级别的特性（属性、基本类型、函数等）
 */

//: ## 1. 模块和源文件
/*:
    Swift 中的 访问控制 模型基于 模块 和 源文件 这两个概念
 
    模块 
    - 指的是以独立单元构建和发布的Framework或Application;
    - 一个模块可以使用import关键字引入另外一个模块
 
    源文件
    - 指的是 Swift 中的Swift File，它通常属于一个模块
 */

//: ## 2. 访问级别

/*:
    Swift 为代码中的实体提供了三种不同的访问级别
    - public：某个接口或Framework可作为外部结构使用时
    - internal：某个接口或Framework作为内部结构使用时
    - private：只能在当前源文件中使用的实体，称为私有实体。使用private级别，可以用作隐藏某些功能的实现细节
 */

/*:
    2.1 访问级别的使用原则
 */
/*:
     Swift 中的访问级别遵循一个使用原则：访问级别统一性
     - 一个public访问级别的变量，不能将它的类型定义为internal和private
     - 函数的访问级别不能高于它的参数、返回类型的访问级别
 */

/*:
    2.2 默认访问级别
 */
/*:
    如果不为代码中的所有实体定义 显式访问级别，那么它们 默认为 internal 级别
 */

/*:   
    2.3 单目标应用程序的访问级别
 */
/*:
    不需要明确设置访问级别，使用默认的访问级别internal即可, 也可以使用 private 用于隐藏一些功能的实现细节
 */

/*:    
    2.4 Framework的访问级别
 */
/*:
    把一些对外的接口定义为public级别,这些被定义为public的接口，就是这个Framework的API
 */

/*:
    2.5 单元测试目标的访问级别
 */
/*:
    如果在引入一个生产模块时使用 @testable 注解，然后用带测试的方式编译这个生产模块，单元测试目标就可以访问所有internal级别的实体
 */
    
//: ## 3. 访问控制语法
/*
    通过修饰符 public、internal、private 来声明实体的访问级别：
    
     public class SomePublicClass {}
     internal class SomeInternalClass {}
     private class SomePrivateClass {}
     
     public var somePublicVariable = 0
     internal let someInternalConstant = 0
     private func somePrivateFunction() {}
 */
class SomeInternalClass {   }              // 隐式访问级别 internal
var someInternalConstant = 0            // 隐式访问级别 internal

//: ## 4. 自定义类型
/*
    一个public类的所有成员的访问级别默认为 internal 级别，而不是public级别;
    如果想将某个成员申明为public级别，那么必须使用修饰符明确的声明该成员
 */
public class SomePublicClass {          // 显式的 public 类
    public var somePublicProperty = 0    // 显式的 public 类成员
    var someInternalProperty = 0         // 隐式的 internal 类成员
    private func somePrivateMethod() {}  // 显式的 private 类成员
}

class SomeInternalClass1 {               // 隐式的 internal 类
    var someInternalProperty = 0         // 隐式的 internal 类成员
    private func somePrivateMethod() {}  // 显式的 private 类成员
}

private class SomePrivateClass {        // 显式的 private 类
    var somePrivateProperty = 0          // 隐式的 private 类成员
    func somePrivateMethod() {}          // 隐式的 private 类成员
}


/*:
    4.1 元组类型
 */
/*:
    元组的访问级别与元组中访问级别 最低 的类型一致
    
    注意：
    元组不同于类、结构体、枚举、函数那样有单独的定义;
    元组的访问级别是在它被使用时自动推导出的，而不是明确的申明
 */

/*:    
    4.2 函数类型
 */
/*:
    函数的访问级别 需要根据该 函数的 参数类型 和 返回类型 的访问级别得出
    如果得出的函数访问级别不符合默认上下文，那么就需要明确地申明该函数的访问级别
 
     此函数返回类型为元组， 函数的访问权限要与返回类型的访问级别一致，故需要显式声明为 private 级别
     private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
        // function implementation goes here
     }

 */

/*:    
    4.3 枚举类型
 */
/*:
    枚举中成员 的访问级别 继承 自该枚举，不能为枚举中的成员单独申明不同的访问级别
 */
// CompassPoint成员的访问级别均为 public
public enum CompassPoint {
    case North
    case South
    case East
    case West
}

/*:
    4.4 原始值和关联值
 */
/*:
    枚举定义中的任何原始值或关联值的类型都必须有一个访问级别，这个级别至少要不低于枚举的访问级别
    e.g 不能 在一个internal访问级别的枚举中定义private级别的原始值类型
 */

/*:    
    4.5 嵌套类型
 */
/*:
    在 private 级别的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别
    在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别
    如果想让嵌套类型拥有public访问级别，那么需要明确地申明该嵌套类型的访问级别
 */

//: ## 5. 子类
/*:
    子类的访问级别不得高于父类的访问级别
 */
// 如果我们无法直接访问某个类中的属性或函数等，那么可以 继承 该类，从而可以更容易的访问到该类的类成员
public class A {
    private func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}  // 覆写并重新声明访问级别
}


// 用子类成员访问父类成员，哪怕父类成员的访问级别比子类成员的要低：
// 因为父类A1和子类B1定义在同一个源文件中，所以在类B1中可以在重写的someMethod方法中调用super.someMethod()
public class A1 {
    private func someMethod() {}
}

internal class B1: A1 {
    override internal func someMethod() {
        super.someMethod()
    }
}

//: ## 6. 常量、变量、属性、下标
/*
    常量、变量、属性不能拥有比它们的类型更高的访问级别
    
    如果常量、变量、属性、下标索引的定义类型是private级别的，那么它们必须要明确的申明访问级别为private
 */
private var privateInstance = SomePrivateClass()

/*:    
    Getter和Setter 
 */
/*:
    常量、变量、属性、下标索引的Getters和Setters的访问级别继承自它们所属成员的访问级别
 
    Setter的访问级别可以低于对应的Getter的访问级别，这样就可以控制变量、属性或下标索引的读写权限;
    在var或subscript定义作用域之前，可以通过private(set)或internal(set)先为它们的写权限申明一个较低的访问级别
 
    注意：这个规定适用于用作存储的属性或用作计算的属性。即使你不明确地申明存储属性的Getter、Setter，Swift也会隐式的为其创建Getter和Setter，用于对该属性进行读取操作。使用private(set)和internal(set)可以改变Swift隐式创建的Setter的访问级别。这对计算属性也同样适用。
 */
// 下面的例子中定义了一个名为TrackedString的结构体，它记录了value属性被修改的次数：
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits++
        }
    }
}
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
stringToEdit.numberOfEdits

public struct TrackedString1 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits++
        }
    }
    public init() {}
}

//: ## 7. 初始化
/*:
    我们可以给自定义的初始化方法申明访问级别，但是要不高于它所属类的访问级别。
    但 必要构造器 例外，它的访问级别必须和所属类的访问级别相同
 */

/*:    
    7.1 默认初始化方法
 */
/*:
    默认 初始化方法的访问级别与 所属 类型的访问级别相同
 
    注意：
    如果一个类型被申明为public级别，那么默认的初始化方法的访问级别为internal;
    如果想让无参的初始化方法在其他模块中可以被使用，那么必须提供一个具有public访问级别的无参初始化方法
 
 */

/*:    
    7.2 结构体的默认成员初始化方法
 */
/*:
    如果结构体中的任一存储属性的访问级别为private，那么它的默认成员初始化方法访问级别就是private。
    尽管如此，结构体的初始化方法的访问级别依然是internal
 
    如果想在其他模块中使用该结构体的默认成员初始化方法，那么需要提供一个访问级别为public的默认成员初始化方法
 */
    
//: ## 8. 协议
/*:
    协议中的每一个必须要实现的函数都具有和该协议相同的访问级别
 
    注意：
    如果定义了一个public访问级别的协议，那么实现该协议提供的必要函数也会是 public 的访问级别；
    不同于其他类型，比如，public 访问级别的其他类型，他们成员的访问级别为 internal
 */
/*:    
    8.1 协议继承
 */
/*:
    继承来的新协议拥有的访问级别最高也只和被继承协议的访问级别相同
 */

/*:    
    8.2 协议一致性
 */
/*:
    采用了协议的 类 的访问级别取它本身和所采用协议中 最低 的访问级别
    采用了协议，那么实现了协议所必须的方法后，该方法的访问级别遵循协议的访问级别
 */
    
//: ## 9. 扩展

/*:
     扩展了一个公共类型，那么新加的成员应该具有和原始成员一样的默认的internal访问级别
     
     可以明确申明扩展的访问级别（比如使用private extension）给该扩展内所有成员申明一个新的默认访问级别;
     这个新的默认访问级别仍然可以被单独成员所申明的访问级别所覆盖
 */


/*:
    协议的扩展 
 */

/*:
    如果一个扩展采用了某个协议，那么就不能对该扩展使用访问级别修饰符来申明了
    该扩展中实现协议的方法都会遵循该协议的访问级别
 */

//: ## 10. 泛型
/*:
    泛型类型或泛型函数的访问级别取泛型类型、函数本身、泛型类型参数三者中的 最低 访问级别
 */

//: ## 11. 类型别名
/*:
    任何被定义的类型别名都会被当作不同的类型，以便于进行访问控制;
    一个类型别名的访问级别不可高于原类型的访问级别
 */

//: [Next](@next)
