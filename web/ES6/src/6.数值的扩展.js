/*
 *  1.二进制和八进制表示法
 *  2.Number.isFinite(), Number.isNaN()
 *  3.Number.parseInt(), Number.parseFloat()
 *  4.Number.isInteger()
 *  5.Number.EPSILON
 *  6.安全整数和Number.isSafeInteger()
 *  7.Math对象的扩展
 *  8.指数运算符
 */

/*
 *  1.二进制 和 八进制 表示法
 */
// ES6: 前缀0b（0B） 八进制； 0o（0O）表示 十六进制
console.log(0b111110111 === 503); // true
console.log(0o767 === 503);        // true

// 从ES5开始，在严格模式之中，八进制就不再允许使用前缀0表示，ES6进一步明确，要使用前缀0o表示
// 非严格模式
(function() {
    // console.log(0o11 === 011);
})();
// 严格模式
(function() {
    'use strict';
    // console.log(0o11 === 011);
})();    // Uncaught SyntaxError: Octal literals are not allowed in strict mode.

// 将 0b 和 0o 前缀的 字符串数值 转为 十进制，要使用Number方法。
console.log(Number('0b111'));       // 7
console.log(Number('0o10'));        // 8


/*
 *  2.Number.isFinite(), Number.isNaN()
 */

 // Number.isFinite()用来检查一个 数值 是否 非无穷（infinity）
 //
Number.isFinite(15); // true
Number.isFinite(0.8); // true
Number.isFinite(NaN); // false
Number.isFinite(Infinity); // false
Number.isFinite(-Infinity); // false
Number.isFinite('foo'); // false
Number.isFinite('15'); // false
Number.isFinite(true); // false

// ES5 可以通过下面的代码， 部署Number.isFinite方法。
/*
(function(global) {
    var global_isFinite = global.isFinite;

    Object.defineProperty(Number, 'isFinite', {
        value: function isFinite(value) {
            return typeof value === 'number' && global_isFinite(value);
        },
        configurable: true,
        enumerable: false,
        writable: true
    });
})(this);*/

// Number.isNaN()用来检查一个值是否为NaN
//
Number.isNaN(NaN)           // true
Number.isNaN(15)            // false
Number.isNaN('15')          // false
Number.isNaN(true)          // false
Number.isNaN(9/NaN)         // true
Number.isNaN('true'/0)      // true
Number.isNaN('true'/'true') // true

// ES5通过下面的代码，部署Number.isNaN()。
/*
(function(global) {
    var global_isNaN = global.isNaN;

    Object.defineProperty(Number, 'isNaN', {
        value: function isNaN(value) {
            return typeof value === 'number' && global_isNaN(value);
        },
        configurable: true,
        enumerable: false,
        writable: true
    });
})(this);*/

// 它们与传统的全局方法isFinite()和isNaN()的区别在于，传统方法先调用Number()将非数值的值转为数值，再进行判断，而这两个新方法只对数值有效，非数值一律返回false


/*
 *  3.Number.parseInt(), Number.parseFloat()
 */
// ES6将全局方法parseInt()和parseFloat()，移植到Number对象上面，行为完全保持不变

// ES5的写法
console.log(parseInt('12.34'));             // 12
console.log(parseFloat('123.45#'));         // 123.45

// ES6的写法
console.log(Number.parseInt('12.34'));      // 12
console.log(Number.parseFloat('123.45#'));  // 123.45

// 这样做的目的，是逐步减少全局性方法，使得语言逐步模块化
console.log(Number.parseInt === parseInt);       // true
console.log(Number.parseFloat === parseFloat);   // true

/*
 *  4.Number.isInteger()
 */
// Number.isInteger()用来判断一个值是否为整数。需要注意的是，在JavaScript内部，整数和浮点数是同样的储存方法，所以3和3.0被视为同一个值
console.log(3 === 3.0);     // true

Number.isInteger(25)   // true
Number.isInteger(25.0) // true
Number.isInteger(25.1) // false
Number.isInteger("15") // false
Number.isInteger(true) // false

// ES5可以通过下面的代码，部署Number.isInteger()
/*
(function(global) {
    var floor = Math.floor,
        isFinite = global.isFinite;

    Object.defineProperty(Number, 'isInteger', {
        value: function isInteger(value) {
            return typeof value === 'number' && isFinite(value) &&
                value > -9007199254740992 && value < 9007199254740992 &&
                floor(value) === value;
        },
        configurable: true,
        enumerable: false,
        writable: true
    });
})(this);   */



/*
 *  5.Number.EPSILON
 */

// ES6在Number对象上面，新增一个极小的常量Number.EPSILON
console.log(Number.EPSILON);                // 2.220446049250313e-16
console.log(Number.EPSILON.toFixed(20));    // '0.00000000000000022204'

// 引入一个这么小的量的目的，在于为浮点数计算，设置一个误差范围。我们知道浮点数计算是不精确的
console.log(0.1 + 0.2);                 // 0.30000000000000004
console.log(0.1 + 0.2 - 0.3);           // 5.551115123125783e-17
console.log(5.551115123125783e-17.toFixed(20)); // 0.00000000000000005551

// 如果这个误差能够小于Number.EPSILON，我们就可以认为得到了正确结果
console.log(5.551115123125783e-17 < Number.EPSILON);        // true

// Number.EPSILON的实质是一个可以接受的误差范围
// 误差检查函数
function withinErrorMargin (left, right) {
    return Math.abs(left - right) < Number.EPSILON;
}
console.log(withinErrorMargin(0.1 + 0.2, 0.3)); // true
console.log(withinErrorMargin(0.2 + 0.2, 0.3)); // false


