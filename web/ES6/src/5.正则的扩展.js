/**
 *	1. RegExp构造函数
 *	2. 字符串的正则方法
 *	3. u修饰符
 *	4. y修饰符
 *	5. sticky属性
 *	6. flags属性
 *	7. RegExp.escape()
 *	8. 后行断言
 */

/**
 *	1. RegExp构造函数
 */
// ES5中，RegExp构造函数的参数有两种情况
// 1) 参数1是字符串，这时第二个参数表示正则表达式的修饰符（flag）
var regex = new RegExp('xyz', 'i');
// 等价于
var regex = /xyz/i;
// 2) 参数1是一个正则表示式，这时会返回一个原有正则表达式的拷贝
var regex = new RegExp(/xyz/i);
// 等价于
var regex = /xyz/i;

// 若参数1是一个正则表示式， ES5不允许此时使用第二个参数，添加修饰符，否则会报错
var regex = new RegExp(/xyz/, 'i');

// ES6改变了这种行为。如果RegExp构造函数第一个参数是一个正则对象，那么可以使用第二个参数指定修饰符。而且，返回的正则表达式会忽略原有的正则表达式的修饰符，只使用新指定的修饰符
new RegExp(/abc/ig, 'i').flags
// 上面代码中，原有正则对象的修饰符是ig，它会被第二个参数i覆盖
console.log(new RegExp(/abc/ig, 'i').flags);        // i


/**
 *	2. 字符串的正则方法
 */
// 字符串对象共有4个方法,可以使用正则表达式：match()、replace()、search() 和 split()

// ES6将这4个方法，在语言内部全部调用RegExp的实例方法，从而做到所有与正则相关的方法，全都定义在RegExp对象上。
/*
    - String.prototype.match 调用 RegExp.prototype[Symbol.match]
    - String.prototype.replace 调用 RegExp.prototype[Symbol.replace]
    - String.prototype.search 调用 RegExp.prototype[Symbol.search]
    - String.prototype.split 调用 RegExp.prototype[Symbol.split]
*/


/**
 *	3. u修饰符
 */
// u修饰符，含义为“Unicode模式”，用来正确处理大于\uFFFF的Unicode字符。也就是说，会正确处理四个字节的UTF-16编码
console.log(/^\uD83D/u.test('\uD83D\uDC2A'));   // false
console.log(/^\uD83D/.test('\uD83D\uDC2A'));    // true

//  1）点字符
// 点（.）字符在正则表达式中，含义是除了 换行符 以外的 任意单个字符。对于码点大于0xFFFF的Unicode字符，点字符不能识别，必须加上u修饰符
var s = '𠮷';
console.log(/^.$/.test(s));         // false
console.log(/^.$/u.test(s));        // true

// 2）Unicode字符表示法
// ES6新增了使用大括号表示Unicode字符，这种表示法在正则表达式中必须加上u修饰符，才能识别
/\u{61}/.test('a');      // false
/\u{61}/u.test('a');     // true
/\u{20BB7}/u.test('𠮷'); // true

// 3）量词
// 使用u修饰符后，所有量词都会正确识别大于码点大于0xFFFF的Unicode字符
/a{2}/.test('aa');       // true
/a{2}/u.test('aa');      // true
/𠮷{2}/.test('𠮷𠮷');     // false
/𠮷{2}/u.test('𠮷𠮷');    // true

// 只有在使用u修饰符的情况下，Unicode表达式当中的大括号才会被正确解读，否则会被解读为量词
/^\u{3}$/.test('uuu'); // true

//  4）预定义模式
// u修饰符也影响到预定义模式，能否正确识别码点大于0xFFFF的Unicode字符
/^\S$/.test('𠮷');   // false
/^\S$/u.test('𠮷');  // true
// 上面代码的 \S 是预定义模式，匹配所有不是空格的字符。只有加了u修饰符，它才能正确匹配码点大于0xFFFF的Unicode字符。

// 利用这一点，可以写出一个正确返回字符串长度的函数
function codePointLength(text) {
    var result = text.match(/[\s\S]/gu);
    return result ? result.length : 0;
}
var s = '𠮷𠮷';
s.length;                // 4
codePointLength(s);       // 2

// 5）i修饰符
// 有些Unicode字符的编码不同，但是字型很相近，比如，\u004B与\u212A都是大写的K
/[a-z]/i.test('\u212A');         // false
/[a-z]/iu.test('\u212A');        // true
// 上面代码中，不加u修饰符，就无法识别非规范的K字符

/**
 *	4. y修饰符
 */
// y 修饰符，叫做“粘连”（sticky）修饰符
// y修饰符的作用与g修饰符类似，也是全局匹配，后一次匹配都从上一次匹配成功的下一个位置开始
// 不同之处在于，g修饰符只要剩余位置中存在匹配就可，而y修饰符确保匹配必须从剩余的第一个位置开始，这也就是“粘连”的涵义
var s = 'aaa_aa_a';
var r1 = /a+/g;
var r2 = /a+/y;

console.log(r1.exec(s));        // [ 'aaa', index: 0, input: 'aaa_aa_a' ]
console.log(r2.exec(s));        // [ 'aaa', index: 0, input: 'aaa_aa_a' ]

