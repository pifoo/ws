/*
 *  1.数组的解构赋值
 *  2.对象的解构赋值
 *  3.字符串的解构赋值
 *  4.数值和布尔值的解构赋值
 *  5.函数参数的解构赋值
 *  6.圆括号问题
 *  7.用途
 */

/*
 *  1.数组的解构赋值
 */

// 解构（Destructuring）: 按照一定模式，从数组和对象中提取值，对变量进行赋值

/*
    1.1 基本用法
 */
 // ES5 只能直接赋值
var a = 1;
var b = 2;
var c = 3;

 // ES6 解构赋值 (模式匹配)
var [a, b, c] = [3, 2, 1];
console.log(a, b, c);                   // 3 2 1

// e.g 使用嵌套数组进行解构 (如果解构不成功，变量的值就等于 undefined)
let [foo, [[bar], baz]] = [11, [[22], 33]];
console.log(foo, bar, baz);             // 11, 22, 33
let [ , , third] = ["foo", "bar", "baz"];
console.log(third);                     // baz
let [x, , y] = [5, 2, 3];
console.log(x, y);                      // 5 3
let [x1, y1] = [5, 2, 3];
console.log(x1, y1);                    // 5 2
let [head, ...tail] = [1, 2, 3, 4];
console.log(head, tail);                // 1 [ 2, 3, 4 ]
let [x2, y2, ...z2] = ['a'];
console.log(x2, y2, z2);                // a undefined []
var [x3] = [];
console.log(x3);                        // undefined
var [x4, y4] = [1];
console.log(x4, y4);                    // 1 undefined

// 不完全解构
let [x5, y5] = [1, 2, 3];
console.log(x5, y5);                    // 1 2
let [x6, [y6], z6] = [1, [2, 3], 4];
console.log(x6, y6, z6);                // 1 2 4

// 等号的右边不是数组(结构不可遍历),将会报错: SyntaxError
// let [err1] = {1};
// let [err2] = false;
// let [err3] = NaN;
// let [err4] = undefined;
// let [err5] = null;
// let [err6] = {};

// 解构赋值不仅适用于 var 命令，也适用于 let 和 const 命令
var [v1, v2, ...vN ] = [1, [2, 3], 4, 5];
console.log(v1, v2, vN);                // 1 [ 2, 3 ] [ 4, 5 ]
let [m1, m2, ...mN ] = [1, [2, 3], 4, 5];
console.log(m1, m2, mN);                // 1 [ 2, 3 ] [ 4, 5 ]
const [n1, n2, ...nN ] = [1, [2, 3], 4, 5];
console.log(n1, n2, nN);                // 1 [ 2, 3 ] [ 4, 5 ]

// Set结构，也可以使用数组的解构赋值
let [xa, xb, xc] = new Set(["a", "b", "c"]);
console.log(xa, xb, xc);                // a b c

// 只要某种数据结构具有 Iterator 接口，都可以采用数组形式的解构赋值
function* fibs() {
    var a = 0;
    var b = 1;
    while (true) {
        yield a;
        [a, b] = [b, a + b];
    }
}
console.log(fibs());                    // GeneratorFunctionPrototype { _invoke: [Function: invoke] }
var [first, second, thirdX, fourth, fifth, sixth] = fibs();
console.log(sixth);                     // 5


/*
    1.2 默认值
 */
// 解构赋值允许指定默认值
var [c = true] = [];
console.log(c);                         // true
[x, y = 'b'] = ['a'];
console.log(x, y);                      // x='a', y='b'
[x, y = 'b'] = ['a', undefined];
console.log(x, y);                      // x='a', y='b'
[x, y = 'b'] = ['a', "undefined"];
console.log(x, y);                      // x='a', y='undefined'

// ES6内部使用严格相等运算符（===），判断一个位置是否有值,如果一个数组成员不严格等于undefined，默认值是不会生效的
let [xe = 1] = [undefined];
console.log(xe);                        // 1
let [ye = 1] = [null]; // 数组成员是null，默认值就不会生效，因为null不严格等于undefined
console.log(ye);                        // null

