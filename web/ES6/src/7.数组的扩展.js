/**
 *	1.Array.from()
 * 	2.Array.of()
 * 	3.数组实例的copyWithin()
 * 	4.数组实例的find()和findIndex()
 * 	5.数组实例的fill()
 * 	6.数组实例的entries()，keys()和values()
 * 	7.数组实例的includes()
 * 	8.数组的空位
 */


/**
 *	1.Array.from()
 */

// Array.from方法用于将两类对象转为真正的数组：

// 传入真正的数组
console.log(Array.from([1, 2, 3]));     // [ 1, 2, 3 ]

// 1.1  类似数组对象（array-like object）
// 所谓类似数组的对象，本质特征只有一点，即必须有length属性
let arrayLike = {
    '0': 'a',
    '1': 'b',
    '2': 'c',
    length: 3
};
// ES5的写法
var arr1 = [].slice.call(arrayLike);
console.log(arr1)                   // ['a', 'b', 'c']
// ES6的写法
let arr2 = Array.from(arrayLike);
console.log(arr2)                   // ['a', 'b', 'c']

/// 常见的类似数组的对象是: DOM操作返回的 NodeList 集合，以及 函数内部的 arguments 对象

// NodeList对象
/*
let ps = document.querySelectorAll('p');

Array.from(ps).forEach(function (p) {
    console.log(p);
});

[...document.querySelectorAll('div')]
*/

// arguments对象
function foo(a = 1, b = 2, c = 3) {
    console.log(arguments);         // { '0': 1, '1': 2, '2': 3 }
    var args1 = Array.from(arguments);
    var args2 = [...arguments]; // 扩展运算符（...）也可以将某些数据结构转为数组
    console.log(args1, args2);              // [ 1, 2, 3 ] [ 1, 2, 3 ]
}
foo(1, 2, 3)

// 1.2  可遍历（iterable）的对象（包括ES6新增的数据结构Set和Map）
//
console.log( Array.from('hello') )  // ['h', 'e', 'l', 'l', 'o']

let namesSet = new Set(['a', 'b'])
console.log([...namesSet]);           // [ 'a', 'b' ]
console.log(namesSet);                // Set { 'a', 'b' }
console.log( Array.from(namesSet))    // ['a', 'b']

// 扩展运算符（...）也可以将某些数据结构转为数组
console.log(...arrayLike);            // a b c

// 任何有length属性的对象，都可以通过Array.from方法转为数组
console.log(Array.from({ length: 3 }));       // [ undefined, undefined, undefined ]
console.log([...{ length: 3}]);               // [ undefined, undefined, undefined ]

// 对于还没有部署该方法的浏览器，可以用Array.prototype.slice方法替代
const toArray = (() =>
    Array.from ? Array.from : obj => [].slice.call(obj)
)();

// Array.from还可以接受第二个参数，作用类似于数组的map方法，用来对每个元素进行处理，将处理后的值放入返回的数组
Array.from(arrayLike, x => x * x);
// 等同于
Array.from(arrayLike).map(x => x * x);
Array.from([1, 2, 3], (x) => x * x)
// [1, 4, 9]


// 下面的例子是取出一组DOM节点的文本内容
/*
let spans = document.querySelectorAll('span.name');
// map()
let names1 = Array.prototype.map.call(spans, s => s.textContent);
// Array.from()
let names2 = Array.from(spans, s => s.textContent)
*/

// e.g 下面的例子将数组中布尔值为false的成员转为0
console.log(Array.from([1, , 2, , 3], (n) => n || 0));  // [1, 0, 2, 0, 3]

// e.g 另一个例子是返回各种数据的类型
function typesOf () {
    return Array.from(arguments, value => typeof value)
}
console.log(typesOf(null, [], NaN));    // ['object', 'object', 'number']

// 如果map函数里面用到了this关键字，还可以传入Array.from的第三个参数，用来绑定this

// Array.from()可以将各种值转为真正的数组，并且还提供map功能。这实际上意味着，只要有一个原始的数据结构，你就可以先对它的值进行处理，然后转成规范的数组结构，进而就可以使用数量众多的数组方法
console.log(Array.from({ length: 2 }, () => 'jack'));
// ['jack', 'jack']

// Array.from()的另一个应用是，将字符串转为数组，然后返回字符串的长度。因为它能正确处理各种Unicode字符，可以避免JavaScript将大于\uFFFF的Unicode字符，算作两个字符的bug。
function countSymbols(string) {
    return Array.from(string).length;
}
console.log(countSymbols("hello"));

/**
 * 	2.Array.of()
 */
