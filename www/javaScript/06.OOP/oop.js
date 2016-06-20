/**
 * JavaScript面身对象
 * @author Hewj
 */
 
// 可以把ECMAScript的对象想象成一个散列表：
// 无非就是一组名值对,其中值可以是数据或函数


/*
 * 创建对象,普通方式
 * 先创建一个对象,再为其添加属性和方法
 * 缺点：使用同一个接口创建多个对象,会产生大量代码
 */
/*
var person = new Object();
person.name = "Mr.he";
person.age = "26";
person.job = "F2E";
person.sayName = function(){
	alert(this.name);
};
person.sayName();
*/


/*
 * 工厂模式 ---------------------------------------------------//
 * 用函数来封装以待定接口创建对象的细节,最后返回这个对象
 * 优点：可创建多个相似对象
 * 缺点：没有解决对象识别问题（即怎样知道一个对象的类型,也就是说创建的新对象是谁的实例）
 */
/* 
function creatPerson(name,age,job){
	var o = new Object();
	o.name = name;
	o.age = age;
	o.job = job;
	o.sayName = function(){
		alert(this.name);
	};
	return o;
};
var person1 = creatPerson("Mr.he","26","F2E");
var person2 = creatPerson("Mr","20","F");
person1.sayName(); person2.sayName();
*/


/*
 * 构造函数模式 ---------------------------------------------------//
 * 创建自定义的构造函数意味着将来可以将它的实例标识为一种特定的类型；这正是构造函数胜过工厂模式的地方
 * 缺点：在构造函数外定义的全局函数只能被，某个对象调用，这些全局作用域有点名不副实
 *       更让人无法接受的是，如果对象征需要定义很多方法，那么封装性就差了
 * 与工厂模式的区别：
 * 1.没有显式地创建对象
 * 2.直接将属性和方法赋给this对象
 * 3.没有return语句
 * 4.实例化对象，必胜使用new操作符(
 * 以这种方式调用构造函数<实例化对象>会经历4个步骤：
    1.创建一个新对象;
    2.将构造函数的作用域赋给新对象(因此this就指向了这个对象)
    3.执行构造函数中的代码(为这个新对象添加属性)
    4.返回新对象)
 */
/* 
function Person(name,age,job){
	this.name = name;
	this.age = age;
	this.job = job;
	this.sayName = function(){
		alert(this.name);
	};
	//与之等价this.sayName = New Function(){alert(this.name);};   2.构造函数的问题
	//ECMAScript中的函数是对象，因此，每定义一个函数，也就实例化了一个对象
	//使用构造函数的问题问题，就是每个方法都要在每个实例上重新创建一遍
	//从这个角度来看构造函数，更容易明白每个实例都包含一个不同的Function的实例
	//因此：alert(person1.sayName == person2.sayName) //false
	//然而，创建两个完成同样任务的Function实例的确没必要；况且有this对象存在，根本不用在执行代码前就把函数绑定到特定对象上面；
	//因此可以使用如下方式,把函数的定义转移到构造函数外部,在构造函数内部，将sayName属性设置成全局的sayName函数
	//创建实例后：alert(person1.sayName == person2.sayName) //true
	//this.sayName = sayName;	// ①可以把函数定义转移到构造函数外部，以便共享，封装性差，多个函数不方便，只能被某个对象调用;引出原型模式
};
	//function sayName(){	①
	//	alert(this.name);
	//}
var person1 = new Person("Mr.he","26","F2E");
var person2 = new Person("Mr","20","F");
person1.sayName();
person2.sayName();
//person1,person2这两个对象分别保存着Person的一个不同的实例
//这两个对象都有一个constructor(构造函数)属性
alert(person1.constructor === Person);	// true
//检测对象类型：instanceof; obj是否为指定的构造函数的实例
alert(person1 instanceof Object);	// true
alert(person1 instanceof Person);	// true

//1.将构造函数当作函数
///构造函数与其它函数的唯一区别：就在于调用它们的方式不同。不过，构造函数毕竟也是函数，不存在定义构造函数的特殊语法。
//任何函数，只要通过new操作符来调用，那它就可以作为构造函数；
// 当作构造函数调用
var person = new Person("Mr.he","26","F2E"); person.sayName() //Mr.he
// 作为普通函数调用
Person("Mr.he","26","F2E"); window.sayName() //Mr.he  //添加到window
// 在另一个对象的作用域中调用 
var o = new Object();
Person.call(o,"Mr.he","26","F2E"); o.sayName() //Mr.he

//2.构造函数的问题
使用构造函数的主要问题：就是每个方法都要在每个实例上重新创建一遍。
每一个person实例都包含一个不同的Function实例
//因此：alert(person1.sayName == person2.sayName) //false
可以通过把函数定义转移到构造函数外部来解决这个问题，而在构造函数内部
把sayName属性设置成等于全局的sayName函数。这样便可共享sayName();
新的问题是：全局作用域定义的函数sayName()实际上只能被某个对象调用 ，这让全局作用域有点名不副实。
无法接受的是:如果对象需要定义很多方法，那那么就要定义很多全局函数，于是我们这个定义的引用类型就没封装性可言了。
好在原型模式可以解决这个问题。
*/