// 如果默认值是一个表达式，那么这个表达式是惰性求值的 (即只有在用到的时候，才会求值)
function f() {
    console.log('aaa');
}
let [fx = f()] = [1];
console.log(fx);                        // 1
// 以上示例因为x能取到值，所以函数f根本不会执行。上面的代码其实等价于下面的代码：
let xf;
if ([1][0] === undefined) {
    xf = f();
} else {
    xf = [1][0];
}
console.log(xf);                        // 1

// 默认值可以引用解构赋值的其他变量，但该变量必须已经声明
let [e1 = 1, l1 = e1] = [];     // x=1; y=1
console.log(e1, l1);
let [e2 = 1, l2 = e2] = [2];    // x=2; y=2
console.log(e2, l2);
let [e3 = 1, l3 = e3] = [1, 2]; // x=1; y=2
console.log(e3, l3);
let [e4 = l4, l4 = 1] = [];     // undefined 1
console.log(e4, l4);

/*
 *  2.对象的解构赋值
 */
// 解构用于对象
var { oA, oB } = { oA: "aaa", oB: "bbb" };
console.log(oA, oB);            // aaa bbb
console.log(typeof oA)          // string
// 对象解构 与 数组解构不同： 数组元素有序排列的，变量的取值由它的位置决定；
// 对象的属性无序，变量必须与属性同名，才能取到正确的值
var { oC } = { oA: "a", oB: "b" };
console.log(oC);                // undefined

// 变量名与属性名不一致，必须写成如下：
var { oD:od, oE } = { oD: "d", oB: "b" };
console.log(od, oE);            // d undefined
//console.log(oD, oE);            // ReferenceError: oD is not defined

//let obj = { first: 'hello', last: 'world' };
let { first: oF, last: oL } = { first: 'hello', last: 'world' };
console.log(oF, oL);            // hello world
// 这实际上说明，对象的解构赋值是下面形式的简写（参见《对象的扩展》）
var { oV: ov } = { ov: "hi" };
var { oV: ov } = { oV: "hi" };
console.log(ov);                // hi  // 必须访问 属性别名
//console.log(oV);              // ReferenceError: oV is not defined; 真正被赋值的是变量ov，而不是模式oV

// 以上这种写法,变量的声明和赋值是一体的。对于let和const来说，变量不能重新声明，所以一旦赋值的变量以前声明过，就会报错
let u;
//let {u} = {u: 1};               // TypeError: Duplicate declaration "u"

// 没有第二个let则会通过编译
({u} = {u: 1});
console.log(u);                   // 1
let u1;
//let {uu: u1} = {uu: 1};         // TypeError: Duplicate declaration "u1"
// 没有第二个let则会通过编译
({uu: u1} = {uu: 1});
console.log(u1);                   // 1

// 解构用于 嵌套结构 的对象
var obc = {
    p: [
        "Hello",
        {q: "World"}
    ]
};
var {p:[h, {q}]} = obc;
console.log(h, q);                  // Hello World, 注意：p是模式，不是变量，因此不会被赋值

var node = {
  loc: {
    start: {
      line: 1,
      column: 5
    }
  }
};
var { loc: { start: { line }} } = node;  // line是变量，loc和start都是模式，不会被赋值
line // 1
//loc  // error: loc is undefined
//start // error: start is undefined

// e.g 嵌套赋值
let obj = {};
let arr = [];
({ foo: obj.prop, bar: arr[0] } = { foo: 123, bar: true });
console.log(obj)                    // {prop:123}
console.log(arr)                    // [true]