console.log(r1.exec(s));        // [ 'aa', index: 4, input: 'aaa_aa_a' ]
console.log(r2.exec(s));        // null

// 下面代码每次匹配，都是从剩余字符串的头部开始
var s = 'aaa_aa_a';
var r = /a+_/y;
r.exec(s); // ["aaa_"]
r.exec(s); // ["aa_"]

// 使用lastIndex属性，可以更好地说明y修饰符
//
const REGEX = /a/g;

// 指定从2号位置（y）开始匹配
REGEX.lastIndex = 2;

// 匹配成功
const match = REGEX.exec('xaya');

// 在3号位置匹配成功
match.index; // 3

// 下一次匹配从4号位开始
REGEX.lastIndex; // 4

// 4号位开始匹配失败
REGEX.exec('xaxa'); // null

// 上面代码中，lastIndex属性指定每次搜索的开始位置，g修饰符从这个位置开始向后搜索，直到发现匹配为止// y 修饰符同样遵守lastIndex属性，但是要求必须在lastIndex指定的位置发现匹配。

/*
const REGEX = /a/y;

// 指定从2号位置开始匹配
REGEX.lastIndex = 2;

// 不是粘连，匹配失败
REGEX.exec('xaya'); // null

// 指定从3号位置开始匹配
REGEX.lastIndex = 3;

// 3号位置是粘连，匹配成功
const match = REGEX.exec('xaxa');
match.index;     // 3
REGEX.lastIndex; // 4

// 进一步说，y修饰符号隐含了头部匹配的标志^。

/b/y.exec('aba');
// null

*/

/*
*************** 未完待续
 */





/**
 *	5. sticky属性
 */

 // 与y修饰符相匹配，ES6的正则对象多了sticky属性，表示是否设置了y修饰符
 var r = /hello\d/y;
 console.log(r.sticky);                 // true



/**
 *	6. flags属性
 */

// flags属性，会返回正则表达式的修饰符

// ES5的source属性
// 返回正则表达式的正文
console.log(/abc/ig.source);            // "abc"

// ES6的flags属性
// 返回正则表达式的修饰符
console.log(/abc/ig.flags);             // 'gi'


/**
 *	7. RegExp.escape()
 */

// 字符串必须转义，才能作为正则模式
function escapeRegExp(str) {
    return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, '\\$&');
}
let str = '/path/to/resource.html?search=query';
console.log(escapeRegExp(str));     // \/path\/to\/resource\.html\?search=query

// ES7未采纳: RegExp.escape()
//
console.log(RegExp.escape('The Quick Brown Fox'));
// "The Quick Brown Fox"
console.log(RegExp.escape('Buy it. use it. break it. fix it.'));
// "Buy it\. use it\. break it\. fix it\."
console.log(RegExp.escape('(*.*)'));
// "\(\*\.\*\)"

// 字符串转义以后，可以使用 RegExp 构造函数生成正则模式
/*
    var str1 = 'hello. how are you?';
    var regex = new RegExp(RegExp.escape(str1), 'g');
    assert.equal(String(regex), '/hello\. how are you\?/g');
    // 目前，该方法可以用上文的escapeRegExp函数或者垫片模块regexp.escape实现。
    var escape = require('regexp.escape');
    escape('hi. how are you?');
    // "hi\\. how are you\\?"
*/


/**
 * 	8. 后行断言
 */
// JavaScript语言的正则表达式，只支持先行断言（lookahead）和先行否定断言（negative lookahead），不支持后行断言（lookbehind）和后行否定断言（negative lookbehind

// 先行断言 x只有在y前面才匹配，必须写成/x(?=y)/；比如，只匹配百分号之前的数字，要写成/\d+(?=%)/。”先行否定断言“指的是，x只有不在y前面才匹配，必须写成/x(?!y)/。比如，只匹配不在百分号之前的数字，要写成/\d+(?!%)/
/\d+(?=%)/.exec('100% of US presidents have been male');  // ["100"] ”先行断言“括号之中的部分（(?=%)），是不计入返回结果的
/\d+(?!%)/.exec('that’s all 44 of them');                 // ["44"]

// ES7 开始支持后行断言
// "后行断言"正好与"先行断言"相反，x只有在y后面才匹配，必须写成/(?<=y)x/。比如，只匹配美元符号之后的数字，要写成/(?<=\$)\d+/。”后行否定断言“则与”先行否定断言“相反，x只有不在y后面才匹配，必须写成/(?<!y)x/。比如，只匹配不在美元符号后面的数字，要写成/(?<!\$)\d+/
//
// /(?<=\$)\d+/.exec('Benjamin Franklin is on the $100 bill');  // ["100"]  "后行断言"的括号之中的部分（(?<=\$)），也是不计入返回结果
//
// /(?<!\$)\d+/.exec('it’s is worth about €90');                // ["90"]

// ”后行断言“的组匹配，与正常情况下结果是不一样的。
// /(?<=(\d+)(\d+))$/.exec('1053');         // ["", "1", "053"]
// /^(\d+)(\d+)$/.exec('1053');             // ["1053", "105", "3"]

// "后行断言"的反斜杠引用，也与通常的顺序相反，必须放在对应的那个括号之前
// /(?<=(o)d\1)r/.exec('hodor');            // null
// /(?<=\1d(o))r/.exec('hodor');            // ["r", "o"]
