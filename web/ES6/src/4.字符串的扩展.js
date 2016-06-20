/*
 *  1.字符的Unicode表示法
 *  2.codePointAt()
 *  3.String.fromCodePoint()
 *  4.字符串的遍历器接口
 *  5.at()
 *  6.normalize()
 *  7.includes(), startsWith(), endsWith()
 *  8.repeat()
 *  9.padStart()，padEnd()
 *  10.模板字符串
 *  11.实例：模板编译
 *  12.标签模板
 *  13.String.raw()
 */

// ES6加强了对Unicode的支持，并且扩展了字符串对象

/*
 *  1.字符的Unicode表示法
 */

// JavaScript允许采用\uxxxx形式表示一个字符，其中“xxxx”表示字符的码点
console.log("\u0061");                          // a
// 这种表示法只限于\u0000——\uFFFF之间的字符。超出这个范围的字符，必须用两个双字节的形式表达 :
console.log("\uD842\uDFB7")                     // 𠮷
console.log("\u20BB7")                          // ₻7    \u20BB+7  由于\u20BB是一个不可打印字符，所以只会显示一个空格，后面跟着一个7

// ES6对这一点做出了改进，只要将码点放入 大括号，就能正确解读该字符
//
console.log("\u{20BB7}");                       // 𠮷
console.log("\u{41}\u{42}\u{43}");              // ABC
console.log("\u{1F496}");                       // 💖

let hello = 123;
console.log( hell\u{6F} );                      // 123
console.log("\u{6F}");                          // o
'\u{1F680}' === '\uD83D\uDE80'                  // true   大括号表示法与四字节的UTF-16编码是等价的

// 由此，JavaScript共有6种方法可以表示一个字符
console.log('\z' === 'z');                      // true
// console.log('\172' === 'z');   // chrome: true,  babel: SyntaxError:Octal literal in strict mode
console.log('\x7A' === 'z');                    // true
console.log('\u007A' === 'z');                  // true
console.log('\u{7A}' === 'z');                  // true


/*
 *  2.codePointAt()   返回32位的UTF-16字符的码点(十进制)
 */
 // JavaScript内部，字符以UTF-16的格式储存，每个字符固定为2个字节。对于那些需要4个字节储存的字符（Unicode码点大于0xFFFF的字符），JavaScript会认为它们是两个字符
var s = "𠮷";

console.log(s.length);              // 2
console.log(s.charAt(0));           // �
console.log(s.charAt(1));           // �
console.log(s.charCodeAt(0));       // 55362
console.log(s.charCodeAt(1));       // 57271
// 汉字“𠮷”的码点是0x20BB7，UTF-16编码为0xD842 0xDFB7（十进制为55362 57271），需要4个字节储存。对于这种 4个字节 的字符，JavaScript不能正确处理，字符串长度会误判为2，而且charAt方法无法读取整个字符，charCodeAt方法只能分别返回 前两个字节 和 后两个字节 的值

// ES6提供了 codePointAt 方法，能够正确处理 4个字节 储存的字符，返回一个 十进制 字符的码点
var s1 = "𠮷a"; // JavaScript将“𠮷a”视为三个字符
console.log(s1.codePointAt(0));      // 134071   第一个字符 "𠮷"的前两个字节的十进制码点
console.log(s1.codePointAt(1));      // 57271    第二个字符“𠮷”的后两个字节的十进制码点

console.log(s1.charCodeAt(2));       // 97   codePointAt方法的结果与charCodeAt方法相同
console.log(s1.charAt(2));           // a
console.log(s1.charCodeAt(2));       // 97 存储空间占两字节的值 与 codePointAt的结果相同

// 转成16进制
console.log(s1.codePointAt(0).toString(16));      // 20bb7

// 但是：字符a在字符串s的正确位置序号应该是1，但是必须向charCodeAt方法传入2。解决这个问题的一个办法是使用for...of循环，因为它会正确识别32位的UTF-16字符
for(let ch of s1){
    console.log(ch.codePointAt(0).toString(16));
}
// 20bb7
// 61