// 对象的解构 指定默认值
var {x7 = 3} = {};
console.log(x7); // 3
var {x7, y7 = 5} = {x7: 1};
x7 // 1
y7 // 5
var { message: msg = "Something went wrong" } = {};
msg // "Something went wrong"
// 认值生效的条件是，对象的属性值严格等于undefined
var {x8 = 3} = {x8: undefined};
console.log(x8);                         // 3
var {x9 = 3} = {x9: null};
console.log(x9);                         // null

// 解构失败，变量的值等于undefined
var {x10} = {bar: 'baz'};
console.log(x10)                         // undefined

// 如果解构模式是嵌套的对象，而且子对象所在的父属性不存在，那么将会报错。
// 报错 因为foo这时等于undefined，再取子属性就会报错
// var {foo: {bar}} = {baz: 'baz'};
var _tmp = {baz: 'baz'};
//_tmp.foo.bar // 报错

// 错误的写法
var x11;
// {x11} = {x11: 1};            // SyntaxError: syntax error   JavaScript引擎会将{x11}理解成一个代码块
// 正确的写法
({x11} = {x11: 1});             // 只有不将大括号写在行首，避免JavaScript将其解释为代码块

// 解构赋值允许，等号左边的模式之中，不放置任何变量名。因此，可以写出非常古怪的赋值表达式,方法合法，表达式无意义
({} = [true, false]);
({} = 'abc');
({} = []);

// 对象的解构赋值，可以很方便地将现有对象的方法，赋值到某个变量
// 将 Math 对象的对数、正弦、余弦三个方法，赋值到对应的变量上
let { log, sin, cos } = Math;
console.log(log(10), Math.log(10));     // 2.302585092994046 2.302585092994046

/*
 *  3.字符串的解构赋值
 */

// 字符串解构赋值: 这是因为此时，字符串被转换成了一个 类似数组 的对象
const [i1, i2, i3, i4, i5] = 'hello';
console.log(i1, i2, i3, i4, i5)          // h e l l o
//类似数组的对象都有一个length属性，因此还可以对这个属性解构赋值。
let {length : len} = 'hello';
console.log(len);                        // 5


/*
 *  4.数值和布尔值的解构赋值
 */

// 解构赋值时，如果等号右边是数值和布尔值，则会先转为对象
// 数值和布尔值的包装对象都有toString属性

let {toString: s1} = 123;
console.log(s1);                                     // [Function: toString]
console.log(s1 === Number.prototype.toString)        // true

let {toString: s2} = true;
console.log(s2);                                     // [Function: toString]
console.log(s2 === Boolean.prototype.toString)       // true

// 解构赋值的规则是，只要等号右边的值不是对象，就先将其转为对象
// 由于undefined和null无法转为对象，所以对它们进行解构赋值，都会报错
// let { prop: px } = undefined; // TypeError: Cannot read property 'prop' of undefined
// let { prop: py } = null;      // TypeError: Cannot read property 'prop' of null


/*
 *  5.函数参数的解构赋值
 */

// 函数的参数也可以使用解构赋值
function add([x, y]){
  console.log(x + y);
}
add([1, 2]);                    // 3

console.log([
    [1, 2],
    [3, 4]
].map(([a, b]) => a + b));      // [ 3, 7 ]

// 函数参数的解构也可以使用 默认值
function move({x = 0, y = 0} = {}) {  // 函数move的参数是一个对象，通过对这个对象进行解构，得到变量x和y的值
    console.log([x, y]);
}
move({x: 3, y: 8});             // [3, 8]
move({x: 3});                   // [3, 0]
move({});                       // [0, 0]
move();                         // [0, 0]

// 下面的写法会得到不一样的结果
function move1({x, y} = { x: 0, y: 0 }) {
  console.log([x, y]);
}
move1({x: 3, y: 8});            // [3, 8]
move1({x: 3});                  // [3, undefined]
move1({});                      // [undefined, undefined]
move1();                        // [0, 0]

// undefined就会触发函数参数的默认值
console.log([1, undefined, 3].map((x = 'yes') => x));   // [ 1, 'yes', 3 ]


