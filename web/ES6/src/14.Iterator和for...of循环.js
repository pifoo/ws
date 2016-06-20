/**
 * 	1. Iterator（遍历器）的概念
 * 	2. 数据结构的默认Iterator接口
 * 	3. 调用Iterator接口的场合
 * 	4. 字符串的Iterator接口
 * 	5. Iterator接口与Generator函数
 * 	6. 遍历器对象的return()，throw()
 * 	7. for...of循环
 */

/**
 * 	1. Iterator（遍历器）的概念
 */
/*
    JS表示集合的对象：
        Array,Object
        Map,Set

    在ES6中，有些数据结构原生具备Iterator接口（比如数组），即不用任何处理，就可以被for...of循环遍历，有些就不行（比如对象

    Iterator的作用有：
        一是为各种数据结构，提供一个统一的、简便的访问接口；
        二是使得数据结构的成员能够按某种次序排列；
        三是ES6创造了一种新的遍历命令for...of循环，Iterator接口主要供for...of消费

    Iterator的遍历过程:
        1）创建一个指针对象，指向当前数据结构的起始位置。也就是说，遍历器对象本质上，就是一个指针对象。
        2）第一次调用指针对象的next方法，可以将指针指向数据结构的第一个成员。
        3）第二次调用指针对象的next方法，指针就指向数据结构的第二个成员。
        4）不断调用指针对象的next方法，直到它指向数据结构的结束位置。
        每一次调用next方法，都会返回数据结构的当前成员的信息。具体来说，就是返回一个包含value和done两个属性的对象。其中，value属性是当前成员的值，done属性是一个布尔值，表示遍历是否结束。
 */
// e.g 模拟next方法返回值的例子(遍历器生成函数)
function makeIterator(array) {
    var nextIndex = 0;
    return {
        /*
        next: function() {
            return nextIndex < array.length ? {
                value: array[nextIndex++],
                done: false
            } : {
                value: undefined,
                done: true
            };
        }
        */
        // 简写 （对于遍历器对象来说，done: false和value: undefined属性都是可以省略的）
        next: function() {
            return nextIndex < array.length ? {
                value: array[nextIndex++]
            } : {
                done: true
            };
        }
    };
}
var it = makeIterator(['a', 'b']);
console.log(it.next());          // { value: "a", done: false }
console.log(it.next());          // { value: "b", done: false }
console.log(it.next());          // { value: undefined, done: true }
// { value: 'a' }
// { value: 'b' }
// { done: true }

// e.g 无限运行的遍历器对象
function idMaker() {  // 返回一个遍历器对象（即指针对象）。但是并没有对应的数据结构，或者说，遍历器对象自己描述了一个数据结构出来
    var index = 0;
    return {
        next: function() {
            return {
                value: index++,
                done: false
            };
        }
    };
}
var it1 = idMaker();
it1.next().value // '0'
it1.next().value // '1'
it1.next().value // '2'
    // ...

/**
 * 	2. 数据结构的默认Iterator接口
 */
// Iterator接口的目的，就是为所有数据结构，提供了一种统一的访问机制，即for...of循环
// 使用for...of循环遍历某种数据结构时，该循环会自动去寻找Iterator接口
// 一个数据结构只要具有Symbol.iterator属性，就可以认为是“可遍历的”（iterable）
// 在ES6中，有三类数据结构原生具备Iterator接口：数组、某些类似数组的对象、Set和Map结构
let arr = ['a', 'b', 'c'];
let iter = arr[Symbol.iterator]();
console.log(iter.next());        // { value: 'a', done: false }
console.log(iter.next());        // { value: 'b', done: false }
console.log(iter.next());        // { value: 'c', done: false }
console.log(iter.next());        // { value: undefined, done: true }

// 一个 对象 如果要有可被for...of循环调用的Iterator接口，就必须在Symbol.iterator的属性上部署遍历器生成方法（原型链上的对象具有该方法也可）
class RangeIterator {
    constructor(start, stop) {
        this.value = start;
        this.stop = stop;
    }
    // 在类中部署Symbol.iterator方法
    [Symbol.iterator]() {
        return this;
    }

    next() {
        var value = this.value;
        if (value < this.stop) {
            this.value++;
            return {
                done: false,
                value: value
            };
        } else {
            return {
                done: true,
                value: undefined
            };
        }
    }
}
function range(start, stop) {
    return new RangeIterator(start, stop);
}
for (var value of range(0, 3)) {
    console.log(value);
}


// e.g  通过遍历器实现指针结构的例子
function Obj(value) {
    this.value = value;
    this.next = null;
}
// 在构造函数的原型链上部署Symbol.iterator方法
Obj.prototype[Symbol.iterator] = function() {
    var iterator = {
        next: next
    };
    var current = this;
    function next() {
        if (current) {
            var value = current.value;
            var done = current.next === null;
            current = current.next;
            return {
                done: done,
                value: value
            };
        } else {
            return {
                done: true
            };
        }
    }
    return iterator;
}
var one = new Obj(1);
var two = new Obj(2);
var three = new Obj(3);

one.next = two;
two.next = three;

for (var i of one) {
    console.log(i);
}
// 1
// 2
// 3

// e.g  另一个为对象添加Iterator接口的例子
let obj = {
    data: ['hello', 'world'],
    [Symbol.iterator]() {
        const self = this;
        let index = 0;
        return {
            next() {
                if (index < self.data.length) {
                    return {
                        value: self.data[index++],
                        done: false
                    };
                } else {
                    return {
                        value: undefined,
                        done: true
                    };
                }
            }
        };
    }
};