/*
 * 原型模式---------------------------------------------------//
 * 优点：所有对象实例共享其所包含的属性和方法
 * 缺点：省略了为构造函数传递初始化参数
 */
/* 
function Person(){}; 
//我们创建的每个函数都有一个prototype属性，这个属性是一个对象，它的用途是包含可以由特定类型的所有实例共享的属性和方法
//
Person.prototype.name = "Mr.he";
Person.prototype.age = 26;
Person.prototype.job = "F2E";
Person.prototype.sayName = function(){
	alert(this.name);
};
// 更简洁的语法，对象字面量方式，construector属性不再指向Person,这种语法本质上完全重写了默认的prototype对象
// 因此construector属性也就变成了新对象的construector属性
Person.prototype = {
	//construector:Person,	// 如果要使用construector，可以在此设置回适当的值
	name:"Mr.he",
	age:"26",
	job:"F2E",
	sayName:function(){
		alert(this.name);
	}
};

var person1 = new Person();
// person1.sayName();

var person2 = new Person();
// person2.sayName();

// alert(person1.sayName == person2.sayName);

var o = {
	toString:function(){
		return "My Object"
	}
};
for (var prop in o){
	if(prop == "toString"){
	//	alert("Found toStrings");	// 在IE中??
	}
};
*/


/*
 * 组合使用构造函数模式和原型模式---------------------------------------------------//
 * 构造函数模式用于定义实例属性
 * 原型模式用于定义方法和共享属性
 */
/*
function Person(name,age,job){	// 定义实例属性
	this.name = name;
	this.age = age;
	this.job = job;
	this.friends = ["shelby","court"];
};
Person.prototype = {			// 定义方法和共享属性
	constructor:Person,
	sayName:function(){
		alert(this.name);
	}
};
var person1 = new Person("Mr.he","26","F2E");
var person2 = new Person("Mrhe","29","F");
person1.friends.push("Van");
alert(person1.friends);
alert(person2.friends);
alert(person1.friends === person2.friends); // false  friends在构造函数中定义的，person.friends分别引用不同的数组,故输出这样的结果
alert(person1.sayName === person2.sayName); // true
*/


/*
 * 动态原型模式---------------------------------------------------//
 * 缺点：不能使用对象字面量重写原型（如果在已经创建了实例的情况下重写原型，那么就会切断现有实例与原型之间的联系）
 */
/* 
function Person(name,age,job){
	// 属性	
	this.name = name;
	this.age = age;
	this.job = job;
	
	// 方法
	// 可以通过检测某个应该存在的方法是否有效，来决定是否需要初始化原型
	// 只有在sayName()不存在的情况下，才会将它添加到原型中
	// 这段代码只会在初次调用构造函数时才会执行。这时对原型所做的修改，会反映到所有实例中
	// 对于采用这种模式创建的对象，还可以使用instanceof操作符确定它的类型
	// 使用动态原型模式，不能使用对象字面量重写原型。
	// 在已经创建了实例的情况下重写原型，那么就会切断所有实例与原型之间的联系
	if(typeof this.sayName != "function"){	// 检查的可以是初始化后应该存在在的任何一个属性和方法，检查一个即个
		Person.prototype.sayName = function(){
			alert(this.name);
		}
	}
};
var person = new Person("Nicholas",29,"Software Engineer");
person.sayName();
*/


