/**
 * @author Hewj
 */
var jk = (function(){

})();


//用换行符分隔,输出所有参数
function msg(){
	for (var a=[],i=0; i < arguments.length; i++) {
		a.push(arguments[i]);
	}
	alert(a.join("\n"));
};	// msg(1,2)


//使用arguments对象模拟函数重载
function fnTest(){
	var args = arguments;
	switch(args.length){
		case 0:
			return "没有传入参数";
		case 1:
			return "传入了参数：" + args[0];
		case 2:
			return "传入了参数：" + args[0] +  "和" + args[1];
	}
};	// alert(fnTest());alert(fnTest(1));alert(fnTest(1,2));


// 阶乘
function add(n){	//面向过程
	for(var i=ret=1;i<=n;i++){
		ret=ret*i;
	};
		alert(arguments.callee.caller);	// caller属性指向调用当前函数的那个函数
	return ret;
};	// alert(add(3));
// function x(){add(1)};x();	// 测试caller属性	
function fnAdd(n){	
	//alert(args.callee);	// arguments对象补充:arguments对象的callee属性指向它所在的函数
	//return n ? n*fnAdd(n-1) : 1;   //函数式
	return n ? n*arguments.callee(n-1) : 1;  //递归
};	// alert(fnAdd(5));


// 循环遍历了BOM中window对象的所有属性
for(var propName in window){
	//document.write(propName + "<br/>");
};


// 重排序方法
function compare(v1,v2){	//适用于大多数数据类型
	if(v1<v2){
		return -1;
	}else if(v1>v2){
		return 1;
	}else{
		return 0;
	};
	//如果对数值类型或valueOf()方法返回数值类型的对象作比较
	//return v1-v2;
};
//使用:只要把比较函数作为参数传递给sort();
var v = [3,54,6,7,24,6];
//alert(v.sort(compare));


// Math.random() // 返回0~1之间的随机数，不包括0和1；
// 例：从某个整数范围内随机显示一个值
// 值 = Math.floor(Math.random() * 可能值的总数 + 第一个可能的值) // x.floor() 向下取整
// var num = Math.floor(Math.random() * 9 + 2) // 介于2~10之间的值(包括)
// alert(num);
function selectFrom(lowerValue,upperValue){	// 通用方法   lowerValue:最小值 	，upperValue：最大值
	var choices = upperValue -lowerValue + 1;
	return Math.floor(Math.random()*choices + lowerValue);
};
var num = selectFrom(2,10);	// 介于2~10之间的值(包括)
// alert(num);
// 例  从数组中随机取出一项
var colors = ["red","green","blue","yellow","black","purple","brown"];
var color = colors[selectFrom(0,colors.length)]
// alert(color);	//可能是数组中的任意一项






























































































































































































































































