//: [Previous](@previous)
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页包含内容：
    1. 下标脚本语法
    2. 下标脚本用法
    3. 下标脚本选项
 */

//: ## 1. 下标脚本语法
/*:
    定义下标脚本 使用 subscript 关键字，显式声明 入参（一个或多个）和 返回类型
    下标脚本可以设定为 读写 或 只读
 */
/*:
    这种方式又有点像计算型属性的getter和setter：
 */
/*:
    subscript(index: Int) -> Int {
        get {
            // 返回与入参匹配的Int类型的值
        }
    
        set(newValue) {     // newValue的类型必须和下标脚本定义的返回类型相同
            // 执行赋值操作
        }
    }
 */

/*:
    与只读计算型属性一样，可以直接将原本应该写在get代码块中的代码写在subscript中：
 */
/*:
    subscript(index: Int) -> Int {
        // 返回与入参匹配的Int类型的值
    }
 */
// 下面代码演示了一个在 TimesTable 结构体中使用只读下标脚本的用法，该结构体用来展示传入整数的n倍
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {     // 定义下标索引
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3) // 数值3作为结构体构造函数入参初始化实例成员multiplier
print("3的6倍是\(threeTimesTable[6])", terminator: "")
// threeTimesTable[6] 这条语句访问了threeTimesTable的第六个下标
//: ## 2. 下标脚本用法
/*:
    通常下标脚本是用来访问集合（collection），列表（list）或序列（sequence）中元素的快捷方式
 */
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2 // 通过下标脚本为字典设值
numberOfLegs

//: ## 3. 下标脚本选项
/*:
    下标脚本允许任意数量的入参索引，并且每个入参类型也没有限制
    下标脚本的返回值也可以是任何类型, 下标脚本可以使用变量参数和可变参数;
    
    但使用 写入读出（in-out）参数 或给 参数设置默认值 都是 不允许的
 
    下标脚本的重载
    一个类或结构体可以根据自身需要提供多个下标脚本实现，在定义下标脚本时通过入参类型进行区分，
    使用下标脚本时会自动匹配合适的下标脚本实现运行
 */
/*:
    多个下标脚本入参
    下例 Matrix结构体，将呈现一个Double类型的二维矩阵，Matrix结构体的下标脚本需要两个整型参数：
 */
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool { // 用来确认入参的row或column值是否会造成数组越界
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix.grid

// 将值赋给带有row和column下标脚本的matrix实例表达式可以完成赋值操作，下标脚本入参使用逗号分割
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

// 上面两条语句分别让matrix的右上值为 1.5，坐下值为 3.2：
matrix.grid

//: [Next](@next)
