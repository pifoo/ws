/**
 * 	1. Class基本语法
 * 	2. Class的继承
 * 	3. 原生构造函数的继承
 * 	4. Class的取值函数（getter）和存值函数（setter）
 * 	5. Class的Generator方法
 * 	6. Class的静态方法
 * 	7. Class的静态属性和实例属性
 * 	8. new.target属性
 * 	9. Mixin模式的实现
 */

/**
 * 1. Class基本语法
 */
// e.g JavaScript语言的传统方法是通过 构造函数，定义并生成新对象
function Point(x, y) {
    this.x = x;
    this.y = y;
}
Point.prototype.toString = function() {
    return '(' + this.x + ', ' + this.y + ')';
};
var o = new Point(1, 2);
console.log(o);             // Point { x: 1, y: 2 }
console.log(o.toString());  // (1, 2)


// ES6 定义类
// 注意：定义“类”的方法的时候，前面不需要加上function这个关键字；法之间不需要逗号分隔
class Point1 {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    toString() {
        return '(' + this.x + ', ' + this.y + ')';
    }
}
var o1 = new Point1(1, 2);
console.log(o1);             // Point { x: 1, y: 2 }
console.log(o1.toString());  // (1, 2)

// ES6的类，完全可以看作构造函数的另一种写法
// 类的数据类型就是函数，类本身就指向构造函数
class Point2{
  // ...
}
console.log(typeof Point2); // "function"
console.log(Point2 === Point2.prototype.constructor); // true

// 构造函数的prototype属性，在ES6的“类”上面继续存在。事实上，类的所有方法都定义在类的prototype属性上面
class Point3 {
    constructor() {
        // ...
    }
    toString() {
        // ...
    }
    toValue() {
        // ...
    }
}
// 等同于
Point3.prototype = {
    toString() {},
    toValue() {}
};

// 在类的实例上面调用方法，其实就是调用原型上的方法
class B {}
let b = new B();
console.log(b.constructor === B.prototype.constructor);      // true

// 由于类的方法都定义在prototype对象上面，所以类的新方法可以添加在prototype对象上面。Object.assign 方法可以很方便地一次向类添加多个方法
class Point4 {
    constructor() {
        // ...
    }
}
Object.assign(Point4.prototype, {
    toString() {},
    toValue() {}
});
// prototype对象的constructor属性，直接指向“类”的本身，这与ES5的行为是一致的
console.log(Point4.prototype.constructor === Point4);    // true

// 类的内部所有定义的方法，都是不可枚举的（non-enumerable）
class Point5 {
    constructor(x, y) {
        // ...
    }
    toString() {
        // ...
    }
}
console.log(Object.keys(Point5.prototype));      // []
console.log(Object.getOwnPropertyNames(Point5.prototype)); //["constructor","toString"]
//
// ES5 的方式 则可枚举
var Point6 = function (x, y){
  // ...
};
Point6.prototype.toString = function() {
  // ...
};
console.log(Object.keys(Point6.prototype)); // ["toString"]
console.log(Object.getOwnPropertyNames(Point6.prototype)); // ["constructor","toString"]

// 类的属性名，可以采用表达式
let methodName = "getArea";
class Square {
    constructor(length) {
        // ...
    }
    [methodName]() {  // Square类的方法名getArea，是从表达式得到
        // ...
    }
}

// constructor方法
// constructor方法是类的默认方法，通过new命令生成对象实例时，自动调用该方法
// constructor方法默认返回实例对象（即this），完全可以指定返回另外一个对象
class Foo {
    constructor() {
        return Object.create(null);
    }
}
console.log(new Foo() instanceof Foo);      // false

// 类的实例对象
var point1 = new Point(2, 3);

// 与ES5一样，实例的属性除非显式定义在其本身（即定义在this对象上），否则都是定义在原型上（即定义在class上）
//定义类
class Point7 {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    toString() {
        return '(' + this.x + ', ' + this.y + ')';
    }
}
var point7 = new Point7(2, 3);
point7.toString();            // (2, 3)
point7.hasOwnProperty('x'); // true
point7.hasOwnProperty('y'); // true
console.log(point7.hasOwnProperty('toString')); // false
console.log(point7.__proto__.hasOwnProperty('toString')); // true
// 上面代码中，x和y都是实例对象point自身的属性（因为定义在this变量上），所以hasOwnProperty方法返回true，而toString是原型对象的属性（因为定义在Point类上），所以hasOwnProperty方法返回false。这些都与ES5的行为保持一致

