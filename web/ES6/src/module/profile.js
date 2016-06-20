// 语法一
/*
    export var firstName = 'Michael';
    export var lastName = 'Jackson';
    export var year = 1958;
*/

// 语法二
//
// 输出变量
var firstName = 'Michael';
var lastName = 'Jackson';
var year = 1958;
// 输出函数或类（class）
export function multiply(x, y) {
    return x * y;
};
// 通常情况下，export输出的变量就是本来的名字，但是可以使用as关键字重命名
function v1() {}

function v2() {}
export {
    v1 as streamV1,
    v2 as streamV2,
    v2 as streamLatestVersion
};

export {
    firstName,
    lastName,
    year
};
