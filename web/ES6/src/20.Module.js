/**
 * 	1.严格模式
 *  2.export命令
 *  3.import命令
 *  4.模块的整体加载
 *  5.export default命令
 *  6.模块的继承
 *  7.ES6模块加载的实质
 *  8.循环加载
 *  9.跨模块常量
 *  10.ES6模块的转码
 */


/**
 * 	1.严格模式
 */
// ES6的模块自动采用严格模式，不管你有没有在模块头部加上 "use strict"


/**
 *  2.export命令
 */
// export命令用于规定模块的对外接口
// e.g profile.js



/**
 *  3.import命令
 */
// import命令用于输入其他模块提供的功能
// import { stat, exists, readFile } from 'fs';
// e.g
import {
    firstName,
    lastName,
    year
} from './module/profile';
function setName(element) {
    element.textContent = firstName + ' ' + lastName;
    console.log(element.textContent);
}
var e = {};
setName(e);     // Michael Jackson



/**
 *  4.模块的整体加载
 */
// 模块的整体加载,用星号（*）指定一个对象，所有输出值都加载在这个对象上面
// 逐一加载
import { area, circumference } from './module/circle';
console.log(area(5));               // 78.53981633974483
console.log(circumference(5));      // 31.41592653589793
// 整体加载
import * as circle from './module/circle';
console.log(circle.area(5));               // 78.53981633974483
console.log(circle.circumference(5));      // 31.41592653589793


/**
 * 	5.export default命令
 */
// export default命令，为模块指定默认输出
import customName from './module/export-default';
customName();   // 'foo'
// 注：导入默认输出的模块 ，不需要大括号

// 在一条import语句中，同时输入默认方法和其他变量:
// import customName, { otherMethod } from './export-default';


/**
 * 	6.模块的继承
 */
 import * as math from './module/circleplus';
 import exp from './module/circleplus';
 import {
     circleArea
 } from './module/circleplus';
 console.log(exp(math.e)); // 15.154262241493734
 // import exp表示将circleplus模块的默认方法加载为exp方法
 console.log(math.area(10)); // 314.1592653589793
 console.log(math.circumference(10)); // 62.83185307179586
 console.log(circleArea(10)); // 314.1592653589793


/**
 * 	7.ES6模块加载的实质
 */

/**
 * 	8.循环加载
 */

/**
 * 	9.跨模块常量
 */

/**
 * 	10.ES6模块的转码
 */
