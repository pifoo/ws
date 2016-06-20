/*  匿名函数
export default function() {
    console.log('foo');
}
*/

/*
export default function foo() {
    console.log('foo');
}
*/
// 或者写成
function foo() {
    console.log('foo');
}
export default foo;
// foo函数的函数名foo，在模块外部是无效的。加载的时候，视同匿名函数加载
