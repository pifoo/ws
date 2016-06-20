/**
 *	1.函数参数的默认值
 * 	2.rest参数
 *  3.扩展运算符
 *  4.name属性
 *  5.箭头函数
 *  6.函数绑定
 *  7.尾调用优化
 *  8.函数参数的尾逗号
 */

/**
 * 	1.函数参数的默认值
 */
// 1.1 基本用法
//
// ES6之前,不能直接为函数的参数指定默认值，只能采用变通的方法
function log(x, y) {
    y = y || 'World';
    console.log(x, y);
}
log('Hello') // Hello World
log('Hello', 'China') // Hello China
log('Hello', '') // Hello World

// ES6
function log(x, y = 'World') {
    console.log(x, y);
}
log('Hello') // Hello World
log('Hello', 'China') // Hello China
log('Hello', '') // Hello

function Point(x = 0, y = 0) {
    this.x = x;
    this.y = y;
}
var p = new Point();
console.log(p);              // { x: 0, y: 0 }

//参数变量是默认声明的，所以不能用let或const再次声明。
function farx(arx = 5) {
    // let arx = 1;   // error
    // const arx = 2; // error
}

// 1.2 与 解构赋值 默认值 结合使用
//
function foo({x, y = 5}) {
    console.log(x, y);
}
foo({});             // undefined, 5
foo({x: 1});         // 1, 5
foo({x: 1, y: 2});   // 1, 2
// foo();            // TypeError: Cannot read property 'x' of undefined

// e.g
function fetch(url, {
    body = '',
    method = 'GET',
    headers = {}
}) {
    console.log(method);
}

fetch('http://example.com', {})
    // "GET"
//fetch('http://example.com')
    // 报错

// 上面的写法不能省略第二个参数，如果结合函数参数的默认值，就可以省略第二个参数。这时，就出现了双重默认值
function fetch(url, {
    method = 'GET'
} = {}) {
    console.log(method);
}
fetch('http://example.com')
    // "GET"


// e.g
//

// 写法一    函数参数的默认值是空对象,但是设置了对象解构赋值的默认值
function m1({
    x = 0,
    y = 0
} = {}) {
    return [x, y];
}
console.log(m1());              // [ 0, 0 ]

// 写法二      函数参数的默认值是一个有具体属性的对象，但是没有设置对象解构赋值的默认值
function m2({
    x,
    y
} = {
    x: 0,
    y: 0
}) {
    return [x, y];
}
console.log(m2());             // [ 0, 0 ]

// x和y都有值的情况
m1({x: 3, y: 8}) // [3, 8]
m2({x: 3, y: 8}) // [3, 8]

// x有值，y无值的情况
m1({x: 3}) // [3, 0]
m2({x: 3}) // [3, undefined]

// x和y都无值的情况
m1({}) // [0, 0];
m2({}) // [undefined, undefined]

m1({z: 3}) // [0, 0]
m2({z: 3}) // [undefined, undefined]

// 1.3 参数默认值的位置
//
// 通常情况下，定义了默认值的参数，应该是函数的 尾参数。因为这样比较容易看出来，到底省略了哪些参数。如果非尾部的参数设置默认值，实际上这个参数是没法省略的
// 例一
function f(x = 1, y) {
  return [x, y];
}

f(); // [1, undefined]
f(2); // [2, undefined])
//f(, 1) // 报错
f(undefined, 1); // [1, 1]

// 例二
function f(x, y = 5, z) {
  return [x, y, z];
}

f(); // [undefined, 5, undefined]
f(1); // [1, 5, undefined]
//f(1, ,2) // 报错
f(1, undefined, 2); // [1, 5, 2]
// 上面代码中，有默认值的参数都不是尾参数。这时，无法只省略该参数，而不省略它后面的参数，除非显式输入undefined。
// 如果传入undefined，将触发该参数等于默认值，null则没有这个效果

function foo(x = 5, y = 6) {
    console.log(x, y);
}
foo(undefined, null);
// 5 null
// 上面代码中，x参数对应undefined，结果触发了默认值，y参数等于null，就没有触发默认值。


// 1.4 函数的length属性
// 指定了默认值以后，函数的length属性，将返回没有指定默认值的参数个数; 也就是说，指定了默认值后，length属性将失真
(function (a) {}).length;    // 1
(function (a = 5) {}).length;    // 0
(function (a, b, c = 5) {}).length;  // 2

