/**
 * 	1.Set
 *  2.WeakSet
 *  3.Map
 *  4.WeakMap
 */

/**
 * 	1.Set  有序 列表 集合
 *
 * 	与Array对象的区别：
    Set中存储的元素是不允许重复的，而Array中可以存储重复的元素。
    遍历元素的方式：Set通过for…of…，而Array通过for…in…。
 */

/**
 * 1.1 基本用法
 */

// 数据结构 Set:类似于数组，但成员的 值 唯一且不重复
// Set本身是一个构造函数，用来生成Set数据结构
//
var s = new Set();
[2, 3, 5, 4, 5, 2, 2].map(i => s.add(i)) // 通过add方法向Set结构加入成员，结果表明Set结构不会添加重复的值
console.log(s);                  // Set { 2, 3, 5, 4 }

// Set函数可以接受一个数组（或类似数组的对象）作为参数，用来初始化
// 例一
var set = new Set([1, 2, 3, 4, 4]);  // 去数组重复
console.log([...set]);          // [1, 2, 3, 4]
// 例二
var items = new Set([1, 2, 3, 4, 5, 5, 5, 5]);
console.log([...items], items.size)         // 5
/* 类似数组
// 例三
function divs () {
  return [...document.querySelectorAll('div')];
}
var set = new Set(divs());
set.size // 56
// 类似于
st().forEach(div => set.add(div));
set.size // 56
*/

// NaN等于自身
let set1 = new Set();
let a = NaN;
let b = NaN;
set1.add(a);
set1.add(b);
console.log(set1.size, set1);  // 1 Set { NaN }          向Set实例添加了两个NaN，但是只能加入一个,Set内部，两个NaN是相等

//  NaN != NaN    {} != {} (两个对象总是不相等的)
console.log(NaN == NaN);        // false
console.log({} == {});          // false
let set2 = new Set();
set2.add({});                   // 1
console.log(set2.size);
set2.add({});                   // 2
console.log(set2.size);

/**
 * 	1.2 Set实例的属性和方法
 */

/*
Set结构的实例有以下 属性
    - Set.prototype.constructor：构造函数，默认就是Set函数
    - Set.prototype.size：返回Set实例的成员总数

Set实例的方法分为两大类：操作方法（用于操作数据）和遍历方法（用于遍历成员）
    操作方法:
    - add(value)：添加某个值，返回Set结构本身。
    - delete(value)：删除某个值，返回一个布尔值，表示删除是否成功。
    - has(value)：返回一个布尔值，表示该值是否为Set的成员。
    - clear()：清除所有成员，没有返回值
 */
// e.g
let set3 = new Set();
set3.add(1).add(2).add(2);      // 注意2被加入了两次
set3.size                       // 2
set3.has(1)                     // true
set3.has(2)                     // true
set3.has(3)                     // false
set3.delete(2);
set3.has(2)                     // false

// e.g  对比判断是否包括一个键，Object结构和Set结构的写法不同：
// 对象的写法
var properties = {
  'width': 11,
  'height': 12
};
if (properties.width) {
    console.log(properties.width);
}
// Set的写法
var properties1 = new Set();
properties1.add('width');
properties1.add('height');
if (properties1.has('height')) {
    console.log(properties1);               // Set { 'width', 'height' }
    console.log(properties1.height);        // undefined
}

// e.g
// Array.from 方法可以将Set结构转为数组
var items = new Set([1, 2, 3, 4, 5]);
var array = Array.from(items);
console.log(array);                         // [ 1, 2, 3, 4, 5 ]

// 数组去重的另一种方法
function dedupe(array) {
  return Array.from(new Set(array));
}
console.log(dedupe([1, 1, 2, 3]))            // [1, 2, 3]

/**
 *	1.3 遍历操作
 */
/*
Set结构的实例有四个遍历方法，可以用于遍历成员:
    - keys()：返回一个键名的遍历器
    - values()：返回一个键值的遍历器
    - entries()：返回一个键值对的遍历器
    - forEach()：使用回调函数遍历每个成员,无返回值

    注：key()、value()、entries()  返回的是 遍历器对象
    由于 Set结构没有键名，只有键值（或者说键名和键值是同一个值），所以key方法和value方法的行为完全一致
 */
// e.g
let set4 = new Set(['red', 'green', 'blue']);

console.log('\n', set4, '\n', set4.keys() + '\n', set4.values() + '\n', set4.entries() + '\n');
// Set { 'red', 'green', 'blue' }
// [object Set Iterator]
// [object Set Iterator]
// [object Set Iterator]