/*
 *  6.安全整数 和 Number.isSafeInteger()
 */
// JavaScript能够准确表示的整数范围在-2^53到2^53之间（不含两个端点），超过这个范围，无法精确表示这个值
console.log(Math.pow(2, 53));               // 9007199254740992
console.log(9007199254740992);              // 9007199254740992
// 超出范围后就不精确了
console.log(9007199254740993);              // 9007199254740992
console.log(Math.pow(2, 53) === Math.pow(2, 53) + 1);       // true

// 安全整数的上下限
console.log(Number.MAX_SAFE_INTEGER);       // 9007199254740991
console.log(Number.MIN_SAFE_INTEGER);       // -9007199254740991


// Number.isSafeInteger()则是用来判断一个整数是否落在这个范围之内
Number.isSafeInteger('a');                           // false
Number.isSafeInteger(null);                          // false
Number.isSafeInteger(NaN);                           // false
Number.isSafeInteger(Infinity);                      // false
Number.isSafeInteger(-Infinity);                     // false

Number.isSafeInteger(3);                             // true
Number.isSafeInteger(1.2);                           // false
Number.isSafeInteger(9007199254740990);              // true
Number.isSafeInteger(9007199254740992);              // false

Number.isSafeInteger(Number.MIN_SAFE_INTEGER - 1);   // false
Number.isSafeInteger(Number.MIN_SAFE_INTEGER);       // true
Number.isSafeInteger(Number.MAX_SAFE_INTEGER);       // true
Number.isSafeInteger(Number.MAX_SAFE_INTEGER + 1);   // false

// 验证运算结果是否落在安全整数的范围时，不要只验证运算结果，而要同时验证参与运算的每个值
Number.isSafeInteger(9007199254740993)
// false
Number.isSafeInteger(990)
// true
Number.isSafeInteger(9007199254740993 - 990)
// true
9007199254740993 - 990
// 返回结果 9007199254740002
// 正确答案应该是 9007199254740003


// 同时验证两个运算数和运算结果
function trusty(left, right, result) {
    if (
        Number.isSafeInteger(left) &&
        Number.isSafeInteger(right) &&
        Number.isSafeInteger(result)
    ) {
        return result;
    }
    throw new RangeError('Operation cannot be trusted!');
}

// console.log(trusty(9007199254740993, 990, 9007199254740993 - 990));
    // RangeError: Operation cannot be trusted!

console.log(trusty(1, 2, 3));
// 3

/*
 *  7.Math对象的扩展
 */
// ES6在Math对象上新增了 17 个与数学相关的方法。所有这些方法都是静态方法，只能在Math对象上调用
/*
 log10(), log2(), log1p(), expm1(), cosh(), sinh(), tanh(), acosh(), asinh(), atanh(), hypot(), trunc(), sign(), imul(), fround(), cbrt() and clz32()
*/

// 1)   Math.trunc()
// Math.trunc方法用于去除一个数的小数部分，返回整数部分
Math.trunc(4.1);         // 4
Math.trunc(4.9);         // 4
Math.trunc(-4.1);        // -4
Math.trunc(-4.9);        // -4
Math.trunc(-0.1234);         // -0

// 非数值
Math.trunc('123.456');      // 123
// 空值和无法截取整数的值
Math.trunc(NaN);      // NaN
Math.trunc('foo');    // NaN
Math.trunc();         // NaN

// 对于没有部署这个方法的环境，可以用下面的代码模拟。

Math.trunc = Math.trunc || function(x) {
  return x < 0 ? Math.ceil(x) : Math.floor(x);
};


// 2)   Math.sign()
// Math.sign方法用来判断一个数到底是正数、负数、还是零
/*
它会返回五种值
    参数为正数，返回+1；
    参数为负数，返回-1；
    参数为0，返回0；
    参数为-0，返回-0;
    其他值，返回NaN。
 */
Math.sign(-5);      // -1
Math.sign(5);       // +1
Math.sign(0);       // +0
Math.sign(-0);      // -0
Math.sign(NaN);     // NaN
Math.sign('foo');   // NaN
Math.sign();        // NaN

// 对于没有部署这个方法的环境，可以用下面的代码模拟

Math.sign = Math.sign || function(x) {
    x = +x; // convert to a number
    if (x === 0 || isNaN(x)) {
        return x;
    }
    return x > 0 ? 1 : -1;
};

// 3) Math.cbrt()
// Math.cbrt方法用于计算一个数的立方根
Math.cbrt(-1) // -1
Math.cbrt(0)  // 0
Math.cbrt(1)  // 1
Math.cbrt(2)  // 1.2599210498948734
console.log(Math.cbrt(8));      // 2

// 对于非数值，Math.cbrt方法内部也是先使用Number方法将其转为数值。
Math.cbrt('8') // 2
Math.cbrt('hello') // NaN

// 对于没有部署这个方法的环境，可以用下面的代码模拟
Math.cbrt = Math.cbrt || function(x) {
    var y = Math.pow(Math.abs(x), 1 / 3);
    return x < 0 ? -y : y;
};

// 未完


/*
 *  8.指数运算符
 */

// ES7新增了一个指数运算符（**）
let num = 2;
num **= 2;
// 等同于 num = num * num;

let num2 = 3;
num2 **= 3;
// 等同于 num3 = num3 * num3 * num3;
