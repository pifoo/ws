/**
 * 	1. 基本概念
 * 	2. Generator函数
 * 	3. Thunk函数
 * 	4. co模块
 * 	5. async函数
 */

/**
 *  ES6诞生以前，异步编程的方法，大概有下面四种：
 *  回调函数
 *  事件监听
 *  发布/订阅
 *  Promise 对象
 */




/**
 * 1. 基本概念
 */
// Promise ：为了解决回调函数的多重嵌套，允许将回调函数的横向加载，改成纵向加载
/*
var readFile = require('fs-readfile-promise');
readFile(fileA)
    .then(function(data) {
        console.log(data.toString());
    })
    .then(function() {
        return readFile(fileB);
    })
    .then(function(data) {
        console.log(data.toString());
    })
    .catch(function(err) {
        console.log(err);
    });
*/




/**
 * 2. Generator函数
 */
// Generator函数的执行方法如下
function* gen(x) {
    try {
        var y = yield x + 2;    // 异步操作需要暂停的地方，都用yield语句注明
    } catch (e) {
        console.log(e);
    }
    return y;
}
var g = gen(1);             // 不直接返回结果，而是会返回一个内部指针（即遍历器）
console.log(g.next());                    // { value: 3, done: false }
console.log(g.next(2));                   // { value: 2, done: true }
console.log(g.throw('出错了～'));                    //


// 异步任务的封装






/**
 * 3. Thunk函数
 */

/**
 * 4. co模块
 */

/**
 * 5. async函数
 */