for (let item of set4.keys()) {
  console.log(item);
}
// red
// green
// blue

for (let item of set4.values()) {
  console.log(item);
}
// red
// green
// blue

for (let item of set4.entries()) { //同时包括键名和键值，所以每次输出一个数组，它的两个成员完全相等
  console.log(item);
}
// ["red", "red"]
// ["green", "green"]
// ["blue", "blue"]


// Set结构的实例默认可遍历，它的默认9遍历器生成函数就是它的 values 方法
console.log(Set.prototype[Symbol.iterator] === Set.prototype.values); // true
// 这意味着，可以省略values方法，直接用 for...of 循环遍历Set
let set5 = new Set(['🌹', '🌼', '🍀']);
for (let x of set5) {
  console.log(x);
}
// 🌹
// 🌼
// 🍀

// 扩展运算符（...）内部使用for...of循环，所以也可以用于Set结构
console.log(...set5);           // 🌹 🌼 🍀

// 扩展运算符 和 Set 结构相结合，数组去重
let arr = [3, 5, 2, 2, 5, 5];
let unique = [...new Set(arr)];
console.log(unique);            // [3, 5, 2]

// 数组的 map 和 filter 方法也可以用于 Set
let set6 = new Set([1, 2, 3]);
set6 = new Set([...set6].map(x => x * 2));
console.log(set6);              // Set { 2, 4, 6 }

let set7 = new Set([1, 2, 3, 4, 5]);
set7 = new Set([...set7].filter(x => (x % 2) == 0));
console.log(set7);              // Set { 2, 4 }

// 使用 Set，实现 并集（Union）、交集（Intersect）和 差集（Difference）
let a1 = new Set([1, 2, 3]);
let b1 = new Set([4, 3, 2]);
// 并集
let union = new Set([...a1, ...b1]);
console.log(union);             // [1, 2, 3, 4]
// 交集
let intersect = new Set([...a1].filter(x => b1.has(x)));
console.log(intersect);         // Set { 2, 3 }
// 差集
let difference = new Set([...a1].filter(x => !b1.has(x)));
console.log(difference);        // Set { 1 }

// Set结构的实例的forEach方法，用于对每个成员执行某种操作，没有返回值
let set8 = new Set([1, 2, 3]);
set8.forEach((value, key) => console.log(value * 2) ) // forEach( , ) 参数1(处理函数): 键值、键名、[集合本身]， 参数2（表示绑定的this对象）
// 2
// 4
// 6
//console.log(set8);              // Set { 1, 2, 3 }

// 在遍历操作中，无法直接 同步改变 原来的 Set结构，但有两种变通方法
// 方法一   利用原Set结构映射出一个新的结构
let set9 = new Set([1, 2, 3, 3]);
set9 = new Set([...set9].map(val => val * 2));
console.log(set9);                // Set { 2, 4, 6 }

// 方法二
let set10 = new Set([1, 2, 3, 3]);
set10 = new Set(Array.from(set10, val => val * 2));
console.log(set10);               // Set { 2, 4, 6 }


/**
 * 	2.WeakSet
 */
// WeakSet: 不重复值的集合，与Set有两个区别：
// 1）WeakSet的成员只能是对象，而不能是其他类型的值
// 2）WeakSet中的对象都是弱引用，WeakSet是不可遍历的
var ws = new WeakSet(); // 参数：任何具有iterable接口的对象
// ws.add(1)                // TypeError: Invalid value used in weak set
// ws.add(Symbol());        // TypeError: Invalid value used in weak set

var a2 = [[1,2], [3,4]];
var ws1 = new WeakSet(a2);  // a数组的成员成为WeakSet的成员，而不是a数组本身;这意味着，数组的成员只能是对象
console.log(ws1);           // WeakSet {}

var a3 = [1, 2];    // 数组 a3 的成员不是对象
// var ws2 = new WeakSet(a3);  // TypeError: Invalid value used in weak set

/*
WeakSet结构有以下三个方法:
    - WeakSet.prototype.add(value)：向WeakSet实例添加一个新成员。
    - WeakSet.prototype.delete(value)：清除WeakSet实例的指定成员。
    - WeakSet.prototype.has(value)：返回一个布尔值，表示某个值是否在WeakSet实例之中。
 */
// e.g
var ws3 = new WeakSet();
var o1 = {};
var o2 = {};
console.log(ws3.add(o1));    // WeakSet {}
console.log(ws3.has(o2));    // false
console.log(ws3.delete(o1)); // true
console.log(ws3.has(o1));    // false