/*
 * 寄生构造函数模式---------------------------------------------------//
 * 除了使用new操作符并把使用的包装函数叫做构造函数之外，这个模式与工厂模式是一样的
 * 说明： 寄生构造函数模式，返回的对象与构造函数或与构造函数的原型属性之间没有关系
 * 也就是说，构造函数返回的对象与在构造函数外部创建的对象没有什么不同
 * 为此，不能依赖instanceof操作符来确定对象类型。
 * 可以为一个原生对象添加额外方法
 */
/*
function Person(name,age,job){
	var o = new Object();
	o.name = name;
	o.age = age;
	o.job = job;
	o.sayName = function(){
		alert(this.name);
	};
	return o;
	//构造函数在不返回值的情况下，默认会返回新对象的实例。
	//而通过构造函数的末尾添加一个return语句，可以重写调用构造函数时返回的值
};
var person = new Person("Mr.he","26","F2E");
//var person = Person("Mr.he","26","F2E");//工厂模式调用方式
//person.sayName();
//这个模式可以在特殊的情况下用来为对象创建构造函数
//假设我们想创建一个具有额外方法的特殊数组。由于不能直接修改Array构造函数，因此可以使用这个模式：
function SpecialArray(){
	//创建数组
	var values = new Array();
	//添加值
	values.push.apply(values,arguments);//初始化数组
	//添加方法
	values.toPipedString = function(){
		return this.join("|");
	};
	//返回数组
	return values;
}
var colors = new SpecialArray("red","blue","green");
alert(colors.toPipedString());//"red"|"blue"|"green"
*/


/*
 * 稳妥构造函数模式---------------------------------------------------//
 * 稳妥构造函数模式遵循与寄生构造函数类似的模式，有两点区别：
 * 1.新创建对象的实例方法不引用 this
 * 2.不使用new操作符调用构造函数
 * 稳妥对象：指的是没有公共属性，而且其方法也不引用this的对象。
 * 稳妥对象最适合在一些安全环境中（这些环境中会禁止使用this和new）
 *
 * 与寄生构造函数类似，使用稳妥构造函数模式创建的对象与构造函数之间也没有什么关系
 * 为此，不能依赖instanceof操作符来确定对象类型。
 */
/* 
function Person(name,age,job){
	// 创建要返回的对象
	var o = new Object();
	
	// 可以在这里定义私有变量和函数
	
	// 添加方法
	o.sayName = function(){
		alert(name);  //与寄生构造函数模式的区别：新创建对象的实例方法不引用 this
		//以这种模式创建的对象中，除了使用sayName()方法之外，没有其它方法访问name的值
	};
	
	// 返回对象
	return o;
};
var person = Person("Mr.he","26","F2E");
person.sayName();
*/





/**
 * 继承
 * ECMAScript只支持实现继承，而且其实现继承主要是依靠原型链来实现的
 * 
 */
/*
 * 原型链---------------------------------------------------//
 * 思想：利用原型让一个引用类型继承另一个引用类型的属性和方法
 * 实现:让原型对象等于另一个类型的实例 
 * 注意：在使用原型链实现继承时，不能使用对象字面量创建原型方法。这样会重写原型链
 * 问题：
 * 1.包含引用类型值的原型
 * 2.在创建子类型的实例时，不能向超类型的构造函数中传递参数
 */
