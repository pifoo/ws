/**
 * 	1. 简介
 * 	2. next方法的参数
 * 	3. for...of循环
 * 	4. Generator.prototype.throw()
 * 	5. Generator.prototype.return()
 * 	6. yield*语句
 * 	7. 作为对象属性的Generator函数
 * 	8. Generator函数的this
 * 	9. 含义
 * 	10. 应用
 */

/**
 * 	1. 简介
 */
// Generator函数是ES6提供的一种异步编程解决方案
// 可以把它理解成，Generator函数是一个状态机，封装了多个内部状态
// 执行Generator函数会返回一个遍历器对象，也就是说，Generator函数除了状态机，还是一个遍历器对象生成函数。返回的遍历器对象，可以依次遍历Generator函数内部的每一个状态
// 形式上，Generator函数是一个普通函数，但是有两个特征。一是，function关键字与函数名之间有一个星号；二是，函数体内部使用yield语句，定义不同的内部状态（yield语句在英语里的意思就是“产出”）
function* helloWorldGenerator() {
    yield 'hello';
    yield 'world';
    return 'ending';
}
var hw = helloWorldGenerator();
// 调用Generator函数后，该函数并不执行，返回的也不是函数运行结果，而是一个指向内部状态的指针对象，也就是遍历器对象（Iterator Object）
// Generator函数是分段执行的，yield语句是暂停执行的标记，而next方法可以恢复执行
console.log(hw.next());
console.log(hw.next());
console.log(hw.next());
console.log(hw.next());
// { value: 'hello', done: false }
// { value: 'world', done: false }
// { value: 'ending', done: true }
// { value: undefined, done: true }
console.log(hw);        // GeneratorFunctionPrototype { _invoke: [Function: invoke] }
/*
for(let x of hw){
    console.log(x);
}
// hello
// world

while (!hw.next().done) {
    console.log(hw.next());
}*/

////
// yield 语句
// yield语句后面的表达式，只有当调用next方法、内部指针指向该语句时才会执行，因此等于为JavaScript提供了手动的“惰性求值”（Lazy Evaluation）的语法功能
function* gen() {
    yield console.log(123 + 456);
}
gen().next();
// Generator函数可以不用yield语句，这时就变成了一个单纯的暂缓执行函数。
function* f() {
  console.log('执行了！')
}
setTimeout(function(){
    f().next();     // 执行了！
}, 500);
// 注：yield语句不能用在普通函数中，否则会报错
/*
(function (){
    yield 1;
})()
*/


var arr5 = [1, [[2, 3], 4],[5, 6]];
var flat = function*(a) {
    var length = a.length;
    for (var i = 0; i < length; i++) {
        var item = a[i];
        if (typeof item !== 'number') {
            yield * flat(item);
        } else {
            yield item;
        }
    }
};
for (var f1 of flat(arr5)) {
    console.log(f1);
}
// 1, 2, 3, 4, 5, 6

////
// 与Iterator接口的关系
// 任意一个对象的Symbol.iterator方法，等于该对象的遍历器生成函数，调用该函数会返回该对象的一个遍历器对象。
// 由于Generator函数就是遍历器生成函数，因此可以把Generator赋值给对象的Symbol.iterator属性，从而使得该对象具有Iterator接口
var myIterable = {};
myIterable[Symbol.iterator] = function*() {
    yield 1;
    yield 2;
    yield 3;
};
console.log([...myIterable]);         // [1, 2, 3]

// gen1是一个Generator函数，调用它会生成一个遍历器对象g1。它的Symbol.iterator属性，也是一个遍历器对象生成函数，执行后返回它自己
function* gen1(){
    // some code
}
var g1 = gen1();
console.log(g1[Symbol.iterator]() === g1);     // true


/**
 * 	2. next方法的参数
 */
// yield语句本身没有返回值，或者说总是返回undefined。next方法可以带一个参数，该参数就会被当作上一个yield语句的返回值
// 可以在Generator函数运行的不同阶段，从外部向内部注入不同的值，从而调整函数行为
function* f3() {
    for (var i = 0; true; i++) {
        var reset = yield i;
        if (reset) {
            i = -1;
        }
    }
}
var g3 = f3();
console.log(g3.next());           // { value: 0, done: false }
console.log(g3.next());           // { value: 1, done: false }
console.log(g3.next(true));       // { value: 0, done: false }

// e.g
function* foo(x) {
    var y = 2 * (yield(x + 1));
    var z = yield(y / 3);
    return (x + y + z);
}
var a = foo(5);
console.log(a.next());       // Object{value:6, done:false}
console.log(a.next());       // Object{value:NaN, done:false}
console.log(a.next());       // Object{value:NaN, done:true}
var b = foo(5);
console.log(b.next());       // { value:6, done:false }
console.log(b.next(12));         // { value:8, done:false }
console.log(b.next(13));         // { value:42, done:true }


// 未完...









/**
 * 	3. for...of循环
 */
// for...of循环可以自动遍历Generator函数，且此时不再需要调用next方法
function* foo1() {
    yield 1;
    yield 2;
    yield 3;
    yield 4;
    yield 5;
    return 6;
}
for (let v of foo1()) {
    console.log(v);
}
// 1 2 3 4 5

// e.g
function* fibonacci() {
    let [prev, curr] = [0, 1];
    for (;;) {
        [prev, curr] = [curr, prev + curr];
        yield curr;
    }
}
for (let n of fibonacci()) {
    if (n > 1000) break;
    console.log(n);
}

// for...of循环、扩展运算符（...）、解构赋值和Array.from方法内部调用的，都是遍历器接口。这意味着，它们可以将Generator函数返回的Iterator对象，作为参数
function* numbers() {
    yield 1
    yield 2
    return 3
    yield 4
}

