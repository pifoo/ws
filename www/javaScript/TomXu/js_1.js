	
	//URL:http://www.cnblogs.com/TomXu/archive/2011/12/28/2286877.html
	
	//单一var声明多个变量
	function updateElement() {
	   var el = document.getElementById("result"),
	       style = el.style;
	       // 使用el和style干点其他什么事...
	       
	}
	
	//缓存数组(或集合)的长度是比较好的形式,这样，在这个循环过程中，你只检索了一次长度值。
	for (var i = 0, max = myarray.length; i < max; i++) {
	   // 使用myarray[i]做点什么
	}
	
	function looper() {
	   var i = 0,
	        max,
	        myarray = [];
	   // ...
	   for (i = 0, max = myarray.length; i < max; i++) {
	      // 使用myarray[i]做点什么
	   }
	}
	
	//第一种变化的形式：
	var i, myarray = [];
	for (i = myarray.length; i--;) {
	   // 使用myarray[i]做点什么
	}
	
	//第二种使用while循环：
	var myarray = [],
	    i = myarray.length;
	while (i--) {
	   // 使用myarray[i]做点什么
	}
	
	
	//数组使用正常的for循环，对象使用for-in循环(遍历、枚举)
	//hasOwnProperty()方法，当遍历对象属性的时候可以过滤掉从原型链上下来的属性。
	//o.hasOwnProperty(p) :返回一个对象是否具有指定的属性，布尔值
	// 对象
	var man = {
	   hands: 2,
	   legs: 2,
	   heads: 1
	};
	
	// 在代码的某个地方
	// 一个方法添加给了所有对象
	if (typeof Object.prototype.clone === "undefined") {
	   Object.prototype.clone = function () {};
	}
	// 1.
	// for-in 循环
	for (var i in man) {
	   if (man.hasOwnProperty(i)) { // 过滤
	      console.log(i, ":", man[i]);
	   }
	}
	/* 控制台显示结果
	hands : 2
	legs : 2
	heads : 1
	*/
	// 2.
	// 反面例子:
	// for-in loop without checking hasOwnProperty()
	for (var i in man) {
	   console.log(i, ":", man[i]);
	}
	/*
	控制台显示结果
	hands : 2
	legs : 2
	heads : 1
	clone: function()
	*/
	
	//使用hasOwnProperty()的形式是取消Object.prototype上的方法
	for (var i in man) {
	   if (Object.prototype.hasOwnProperty.call(man, i)) { // 过滤
	      console.log(i, ":", man[i]);
	   }
	}
	
	var i, hasOwn = Object.prototype.hasOwnProperty;
	for (i in man) {
	    if (hasOwn.call(man, i)) { // 过滤
	        console.log(i, ":", man[i]);
	    }
	}		

	//给原型进行自定义的添加
	if (typeof Object.protoype.myMethod !== "function") {
	   Object.protoype.myMethod = function () {
	      // 实现...
	   };
	}

	//避免隐式类型转换	
	var zero = 0;
	if (zero === false) {
	   // 不执行，因为zero为0, 而不是false
	}
	
	// 反面示例
	if (zero == false) {
	   // 执行了...
	}
	






