/*
 *  6.圆括号问题
 */
// 只要有可能，就不要在模式中放置圆括号  ():表示一个表达式，非模式

/*
    不能使用圆括号的情况
 */

//（1）变量声明语句中，不能带有圆括号
// 全部报错
// var [(a)] = [1];
//
// var {x: (c)} = {};
// var ({x: c}) = {};
// var {(x: c)} = {};
// var {(x): c} = {};}
//
// var { o: ({ p: p }) } = { o: { p: 2 } };

// (2）函数参数中，模式不能带有圆括号
// 报错
// function f([(z)]) { return z; }

// (3）赋值语句中，不能将整个模式，或嵌套模式中的一层，放在圆括号之中
// 全部报错
// ({ p: a }) = { p: 42 };
// ([a]) = [5];
// 报错
// [({ p: a }), { x: c }] = [{}, {}];

/*
    可以使用圆括号的情况
 */
// 可以使用圆括号的情况只有一种：赋值语句的非模式部分，可以使用圆括号
[(b)] = [3];                    // 正确  模式是取数组的第一个成员，跟圆括号无关
//({ p: d } = {});                // TOD  模式是p，而不是d
[(parseInt.prop)] = [3];        // 正确
// 以上都是赋值语句，而非声明语句， 其次它们的圆括号都不属于模式的一部分


/*
 *  7.变量的解构赋值用途
 */

// 7.1 交换变量的值
var p1 = 1, p2 = 2;
[p1, p2] = [p2, p1];
console.log(p1, p2);                // 2 1

// 7.2 从函数返回多个值

// 返回一个数组
function example() {
  return [1, 2, 3];
}
var [ps1, ps2, ps3] = example();
console.log([ps1, ps2, ps3]);           // [ 1, 2, 3 ]

// 返回一个对象
function example1() {
  return {
    K: 1,
    V: 2
  };
}
var { K, V } = example1();
console.log({K, V});                    // { K: 1, V: 2 }
console.log(K, V);                      // 1 2

// 7.3 函数参数的定义
// 解构赋值可以方便地将一组参数与变量名对应起来

// 参数是一组有次序的值
function fn1([x, y, z]) {
    console.log([x, y, z]);
}
fn1([1, 2, 3]);                         // [ 1, 2, 3 ]

// 参数是一组无次序的值
function fn2({x, y, z}) {
    console.log({x, y, z});
}
fn2({z: 3, y: 2, x: 1});                // { x: 1, y: 2, z: 3 }
fn2(3, 2, 1);                           // { x: undefined, y: undefined, z: undefined }

// 7.4 提取JSON数据
// 解构赋值对提取JSON对象中的数据，尤其有用
var jsonData = {
    id: 42,
    status: "OK",
    data: [867, 5309]
};
let { id, status, data: number } = jsonData;
console.log(id, status, number);        // 42 'OK' [ 867, 5309 ]


// 7.5 函数参数的默认值
// jQuery.ajax = function (url, {
//     async = true,
//     beforeSend = function () {},
//     cache = true,
//     complete = function () {},
//     crossDomain = false,
//     global = true,
//     // ... more config
// }) {
//     // ... do stuff
// };


// 7.6 遍历Map结构
// 任何部署了Iterator接口的对象，都可以用 for...of 循环遍历
var map = new Map();
map.set('first', 'hello');
map.set('second', 'world');
for (let [key, value] of map) {
    console.log(key + " is " + value);
}
// first is hello
// second is world

// 如果只想获取 键名，或者只想获取 键值，如下：
// 获取键名
for (let [key] of map) {
    console.log(key);
}
for (let [, value] of map) {  // 或 _ 忽略 key
    console.log(value);
}

// 7.7 输入 模块 的 指定方法
// 加载模块时，往往需要指定输入那些方法。解构赋值使得输入语句非常清晰 :
const {
    SourceMapConsumer,
    SourceNode
} = require("source-map");