// Array.of方法用于将一组值，转换为数组
Array.of(3, 11, 8) // [3,11,8]
Array.of(3)         // [3]
Array.of(3).length // 1
// 这个方法的主要目的，是弥补数组构造函数Array()的不足。因为参数个数的不同，会导致Array()的行为有差异
Array() // []
Array(3) // [, , ,]
Array(3, 11, 8) // [3, 11, 8]

console.log(Array.of());            // []
console.log(Array.of(3));           // [ 3 ]
console.log(Array.of(3,11,8));      // [ 3, 11, 8 ]
console.log(Array.of(undefined));   // undefined

// Array.of方法可以用下面的代码模拟实现
function ArrayOf() {
    return [].slice.call(arguments);
}
console.log(ArrayOf(4,5,5));        // [ 4, 5, 5 ]

/**
 * 	3.数组实例的 copyWithin()
 */
// 数组实例的copyWithin方法，在当前数组内部，将指定位置的成员复制到其他位置（会覆盖原有成员），然后返回当前数组。也就是说，使用这个方法，会修改当前数组
// Array.prototype.copyWithin(target, start = 0, end = this.length);
/*
它接受三个参数:
    - target（必需）：从该位置开始替换数据
    - start（可选）：从该位置开始读取数据，默认为0。如果为负值，表示倒数
    - end（可选）：到该位置前停止读取数据，默认等于数组长度。如果为负值，表示倒数
*/
console.log([1,2,3,4,5].copyWithin(0,3));       // [ 4, 5, 3, 4, 5 ]

// e.g

// 将3号位复制到0号位
[1, 2, 3, 4, 5].copyWithin(0, 3, 4);
// [4, 2, 3, 4, 5]

// -2相当于3号位，-1相当于4号位
[1, 2, 3, 4, 5].copyWithin(0, -2, -1);
// [4, 2, 3, 4, 5]

// 将3号位复制到0号位
[].copyWithin.call({length: 5, 3: 1}, 0, 3);
// {0: 1, 3: 1, length: 5}

// 将2号位到数组结束，复制到0号位
var i32a = new Int32Array([1, 2, 3, 4, 5]);
i32a.copyWithin(0, 2);
// Int32Array [3, 4, 5, 4, 5]

// 对于没有部署TypedArray的copyWithin方法的平台
// 需要采用下面的写法
[].copyWithin.call(new Int32Array([1, 2, 3, 4, 5]), 0, 3, 4);
// Int32Array [4, 2, 3, 4, 5]



/**
 * 	4.数组实例的find()和findIndex()
 */
// 数组实例的 find方法，用于找出第一个符合条件的数组成员。它的参数是一个回调函数，所有数组成员依次执行该回调函数，直到找出第一个返回值为true的  成员，然后返回该成员。如果没有符合条件的成员，则返回undefined
console.log([1, 4, -5, 10].find((n) => n < 0));   // -5

[1, 5, 10, 15].find(function(value, index, arr) {
  return value > 9;
}); // 10

// 数组实例的findIndex方法的用法与find方法非常类似，返回第一个符合条件的数组 成员 的 位置，如果所有成员都不符合条件，则返回-1
[1, 5, 10, 15].findIndex(function(value, index, arr) {
    return value > 9;
}); // 2

// 这两个方法都可以接受第二个参数，用来绑定回调函数的this对象。

// 另外，这两个方法都可以发现NaN，弥补了数组的IndexOf方法的不足。

[NaN].indexOf(NaN);
// -1

[NaN].findIndex(y => Object.is(NaN, y));
// 0
//上面代码中，indexOf方法无法识别数组的NaN成员，但是findIndex方法可以借助Object.is方法做到


/**
 * 	5.数组实例的fill()
 */
// fill方法使用给定值，填充一个数组
['a', 'b', 'c'].fill(7);
// [7, 7, 7]

new Array(3).fill(7);
// [7, 7, 7]
// 上面代码表明，fill方法用于空数组的初始化非常方便。数组中已有的元素，会被全部抹去。

// fill方法还可以接受第二个和第三个参数，用于指定填充的起始位置和结束位置。
['a', 'b', 'c'].fill(7, 1, 2);
// ['a', 7, 'c']
//上面代码表示，fill方法从1号位开始，向原数组填充7，到2号位之前结束


/**
 * 	6.数组实例的 entries()，keys()和 values()
 */
// entries()，keys()和values()——用于遍历数组 ,返回一个遍历器对象
// 可以用for...of循环进行遍历
//
for (let index of['a', 'b'].keys()) { // keys()是对键名的遍历
    console.log(index);
}
// 0
// 1

for (let elem of['a', 'b'].values()) {// values()是对键值的遍历
    console.log(elem);
}
// 'a'
// 'b'

