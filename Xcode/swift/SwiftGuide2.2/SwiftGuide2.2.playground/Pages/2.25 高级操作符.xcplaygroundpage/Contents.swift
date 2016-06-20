//: [Previous](@previous)
import UIKit
var str = "💡🕯📍🚩📝✏️🖍❗️‼️⁉️❕❔❌⭕️💢♨️"
/*:
    本页内容包括：
    1. 位运算符
    2. 溢出运算符
    3. 优先级和结合性(Precedence and Associativity)
    4. 运算符函数(Operator Functions)
    5. 自定义运算符
 */

//: ## 1. 位运算符
/*:
    位运算符(Bitwise operators)可以操作一个数据结构中每个独立的位;
    
    开发场景:
    - 底层开发中( 比如图形编程和创建设备驱动)
    - 处理外部资源的原始数据( 比如对自定义通信协议传输的数据进行编码和解码)
 */
/*:
    1.1 按位取反运算符(bitwise NOT operator)
        (~) 可以对一个数值的全部位进行取反
 */
// e.g
UIImage(named: "bitwiseNOT_2x.png")

let initialBits: UInt8 = 0b00001111
let invertedBits = String(~initialBits, radix: 2)  // 按位取反，并以二进制形式输出
~initialBits

/*:
     1.2 按位与运算符(Bitwise AND Operator)
         (&)可以对两个数的比特位进行 与 合并
 */
// e.g
UIImage(named: "SwiftGuide2.2.png")

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = String(firstSixBits & lastSixBits, radix: 2)

/*:
     1.3 按位或运算符(Bitwise OR Operator)
         (|)可以对两个数的比特位进行 或 比较
 */
// e.g
UIImage(named: "bitwiseOR_2x.png")

let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = String(someBits | moreBits, radix: 2)

/*:
    1.4 按位异或运算符(Bitwise XOR Opoerator)
        (^) 两个操作数的对应位不相同时，该数的对应位就为 1
 */
// e.g
UIImage(named: "bitwiseXOR_2x.png")

let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = String(firstBits ^ otherBits, radix: 2)

/*:
    1.5 按位左移/右移运算符
        按位左移运算符(<<) 和 按位右移运算符(>>)
        注：
        按位左移 或 按位右移，相当于对这个数进行乘以 2 或除以 2 的运算
 */
/*:
    1.5.1 无符号整型的移位操作(逻辑移位)
          - 已经存在的比特位按指定的位数进行左移和右移
          - 任何移动超出整型存储边界的位都会被丢弃
          - 用 0 来填充移动后产生的空白位
 */
// e.g 移位操作
let shiftBits: UInt8 = 4   // 即二进制的00000100
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000
shiftBits >> 2             // 00000001

// e.g 使用移位操作对其他的数据类型进行编码和解码
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent 是 0xCC, 即 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 是 0x66, 即 102
let blueComponent = pink & 0x0000FF           // blueComponent 是 0x99, 即 153

/*:
    1.5.2 有符号整型的移位操作
          有符号整数使用第 1 个比特位(通常被称为符号位)来表示这个数的正负; 符号位为 0 代表正数，为 1 代表负数。
 
          负数的存储方式略有不同:
          它存储的是 2 的 n 次方减去它的真实值绝对值，这里的 n 为数值位的位数
          负数的二进制表示 通常称为 二进制补码(two's complement)表示法
 
          当对 正整数进行按位 右移操作时，遵循与无符号整数相同的规则；
          但是对于移位产生的空白位使用符号位进行填充，而不是用 0 （算术移位(arithmetic shift)）
 */

//: ## 2. 溢出运算符
/*
     溢出加法 &+
     溢出减法 &-
     溢出乘法 &*
 
 */



//: ## 3. 优先级和结合性(Precedence and Associativity)

//: ## 4. 运算符函数(Operator Functions)


//: ## 5. 自定义运算符



//: [Next](@next)