// e.g  类似数组的对象调用数组的Symbol.iterator方法的例子。
let iterable = {
    0: 'a',
    1: 'b',
    2: 'c',
    length: 3,
    [Symbol.iterator]: Array.prototype[Symbol.iterator]
};
for (let item of iterable) {
    console.log(item); // 'a', 'b', 'c'
}

// e.g  while循环遍历
var ITERABLE = [3, 2, 1];
var $iterator = ITERABLE[Symbol.iterator](); // 返回遍历器对象
var $result = $iterator.next();
while (!$result.done) {
    var x = $result.value;
    // ...
    $result = $iterator.next();
    console.log($result);
}
// { value: 2, done: false }
// { value: 1, done: false }
// { value: undefined, done: true }

/**
 * 	3. 调用Iterator接口的场合
 */

// 1）解构赋值 - 对数组和Set结构进行解构赋值时，会默认调用Symbol.iterator方法
let set = new Set().add('a').add('b').add('c');
let [m,n] = set;
// x='a'; y='b'
let [first, ...rest] = set;
// first='a'; rest=['b','c'];

// 2）扩展运算符 - 扩展运算符（...）也会调用默认的iterator接口
// 例一
var str = 'hello';
[...str] //  ['h','e','l','l','o']

// 例二
let arr1 = ['b', 'c'];
['a', ...arr1, 'd']
// ['a', 'b', 'c', 'd']


// 3) yield* 后面跟的是一个可遍历的结构，它会调用该结构的遍历器接口
let generator = function*() {
    yield 1;
    yield* [2, 3, 4];
    yield 5;
};
var iterator = generator();
console.log(iterator.next());         // { value: 1, done: false }
console.log(iterator.next());         // { value: 2, done: false }
console.log(iterator.next());         // { value: 3, done: false }
console.log(iterator.next());         // { value: 4, done: false }
console.log(iterator.next());         // { value: 5, done: false }
console.log(iterator.next());         // { value: undefined, done: true }

/*  4) 其他场合
由于数组的遍历会调用遍历器接口，所以任何接受数组作为参数的场合，其实都调用了遍历器接口。下面是一些例子:
    for...of
    Array.from()
    Map(), Set(), WeakMap(), WeakSet()（比如new Map([['a',1],['b',2]])）
    Promise.all()
    Promise.race()
 */


/**
 * 	4. 字符串的Iterator接口
 */
// 字符串是一个类似数组的对象，也原生具有Iterator接口
var someString = "hi";
typeof someString[Symbol.iterator];
// "function"
var iterator = someString[Symbol.iterator]();
iterator.next();  // { value: "h", done: false }
iterator.next();  // { value: "i", done: false }
iterator.next();  // { value: undefined, done: true }

// 覆盖原生的Symbol.iterator方法，达到修改遍历器行为的目的
var str2 = new String("hi");
console.log([...str2]);             // ["h", "i"]
str2[Symbol.iterator] = function() {
    return {
        next: function() {
            if (this._first) {
                this._first = false;
                return {
                    value: "bye",
                    done: false
                };
            } else {
                return {
                    done: true
                };
            }
        },
        _first: true
    };
};
console.log([...str2]);               // ["bye"]
console.log(str2);                    // [String: 'hi']


/**
 * 	5. Iterator接口与Generator函数
 */
// Symbol.iterator方法的最简单实现，还是使用Generator函数 :
var myIterable = {};
myIterable[Symbol.iterator] = function*() {
    yield 1;
    yield 2;
    yield 3;
};
console.log([...myIterable]);        // [1, 2, 3]

// 或者采用下面的简洁写法
let obj1 = { * [Symbol.iterator]() {
        yield 'hello';
        yield 'world';
    }
};
for (let x of obj1) {
    console.log(x);
}
// hello
// world


/**
 * 	6. 遍历器对象的return()，throw()
 */
// 遍历器对象除了具有next方法，还可以具有return方法和throw方法;(next方法是必须部署的)
// e.g  如果一个对象在完成遍历前，需要清理或释放资源，就可以部署return方法
function readLinesSync(file) {
    return {
        next() {
            if (file.isAtEndOfFile()) {
                file.close();
                return {
                    done: true
                };
            }
        },
        return() {
            file.close();
            return {
                done: true
            };
        },
    };
}
/*
for (let line of readLinesSync(fileName)) {
    console.log(x);
    break;
}*/


/**
 * 	7. for...of循环
 */
// for...of循环内部调用的是数据结构的Symbol.iterator方法
// for...of循环可以使用的范围包括数组、Set和Map结构、某些类似数组的对象（比如arguments对象、DOM NodeList对象）、后文的Generator对象，以及字符串
// for...of循环可以代替数组实例的forEach方法

// 1)   数组
const arr2 = ['red', 'green', 'blue'];
for (let v of arr2) {
    console.log(v);             // red green blue
}
let iterator3 = arr2[Symbol.iterator]();
for (let v3 of iterator3) {
    console.log(v3);            // red green blue
}

const arr3 = ['red', 'green', 'blue'];
arr3.forEach(function (element, index) {
    console.log(index, element);
    // 0 'red'
    // 1 'green'
    // 2 'blue'
});

// JavaScript原有的for...in循环，只能获得对象的键名，不能直接获取键值。ES6提供for...of循环，允许遍历获得键值
var arr4 = ['a', 'b', 'c', 'd'];
for (let a in arr4) {
  console.log(a); // 0 1 2 3
}
for (let a of arr4) {
  console.log(a); // a b c d
}


// 未完