// 这是因为length属性的含义是，该函数预期传入的参数个数。某个参数指定默认值以后，预期传入的参数个数就不包括这个参数了。同理，rest参数也不会计入length属性。
(function(...args) {}).length; // 0

// 如果设置了默认值的参数不是尾参数，那么length属性也不再计入后面的参数了。
(function (a = 0, b, c) {}).length; // 0
(function (a, b = 1, c) {}).length; // 1

// 1.5 作用域
// 一个需要注意的地方是，如果参数默认值是一个变量，则该变量所处的作用域，与其他变量的作用域规则是一样的，即先是当前函数的作用域，然后才是全局作用域。
var x = 1;
function f(x, y = x) {
    console.log(y);
}
f(2); // 2

// 如果调用时，函数作用域内部的变量x没有生成，结果就会不一样。

let x1 = 1;
function f(y = x1) {
  let x1 = 2;
  console.log(y);
}
f(); // 1

// 未完。。。

/**
 * 	2.rest参数  (可变参数)   rest参数中的变量代表一个数组
 */
// ES6引入rest参数（形式为“...变量名”），用于获取函数的多余参数，这样就不需要使用arguments对象了。rest参数搭配的变量是一个数组，该变量将多余的参数放入数组中
function add(...values) {
    let sum = 0;

    for (var val of values) {
        sum += val;
    }

    return sum;
}
console.log(add(2, 5, 3)); // 10

// e.g
// rest参数代替arguments变量的例子
// arguments变量的写法
function sortNumbers() {
    return Array.prototype.slice.call(arguments).sort();
}
// rest参数的写法
const sortNumbers2 = (...numbers) => numbers.sort();

// e.g
// rest参数改写数组push方法的例子
function push(array, ...items) {
    items.forEach(function(item) {
        array.push(item);
        console.log(item);
    });
}
var a = [];
push(a, 1, 2, 3);

// 注意，rest参数之后不能再有其他参数（即只能是最后一个参数），否则会报错。
// 报错
/*
function f(a, ...b, c) {
  // ...
}
*/

// 函数的length属性，不包括rest参数
(function(a) {}).length;          // 1
(function(...a) {}).length;       // 0
(function(a, ...b) {}).length;     // 1


/**
 * 	3.扩展运算符    将一个数组，变为参数序列
 */
// 3.1 含义
// 扩展运算符（spread）（...）,它好比rest参数的逆运算，将一个数组转为用逗号分隔的参数序列
console.log(...[1, 2, 3])
// 1 2 3
console.log(1, ...[2, 3, 4], 5)
// 1 2 3 4 5

// 该运算符主要用于函数调用
function push1(array, ...items) {
    array.push1(...items);
}
function add1(x, y) {
    return x + y;
}
var numbers = [4, 38];
console.log(add1(...numbers));        // 42

// e.g
// 扩展运算符与正常的函数参数可以结合使用，非常灵活
function f(v, w, x, y, z) { }
var args = [0, 1];
f(-1, ...args, 2, ...[3]);


// 3.2 替代数组的apply方法
// 由于扩展运算符可以展开数组，所以不再需要apply方法，将数组转为函数的参数了

// ES5的写法
function f(x, y, z) {
  // ...
}
var args = [0, 1, 2];
f.apply(null, args);

// ES6的写法
function f(x, y, z) {
  // ...
}
var args = [0, 1, 2];
f(...args);

// e.g 下面是扩展运算符取代apply方法的一个实际的例子，应用Math.max方法，简化求出一个数组最大元素的写法
// ES5的写法
Math.max.apply(null, [14, 3, 77])
// ES6的写法
Math.max(...[14, 3, 77])
// 等同于
Math.max(14, 3, 77);

// e.g
// 通过push函数，将一个数组添加到另一个数组的尾部
//
// ES5的写法
var arr1 = [0, 1, 2];
var arr2 = [3, 4, 5];
Array.prototype.push.apply(arr1, arr2);
// ES6的写法
var arr1 = [0, 1, 2];
var arr2 = [3, 4, 5];
arr1.push(...arr2);



// 3.3 扩展运算符的应用
// 1）合并数组
// 2）与解构赋值结合
// 3）函数的返回值
// 4）字符串
// 5）实现了Iterator接口的对象
// 6）Map和Set结构，Generator函数


// 未完。。。

/**
 * 	4.name属性
 */
// 函数的 name 属性，返回该函数的函数名

// 4.1 匿名函数
var func1 = function () {};
// ES5
func1.name; // ""        返回空
// ES6
func1.name; // "func1"   返回实际的函数名