// codePointAt方法测试一个字符由 两个字节 还是 由四个字节组成:
function is32Bit(c) {
  return c.codePointAt(0) > 0xFFFF;
}
console.log(is32Bit('中'));          // false    //TODO
console.log(is32Bit('a'));           // false


/*
 *  3. String.fromCodePoint()       从码点返回对应字符
 */
// ES5
console.log(String.fromCharCode(0x007A));       // z
console.log(String.fromCharCode(0x20BB7));  // ஷ  // 根据码点返回对应字符（Unicode编号小于0xFFFF）

// ES6
console.log(String.fromCodePoint(0x20BB7));     // 𠮷

// String.fromCharCode 方法有多个参数，则它们会被合并成一个字符串返回
console.log(String.fromCodePoint(0x78, 0x1f680, 0x79) === 'x\uD83D\uDE80y'); //true
console.log(String.fromCodePoint(0x78, 0x1f680, 0x79)); // x🚀y
console.log('x\uD83D\uDE80y');                          // x🚀y

/*
    fromCodePoint & codePointAt 区别：
    fromCodePoint方法定义在 String 对象上，而 codePointAt 方法定义在 字符串的实例 对象上
 */


/*
 *  4. 字符串的遍历器接口
 */
for (let codePoint of 'foo') {
    console.log(codePoint)
}

// for...of 可识别大于0xFFFF的码点，传统的for则不行
var text = String.fromCodePoint(0x20BB7);

for (let i = 0; i < text.length; i++) {
    console.log(text[i]);
}// 无法正确识别
// �
// �

for (let i of text) {
    console.log(i);
}                                    // "𠮷"


/*
 *  5.at()   字符串给定位置的字符,包括码点大于0xFFFF的字符
 */

 // ES5对字符串对象提供charAt方法，返回字符串给定位置的字符。该方法不能识别码点大于0xFFFF的字符。
console.log('abc'.charAt(0))       // "a"
console.log('𠮷'.charAt(0))        // �

console.log('abc'.at(0))           // "a"
console.log('𠮷'.at(0))            // "𠮷"



/*
 *  6.normalize()       将字符的不同表示方法统一为同样的形式
 */
console.log('\u01D1');                  // Ǒ
// 为了表示语调和重音符号，Unicode提供了两种方法。一种 是直接提供带重音符号的字符，比如Ǒ（\u01D1）。另一种 是提供 合成符号（combining character），即原字符与重音符号的合成，两个字符合成一个字符，比如O（\u004F）和ˇ（\u030C）合成Ǒ（\u004F\u030C）
console.log('\u004F\u030C');            // Ǒ

// 此两种表示方法，在视觉和语义上都等价，但是JavaScript不能识别
console.log('\u01D1'==='\u004F\u030C');     // false

// ES6 提供 字符串实例的 normalize() 方法, 将字符的不同表示方法统一为同样的形式，这称为Unicode正规化
console.log('\u01D1'.normalize() === '\u004F\u030C'.normalize());  // true
console.log('\u01D1'.normalize());
console.log('\u004F\u030C'.normalize());

/*
normalize方法可以接受四个参数:
    - NFC，默认参数，表示“标准等价合成”（Normalization Form Canonical Composition），
    返回多个简单字符的合成字符。所谓“标准等价”指的是视觉和语义上的等价。
    - NFD，表示“标准等价分解”（Normalization Form Canonical Decomposition），即在标准等价的前提下，返回合成字符分解的多个简单字符。
    - NFKC，表示“兼容等价合成”（Normalization Form Compatibility Composition），返回合成字符。所谓“兼容等价”指的是语义上存在等价，但视觉上不等价，比如“囍”和“喜喜”。（这只是用来举例，normalize方法不能识别中文。）
    - NFKD，表示“兼容等价分解”（Normalization Form Compatibility Decomposition），即在兼容等价的前提下，返回合成字符分解的多个简单字符。
 */

'\u004F\u030C'.normalize('NFC').length      // 1   NFC参数返回字符的合成形式
'\u004F\u030C'.normalize('NFD').length      // 2   NFD参数返回字符的分解形式