[...numbers()] // [1, 2]

Array.from(numbers()) // [1, 2]

let [x1, y1] = numbers();
console.log(x1, y1);    // 1 2

for (let n of numbers()) {
    console.log(n)
}
// 1
// 2


// 原生的JavaScript对象没有遍历接口，无法使用for...of循环，通过Generator函数为它加上这个接口，就可以用了
function* objectEntries(obj) {
    let propKeys = Reflect.ownKeys(obj);

    for (let propKey of propKeys) {
        yield [propKey, obj[propKey]];
    }
}
let jane = {
    first: 'Jane',
    last: 'Doe'
};
for (let [key, value] of objectEntries(jane)) {
    console.log(`${key}: ${value}`);
}
// first: Jane
// last: Doe

// 加上遍历器接口的另一种写法是，将Generator函数加到对象的Symbol.iterator属性上面。
function* objectEntries1() {
  let propKeys = Object.keys(this);

  for (let propKey of propKeys) {
    yield [propKey, this[propKey]];
  }
}

let jane1 = { first: 'Jane', last: 'Doe' };

jane1[Symbol.iterator] = objectEntries1;

for (let [key, value] of jane1) {
  console.log(`${key}: ${value}`);
}
// first: Jane
// last: Doe






/**
 * 	4. Generator.prototype.throw()
 */
 // Generator函数返回的遍历器对象，都有一个throw方法，可以在函数体外抛出错误，然后在Generator函数体内捕获。

 var g1 = function* () {
   try {
     yield;
   } catch (e) {
     console.log('内部捕获', e);
   }
 };

 var i = g1();
 i.next();

 try {
   i.throw('a');
   i.throw('b');
 } catch (e) {
   console.log('外部捕获', e);
 }
 // 内部捕获 a
 // 外部捕获 b


// e.g
function* g2() {
  yield 1;
  console.log('throwing an exception');
  throw new Error('generator broke!');
  yield 2;
  yield 3;
}

function log(generator) {
  var v;
  console.log('starting generator');
  try {
    v = generator.next();
    console.log('第一次运行next方法', v);
  } catch (err) {
    console.log('捕捉错误', v);
  }
  try {
    v = generator.next();
    console.log('第二次运行next方法', v);
  } catch (err) {
    console.log('捕捉错误', v);
  }
  try {
    v = generator.next();
    console.log('第三次运行next方法', v);
  } catch (err) {
    console.log('捕捉错误', v);
  }
  console.log('caller done');
}

log(g2());
// starting generator
// 第一次运行next方法 { value: 1, done: false }
// throwing an exception
// 捕捉错误 { value: 1, done: false }
// 第三次运行next方法 { value: undefined, done: true }
// caller done








/**
 * 	5. Generator.prototype.return()
 */

/**
 * 	6. yield*语句
 */
// 用来在一个Generator函数里面执行另一个Generator函数
//
// 以下直接在Generator函数里面执行另一个Generator函数，默认是没有效果的
function* foo3() {
    yield 'a';
    yield 'b';
}
function* bar3() {
    yield 'x';
    // foo3();      // 直接在Generator函数里面执行另一个Generator函数，默认是没有效果的
    yield* foo3();
    yield 'y';
}
// 等同于
function* bar4() {
  yield 'x';
  yield 'a';
  yield 'b';
  yield 'y';
}
// 等同于
function* bar4() {
  yield 'x';
  for (let v of foo3()) {
    yield v;
  }
  yield 'y';
}

for (let v of bar3()) {
    console.log(v);
}
// x
// a
// b
// y



/**
 * 	7. 作为对象属性的Generator函数
 */

/**
 * 	8. Generator函数的this
 */

/**
 * 	9. 含义
 */
// 1) Generator与状态机
// ES5
var ticking = true;
var clock = function() {
    if (ticking)
        console.log('Tick!');
    else
        console.log('Tock!');
    ticking = !ticking;
}
// ES6
var clock = function*() {
    while (true) {
        console.log('Tick!');
        yield;
        console.log('Tock!');
        yield;
    }
};

// 2) Generator与协程
// 2.1) 协程与子例程的差异
// 在内存中，子例程只使用一个栈（stack），而协程是同时存在多个栈，但只有一个栈是在运行状态，也就是说，协程是以多占用内存为代价，实现多任务的并行
// 2.1）协程与普通线程的差异
// 协程同一时间可以有多个线程处于运行状态，但是运行的协程只能有一个，其他协程都处于暂停状态。普通的线程是抢先式的，到底哪个线程优先得到资源，必须由运行环境决定，但是协程是合作式的，执行权由协程自己分配
//
// Generator函数是ECMAScript 6对协程的实现，但属于不完全实现。Generator函数被称为“半协程”（semi-coroutine），意思是只有Generator函数的调用者，才能将程序的执行权还给Generator函数。如果是完全执行的协程，任何函数都可以让暂停的协程继续执行。

// 如果将Generator函数当作协程，完全可以将多个需要互相协作的任务写成Generator函数，它们之间使用yield语句交换控制权


/**
 * 	10. 应用
 */
// Generator可以暂停函数执行，返回任意表达式的值。这种特点使得Generator有多种应用场景
//
// 10.1）异步操作的同步化表达
    // Generator函数的一个重要实际意义就是用来处理异步操作，改写回调函数
/*
function* loadUI() {
    showLoadingScreen();
    yield loadUIDataAsynchronously();
    hideLoadingScreen();
}
var loader = loadUI();
// 加载UI
loader.next()
    // 卸载UI
loader.next()
*/





// 10.2) 控制流管理




// 10.3）部署iterator接口







// 10.4) 作为数据结构