// 4.2 具名函数 ， 赋值给一个变量
const bar = function baz() {};
// ES5
bar.name; // "baz"
// ES6
bar.name; // "baz"

// 4.3 Function构造函数返回的函数实例，name属性的值为“anonymous”。
(new Function).name; // "anonymous"

// 4.4 bind返回的函数，name属性值会加上“bound ”前缀
function foo() {};
foo.bind({}).name; // "bound foo"
(function(){}).bind({}).name // "bound "

/**
 * 	5.箭头函数
 */
// ES6允许使用“箭头”（=>）定义函数

// 一个参数
var f = v => v;
// 等同于
var f = function(v) {
    return v;
};
console.log(f(1));  // 1

// 没有参数
var f = () => 5;
// 等同于
var f = function () { return 5 };
console.log(f());   // 5

// 多个参数
var sum = (num1, num2) => num1 + num2;
// 等同于
var sum = function(num1, num2) {
    return num1 + num2;
};
console.log(sum(1,2));  // 3


// ....

// 使用注意点
/*
（1）函数体内的this对象，就是定义时所在的对象，而不是使用时所在的对象。this对象的指向是可变的，但是在箭头函数中，它是固定的
（2）不可以当作构造函数，也就是说，不可以使用new命令，否则会抛出一个错误。
（3）不可以使用arguments对象，该对象在函数体内不存在。如果要用，可以用Rest参数代替。
（4）不可以使用yield命令，因此箭头函数不能用作Generator函数。
 */

// 嵌套的箭头函数


/**
 * 	6.函数绑定(ES7)
 */
// 箭头函数可以绑定this对象，大大减少了显式绑定this对象的写法（call、apply、bind）

// 函数绑定运算符是并排的两个 双冒号（::）  object::function
// 该运算符会自动将左边的对象，作为上下文环境（即this对象），绑定到右边的函数上面
function func() {};
var object = {};
/*
object::func;   // Unexpected token  待支持?
// 等同于
bar.bind(object);

object::func(...arguments);
// 等同于
bar.apply(object, arguments);

const hasOwnProperty = Object.prototype.hasOwnProperty;
function hasOwn(obj, key) {
    return obj::hasOwnProperty(key);
}
*/


/**
 * 	7.尾调用优化
 */
// 7.1  尾调用（Tail Call）是函数式编程的一个重要概念 : 就是指某个函数的最后一步是调用另一个函数
function g() {};
function f(x){
    return g(x);        // 尾调用
}

// 以下三种情况，都不属于尾调用

// 情况一
function f(x) {
    let y = g(x);
    return y;
}

// 情况二
function f(x) {
    return g(x) + 1;
}

// 情况三
function f(x) {
    g(x);
}
    // 等同于：
    function f(x) {
        g(x);
        return undefined;
    }

// 尾调用不一定出现在函数尾部，只要是最后一步操作即可
// 函数m和n都属于尾调用，因为它们都是函数f的最后一步操作
function m(argument) {};
function n(argument) {};
function f(x) {
    if (x > 0) {
        return m(x)
    }
    return n(x);
}


// 7.2  尾调用优化


// 7.3 尾递归
function factorial(n) {
    if (n === 1) return 1;
    return n * factorial(n - 1);
}
factorial(5) // 120

function factorial1(n, total) { // total: 调用记录
    if (n === 1) return total;
    return factorial1(n - 1, n * total);
}
console.log(factorial1(5, 1));        // 120
console.log(factorial1(5, 2));        // 240

// 非尾递归的 fibonacci 递归方法
function Fibonacci (n) {
  if ( n <= 1 ) {return 1};

  return Fibonacci(n - 1) + Fibonacci(n - 2);
}
console.log(Fibonacci(10));           // 89

// 尾递归优化过的fibonacci 递归算法
function Fibonacci2(n, ac1 = 1, ac2 = 1) {
    if (n <= 1) {
        return ac1
    };
    return Fibonacci2(n - 1, ac2, ac1 + ac2);
}
console.log(Fibonacci2(10));     // 55
console.log(Fibonacci2(100));    // 354224848179262000000
console.log(Fibonacci2(1000));   // 4.346655768693743e+208
// console.log(Fibonacci2(10000));     //RangeError: Maximum call stack size exceeded

// 未完....





/**
 * 	8.函数参数的尾逗号
 */
// ES7有一个提案，允许函数的最后一个参数有尾逗号（trailing comma）
function clownsEverywhere(param1,param2,) { /* ... */ };

clownsEverywhere('param1','param2',);