/*
// 定义超类
function SuperType(){
	this.property = true;
};
SuperType.prototype.getSuperValue = function(){
	return this.property;
};
// 定义子类
function SubType(){
	this.subproperty = false;
};
// 实现继承
SubType.prototype = new SuperType();
// 为子类添加了一个方法
SubType.prototype.getSubValue = function(){
	return this.subproperty;
};
// 重写父类中的方法
SubType.prototype.getSuperValue = function(){
	return false;
};
// 实例化子类
var instance = new SubType();
// alert(instance.getSuperValue());	//true 继承了父类的方法
//alert(instance.getSuperValue());    //重写后返回false
// alert(instance.getSubValue());     //false

// 确定原型链和实例之间的关系instanceof   ；  isPrototypeOf()
// instance都是指向以下对象的实例
// alert(instance instanceof Object);//true
// alert(instance instanceof SuperType);//true
// alert(instance instanceof SubType);//true
//instance的内部属性都指向以下对象的原型
//alert(Object.prototype.isPrototypeOf(instance));//true
//alert(SuperType.prototype.isPrototypeOf(instance));//true
//alert(SubType.prototype.isPrototypeOf(instance));//true
//因此实现了继承


//使用对象字面量添加属性和方法
function SuperType(){
	this.property = true;
};
SuperType.prototype.getSuperValue = function(){
	return this.property;
};
// 定义子类
function SubType(){
	this.subproperty = false;
};
// 实现继承
SubType.prototype = new SuperType();
// 使用字面量添加新方法，会导致上一行代码无效
//将原型替换成一个对象字面量，由于现在的原型包含一个Object的实例，而非SuperType的实例
//因此原型链已被切断---SubType和SuperType之间已经没有关系了
SubType.prototype = {
	getSubValue:function(){
		return this.subproperty;
	},
	someOtherMethod:function(){
		return false;
	}
};
var instance = new SubType();
//alert(instance.getSuperValue()); //error


//原型链的问题
function SuperType(){
	this.colors = ["red","blue","green"];
}
function SubType(){};
SubType.prototype = new SuperType();
var instance1 = new SubType();
instance1.colors.push("black"); 
alert(instance1.colors); // "red","blue","green","black"
var instance2 = new SubType();
alert(instance2.colors); // "red","blue","green","black"
//在通过原型来实现继承时，原型实际上会变成另一个类型的实例，
//--------于是，原先的实例属性也就顺理成章地变成了现在的原型属性
//第二个问题：在创建子类型的实例时，不能向超类型的构造中传递参数
*/



/*
 * 借用构造函数---------------------------------------------------//
 * 思想：即在子类型构造函数的内部调用超类型构造函数，通过使用call()和apply()方法
 * 问题：
 * 1.方法都在构造函数中定义 ，无复用
 * 2.在超类型的原型中定义的方法，对子类而言是不可见的。结果所有类型都只能使用构造函数模式
 */
/* 
function SuperType(){ //可以传递参数
	this.colors = ["red","green","blue"];
};
function SubType(){
	//继承了SuperType
	SuperType.call(this);	// 借调了超类型的构造函数   可以传递参数
};

var instance1 = new SubType();
instance1.colors.push("black");
alert(instance1.colors);//"red","blue","green","black"

var instance2 = new SubType();
alert(instance2.colors);//"red","blue","green"
*/

/*
 * 组合继承：将原型链和借用构造函数的技术组合到一起---------------------------------------------------//
 * 思想：使用原型链实现对原型属性和方法的继承，而通过借用构造函数来实现对实例属性的继承
 * instanceof 和isPrototypeOf()也能够用于识别基于组合继承创建的对象
 * 
 * 问题：无论在什么情况下，都会调用两次超类型构造函数：
 * ①一次是在创建子类型原型的时候
 * ②一次是在子类型构造函数内部
 * 虽然子类最终后包含超类型对象的全部实例属性，但我们不得不在调用子类型构造函数时重写这些属性
 */
/*
function SuperType(name){
	this.name = name;
	this.colors = ["red","green","blue"];
};
SuperType.prototype.sayName = function(){  
	alert(this.name);
};
function SubType(name,age){
	// 继承属性
	SuperType.call(this,name); // ②第二次调用 
	
	this.age = age ;
};
// 继承方法
SubType.prototype = new SuperType();// ①第一次调用 
SubType.prototype.sayAge = function(){
	alert(this.age);
}
var instance1 = new SubType("Mr.he","26");
instance1.colors.push("black"); 
//alert(instance1.colors);  // "red","green","blue","black"
//instance1.sayName();      // Mr.he
//instance1.sayAge();       // 26

var instance2 = new SubType("Mr.he","27");
//alert(instance2.colors);  // "red","green","blue"
//instance2.sayName();      // Mr.he
//instance2.sayAge();       // 27
/*


/*
 * 原型式继承---------------------------------------------------//
 * 思想：借助原型基于已有的对象创建新对象,同时不必因此创建自定义类型
 */