/*
    注：
    normalize方法目前不能识别三个或三个以上字符的合成。这种情况下，还是只能使用正则表达式，通过Unicode编号区间判断
 */


/*
 *  7.
 *  includes()          返回布尔值，表示是否找到了参数字符串
 *  startsWith()        返回布尔值，表示参数字符串是否在源字符串的头部
 *  endsWith()          返回布尔值，表示参数字符串是否在源字符串的尾部
 */
// JavaScript只有indexOf方法，可以用来确定一个字符串是否包含在另一个字符串中

var s = 'Hello world!';

s.startsWith('world', 6)    // true
s.endsWith('Hello', 5)      // true
s.includes('Hello', 6)      // false

// 这三个方法都支持第二个参数，表示开始搜索的位置
s.startsWith('world', 6)    // true
s.endsWith('Hello', 5)      // true   前n个字符...
s.includes('Hello', 6)      // false


/*
 *  8.repeat()          方法返回一个新字符串，表示将原字符串重复n次
 */
console.log('x'.repeat(3));         // xxx
console.log('hello'.repeat(2));     // "hellohello");
console.log('na'.repeat(0));        // ""

// repeat的 参数 是 负数 或者 Infinity，会报错
// console.log('na'.repeat(Infinity)); // RangeError
// console.log('na'.repeat(-1));       // RangeError

// 参数 是 0到-1 之间的小数，则等同于0，这是因为会先进行取整运算。0到-1之间的小数，取整以后等于-0，repeat视同为0
console.log('na'.repeat(-0.9));        // ""

// 参数 NaN 等同于0
console.log('na'.repeat(NaN))          // ""

// 参数 是 字符串，则会先 转换成 数字
console.log('na'.repeat('na'));         // ""
console.log('na'.repeat('3'));          // "nanana"

/*
 *  9.padStart()，padEnd()    字符串补全长度的功能(ES7)
 */

// 用于头部补全
console.log('x'.padStart(5, 'ab'));         // 'ababx'
console.log('x'.padStart(4, 'ab'));         // 'abax'

// 用于尾部补全
console.log('x'.padEnd(5, 'ab'));           // 'xabab'
console.log('x'.padEnd(4, 'ab'));           // 'xaba'

// 字符串的长度，等于 或 大于 指定的最小长度，则返回原字符串
console.log('xxx'.padStart(2, 'ab'));       // 'xxx'
console.log('xxx'.padEnd(2, 'ab'));         // 'xxx'

// 用来补全的字符串与原字符串，两者的长度之和超过了指定的最小长度，则会截去超出位数的补全字符串
console.log('abc'.padStart(10, '0123456789'));      // 0123456abc

// 省略第二个参数，则会用空格补全长度
console.log('str'.padStart(6));               // '   str'
console.log('str'.padEnd(6));                 // 'str   '

// e.g 用途1:是为数值补全指定位数; 下面代码生成10位的数值字符串。
'1'.padStart(10, '0');                   // "0000000001"
'12'.padStart(10, '0');                  // "0000000012"
'123456'.padStart(10, '0');              // "0000123456"

// e.g 用途2：提示字符串格式
console.log('12'.padStart(10, 'YYYY-MM-DD')); // "YYYY-MM-12"
console.log('09-12'.padStart(10, 'YYYY-MM-DD')); // "YYYY-09-12"


/*
 *  10.模板字符串   模板字符串（template string）是增强版的字符串，用反引号（`）标识
 */

// 传统方式JavaScript处理模板：
/*
$("#result").append(
    "There are <b>" + basket.count + "</b> " +
    "items in your basket, " +
    "<em>" + basket.onSale +
    "</em> are on sale!"
);
*/

// 上面这种写法相当繁琐不方便，ES6引入了模板字符串解决这个问题
/*
$("#result").append(`
    There are <b>${basket.count}</b> items
    in your basket, <em>${basket.onSale}</em>
    are on sale!
`);
*/

// (`）可以当作普通字符串使用，也可以用来定义多行字符串，或者在字符串中嵌入变量

