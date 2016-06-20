require("!style!css!./style.css") // 载入 style.css
import a from './module.js'
import $ from 'jquery';

document.write('It works. \n')
document.write(a) // 添加模块

$('#app').text('jquery');
console.log('log');