// 与ES5一样，类的所有实例共享一个原型对象
var p1 = new Point1(2,3);
var p2 = new Point1(3,2);
console.log(p1.__proto__ === p2.__proto__);           //true
console.log(p1.__proto__, p2.__proto__);        // Point1 {} Point1 {}

// 这也意味着，可以通过实例的__proto__属性为Class添加方法
// 注意：使用实例的__proto__属性改写原型，会改变Class的原始定义，影响到所有实例，须谨慎
p1.__proto__.printName = function () { return 'Oops' };
console.log(p1.printName());     // "Oops"
console.log(p2.printName());     // "Oops"
var p3 = new Point1(4,2);
console.log(p3.printName());     // "Oops"

// name属性
// 由于本质上，ES6的Class只是ES5的构造函数的一层包装，所以函数的许多特性都被Class继承，包括name属性。
// name属性总是返回紧跟在class关键字后面的类名
console.log(Point1.name);       // "Point"

// Class表达式
// 与函数一样，Class也可以使用表达式的形式定义。
const MyClass = class Me { // Me只在Class的内部代码可用，指代当前类
    getClassName() {
        return Me.name;
    }
};
let inst = new MyClass();
console.log(inst.getClassName()); // Me
//console.log(Me.name);             // ReferenceError: Me is not defined

// 如果Class内部没用到的话，可以省略Me，也就是可以写成下面的形式
const MyClass1 = class { /* ... */ };

// 采用Class表达式，可以写出立即执行的Class。
let person = new class {
    constructor(name) {
        this.name = name;
    }
    sayName() {
        console.log(this.name);
    }
}('张三');
person.sayName(); // "张三"


/**
 * 2. Class的继承
 */
// ES6使用extends实现继承，ES5通过修改原型链实现
class ColorPoint extends Point1 {
    constructor(x, y, color) {
        // 在子类的构造函数中，只有调用super之后，才可以使用this关键字，否则会报错
        // this.color = color; // ReferenceError
        super(x, y); // 调用父类的constructor(x, y)； 子类必须在constructor方法中调用super方法，否则新建实例时会报错；子类没有自己的this对象，而是继承父类的this对象，然后对其进行加工；
        this.color = color;
    }

    toString() {
        return this.color + ' ' + super.toString(); // 调用父类的toString()
    }
}

// ES5的继承机制：实质是先创造子类的实例对象this，然后再将父类的方法添加到this上面（Parent.apply(this)）
// ES6的继承机制：实质是先创造父类的实例对象this（所以必须先调用super方法），然后再用子类的构造函数修改this

// e.g 生成子类实例的代码
let cp = new ColorPoint(25, 8, 'green');
console.log(cp.toString());                  // green (25, 8)
console.log(cp instanceof ColorPoint);       // true
console.log(cp instanceof Point1);            // true
// 实例对象cp同属ColorPoint和Point两个类的实例


// 类的prototype属性和__proto__属性
// 1）子类的__proto__属性，表示构造函数的继承，总是指向父类
// 2）子类prototype属性的__proto__属性，表示方法的继承，总是指向父类的prototype属性
class ClassA {}
class ClassB extends ClassA {}
console.log(ClassB.__proto__ === ClassA);                           // true
console.log(ClassB.prototype.__proto__ === ClassA.prototype);       // true



/**
 * 3. 原生构造函数的继承
 */

// e.g
class MyArray extends Array {
    constructor(...args) {
        super(...args);
    }
}

var arr = new MyArray();
arr[0] = 12;
arr.length // 1
arr.length = 0;
arr[0] // undefined

// e.g 带版本功能的数组
class VersionedArray extends Array {
    constructor() {
        super();
        this.history = [
            []
        ];
    }
    commit() {
        this.history.push(this.slice());
    }
    revert() {
        this.splice(0, this.length, ...this.history[this.history.length - 1]);
    }
}
var v = new VersionedArray();
v.push(1);
v.push(2);
console.log(v);             // [ 1, 2, history: [ [] ] ]
// v.history;               // [[]]
// v.commit();
// v.history;               // [[], [1, 2]]
// v.push(3);
// v;                       // [1, 2, 3]
// v.revert();
// v;                       // [1, 2]


