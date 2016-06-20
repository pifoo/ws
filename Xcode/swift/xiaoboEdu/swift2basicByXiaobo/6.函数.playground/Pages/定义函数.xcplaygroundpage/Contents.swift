//: 定义函数
//:  - 形式：func 函数名(参数1:类型, 参数2:类型, ...) -> 返回结果的类型 {执行语句}
//:  - 调用：var 变量名称 =  函数名(变量1, 变量2, ...)
//:  - 🌰将两个字符串相加的函数
// 定义格式

/*
 func <#name#>(<#parameters#>) -> <#return type#> {
 <#function body#>
 }*/

func printName() {
    print("定义了一个函数")
}
printName()


func multipleOfTen(multiplier: Int) {
    print("\(multiplier) * 10 = \(multiplier * 10)")
}
multipleOfTen(10)


func multipleOf(multiplier: Int, addVlue: Int) {
    print("\(multiplier) + \(addVlue) = \(multiplier + addVlue)")
}
multipleOf(10, addVlue: 10)  // addVlue 不能省略

//: param name
// innerName   outName

func f(/*outName*/ innerNameA: Int, /*outName*/ innerNameB: Int){
    
}

func createTable(/*outName*/row: Int, /*outName*/column: Int) {
    print("\(row) + \(column) = \(row + column)")
}
createTable(10,column: 10) // addVlue 不能省略,outName给外部调用者使用


func createTab(row: Int, colNumber column: Int) {
    print("\(row) + \(column) = \(row + column)")
}
createTab(10,colNumber: 10) // 如果定义了outName，则调用时 outName 不能省略




func 加法(a: Int, b: Int) -> Int {
    return a + b
}

var 结果 = 加法(3, b: 4)


加法(4, b: -2)
//: [参数和返回值](@next)
