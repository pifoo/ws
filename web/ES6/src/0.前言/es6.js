'use strict';

for (let i = 0; i < 3; i++) {
	console.log("i:", i);
}
// console.log(i);	// ReferenceError: i is not defined

let curry1 = f => (a) => f(a);



function aboutme(){
  {
    let gfs = 10;
    var wife = 1;
  }
  console.log(wife);
  //console.log(gfs);
}
// Let's invoke aboutme
aboutme();
// Would result in :
//1
//ReferenceError: gfs is not defined.


var assert = require('assert')
  , m = new Map()
  , key = { a: 'Test' }
  , value = 'a test value'
  ;
m.set(key, value);
assert.equal(m.get(key), value);


console.log([1,2,3].map(x => x * x))


class Calc {
    constructor(){
      console.log('Calc constructor');
    }
    add(a, b){
      return a + b;
    }
}
var c = new Calc();
console.log(c.add(4,5));


var a = [];
for (let i = 0; i < 10; i++) {
  a[i] = function () {
    console.log(i);
  };
}
a[6]();




