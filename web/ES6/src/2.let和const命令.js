/*
 *  1. let命令
 *  2. 块级作用域
 *  3. const命令
 *  4. 全局对象的属性
 */

/*
 *  1. let命令
 */

/*
    1.1 基本用法
 */
{
    let a = 0; // let声明的变量只在它所在的代码块有效
    var b = 1;
    console.log(++a); // 1
}
// a                         // ReferenceError: a is not defined
console.log(b); // 1

// for循环的计数器，就很合适使用let命令。
for (let i = 0; i < 3; i++) { // i 只在for循环体内有效
    console.log("i - " + i);
}
// console.log(i);           // ReferenceError: i is not defined

// 下面的代码如果使用 var，最后输出的是 10
var a = [];
// i 全局范围内都有效。每一次循环，新的i值都会覆盖旧值，导致最后输出的是最后一轮的 i 的值
for (var i = 0; i < 10; i++) {
    a[i] = function() {
        console.log(i);
    };
}
a[1](); // 10
a[6](); // 10

// 下面的代码如果使用 let，最后输出的是 6
var a = [];
// 当前的 i 只在本轮循环有效，每一次循环的i其实都是一个新的变量
for (let i = 0; i < 10; i++) {
    a[i] = function() {
        console.log(i);
    };
}
a[6](); // 6

/*
    1.2 不存在变量提升
 */
console.log(foo); // 输出 undefined
console.log(bar); // 输出 undefined ?
var foo = 2;
let bar = 2;

/*
    1.3 暂时性死区 ???
 */
// 只要块级作用域内存在let命令，它所声明的变量就“绑定”（binding）这个区域，不再受外部的影响。在代码块内，使用let命令声明变量之前，该变量都是不可用的。这在语法上，称为“暂时性死区”（temporal dead zone，简称TDZ）
var tmp = 123
if (true) {
    // TDZ开始
    tmp = 'abc';
    console.log(tmp); // abc

    let tmp; // TDZ结束
    console.log(tmp); // undefined

    tmp = 123;
    console.log(tmp); // 123
}

// “暂时性死区”也意味着typeof不再是一个百分之百安全的操作
console.log(typeof x) // undefined
let x;

// 参考x=y,此时y还没有声明，属于”死区“
function bar1(x = y, y = 2) {
    return [x, y];
}
// console.log(bar1())      // TypeError: bar is not a function
function bar2(x = 2, y = x) {
    return [x, y];
}
console.log(bar2()) // [2, 2]



/*
    1.4 不允许重复声明
 */

// let不允许在相同作用域内，重复声明同一个变量
function a() { // 报错 SyntaxError
    let a = 10;
    //var a = 1;
}

function b() { // 报错 TypeError
    let a = 10;
    //let a = 1;
}

// 不能在函数内部重新声明参数
function f1(arg) {
    //let arg;              // 报错
}


function f2(arg) {
    {
        let arg; // 不报错
    }
}

/*
 *  2. 块级作用域
 */

// ES5只有全局作用域和函数作用域，没有块级作用域，这带来很多不合理的场景

// 第一种场景，内层变量可能会覆盖外层变量
var date = new Date();

function f() {
    console.log(date); // 变量提升，导致内层的date变量覆盖了外层的date变量
    if (false) {
        var date = "hello world";
    }
}
f() // undefined

// 第二种场景，用来计数的循环变量泄露为全局变量
var s = 'hello';
for (var j = 0; j < s.length; j++) {
    console.log(s[j]);
}
console.log(j); // 5,   泄露成了全局变量

/*
    ES6的块级作用域
 */
// let 为JavaScript新增了块级作用域
var s1 = 'hello';
for (let k = 0; k < s.length; k++) {
    console.log(s1[k]);
}
//console.log(k);     // ReferenceError

function fu1() {
    let n = 5;
    if (true) {
        let n = 10;
    }
    console.log(n); // 5     let声明，外层代码块不受内部影响
}
fu1()

function fu2() {
    var n = 5;
    if (true) {
        var n = 10;
    }
    console.log(n); // 10    var声明
}
fu2()

// ES6允许块级作用域的任意嵌套
{
    {
        {
            {
                {
                    let insane = 'Hello World'
                    console.log(insane)
                }
            }
        }
    }
}
// 外层作用域无法读取内层作用域的变量
{
    {
        {
            {
                {
                    let insane = 'Hello World'
                }
                //console.log(insane); // 报错 ReferenceError: insane is not defined
            }
        }
    }
}
// 内层作用域可以定义外层作用域的同名变量
{
    {
        {
            {
                let insane = 'Hello World 1' {
                    let insane = 'Hello World 2'
                    console.log(insane) // Hello World 2
                }
                console.log(insane) // Hello World 1
            }
        }
    }
}

