export * from './circle'; // 导入再输出 circle模块的所有属性、方法
export var e = 2.71828182846;
export default function(x) {
    return Math.exp(x);
}

// 只输出circle模块的area方法，且将其改名为circleArea
export { area as circleArea } from './circle';