// e.g 自定义Error子类的例子
class ExtendableError extends Error {
    constructor(message) {
        super();
        this.message = message;
        this.stack = (new Error()).stack;
        this.name = this.constructor.name;
    }
}
class MyError extends ExtendableError {
    constructor(m) {
        super(m);
    }
}
var myerror = new MyError('ll');
myerror.message // "ll"
myerror instanceof Error // true
myerror.name // "MyError"
myerror.stack
// Error
// at MyError.ExtendableError
// ...


/**
 * 4. Class的取值函数（getter）和存值函数（setter）
 */
class MyClass2 {
    constructor() {
        // ...
    }
    get prop() {
        return 'getter';
    }
    set prop(value) {
        console.log('setter: ' + value);
    }
}
let inst2 = new MyClass2();
inst2.prop = 123;               // setter: 123
console.log(inst2.prop);        // 'getter'

// 存值函数和取值函数是设置在属性的descriptor对象上的
class CustomHTMLElement {
    constructor(element) {
        this.element = element;
    }

    get html() {
        return this.element.innerHTML;
    }

    set html(value) {
        this.element.innerHTML = value;
    }
}
var descriptor = Object.getOwnPropertyDescriptor(
    CustomHTMLElement.prototype, "html");
"get" in descriptor; // true
"set" in descriptor; // true
// 上面代码中，存值函数和取值函数是定义在html属性的描述对象上面，这与ES5完全一致


/**
 * 5. Class的Generator方法
 */
// 某个方法之前加上星号（*），就表示该方法是一个Generator函数
class Foo1 {
    constructor(...args) {
        this.args = args;
    }
    *[Symbol.iterator]() {
        for (let arg of this.args) {
            yield arg;
        }
    }
}
for (let x of new Foo1('hello', 'world')) {
    console.log(x);
}
// hello
// world
//上面代码中，Foo1类的Symbol.iterator方法前有一个星号，表示该方法是一个Generator函数。Symbol.iterator方法返回一个Foo1类的默认遍历器，for...of循环会自动调用这个遍历器



/**
 * 6. Class的静态方法
 */
// “静态方法”: 在一个方法前，加上static关键字，就表示该方法不会被实例继承，而是直接通过类来调用
class Foo2 {
  static classMethod() {
    return 'hello';
  }
}
console.log(Foo2.classMethod()); // 'hello'

// var foo2 = new Foo();
// foo2.classMethod();
// TypeError: undefined is not a function

// 父类的静态方法，可以被子类继承
class Bar extends Foo2 {
    static classMethod() {
        // 静态方法也是可以从super对象上调用的
        return super.classMethod() + ', too';
    }
}
console.log(Bar.classMethod()); // 'hello'


/**
 * 7. Class的静态属性和实例属性
 */
// ES6明确规定，Class内部只有静态方法，没有静态属性
// 静态属性指的是Class本身的属性，即Class.propname，而不是定义在实例对象（this）上的属性。
class Foo3 {}
// 为Foo类定义了一个静态属性prop
Foo3.prop = 1;
Foo3.prop; // 1

// ES7
//
// 1) 类的实例属性
// 类的实例属性可以用等式，写入类的定义之中
class MyClass3 {
    myProp3 = 42;
    constructor() {
        console.log(this.myProp3);
    }
}
new MyClass3(); // 42

// 2）类的静态属性
// 实例属性前面，加上static关键字
class MyClass4 {
    static myStaticProp = 423;
    constructor() {
        console.log(MyClass4.myStaticProp);
    }
}
console.log(MyClass4.myStaticProp);     // 423
new MyClass4();                         // 423

/**
 * 8. new.target属性
 */
// new.target属性，（在构造函数中）返回new命令作用于的那个构造函数
function Person1(name) {
    if (new.target === Person1) {
        this.name = name;
    } else {
        throw new Error('必须使用new生成实例');
    }
}
var person1 = new Person1('张三'); // 正确
//var notAPerson = Person1.call(person, '张三'); // 报错

// Class内部调用new.target，返回当前Class
class Rectangle {
  constructor(length, width) {
    console.log(new.target === Rectangle);
    this.length = length;
    this.width = width;
  }
}
var obj = new Rectangle(3, 4); // 输出 true

// 子类继承父类时， new.target会返回子类
class Square1 extends Rectangle {
    constructor(length) {
        super(length, length);
    }
}
var obj = new Square1(3); // 输出 false

/**
 * 9. Mixin模式的实现
 */
// Mixin模式指的是，将多个类的接口“混入”（mix in）另一个类
