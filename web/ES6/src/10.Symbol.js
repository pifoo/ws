/**
 * 	1. 概述
 *  2. 作为属性名的Symbol
 *  3. 实例：消除魔术字符串
 *  4. 属性名的遍历
 *  5. Symbol.for()，Symbol.keyFor()
 *  6. 内置的Symbol值
 */



/**
 *	1. 概述
 */
// ES6新增 原始数据类型 Symbol，表示独一无二的值(也是基本数据类型)
// 另外六种原始数据类型：Undefined、Null、布尔值（Boolean）、字符串（String）、数值（Number）、对象（Object）
// 凡是属性名属于Symbol类型，就都是独一无二的，可以保证不会与其他属性名产生冲突
let s = Symbol();
console.log(typeof s);      // "symbol"

// Symbol函数可以接受一个字符串作为参数，表示对Symbol实例的描述; 主要是为了在控制台显示，或者转为字符串时，比较容易区分
var s1 = Symbol();
var s2 = Symbol();
s1 === s2 // false

var s1 = Symbol('foo');
var s2 = Symbol('bar');
s1 === s2 // false

console.log(s1);            // Symbol(foo)
console.log(s2);            // Symbol(bar)
console.log(s1.toString()); // Symbol(foo)
console.log(s2.toString()); // Symbol(bar)

// Symbol值不能与其他类型的值进行运算，会报错
var sym = Symbol('My symbol');
//"your symbol is " + sym
// TypeError: can't convert symbol to string
//`your symbol is ${sym}`
// TypeError: can't convert symbol to string

// Symbol值可以显式转为字符串
var sym = Symbol('My symbol');
String(sym) // 'Symbol(My symbol)'
sym.toString() // 'Symbol(My symbol)'

// Symbol值也可以转为布尔值，但是不能转为数值
var sym = Symbol();
Boolean(sym) // true
!sym  // false
if (sym) {
  // ...
}
//Number(sym) // TypeError
//sym + 2 // TypeError

/**
 * 	2. 作为属性名的Symbol
 */
 var mySymbol = Symbol();
 // 第一种写法
 var a = {};
 a[mySymbol] = 'Hello!';
 // 第二种写法
 var a = {
   [mySymbol]: 'Hello!'
 };
 // 第三种写法
 var a = {};
 Object.defineProperty(a, mySymbol, { value: 'Hello!' });
 // 以上写法都得到同样结果
 a[mySymbol] // "Hello!"

 // Symbol值作为对象属性名时，不能用点运算符
 var mySymbol = Symbol();
 var a = {};
 a.mySymbol = 'Hello!';
 a[mySymbol] // undefined
 a['mySymbol'] // "Hello!"

/**
 *	3. 实例：消除魔术字符串
 */

/**
 *	4. 属性名的遍历
 */

/**
 *	5. Symbol.for()，Symbol.keyFor()
 */

/**
 *	6. 内置的Symbol值
 */