// WeakSet没有size属性，没有办法遍历它的成员
console.log(ws3.size)                       // undefined
console.log(ws3.forEach)                    // undefined
// ws3.forEach(function(item){ console.log('WeakSet has ' + item)}) // TypeError: undefined is not a function
// WeakSet的一个用处，是储存DOM节点，而不用担心这些节点从文档移除时，会引发内存泄漏
// e.g
// foos对实例的引用，不会被计入内存回收机制，所以删除实例的时候，不用考虑foos，也不会出现内存泄漏
const foos = new WeakSet()
class Foo {
    constructor() {
        foos.add(this)
    }
    method() {
        if (!foos.has(this)) {
            throw new TypeError('Foo.prototype.method 只能在Foo的实例上调用！');
        }
    }
}


/**
 * 	3.Map   有序 键值对 集合
 * 	与Object对象的区别：
    Map中的Key值可以是任意类型，而Object中的Key值只允许为字符串。
    遍历元素的方式：Map通过for…of…，而Object通过for…in…。
 */
// JavaScript的对象（Object），本质上是键值对的集合（Hash结构），但是只能用 字符串 当作 键。这给它的使用带来了很大的限制
/*
var data = {};
var element = document.getElementById("myDiv");

data[element] = metadata;
data["[Object HTMLDivElement]"] // metadata
*/

/*
    3.1 基本使用
 */

// Map: 类似于对象，也是键值对的集合，但是“键”的范围不限于字符串，各种类型的值（包括对象）都可以当作键; Object结构提供了“字符串—值”的对应，Map结构提供了“值—值”的对应，是一种更完善的Hash结构实现; Map比Object更合适 “键值对”的数据结构
var m = new Map();
var o = {p: "Hello World"};
m.set(o, "content")              // 将对象o当作m的一个键
console.log(m.get(o))            // content
console.log(m.has(o))            // true
console.log(m.delete(o))         // true
console.log(m.has(o))            // false

// 作为构造函数，Map也可以接受一个数组作为参数。该数组的成员是一个个表示键值对的数组
var map = new Map([["name", "张三"], ["title", "Author"]]);//指定了两个键name和title
console.log(map.size)            // 2
console.log(map.has("name"));    // true
console.log(map.get("name"));    // "张三"
console.log(map.has("title"));   // true
console.log(map.get("title"));   // "Author"

// Map构造函数接受数组作为参数，实际上执行的是下面的算法
var items = [
    ["name", "张三"],
    ["title", "Author"]
];
var map1 = new Map();
items.forEach(([key, value]) => map.set(key, value));

// 如果对同一个键多次赋值，后面的值将覆盖前面的值
let map2 = new Map();
map2.set(1, 'aaa').set(1, 'bbb');
console.log(map2.get(1))          // "bbb"

// 读取一个未知的键，则返回undefined。
console.log(new Map().get('asfddfsasadf'))  // undefined

// 只有对同一个对象的引用，Map结构才将其视为同一个键:
var map3 = new Map();
console.log(map3.set(['a'], 555));           // Map { [ 'a' ] => 555 }
console.log(map3.get(['a']));                // undefined

// 同样的值的两个实例，在Map结构中被视为两个键
var map4 = new Map();
var k1 = ['a'];
var k2 = ['a'];
map4
    .set(k1, 111)
    .set(k2, 222);
map4.get(k1) // 111
map4.get(k2) // 222

// 如果Map的键是一个 简单类型的值（数字、字符串、布尔值），则只要两个值严格相等，Map将其视为一个键，包括0和-0。另外，虽然NaN不严格相等于自身，但Map将其视为同一个键
let map5 = new Map();
map5.set(NaN, 123);
map5.get(NaN) // 123
map5.set(-0, 123);
map5.get(+0)  // 123

/*
    3.2 实例的属性和操作方法
*/
//Map结构的实例有以下属性和操作方法

//（1）size属性
// size属性返回Map结构的成员总数
let map6 = new Map();
map6.set('foo', true);
map6.set('bar', false);
map6.size // 2

// （2）set(key, value)
// set方法设置key所对应的键值，然后返回整个Map结构。如果key已经有值，则键值会被更新，否则就新生成该键
var m = new Map();
m.set("edition", 6)        // 键是字符串
m.set(262, "standard")     // 键是数值
m.set(undefined, "nah")    // 键是undefined
console.log(m);            // Map { 'edition' => 6, 262 => 'standard', undefined => 'nah' }

