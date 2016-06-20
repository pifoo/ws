/**
 * 	1. Promise的含义
 * 	2. 基本用法
 * 	3. Promise.prototype.then()
 * 	4. Promise.prototype.catch()
 * 	5. Promise.all()
 * 	6. Promise.race()
 * 	7. Promise.resolve()
 * 	8. Promise.reject()
 * 	9. 两个有用的附加方法
 * 	10. 应用
 * 	11. async函数
 */

/**
 *	1. Promise的含义
 */
// Promise是异步编程的一种解决方案，比传统的解决方案——回调函数和事件——更合理和更强大
// 所谓Promise，简单说就是一个容器，里面保存着某个未来才会结束的事件（通常是一个异步操作）的结果
// 从语法上说，Promise是一个对象，从它可以获取异步操作的消息。Promise提供统一的API，各种异步操作都可以用同样的方法进行处理

// Promise对象有以下两个特点
// 1）对象的状态不受外界影响
//      Promise对象代表一个异步操作，有三种状态：Pending（进行中）、Resolved（已完成，又称Fulfilled）和Rejected（已失败）
// 2）一旦状态改变，就不会再变，任何时候都可以得到这个结果
//      Promise对象的状态改变，只有两种可能：从Pending变为Resolved和从Pending变为Rejected


/**
 *	2. 基本用法
 */
// ES6规定，Promise对象是一个构造函数，用来生成Promise实例
// 下面代码创造了一个Promise实例
var promise = new Promise(function(resolve, reject) {
    // ... some code

    if (true /* 异步操作成功 */ ) {
        resolve(value);
    } else {
        reject(error);
    }
});
// resolve函数的作用是将Promise对象的状态从“未完成”变为“成功”（即从Pending变为Resolved）
// reject函数的作用是，将Promise对象的状态从“未完成”变为“失败”（即从Pending变为Rejected）

// Promise实例生成以后，可以用then方法分别指定Resolved状态和Reject状态的回调函数
promise.then(function(value) {
    // success
}, function(error) {
    // failure
});

// e.g
function timeout(ms) {
    return new Promise((resolve, reject) => {
        setTimeout(resolve, ms, 'done');
    });
}
timeout(100).then((value) => {
    console.log(value);
});
// done

// Promise新建后就会立即执行
let promise1 = new Promise(function(resolve, reject) {
    console.log('Promise');
    resolve();
});
promise1.then(function() {
    console.log('Resolved.');
});
console.log('Hi!');
// Promise
// Hi!
// Resolved

// e.g 异步加载图片的例子。
function loadImageAsync(url) {
    return new Promise(function(resolve, reject) {
        var image = new Image();

        image.onload = function() {
            resolve(image);
        };

        image.onerror = function() {
            reject(new Error('Could not load image at ' + url));
        };

        image.src = url;
    });
}

// e.g 用Promise对象实现的Ajax操作的例子
/*
var getJSON = function(url) {
    var promise = new Promise(function(resolve, reject) {
        var client = new XMLHttpRequest();
        client.open("GET", url);
        client.onreadystatechange = handler;
        client.responseType = "json";
        client.setRequestHeader("Accept", "application/json");
        client.send();

        function handler() {
            if (this.readyState !== 4) {
                return;
            }
            if (this.status === 200) {
                resolve(this.response);
            } else {
                reject(new Error(this.statusText));
            }
        };
    });

    return promise;
};
getJSON("/posts.json").then(function(json) {
    console.log('Contents: ' + json);
}, function(error) {
    console.error('出错了', error);
});*/


// resolve函数的参数除了正常的值以外，还可能是另一个Promise实例，表示异步操作的结果有可能是一个值，也有可能是另一个异步操作，比如像下面这样
var p1 = new Promise(function(resolve, reject) {
    // ...
});
var p2 = new Promise(function(resolve, reject) {
    // ...
    resolve(p1);
});

// e.g
var p1 = new Promise(function(resolve, reject) {
    setTimeout(() => reject(new Error('fail')), 3000)
})
var p2 = new Promise(function(resolve, reject) {
    setTimeout(() => resolve(p1), 1000)
})
p2.then(result => console.log(result))
p2.catch(error => console.log(error))
    // Error: fail

/**
 *	3. Promise.prototype.then()
 */
// then方法是定义在原型对象Promise.prototype上的。它的作用是为Promise实例添加状态改变时的回调函数。前面说过，then方法的第一个参数是Resolved状态的回调函数，第二个参数（可选）是Rejected状态的回调函数
// then方法返回的是一个新的Promise实例（注意，不是原来那个Promise实例）。因此可以采用链式写法，即then方法后面再调用另一个then方法
/*
getJSON("/posts.json").then(function(json) {
    return json.post;
}).then(function(post) {
    // ...
});*/





/**
 *	4. Promise.prototype.catch()
 */
// Promise.prototype.catch方法是.then(null, rejection)的别名，用于指定发生错误时的回调函数


/**
 *	5. Promise.all()
 */
// Promise.all方法用于将多个Promise实例，包装成一个新的Promise实例。
// （Promise.all方法的参数可以不是数组，但必须具有Iterator接口，且返回的每个成员都是Promise实例。）
var p = Promise.all([p1, p2]);





/**
 *	6. Promise.race()
 */
// Promise.race方法同样是将多个Promise实例，包装成一个新的Promise实例。
 var p = Promise.race([p1,p2]);



/**
 *	7. Promise.resolve()
 */
// 有时需要将现有对象转为Promise对象，Promise.resolve方法就起到这个作用
// var jsPromise = Promise.resolve($.ajax('/whatever.json'));

// Promise.resolve等价于下面的写法
Promise.resolve('foo')
// 等价于
new Promise(resolve => resolve('foo'))


/**
 *	8. Promise.reject()
 */
// Promise.reject(reason)方法也会返回一个新的Promise实例，该实例的状态为rejected。它的参数用法与Promise.resolve方法完全一致






/**
 *	9. 两个有用的附加方法
 */
// 1)   done()


// 2)   finally()



/**
 *	10. 应用
 */
// 1) 加载图片
// 我们可以将图片的加载写成一个Promise，一旦加载完成，Promise的状态就发生变化。
const preloadImage = function(path) {
    return new Promise(function(resolve, reject) {
        var image = new Image();
        image.onload = resolve;
        image.onerror = reject;
        image.src = path;
    });
};

// Generator函数与Promise的结合
// 使用Generator函数管理流程，遇到异步操作的时候，通常返回一个Promise对象
function getFoo() {
    return new Promise(function(resolve, reject) {
        resolve('foo');
    });
}
var g = function*() {
    try {
        var foo = yield getFoo();
        console.log(foo);
    } catch (e) {
        console.log(e);
    }
};
function run(generator) {
    var it = generator();

    function go(result) {
        if (result.done) return result.value;

        return result.value.then(function(value) {
            return go(it.next(value));
        }, function(error) {
            return go(it.throw(error));
        });
    }

    go(it.next());
}
run(g);











/**
 *	11. async函数
 */
