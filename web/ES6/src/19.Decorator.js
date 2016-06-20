/**
 * 	1. 类的修饰
 * 	2. 方法的修饰
 * 	3. 为什么修饰器不能用于函数？
 * 	4. core-decorators.js
 * 	5. 使用修饰器实现自动发布事件
 * 	6. Mixin
 * 	7. Trait
 * 	8. Babel转码器的支持
 */

/**
 * 	1. 类的修饰
 */
// 修饰器（Decorator）是一个函数，用来修改类的行为
// 修饰器对类的行为的改变，是代码编译时发生的，而不是在运行时
function testable(target) {
    target.isTestable = true;
}

@testable
class MyTestableClass {

};

console.log(MyTestableClass.isTestable);     // true




/**
 *	2. 方法的修饰
 */


/**
 *	3. 为什么修饰器不能用于函数？
 */

/**
 *	4. core-decorators.js
 */

/**
 *	5. 使用修饰器实现自动发布事件
 */

/**
 *	6. Mixin
 */

/**
 *	7. Trait
 */


/**
 *	8. Babel转码器的支持
 */