// 普通字符串
`In JavaScript '\n' is a line-feed.`;

// 多行字符串
`In JavaScript this is
 not legal.`;

console.log(`string text line 1
string text line 2`);

// 字符串中嵌入变量 ${}
var name = "Bob", time = "today";
console.log(`Hello ${name}, how are you ${time}?`); // Hello Bob, how are you today?

console.log(`\`Yo\` World!`);           // `Yo` World!

// 使用模板字符串表示多行字符串，所有的 空格 和 缩进 都会被保留在输出之中
/*
$("#warning").html(`
    <h1>Watch out!</h1>
    <p>Unauthorized hockeying can result in penalties
    of up to ${maxPenalty} minutes.</p>
`);
*/

// {}大括号内部可以放入任意的JavaScript表达式，可以进行运算，以及引用对象属性
var x1 = 1;
var y1 = 2;
console.log(`${x1} + ${y1} = ${x1 + y1}`);          // "1 + 2 = 3"
console.log(`${x1} + ${y1 * 2} = ${x1 + y1 * 2}`);  // "1 + 4 = 5"
var obj = {x1: 1, y1: 2};
console.log(`${obj.x1 + obj.y1}`);                  // 3

// 模板字符串之中调用函数。

function fn() {
    return "Hello World";
}
console.log(`foo ${fn()} bar`);             // foo Hello World bar

// 引用模板字符串本身，在需要时执行

// 写法一
let str1 = 'return ' + '`Hello ${name}!`';
let func1 = new Function('name', str1);
func1('Jack') // "Hello Jack!"

// 写法二
let str2 = '(name) => `Hello ${name}!`';
let func2 = eval.call(null, str2);
func2('Jack') // "Hello Jack!"


/*
 *  11.实例：模板编译
 */





/*
 *  12.标签模板
 */
// 模板字符串 可以紧跟在一个 函数名 后面，该函数将被调用来处理这个模板字符串
// 标签模板其实不是模板，而是函数调用的一种特殊形式。“标签”指的就是函数，紧跟在后面的模板字符串就是它的参数
/*
    alert`123`
    // 等同于
    alert(123)
*/
//    tag函数的 第一个参数 是 一个数组, 该数组的成员是模板字符串中那些没有变量替换的部分
var a1 = 5;
var b1 = 10;
function tag(stringArr, value1, value2){
    console.log(stringArr);
    console.log(value1, value2);
}
tag`Hello ${ a1 + b1 } world ${ a1 * b1 }`;
// [ 'Hello ', ' world ', '' ]
// 15 50

// 等同于
/*
function tag(stringArr, ...values){
  // ...
}
*/
// 等同于以下方式的调用
tag(['Hello ', ' world ', ''], 15, 50)

// e.g
var a2 = 5;
var b2 = 10;
function tag(s, v1, v2) {
    console.log(s[0]);
    console.log(s[1]);
    console.log(s[2]);
    console.log(v1);
    console.log(v2);

    return "OK";
}
console.log(tag`Hello ${ a2 + b2 } world ${ a2 * b2}`);
// "Hello "
// " world "
// ""
// 15
// 50
// "OK"



/*
 *  13.String.raw()         // 用来充当模板字符串的处理函数
 *  返回一个斜杠都被转义（即斜杠前面再加一个斜杠）的字符串，对应于替换变量后的模板字符串
 */
console.log(String.raw`Hi\n${2+3}!`);       // Hi\n5!
console.log(String.raw`Hi\u000A!`);         // Hi\u000A!


// String.raw的代码基本如下

String.raw = function (strings, ...values) {
    var output = "";
    for (var index = 0; index < values.length; index++) {
    output += strings.raw[index] + values[index];
    }

    output += strings.raw[index]
    return output;
}

// 它的第一个参数，应该是一个具有raw属性的对象，且raw属性的值应该是一个数组
String.raw({ raw: 'test' }, 0, 1, 2);
// 't0e1s2t'

// 等同于
String.raw({ raw: ['t','e','s','t'] }, 0, 1, 2);