// set方法返回的是Map本身，因此可以采用链式写法
let map7 = new Map()
  .set(1, 'a')
  .set(2, 'b')
  .set(3, 'c');
console.log(map7);          // Map { 1 => 'a', 2 => 'b', 3 => 'c' }

// 3）get(key)
// get方法读取key对应的键值，如果找不到key，返回undefined
var map8 = new Map();
var hello = function() {console.log("hello");}
map8.set(hello, "Hello ES6!") // 键是函数
console.log(map8.get(hello));               // Hello ES6!

// （4）has(key)
// has方法返回一个布尔值，表示某个键是否在Map数据结构中
var m = new Map();
m.set("edition", 6);
m.set(262, "standard");
m.set(undefined, "nah");

m.has("edition")     // true
m.has("years")       // false
m.has(262)           // true

m.has(undefined)     // true

// 5）delete(key)
// delete方法删除某个键，返回true。如果删除失败，返回false。
var m = new Map();
m.set(undefined, "nah");
m.has(undefined)       // true

m.delete(undefined)
m.has(undefined)       // false


// 6）clear()
// clear方法清除所有成员，没有返回值。
var map = new Map();
map.set('foo', true);
map.set('bar', false);

map.size // 2
map.clear()
map.size // 0

/*
    3.3 遍历方法
*/

/*
Map原生提供三个遍历器生成函数和一个遍历方法:
    - keys()：返回键名的遍历器
    - values()：返回键值的遍历器
    - entries()：返回所有成员的遍历器
    - forEach()：遍历Map的所有成员
 */

// e.g
//
let map9 = new Map([
    ['F', 'no'],
    ['T', 'yes'],
]);

for (let key of map9.keys()) {
    console.log(key);
}
// "F"
// "T"

for (let value of map9.values()) {
    console.log(value);
}
// "no"
// "yes"

for (let item of map9.entries()) {
    console.log(item[0], item[1]);
}
// "F" "no"
// "T" "yes"

// 或者
for (let [key, value] of map9.entries()) {
    console.log(key, value);
}

// 等同于使用map.entries()
for (let [key, value] of map9) { // 表示Map结构的默认遍历器接口（Symbol.iterator属性），就是entries方法
    console.log(key, value);
}

map[Symbol.iterator] === map.entries        // true

// Map结构 转为 数组结构，比较快速的方法是结合使用扩展运算符（...）
let mapA = new Map([
    [1, 'one'],
    [2, 'two'],
    [3, 'three'],
]);
[...mapA.keys()];             // [1, 2, 3]
[...mapA.values()];           // ['one', 'two', 'three']
[...mapA.entries()];          // [[1,'one'], [2, 'two'], [3, 'three']]
[...mapA];                    // [[1,'one'], [2, 'two'], [3, 'three']]

// 结合数组的map方法、filter方法，可以实现Map的遍历和过滤（Map本身没有map和filter方法）
//
let map10 = new Map()
    .set(1, 'a')
    .set(2, 'b')
    .set(3, 'c');

let map11 = new Map(
    [...map10].filter(([k, v]) => k < 3)
);
// 产生Map结构 {1 => 'a', 2 => 'b'}

let map12 = new Map(
    [...map10].map(([k, v]) => [k * 2, '_' + v])
);
// 产生Map结构 {2 => '_a', 4 => '_b', 6 => '_c'}

// Map还有一个forEach方法，与数组的forEach方法类似，也可以实现遍历
map10.forEach(function(value, key, map10) {
    console.log("Key: %s, Value: %s", key, value);
});
// Key: 1, Value: a
// Key: 2, Value: b
// Key: 3, Value: c

// forEach方法还可以接受第二个参数，用来绑定this
var reporter = {
    report: function(key, value) {
        console.log("Key: %s, Value: %s", key, value);
    }
};
map10.forEach(function(value, key, map) {
    this.report(key, value);
}, reporter);
// 上面代码中，forEach方法的回调函数的this，就指向reporter


/*
    3.4 与其他数据结构的互相转换
 */

// （1）Map转为数组
let myMap = new Map().set(true, 7).set({foo: 3}, ['abc']);
console.log([...myMap]);   // [ [ true, 7 ], [ { foo: 3 }, [ 'abc' ] ] ]

// 2）数组转为 Map
// 将数组转入Map构造函数，就可以转为Map
new Map([[true, 7], [{foo: 3}, ['abc']]])
// Map {true => 7, Object {foo: 3} => ['abc']}