/*
function object(o){	// 传入一个对象
	function F(){}; // 临时性构造函数
	F.prototype = o; // 将传入的对象作为这个构造函数的原型
	return new F();  // 返回这个临时类型的新实例
};// 从本质上讲，object()对传入其中的对象执行了一次浅复制
var person = {
	name: "Mr.he",
	friends: ["sheLe","cour","Rob"]
}
var anotherPerson = object(person);
anotherPerson.name = "Mr.h";
anotherPerson.friends.push("Barbie");
alert(person.name);//Mr.he
alert(anotherPerson.name);//Mr.h
alert(person.friends);//"sheLe","cour","Rob","Barbie"

var yetotherPerson = object(person);
yetotherPerson.name = "Mr.hse";
yetotherPerson.friends.push("BA");
alert(person.friends);//"sheLe","cour","Rob","Barbie","BA"

//person.friends不仅属于person所有，还会被anotherPerson和yetotherPerson共享
//在没有必要兴师动众地创建构造函数，而只想让一个对象与另一个对象保持类似的情况，原型式继承是完全可以胜任的。
//注意，包含引用类型值的属性始终都会共享相应的值，就像使用原型模式一样。
//
*/


/*
 * 寄生式继承---------------------------------------------------//
 * 基于已有的对象创建新对象
 * 寄生式继承的思路与寄生构造函数和工厂模式类式，即创建一个仅用于封装继承过程的函数，
 * 该函数在内部以某种方式来增强对象，最后再像真地是它做了所有工作一样返回对象
 */
/*
function createAnother(original){//传入一个对象
	var clone = new Object(original); // 通过调用Object()函数创建一个新对象
	clone.sayHi= function(){	  // 以某种方式来增强这个对象
		alert("Hi");
	};
	return clone;	// 返回这个对象
};
var person = {
	name : "Mr.he",
	friends:["s","r","d"]
};
var anohterPerson = createAnother(person);
anohterPerson.sayHi();//Hi
//alert(person.name);//Mr.he
//alert(anohterPerson.name);//Mr.he
anohterPerson.friends.push("r");
//alert(person.friends);//"s","r","d","r"   被共享了

//这个例子基于person返回了一个新对象--anotherPerson。
//新对象不仅具有person的所有属性和方法，而且还有自己的sayHi()方法。
//在主要考虑对象而不是自定义类型和构造函数的情况下，寄生式继承也是一种有用的模式。
//前面示范继承模式时使用的Object()函数不是必须的，任何能够返回新对象的函数都适用于此模式

//使用寄生式继承来为对象添加函数，会由于不能做到函数复用而降低效率；这一点与构造函数模式类似
*/


/*
 * 寄生组合式继承---------------------------------------------------//
 * 即通过借用构造函数来继承属性，通过原型链的混成形式来继承方法
 * 思路：不必为了指定子类型的原型而调用超类型的构造函数，我们所需要的无非就是超类型原型的一个副本而已
 * 本质上，就是使用寄生式继承来继承超类型的原型，然后再将结果指定给子类型的原型
 */
/* 
function SuperType(name){
	this.name = name;
	this.colors = ["red","green","blue"];
};
SuperType.prototype.sayName = function(){
	alert(this.name);
};
function SubType(name,age){
	SuperType.call(this,name); // 第二次调用SuperType()
	this.age = age;
};

//去掉下面没加注释的两行~~~~~~~~~~~~~~~
//inheriPrototype(SubType,SuperType);
//SubType.prototype.sayAge = function(){
//	alert(this.age); 
//}

SubType.prototype = new SuperType(); // 第一次调用SuperType()
SubType.prototype.sayAge = function(){
	alert(this.age);
};

//寄生组合式继承的基本模式
function inheriPrototype(subType,superType){	 // 子类型构造函数，超类型构造函数 
	var prototype = Object(superType.prototype); // 创建对象  创建超类型原型的一个副本
	prototype.constructor = subType; 			 // 增强对象  为创建的副本添加constructor属性
	subType.prototype = prototype;				 // 指定对象  将新创建的对象（即副本）赋值给子类型的原型
};
//inheriPrototype(SubType,SuperType);~~~~~~~~~~~~~~~
//SubType.prototype.sayAge = function(){
//	alert(this.age);
//}

//只调用了一次SuperType构造函数，并且因此避免了在SubType.prototype上面创建不必要的，多余的属性
//与此同时，原型链还能保持不变；  因此还能够使用instanceof 和 inPrototypeOf()方法
//开发人员普遍认为寄生组合式继承是引用类型最理想的继承范式
*/


