for (let [index, elem] of['a', 'b'].entries()) {// entries()是对键值对的遍历
    console.log(index, elem);
}
// 0 "a"
// 1 "b"


// 不使用for...of循环，可以手动调用遍历器对象的next方法，进行遍历

let letter = ['a', 'b', 'c'];
let entries = letter.entries();
console.log(entries.next().value); // [0, 'a']
console.log(entries.next().value); // [1, 'b']
console.log(entries.next().value); // [2, 'c']



/**
 * 	7.数组实例的 includes()
 */
// 表示某个数组是否包含给定的值
[1, 2, 3].includes(2);     // true
[1, 2, 3].includes(4);     // false
[1, 2, NaN].includes(NaN); // true

// 该方法的第二个参数表示搜索的起始位置，默认为0。如果第二个参数为负数，则表示倒数的位置，如果这时它大于数组长度（比如第二个参数为-4，但数组长度为3），则会重置为从0开始
[1, 2, 3].includes(3, 3);  // false
[1, 2, 3].includes(3, -1); // true

// 没有该方法之前，我们通常使用数组的indexOf方法，检查是否包含某个值
if (arr1.indexOf(1) !== -1) {
  // ...
}
// indexOf() 存在一些不足
console.log([NaN].indexOf(NaN));
// -1

console.log([NaN].includes(NaN));
// true


// 下面代码用来检查当前环境是否支持该方法，如果不支持，部署一个简易的替代版本。

const contains = (() =>
    Array.prototype.includes ? (arr, value) => arr.includes(value) : (arr, value) => arr.some(el => el === value)
)();
console.log(contains(["foo", "bar"], "baz")); // false


/*
Map和Set数据结构有一个has方法，需要注意与includes区分
    - Map结构的has方法，是用来查找键名的，比如Map.prototype.has(key)、WeakMap.prototype.has(key)、Reflect.has(target, propertyKey)
    - Set结构的has方法，是用来查找值的，比如Set.prototype.has(value)、WeakSet.prototype.has(value)
*/


/**
 * 	8.数组的空位
 */
// 数组的空位指，数组的某一个位置没有任何值。比如，Array构造函数返回的数组都是空位
Array(3);    // [, , ,]

// 注意，空位不是undefined，一个位置的值等于undefined，依然是有值的。空位是没有任何值，in运算符可以说明这一点 (in操作符用来判断某个属性属于某个对象)
0 in [undefined, undefined, undefined];  // true
0 in [, , ,];                            // false
// 上面代码说明，第一个数组的0号位置是有值的，第二个数组的0号位置没有值

/*
ES5对空位的处理，已经很不一致了，大多数情况下会忽略空位
    - forEach(), filter(), every() 和some()都会跳过空位
    - map()会跳过空位，但会保留这个值
    - join()和toString()会将空位视为undefined，而undefined和null会被处理成空字符串
 */
 // forEach方法
 [,'a'].forEach((x,i) => i); // 1

 // filter方法
 ['a',,'b'].filter(x => true); // ['a','b']

 // every方法
 [,'a'].every(x => x==='a'); // true

 // some方法
 [,'a'].some(x => x !== 'a'); // false

 // map方法
 [,'a'].map(x => 1); // [,1]

 // join方法
 [,'a',undefined,null].join('#'); // "#a##"

 // toString方法
 [,'a',undefined,null].toString(); // ",a,,"

/*
ES6则是明确将空位转为undefined
Array.from方法会将数组的空位，转为undefined，也就是说，这个方法不会忽略空位
*/
Array.from(['a',,'b']);
// [ "a", undefined, "b" ]

//  扩展运算符（...）也会将空位转为undefined。
[...['a',,'b']];
// [ "a", undefined, "b" ]

// copyWithin()会连空位一起拷贝。
[,'a','b',,].copyWithin(2,0); // [,"a",,"a"]

// fill()会将空位视为正常的数组位置。
new Array(3).fill('a'); // ["a","a","a"]

// for...of循环也会遍历空位
let arr = [, ,];
for (let i of arr) {
    console.log(1);
}
// 1
// 1


/*
上面代码中，数组arr有两个空位，for...of并没有忽略它们。如果改成map方法遍历，空位是会跳过的;
entries()、keys()、values()、find()和findIndex()会将空位处理成undefined
 */

// entries()
[...[,'a'].entries()];       // [[0,undefined], [1,"a"]]

// keys()
[...[,'a'].keys()];          // [0,1]

// values()
[...[,'a'].values()];        // [undefined,"a"]

// find()
[,'a'].find(x => true);      // undefined

// findIndex()
[,'a'].findIndex(x => true);         // 0

// 由于空位的处理规则非常不统一，所以建议避免出现空位