// 块级作用域的出现，使得获得广泛应用的 立即执行匿名函数（IIFE）不再必要了

// IIFE写法
(function() {
    var tmp = 0;
    console.log(tmp);
})(); // 匿名方法
(function() {
    var tmp = 1;
    console.log(tmp);
}()) // 表达式 ()

// 块级作用域写法
{
    let tmp = 10;
    console.log(tmp);
}

// ES6也规定，函数本身的作用域，在其所在的块级作用域之内
// ES6输出： I am outside!
// ES5输出： I am inside!
function fout() {
    console.log('I am outside!');
}
(function() {
    if (true) {
        // 重复声明一次函数fout
        function fout() {
            console.log('I am inside!');
        }
    }
    fout(); // ES6；I am outside!
}())

// 块级作用域外部，无法调用块级作用域内部定义的函数
{
    let a = 'secret';

    function fin() {
        return a;
    }
}
//fin();    // ReferenceError

// 要想在外部调用，则先声明
let func; {
    let a = 'secret';

    func = function() {
        return a;
    }
}
console.log(func());

// ES5的严格模式规定，函数只能在顶层作用域和函数内声明，其他情况（比如if代码块、循环代码块）的声明都会报错

// ES5 报错，ES6 不报错
{
    'use strict';
    if (true) {
        function fn1() {
            console.log("use strict");
        }
    }
}

// 不报错
{
    'use strict';
    if (true) {
        function fn2() {}
    }
}
//fn2();      // ReferenceError

// 报错  构造区块的大括号不能少
{
    'use strict';
    // if (true)
    //   function fn3() {}
}


/*
 *  3. const命令
 */

// const 声明一个只读的常量。一旦声明就不能改变
const PI = 3.1415;
PI // 3.1415
//PI = 3;  // TypeError: "PI" is read-only

// const一旦声明变量，就必须立即初始化
//const FOO;          // SyntaxError:
//FOO = 1;            // 常规模式，重新赋值无效
//FOO                 // undefined

// const的作用域与let命令相同：只在声明所在的块级作用域内有效
if (true) {
    const MAX = 5;
}
// MAX              // Uncaught ReferenceError: MAX is not defined

// const命令声明的常量也是不提升，同样存在暂时性死区，只能在声明的位置后面使用
if (true) {
    //console.log(MAX); // ReferenceError
    const MIN = 5;
}

// const声明的常量，也与let一样不可重复声明
var message = "Hello!";
let age = 25;
// 以下两行都会报错
//const message = "Goodbye!";
//const age = 30;

// 对于复合类型的变量(引用类型)，变量名不指向数据，而是指向数据所在的地址。const命令只是保证变量名指向的地址不变，并不保证该地址的数据不变
const fno = {};
fno.prop = 123;
fno.prop
    // 123
    //fno = {}; // TypeError: "foo" is read-only

const arr = [];
arr.push("Hello"); // 可执行
arr.length = 0; // 可执行
//arr = ["Dave"];    // SyntaxError:  "arr" is read-only


// 将对象冻结，应该使用Object.freeze方法

// 常量foo指向一个冻结的对象，所以添加新属性不起作用，严格模式时还会报错
const o = Object.freeze({});
// 常规模式时，下面一行不起作用；
// 严格模式时，该行会报错
// o.prop = 123; // TypeError: Can't add property prop, object is not extensible

// 除了将对象本身冻结，对象的属性也应该冻结。下面是一个将对象彻底冻结的函数。
var constantize = (obj) => {
    Object.freeze(obj);
    Object.keys(obj).forEach((key, value) => {
        if (typeof obj[key] === 'object') {
            constantize(obj[key]);
        }
    });
};
//ES5只有两种声明变量的方法：var命令和function命令
//ES6除了添加let和const命令，后面章节还会提到，另外两种声明变量的方法：import命令和class命令。所以，ES6一共有6种声明变量的方法


/*
 *  4. 全局对象的属性
 */
//全局对象是最顶层的对象，在浏览器环境指的是window对象
//在Node.js指的是global对象。ES5之中，全局对象的属性与全局变量是等价的
// window.a = 1;
// a // 1
//
// a = 2;
// window.a // 2

// ES6为了改变这一点，一方面规定，为了保持兼容性，var命令和function命令声明的全局变量，依旧是全局对象的属性；
// 另一方面规定，let命令、const命令、class命令声明的全局变量，不属于全局对象的属性。
// 也就是说，从ES6开始，全局变量将逐步与全局对象的属性脱钩

//  var a = 1;
// 如果在Node的REPL环境，可以写成global.a
// 或者采用通用方法，写成this.a
// window.a // 1
// let b = 1;
// window.b // undefined
// 上面代码中，全局变量a由var命令声明，所以它是全局对象的属性；全局变量b由let命令声明，所以它不是全局对象的属性，返回undefined