// （3）Map转为对象
// 如果所有Map的键都是字符串，它可以转为对象。
function strMapToObj(strMap) {
  let obj = Object.create(null);
  for (let [k,v] of strMap) {
    obj[k] = v;
  }
  return obj;
}

let myMap1 = new Map().set('yes', true).set('no', false);
strMapToObj(myMap1)
// { yes: true, no: false }

// （4）对象转为Map
function objToStrMap(obj) {
  let strMap = new Map();
  for (let k of Object.keys(obj)) {
    strMap.set(k, obj[k]);
  }
  return strMap;
}

objToStrMap({yes: true, no: false})
// [ [ 'yes', true ], [ 'no', false ] ]

// 5）Map转为JSON
// 5.1) Map的键名 都是字符串，这时可以选择转为 对象JSON
function strMapToJson(strMap) {
  return JSON.stringify(strMapToObj(strMap));
}

let myMap2 = new Map().set('yes', true).set('no', false);
strMapToJson(myMap2)
// '{"yes":true,"no":false}'

// 5.2) Map的键名 有非字符串，这时可以选择转为 数组JSON
function mapToArrayJson(map) {
  return JSON.stringify([...map]);
}

let myMap3 = new Map().set(true, 7).set({foo: 3}, ['abc']);
mapToArrayJson(myMap3)
// '[[true,7],[{"foo":3},["abc"]]]'

// （6）JSON转为Map
//
// JSON转为Map，正常情况下，所有键名都是字符串
function jsonToStrMap(jsonStr) {
  return objToStrMap(JSON.parse(jsonStr));
}
jsonToStrMap('{"yes":true,"no":false}')
// Map {'yes' => true, 'no' => false}

// 有一种特殊情况，整个JSON就是一个数组，且每个数组成员本身，又是一个有两个成员的数组。这时，它可以一一对应地转为Map。这往往是数组转为JSON的逆操作。
function jsonToMap(jsonStr) {
  return new Map(JSON.parse(jsonStr));
}

jsonToMap('[[true,7],[{"foo":3},["abc"]]]')
// Map {true => 7, Object {foo: 3} => ['abc']}


/**
 * 	4.WeakMap
 */
// WeakMap结构有助于防止内存泄漏
// WeakMap结构与Map结构基本类似，唯一的区别是它只接受 对象作为键名（null除外），不接受其他类型的值作为键名，而且键名所指向的对象，不计入垃圾回收机制。
var map21 = new WeakMap()
// map21.set(1, 2)           // TypeError: 1 is not an object!
// map21.set(Symbol(), 2)    // TypeError: Invalid value used as weak map key

// e.g
/* 操作DOM
var wm = new WeakMap();
var element = document.querySelector(".element");

wm.set(element, "Original");
wm.get(element) // "Original"

element.parentNode.removeChild(element);
element = null;
wm.get(element) // undefined
*/

/*
WeakMap与Map在API上的区别主要是两个:
一是没有遍历操作（即没有key()、values()和entries()方法），也没有size属性；
二是无法清空，即不支持clear方法。
因此，WeakMap只有四个方法可用：get()、set()、has()、delete()。
 */
 var wm = new WeakMap();
 wm.size
 // undefined
 wm.forEach
 // undefined

 // e.g WeakMap应用的典型场合就是DOM节点作为键名。下面是一个例子

 /*
 let myElement = document.getElementById('logo');
 let myWeakmap = new WeakMap();

 myWeakmap.set(myElement, {timesClicked: 0});

 myElement.addEventListener('click', function() {
   let logoData = myWeakmap.get(myElement);
   logoData.timesClicked++;
   myWeakmap.set(myElement, logoData);
 }, false);
*/

// e.g WeakMap的另一个用处是部署私有属性

let _counter = new WeakMap();
let _action = new WeakMap();

class Countdown {
  constructor(counter, action) {
    _counter.set(this, counter);
    _action.set(this, action);
  }
  dec() {
    let counter = _counter.get(this);
    if (counter < 1) return;
    counter--;
    _counter.set(this, counter);
    if (counter === 0) {
      _action.get(this)();
    }
  }
}

let c = new Countdown(2, () => console.log('DONE'));

c.dec()
c.dec()
// DONE

// 上面代码中，Countdown类的两个内部属性_counter和_action，是实例的弱引用，所以如果删除实例，它们也就随之消失，不会造成内存泄漏


/*
Set & Array   Map & Object 的区别 :
http://www.html-js.com/article/JavaScript-random-records-summarizes-the-types-of-set-in-ES6
https://imququ.com/post/set-map-weakmap-in-es6.html

 */
