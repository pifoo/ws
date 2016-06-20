/**
 * 	1. Proxy概述
 * 	2. Proxy实例的方法
 * 	3. Proxy.revocable()
 * 	4. Reflect概述
 * 	5. Reflect对象的方法
 */

/**
 * 	1. Proxy概述
 */
// Proxy用于修改某些操作的默认行为，等同于在语言层面做出修改，所以属于一种“元编程”（meta programming），即对编程语言进行编程
// 下面代码对一个空对象架设了一层拦截，重定义了属性的读取（get）和设置（set）行为
var obj = new Proxy({}, {
    get: function(target, key, receiver) {
        console.log(`getting ${key}!`);
        return Reflect.get(target, key, receiver);
    },
    set: function(target, key, value, receiver) {
        console.log(`setting ${key}!`);
        return Reflect.set(target, key, value, receiver);
    }
});
obj.count = 1;
// setting count!
console.log(++obj.count);
//  getting count!
//  setting count!
//  2
// 上面代码说明，Proxy实际上重载（overload）了点运算符，即用自己的定义覆盖了语言的原始定义。

// e.g 下面是另一个拦截读取属性行为的例子
var proxy1 = new Proxy({}, {
    get: function(target, property) { // 参数：目标对象，所要访问的属性
        return 35;
    }
});
console.log(proxy1.time);  // 35
console.log(proxy1.name);  // 35
console.log(proxy1.title); // 35

// ES6原生提供Proxy构造函数，用来生成Proxy实例
var target = {};
var handler = {}; //handler没有设置任何拦截，那就等同于直接通向原对象
var proxy = new Proxy(target, handler);
// target: 参数表示所要拦截的目标对象;   handler: 参数也是一个对象，用来定制拦截行为
proxy.a = 'b';
target.a // "b"
// 上面代码中，handler是一个空对象，没有任何拦截效果，访问handeler就等同于访问target

// 一个技巧是将Proxy对象，设置到object.proxy属性，从而可以在object对象上调用
var object = { proxy: new Proxy(target, handler) };

// Proxy实例也可以作为其他对象的原型对象。
var proxy1 = new Proxy({}, {
    get: function(target, property) {
        return 36;
    }
});
let obj1 = Object.create(proxy1);
console.log(obj1.time);       // 36

// 同一个拦截器函数，可以设置拦截多个操作
var handler = {
    get: function(target, name) {
        if (name === 'prototype') return Object.prototype;
        return 'Hello, ' + name;
    },
    apply: function(target, thisBinding, args) {
        return args[0];
    },
    construct: function(target, args) {
        return args[1];
    }
};
var fproxy = new Proxy(function(x, y) {
    return x + y;
}, handler);

fproxy(1, 2); // 1
//new fproxy(1, 2); // 2
fproxy.prototype; // Object.prototype
fproxy.foo; // 'Hello, foo'



/**
 * 	2. Proxy实例的方法
 */

/**
 * 	3. Proxy.revocable()
 */

/**
 *  4. Reflect概述
 */

/**
 * 	5. Reflect对象的方法
 */
