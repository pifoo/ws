/**
 *	1.属性的简洁表示法
 *	2.属性名表达式
 *	3.方法的name属性
 *	4.Object.is()
 *	5.Object.assign()
 *	6.属性的可枚举性
 *	7.属性的遍历
 *	8.__proto__属性，Object.setPrototypeOf()，Object.getPrototypeOf()
 *	9.Object.values()，Object.entries()
 *	10.对象的扩展运算符
 *	11.Object.getOwnPropertyDescriptors()
 */

/**
 * 	1.属性的简洁表示法
 */

 // ES6允许直接写入变量和函数，作为对象的属性和方法。这样的书写更加简洁
 var foo = 'bar';
 var baz = {foo};
 baz // {foo: "bar"}
 // 等同于
 var baz = {foo: foo};

// 上面代码表明，ES6允许在对象之中，只写属性名，不写属性值。这时，属性值等于属性名所代表的变量
function f(x, y) {
    return {
        x,
        y
    };
}
// 等同于
function f(x, y) {
    return {
        x: x,
        y: y
    };
}
f(1, 2) // Object {x: 1, y: 2}

// 除了属性简写，方法也可以简写
var o = {
    method() {
        return "Hello!";
    }
};
// 等同于
var o = {
    method: function() {
        return "Hello!";
    }
};

// e.g
var birth = '2000/01/01';
var Person = {
    name: '张三',
    //等同于birth: birth
    birth,
    // 等同于hello: function ()...
    hello() {
        console.log('我的名字是', this.name);
    }
};

// e.g 用于函数的返回值，将会非常方便
function getPoint() {
    var x = 1;
    var y = 10;
    return {
        x,
        y
    };
}
getPoint()
// {x:1, y:10}

// e.g CommonJS模块输出变量，就非常合适使用简洁写法
var module = {};
var ms = {};
function getItem(key) {
    return key in ms ? ms[key] : null;
}
function setItem(key, value) {
    ms[key] = value;
}
function clear() {
    ms = {};
}
module.exports = {
    getItem,
    setItem,
    clear
};
// 等同于
module.exports = {
    getItem: getItem,
    setItem: setItem,
    clear: clear
};

// e.g 属性的赋值器（setter）和取值器（getter），事实上也是采用这种写法
var cart = {
    _wheels: 4,
    get wheels() {
        return this._wheels;
    },
    set wheels(value) {
        if (value < this._wheels) {
            throw new Error('数值太小了！');
        }
        this._wheels = value;
    }
}

// 注意，简洁写法的属性名总是字符串，这会导致一些看上去比较奇怪的结果。
var obj = {
    class() {}
};
// 等同于
var obj = {
    'class': function() {}      // class是字符串，所以不会因为它属于关键字，而导致语法解析报错
};

// 如果某个方法的值是一个Generator函数，前面需要加上星号
var obj = { * m() {
        yield 'hello world';
    }
};


/**
 *  2.属性名表达式
 */
// JavaScript语言定义对象的属性，有两种方法。
// 写法一
obj.foo = true;             // 直接用标识符作为属性名
// 写法二
obj['a' + 'bc'] = 123;      // 用表达式作为属性名,将表达式放在方括号之内

// 使用字面量方式定义对象,只能使用写法一
var obj = {
    foo: true,
    abc: 123
};

// ES6
let propKey = 'foo';
let obj = {
    [propKey]: true,
    ['a' + 'bc']: 123
};

/**
 *	3.方法的name属性
 */


/**
 * 	4.Object.is()
 */
// “Same-value equality”（同值相等）算法，用来解决这个问题。Object.is就是部署这个算法的新方法。它用来比较两个值是否严格相等，与严格比较运算符（===）的行为基本一致
Object.is('foo', 'foo');
// true
Object.is({}, {});
// false


/**
 * 	5.Object.assign()
 */
// Object.assign方法用于对象的合并，将源对象（source）的所有可枚举属性，复制到目标对象（target）
var target = { a: 1 };
var source1 = { b: 2 };
var source2 = { c: 3 };
Object.assign(target, source1, source2);
target // {a:1, b:2, c:3}


/**
 * 	6.属性的可枚举性
 */

/**
 * 	7.属性的遍历
 */


/**
 * 	8.__proto__属性，Object.setPrototypeOf()，Object.getPrototypeOf()
 */


/**
 * 	9.Object.values()，Object.entries()
 */


/**
 * 	10.对象的扩展运算符
 */


/**
 * 	11.Object.getOwnPropertyDescriptors()
 */
