/*myJSFrame源代码分析(1)
本篇内容：选择器前半部份，非字符串类型处理和ID类型处理。
/++++++++++以下为正文部份++++++++++
/*1、*
 ł、*	My JavaScript Framework
 Ń、*	Version	:Z.2.1.5
 ń、*	Author	:	misshjn
 Ņ、*	Email	:	[email]misshjn@163.com[/email]
 ņ、*	Home	:	[url]http://www.happyshow.org/[/url]
 Ň、*/
//1-7行为版权声明略过，从第8行开始。
/*8、*/function $(){
	//声明主体函数$，$函数在这里是作为选择器函数。大多数框架都是以这种形式开场。

/*9、*/	var elem = null;
		//var关键字在函数内部使用，使变量elem成为函数内部的一个局部变量,初始值为null。

/*10、*/	if(typeof arguments[0] !="string"){
			//arguments[0]取$ 函数的第一个实际参数(以下称 实参1 )。typeof判断 实参1 的类型，如果 实参1 的类型不是"string"字符串型
			//就进入if语句下面的处理逻辑。否则跳转至21行。

/*11、*/		if(!arguments[0]){return null;}//#匹配$(),$(false),$(null)这种，直接返回 null。
				// !arguments[0] 取反 实参1 。如果值为true就退出$选择器函数返回null值。退出即表示选择器没有选择到匹配的对象，操作失败。

/*12、*/		elem = arguments[0];
				//经过上面的一层筛选，没有退出函数。证明 实参1 实际存在，且不为false值。为elem局变赋值实参1

/*13、*/		if(!elem["version"]){  //#匹配 $(document.body) 类似这种
				//取反elem的version属性，如果不存在version返回true,即进入下面的初始化。否则跳转至19行，直接返回。
				
/*14、*/			$._Method.Element.apply(elem);
					//作者在这里声明了一个方法的集合，$._Method。Element是$._Method方法集合的一个子集，里面声明了添加给元素的方法。以函数的方法定义。
					//apply将elem设为$.MetHod.Element函数的上下文对象，去执行$._Method.Element函数。将方法添加到elem上面。

/*15、*/			if($._appendMethod){
/*16、*/				$._appendMethod.apply(elem);
/*17、*/			}
					//如果有$._appendMethod方法集合，则为elem添加这些方法。
					//作者预留的扩充方法，在这个版本里面，并未定义。

/*18、*/		}
/*19、*/		return elem;
				//匹配完成，并且初始化成功。返回。
/*20、*/	}
			//############匹配第一部份完########################
			
/*21、*/	var argID = arguments[0].trim();
			//定义局变argID，值为 实参1 调用trim函数。 trim函数是作者通过扩展String类型的原型添加上去的，用于剪除字符串两边空白。
/*22、*/
/*23、*/	if(argID.indexOf(" ")==-1 && argID.indexOf(",")==-1 && argID.indexOf(".")==-1 && argID.indexOf("[")==-1 && argID.indexOf(">")==-1){
			//#匹配 $('#testDIV') 类似这种情况
			//如果argID里面找不到 " "(空格) 并且找不到 ","(逗号) 并且找不到 "."（点） 并且找不到 "["（中括号） 并且找不到">"(大于号)

/*24、*/		elem = document.getElementById(argID.replace("#",""));
				//argID.replace替换argID里面的#字符为""空。然后用document.getElementById方法来获取

/*25、*/		if(!elem){return null;}
				//没获取到，返回空，匹配失败。

/*26、*/		if(!elem["version"]){
				//判断是否有version属性，有version则认为是之前初始化过。直接返回。
				
/*27、*/			$._Method.Element.apply(elem);
/*28、*/			if($._appendMethod){
/*29、*/				$._appendMethod.apply(elem);
/*30、*/			}
					//没有version属性，进行初始化。

/*31、*/		}
/*32、*/		return elem;
				//返回
/*33、*/	}
/*++++++++++++++++++++++++++++++++++++++++++++++++++未完待续
部分注解：
arguments是javascript函数内部的一个伪属性。
function $() 这个地方声明时并未带参数。
arguments.length可以知道一共传了几个参数给$函数。然后通过arguments[0]下标的方式来访问。
arguments.callee指向当前执行的函数,在函数$里面，指向$函数本身。
arguments.caller指向调用当前函数的函数，在函数A里面调用函数$，函数$里面arguments.caller指向函数A

if(!arguments[0])取反
javascript是弱类型，类型间可以隐式转换。 如果arguments[0]未定义，或者为可以隐式转换为false类型的值(''空字符串,0 数字0等等)，则条件成立。

$._Method.Element.apply(elem);
apply是Function原型上的。所有的函数都可以调用apply方法，可以接受两个参数，第一个被设为当前对象。第二个参数为一个数组，里面的值会被传给函数。
var obj = new Object();
function foo(a,b)
{
	this.a = a;
	this.b = b;
}
foo(1,2,3)//直接调用，this指向了foo的上一级对象。在这里没有，则指向了window，然后为window添加了属性a，属性b

foo.apply(obj,[1,2]);//this指向了obj，并且为obj添加了属性a 属性b

Function原型上还有一个call方法，功能和apply相似。只是接受参数有区别。
如果要实现上面一句
foo.call(obj,1,2) //call方法传递的参数是依次传的。apply传递的参数是一个数组
myJSFrame源代码分析(2)
本篇内容：选择器函数的字符串复杂匹配。
/++++++++++以下为正文部份++++++++++
/*34、*/	var path = argID.replace(/(^,*)|(,*$)/g,"").split(",");
			//定义局变path，值为 实参1 去头部和结尾的,(逗号)以后。以,（逗号）拆解的数组。
			//以调用 $('#testDIV,#list[0]')为实例

/*35、*/	var allelem = [];
			//定义局变allelem，用来暂存返回的elem集合。初始值为一个空的数组。

/*36、*/	for(var a=0,b; b=path[a]; a++){
			//第一层嵌套，局变a为下标，b为暂存。

/*37、*/		var p = b=path[a].trim().replace(/ +/g," ").split(" ");
				//局变p的值为当前循环下标处的值去除首尾空格，将多个空格替换成1个，然后以" "（空格）拆分的数组。

/*38、*/		for (var i=0,q; q=p[i]; i++){
				//第二层循环，局变i为下标，q为暂存。

/*39、*/			if (q.indexOf("#")==0){
					//当前循环中暂存q如果是以"#"(井字符)开头

/*40、*/				if(!document.getElementById(q.substring(1)))return null;
						//获取以 q 去掉井字符的值为ID的元素取反。如果结果集为空，则退出。

/*41、*/				elem = $(q.substring(1)); 
						//如果存在这个元素，调用选择器去获取。

/*42、*/				continue;
						//跳过当前循环
/*43、*/			}
/*44、*/			var attsel = [];
					//局变attsel（通过变量名推测为 根据属性选择的一个暂存数组）

/*45、*/			var elem_temp=[];
					//对象临时暂存数组。

/*46、*/			if (q.indexOf(".")!=-1){
					//如果 q 中存在"."(点字符)

/*47、*/				var tags = q.replace(/\[.*?\]/gi,function($1){attsel.push($1.replace(/\[|\]/g,""));return "";});
						//定义局变tags 
						/* q 为当前循环中的局变， replace为替换函数 /\[.*?\]/gi 这个正则匹配被[]（中括号）包裹的任意值
						.*? 点 匹配任意值 星 是量词0个或者更多个 ?表示量词为非贪心的，即尽量匹配最少的。
						gi选项，表示全局匹配，不匹分大小写。
						function($1){attsel.push($1.replace(/\[|\]/g,""));return "";}
						匹配到的值传递这个函数 $1即匹配值。 attsel.push 添加到数组的最后一维，值为前面模式匹配到的值去掉[]（中括号）后的值。
						函数返回的值为""（空）即tags的值是去掉属性的。*/

/*48、*/				var tag = tags.split(".")[0];
						//局变tag是tags以.拆分的第一个,表示标签名称

/*49、*/				var cn = tags.split(".")[1];
						//局变cn是tags以.拆分的第二个.通过上下文代码通读，这里应该是className即类名称的简写。表示class属性名称

/*50、*/				if (elem == null){
						//如果elem为null值

/*51、*/					elem_temp = $._find(tag,cn,arguments[1] || document);
							//elem_temp赋值为 $.find函数的结果
							/* $._find函数查找一个对象里面的具有某个类名的标签
							接受三个参数 tag 表示标签名称 cn表示类名 第三个参数为父对象。取$函数的第二个实参。如果不存在则为document对象，即在整个文档中查找。*/

/*52、*/				}else{
							//如果elem不为空，即41行代码执行成功。
/*53、*/					if (elem instanceof Array){
							//判断elem是否为数组的一个实例。即判断是否为数组
/*54、*/						var arr = [];
								//局变数组

/*55、*/						elem.each(function(obj){$._find(tag,cn,obj).each(function(){arr.push(arguments[0])});});
								//遍历elem，对elem的每一维执行一个函数，函数将elem设为父对象去查找带有指定class属性的标签，将返回的结果，遍历添加到arr临时数组

/*56、*/						elem_temp = arr;
								//elem_temp 赋值为 arr临时数组

/*57、*/					}else{
							//如果elem不是临时数组
/*58、*/						elem_temp = $._find(tag,cn,elem);
								//elem_temp赋值为$._find的结果
/*59、*/					}
/*60、*/				}

/*61、*/				elem = $._attributeSelector(attsel,elem_temp);
						//在elem_temp元素集合中筛选具有指定属性的元素。

/*62、*/				continue;
						//跳出
/*63、*/			}else{
					//如果q中不存在.（点字符）
/*64、*/				var tag = q.replace(/\[.*?\]/gi,function($1){attsel.push($1.replace(/\[|\]/g,""));return "";});
						//将q中的属性添加到attsel临时数组

/*65、*/				if(elem == null){
						//如果elem为null
/*66、*/					elem_temp = $A((arguments[1] || document).getElementsByTagName(tag)).each(function(obj){$(obj)});
							//给elem_temp赋值，结果为一个数组，里面的元素为$选择器返回的值。
							/*
								$A将一个集合转换为一个数组。HTMLDOM.getElementsByTagName(tagname)返回的结果是一个结果集，不是数组。
								数组调用each方法为每一个元素执行函数，该函数对每个元素调用$选择器函数。
							*/
/*67、*/				}else{
						//elem不为null值的情况
/*68、*/					if (elem instanceof Array){
							//如果elem是一个数组
/*69、*/						var arr = [];
/*70、*/						elem.each(function(obj){$A(obj.getElementsByTagName(tag)).each(function(obj){arr.push($(obj))})});
								//将数组中的每一维视为一个对象，查找该对象中指定标签，然后将得到的集合转化为数组，然后添加到arr
/*71、*/						elem_temp = arr;
								//赋值给elem_temp
/*72、*/					}else{
/*73、*/						elem_temp = $A(elem.getElementsByTagName(tag)).each(function(obj){$(obj)});
								//如果elem不是数组，以elem为对象查找其中的指定名称的标签，然后将得到的集合转化为数组，为数组的每一维执行$选择器方法。得到的结果赋值给elem_temp;
/*74、*/					}
/*75、*/				}
/*76、*/				elem = $._attributeSelector(attsel,elem_temp);
						//在elem_temp结果集中查找带有指定属性的。
/*77、*/			}
/*78、*/		}
/*79、*/		if(elem.constructor==Array){
/*80、*/			elem.each(function(obj){allelem.push(obj)});
/*81、*/		}else{
/*82、*/			allelem.push(elem);
/*83、*/		}
/*84、*/		elem = null;
				//筛选完成，如果elem结果是一个数组，就对每一维执行函数。添加到allelem数组中。如果不是数组，直接添加到allelem中。
/*85、*/	}
/*86、*/	return allelem;
			//返回
/*87、*/};
/*++++++++++++++++++++++++++++++++++++++++++++++++++未完待续
部分注解：
这段函数主要实现将传入的字符串去掉 首尾,（逗号）以,（逗号）拆分成数组进入第一层循环
以 " "（空格）拆分 进入第二层循环，然后进行按属性和css类的查找，将返回的结果组合成一个数组返回。
选择器函数主要逻辑至此完结。还有一些被分在独立函数中，稍后会逐一分析到。

文中有几处在一行javascript代码里面执行多个功能的
第47行*/
var tags = q.replace(/\[.*?\]/gi,function($1){attsel.push($1.replace(/\[|\]/g,""));return "";});
/*第55行*/
elem.each(function(obj){$._find(tag,cn,obj).each(function(){arr.push(arguments[0])});});
//等等，涉及到正则表达式，javascript的多层调用等。可能有些难以理解。如果看得吃力。可以试着拆解成多行。
var tags = q.replace(
	/\[.*?\]/gi,
	function($1){
		attsel.push($1.replace(/\[|\]/g,""));
		return "";
	}
);

elem.each(function(obj){
	$._find(tag,cn,obj).each(
		function(){
			arr.push(arguments[0])
		}
	);
});
/*选择器作为一个框架的核心部分，十分重要。几乎用来取决一个javascript框架的质量。
这个选择器比较简易，但还是能看到一些平常在书藉里，论坛上看不到的东西。
如果还有疑问，可以留下电子邮件。我可以传一份这个框架和框架的API文档，对照API文档去理解框架的一些内置方法。用
firebug（火狐浏览器的一个插件）的逐行功能，逐行查看程序的运行可能会容易理解一些。

myJSFrame源代码分析(3)
本篇内容：$选择器中调用的两个函数。
一个实现查找指定标签下的子标签和在指定集合中筛选带有指定属性的元素。
/+++++++++++++++++++++++++++++以下为正文部份++++++++++++++++++++++++++++++++++++++++
/*88*/$.Version = "0.2.1.5";
	//框架版本，也用来判断一个object是否被初始化。
/*89*/$._find = function(tag,cn,par){
	//查找带指定类名的标签，接受三个参数 tag 标签名 cn 类名 par父对象
/*90*/	var arr = par.getElementsByTagName(tag||"*");
	//临时数组，取你对象中的指定标签，如果为空则取所有标签。
/*91*/	var elem = [];
	//对象集合 局变
/*92*/	for(var i=0,j; j=arr[i]; i++){
/*93*/		if(j.className.hasSubString(cn," ")){elem.push($(j));}
	//遍历所有标签的className属性，返回其中带有cn名称的，添加至 elem数组
/*94*/	}
/*95*/	return elem;
	//返回
/*96*/};
/*97*/$._attributeSelector = function(attsel,elem_temp){
	//按属性查找，接收两个参数，属性 对象集合
/*98*/	for (var j=0; j<attsel.length; j++){
	//循环，j 为下标。
/*99*/		var elemArr = [];
	//局变，对象数组
/*100*/		var k=attsel[j].split(/=|!=/g);
	//局变，attsel当前下标以=(等于) !=(不等于)拆分
/*101*/		if(k.length==1){
	//如果属性中不存在= !=
/*102*/			elem_temp.each(function(n){
/*103*/				if(n.getAttribute(k[0].trim())){
/*104*/					elemArr.push(n);
/*105*/				}
	//遍历临时对象的集合，查找所有带有属性的对象。添加到elemArr数组
/*106*/			});
/*107*/		}else if(k.length>1){
	//如果属性中存在 = 和!=被拆分
/*108*/			elem_temp.each(function(n){
/*109*/				if(attsel[j].indexOf("!=")!=-1){
/*110*/					if(n.getAttribute(k[0].trim())!=k[1].trim()){
/*111*/						elemArr.push(n);
/*112*/					}
	//遍历临时对象集合，查找指定属性不等于值的对象，添加到数组
/*113*/				}else{
/*114*/					if(n.getAttribute(k[0].trim())==k[1].trim()){
/*115*/						elemArr.push(n);
/*116*/					}
	//遍历临时对象集合，查找指定属性等于值的对象，添加到数组
/*117*/				}
/*118*/			});						
/*119*/		}						
/*120*/		elem_temp.length = 0;
	//清零elem_temp
/*121*/		elem_temp = elemArr;
	//重写elem_temp值
/*122*/	}
/*123*/	return elem_temp; 
	//返回
/*124*/};
/*125*/function NameSpace(){};
	//初始化名称空间
/*126*/function StringBuffer(){this.data = []};
	//初始化字符串缓存。
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++未完待续
myJSFrame源代码分析(4)
本篇内容：$._Method.Element扩展方法集(上)
/++++++++++以下为正文部份++++++++++
/*127*/$._Method = {
		/*
			定义_Method方法集 类型是一个对象。使用 {}形式的简写
			可以看成是函数的静态变量，也可以看成是对象的属性。
		*/
/*128*/	Element	: function(){
		/*
			接受参数：none
			功能：扩展$选择器配匹的HTML DOM 元素对象
			实现原理：$函数将匹配到的 elem 作为this来调用 $._Method.Element函数。
			$._Method.Element函数里面给this添加内容，从而扩展了elem。
			示例:$._Method.Element.call(document.body);
		*/
/*129*/		this.version = $.Version;
		//添加version属性，值为框架版本号。
/*130*/		this.hide = function(){this.style.display="none"; return this};
		/*
			接受参数：none
			功能：使元素不可见
			实现原理：设置元素的style对象的display属性的值为none
			示例:$(document.body).hide();
		*/
/*131*/		this.show = function(){this.style.display=""; return this};
		/*
			接受参数：none
			功能：使元素可见
			实现原理：设置元素的style对象的display属性的值为""(空)
			在这里有一个兼容性问题，firefox(火狐浏览器）里面的表格跨行在display设为none隐藏后，
			若再设为display为block，跨行就会失效。所以设为""
			这个bug直到我现在用的3.6版本依然存在
			示例:$(document.body).show();
		*/
/*132*/		this.getStyle = function(s){
/*133*/			var value = this.style[s=="float"?($.Browse.isIE()?"styleFloat":"cssFloat"):s.camelize()];
/*134*/			if (!value){
/*135*/				if (this.currentStyle){
/*136*/					value = this.currentStyle[s.camelize()];
/*137*/				}else if (document.defaultView && document.defaultView.getComputedStyle){
/*138*/					var css = document.defaultView.getComputedStyle(this, null);
/*139*/					value = css ? css.getPropertyValue(s) : null;
/*140*/				}
/*141*/			}
/*142*/			return value;
/*143*/		};
		/*
			接受参数：string 样式名
			功能：获取指定名称的样式
			实现原理：首先尝试从dom对象上面读取style对象的值。
			如果浏览器是ie,当获取float属性时，返回style对象的styleFloat属性，其它浏览器返回cssFloat属性。
			接受的参数调用扩展String对象的方法camelize，该函数将margin-left这样的css属性转换成marginLeft这样的js读取的属性。
			
			如果从style上面未获取到(css文件里面继承的属性无法从dom上面直接读取)
			先尝试currentStyle属性(IE系列的浏览器)如果有。从currStyle上面获取
			如果没有currentStyle再尝试document.defaultView(NS系列浏览器)
			调用document.defaultView.getComputedStyle方法获取指定属性。
			示例:$(document.body).getStyle('background-color');
		*/
/*144*/		this.setStyle = function(s){
/*145*/			var sList = s.split(";");
/*146*/			for (var i=0,j; j=sList[i]; i++){
/*147*/				var k = j.split(/:(?!\/\/)/g);
/*148*/				var key = k[0].trim();
/*149*/				key=key=="float"?($.Browse.isIE()?"styleFloat":"cssFloat"):key.camelize();
/*150*/				this.style[key] = k[1].trim();
/*151*/			}
/*152*/			return this;
/*153*/		};
		
		/*
			接受参数：string 样式字符串
			功能：设置样式。
			实现原理：将参数先以;(分号)分拆为数组，遍历。再对每一维以:(冒号)分拆。
			设置将分拆后的结果第一维作为元素的style对象的属性名，第二维作值。
			属性名处理规则同上面函数相同
			示例:$(document.body).setStyle('width:100px; height:200px; padding:10px; margin:0 auto;');
		*/
/*154*/		this.toggle = function(){this.getStyle("display")=="none"?this.show():this.hide(); return this};
		/*
			接受参数：none
			功能：切换 显示/隐藏
			实现原理：获取display样式，根据获取的值调用show方法或者hide方法
			示例：$(document.body).toggle();
		*/
/*155*/		this.hasClassName = function(c){return this.className.hasSubString(c," ");};
		/*
			接受参数：string 类名
			功能：查找元素的class属性是否包含指定的字符串。
			实现原理：通过调用作者扩展String对象的hasSubString实现。
			hasSubstring方法调用indexOf检测是否有指定值。是则返回true。
			示例：$(document.body).hasClassName('style1');
		*/
/*156*/		this.addClassName = function(c){if(!this.hasClassName(c)){this.className+=" "+c};return this};
		/*
			接受参数：string 类名
			功能：添加一个class类名。
			实现原理：先检测是否已有指定类，如果没有，则使元素的className属性加上 " "空格和传入的类名。
			示例：$(document.body).addClassName('style1');
		*/
/*157*/		this.removeClassName = function(c){if(this.hasClassName(c)){this.className = (" "+this.className+" ").replace(" "+c+" "," ").trim(); return this}};
		/*
			接受参数：string 类名
			功能：移除一个class类名。
			实现原理：先检测是否已有指定类，如果有，则修改元素的className属性，使用正则替换。
			为了方便替换。还预先在两端加上空格。替换后的值修减空格。
			示例：$(document.body).removeClassName('style1');
		*/
/*158*/		this.toggleClassName = function(c){if(this.hasClassName(c)){this.removeClassName(c);}else{this.addClassName(c);};return this;};
		/*
			接受参数：string 类名
			功能：添加/移除 类名实现切换。
			实现原理：检测是否有指定类名，有则删除，没有则添加。
			示例：$(document.body).toggleClassName('style1');
		*/
/*159*/		this.getElementsByClassName = function(c){return this.getElementsByAttribute("className",c)};
		/*
			接受参数：string 类名
			功能：获取元素下指定类名的子元素
			实现原理：通过调用getElementsByAttribute设置属性为className来实现。
			示例：$(document.body).getElementsByClassName('list');
		*/
/*160*/		this.getElementsByAttribute = function(n,v){
/*161*/			var elems = this.getElementsByTagName("*");
/*162*/			var elemList = [];
/*163*/			for (var i=0,j; j=elems[i]; i++){
/*164*/				var att = j[n] || j.getAttribute(n);
/*165*/				if (att==v){
/*166*/					elemList.push(j);
/*167*/				}
/*168*/			}
/*169*/			return elemList;
/*170*/		};
		/*
			接受参数：string 属性名 string 属性值
			功能：获取元素下带有指定属性名和值的子元素
			实现原理：获取带有带指定属性的子元素，上面一个方法的实现，即调用这个方法查找带有className属性的子元素。
			实现很简单，获取该元素下的所有 tag，然后遍历比较属性。
			示例：$(document.body).getElementsByAttribute('a','hot');
		*/
/*171*/		this.subTag = function(){return $A(this.getElementsByTagName(arguments[0])).each(function(n){$(n);});};
		/*
			接受参数：string 标签名
			功能：获取指定标签名的子元素
			实现原理：通过dom的getElementsByTagName方法获取参数传入的标签名，通过$A转化为数组
			遍历数组，对每一维都调用$函数进行扩展。
			示例：$(document.body).subTag('table');
		*/
/*172*/		this.parentIndex = function(p){
/*173*/			if (this==p){return 0}			
/*174*/			for (var i=1,n=this; n=n.parentNode; i++){
/*175*/				if(n==p){return i;}
/*176*/				if(n==document.documentElement) return -1;
/*177*/			}
/*178*/		};
		/*
			接受参数：HTML Element 元素
			功能：当前元素是指定元素的第几层子元素
			实现原理：循环设置parentNode，直到相等，或者到达document.documentElement(HTML文档对象)
			示例:$(document.body.childNodes[0]).parentIndex(document.body);
		*/
/*++++++++++++++++++++++++++++++++++++++++++++++++++未完待续
myJSFrame源代码分析(5)
本篇内容：$._Method.Element扩展方法集(下)、$._Method.Array 数组扩展方法集
/++++++++++以下为正文部份++++++++++
/*179*/		this.remove = function(){
/*180*/			if(!this||!window.recycler)return;
/*181*/			window.recycler.appendChild(this);
/*182*/			window.recycler.innerHTML="";
/*183*/		};
		/*
			接受参数：none
			功能：移除当前元素
			实现原理：recycler是一个绝对定位的div,将当前对象指向的元素添加至recycler，
			再设置recycler的innerHTML为""空。
			示例:$('#testdiv').remove();
		*/
/*184*/		this.nextElement = function(){
/*185*/			var n = this;
/*186*/			for (var i=0,n; n = n.nextSibling; i++){
/*187*/				if(n.nodeType==1) return $(n);
/*188*/			}
/*189*/			return null;
/*190*/		};
		/*
			接受参数：none
			功能：获取当前元素所处树中的下一个元素
			实现原理：调用nextSibling方法获取下一个节点，判断下一个节点的类型。
			如果为1(即元素类型)则调用$方法扩展该元素并返回。
			示例:$('#testdiv').nextElement();
		*/
/*191*/		this.previousElement = function(){
/*192*/			var n = this;
/*193*/			for (var i=0,n; n = n.previousSibling; i++){
/*194*/				if(n.nodeType==1) return $(n);
/*195*/			}
/*196*/			return null;
/*197*/		};
		/*
			接受参数：none
			功能：获取当前元素所处树中的上一个元素
			实现原理：调用previousSibling方法获取上一个节点，判断上一个节点的类型。
			如果为1(即元素类型)则调用$方法扩展该元素并返回。
			示例:$('#testdiv').previousElement();
		*/
/*198*/		this.subElem = function(css){
/*199*/			return $(css,this);
/*200*/		};
		/*
			接受参数：string CSS选择器规则
			功能：查找子元素
			实现原理：给$函数传入CSS规则，并传入自身作为上下文对象。
			示例:$('#testdiv').subElem('input[type=text]');
		*/
/*201*/		this.findParent = function(p){
/*202*/			for(var i=0,n=this; n=n.parentNode; i++){
/*203*/				if(n==document.documentElement || n==document.body) break;
/*204*/				var t = 0;
/*205*/				for(var key in p){
/*206*/					var m = n.key || n[key] || n.getAttribute(key);
/*207*/					if(m!=p[key]){t++;break;}
/*208*/				}
/*209*/				if(t==0) return n;
/*210*/			}
/*211*/			return null;
/*212*/		};
		/*
			接受参数：object 条件
			功能：查找子元素
			实现原理：循环向父级引用，检测引用到的对象如果达到document.documentElement根级，就退出循环，返回null。
			否则遍历传入的条件，对比。如果全部符合则返回。
			示例：$('#testdiv').findParent({className:"container", myAttribute:"hello", tagName:"DIV"});
		*/
/*213*/	},
/*214*/	Array :	function(){
		//扩展给Array数组的方法
/*215*/		this.indexOf = function(){
/*216*/			for (i=0; i<this.length; i++){
/*217*/				if (this[i]==arguments[0])
/*218*/					return i;
/*219*/			}
/*220*/			return -1;
/*221*/ 	};
		/*
			接受参数：var 要查找的值
			功能：接受一个值，返回该值首次出现在数组中的位置
			实现原理：遍历数组，对比值。值相同返回该下标。
			示例：['a','b','c','d'].indexOf('d'); 
		*/
/*222*/		this.each = function(fn){
/*223*/			for (var i=0,len=this.length; i<len; i++){
/*224*/				fn(this[i],i);
/*225*/			}
/*226*/			return this;
/*227*/		};
		/*
			接受参数：function 要调用的函数
			功能：接受一个函数，对数组中的值进行处理。
			实现原理：遍历数组将数组中的每一维值作为第一个参数，下标作为第二个参数调用该函数。
			示例：[1,2,3,4,5].each(function(i,n){ console.log(i+':'+n); });
		*/
/*228*/		this.sortByValue = function(t){
/*229*/			for (var i=this.length; i>0; i>>=1){
/*230*/				for(var j=0; j<i; j++){
/*231*/					for (var x = i+j; x<this.length; x=x+i){
/*232*/						var v = this[x];
/*233*/						var y = x;
/*234*/						while( y>=i && t?this[y-1]<v:this[y-i]>v){
/*235*/							this[y] = this[y-i];
/*236*/							y = y-i;
/*237*/						}
/*238*/						this[y] = v;
/*239*/					}
/*240*/				}		
/*241*/			}
/*242*/			return this;
/*243*/		};
		/*
			接受参数：bool 决定升序还是降序。
			功能：接受一个函数，对数组中的值进行排序。参数为真则降序，否则为升序。
			实现原理：javascript版本希尔排序。有兴趣深入的，可自行查找相关资料。
			示例：[3,2,1,5,4].sortByValue();
		*/
/*244*/	},
/*++++++++++++++++++++++++++++++++++++++++++++++++++未完待续
myJSFrame源代码分析(6)
本篇内容：$._Method.String,Function,StringBuffer,NameSpace扩展方法集
/+++++++++++++++++++++++++++++以下为正文部份++++++++++++++++++++++++++++++++++++++++
/*245*/
/*246*/	String : function(){
/*247*/		this.trim = function(){
/*248*/			var _argument = arguments[0]==undefined ? " ":arguments[0];
/*249*/			if(typeof(_argument)=="string"){
/*250*/				return this.replace(_argument == " "?/(^\s*)|(\s*$)/g : new RegExp("(^"+_argument+"*)|("+_argument+"*$)","g"),"");
/*251*/			}else if(typeof(_argument)=="object"){
/*252*/				return this.replace(_argument,"")
/*253*/			}else if(typeof(_argument)=="number" && arguments.length>=1){
/*254*/				return arguments.length==1? this.substring(arguments[0]) : this.substring(arguments[0],this.length-arguments[1]);
/*255*/			}
/*256*/		};
		/*
			接受参数：string|regexp|number 字符串或者正则表达式或者数字
			功能：根据传入的参数类型来修剪字符串。如果传入的是一个字符，则修剪该字符。如果是一个正则表达式，则修剪该正则表达式匹配的。
			如果传入的是数字，则调用substring来获取数字指定的子集。
			实现原理：使用replace函数来替换正则匹配的字符，substring函数来获取指定子集。
			示例:'         aaaa        '.trim();
		*/
/*257*/		this.stripTags = function(){
/*258*/			return this.replace(/<\/?[^>]+>/gi, '');
/*259*/		};
		/*
			接受参数：none
			功能：去除html标签
			实现原理：使用正则表达式 /<\/?[^>]+>/gi 匹配html标签，替换为''空字符。
			示例:'<a href="#">这是链接文字</a>'.stripTags();
		*/
/*260*/		this.cint = function(){
/*261*/		    return this.replace(/\D/g,"")*1;
/*262*/		};
		/*
			接受参数：none
			功能：转换成数字
			实现原理：使用 /\D/g 匹配非数字，替换为空。剩余字符串*(乘)1。(利用了javascript的隐式转换)
			示例:'         aaaa        '.trim();
		*/
/*263*/		this.camelize = function(){
/*264*/			return this.replace(/(-\S)/g,function($1){return $1.toUpperCase().substring(1,2)});
/*265*/		};
		/*
			接受参数：none
			功能：将一个css属性转换为一个javascript样式属性。
			实现原理：使用正则表达式 -\S 匹配-(连字符)后跟的一个字母，然后转换为大写。
			示例: 'line-height'.camelize() //转换为 'lineHeight' 。
		*/
/*266*/		this.hasSubString = function(s,f){
/*267*/			if(!f) f="";
/*268*/			return (f+this+f).indexOf(f+s+f)==-1?false:true;
/*269*/		};
		/*
			接受参数：string,string 一个是用来查找的子串，一个是子串边界。
			功能：检测一个字符串中是否存在指定字符串的子串。
			实现原理：使用原生indexOf方法，检测指定字符串位置。
			示例: 'line-height'.indexOf('line')
		*/
/*270*/		this.hasSubStrInArr = function(){
/*271*/			for(var i=0; i<arguments[0].length; i++){
/*272*/				if(this.hasSubString(arguments[0][i])){return true;}
/*273*/			}
/*274*/			return false;
/*275*/		};
		/*
			接受参数：array 一个字符串数组
			功能：功能和上面函数相同，这个接受的是一个字符串数组。
			实现原理：遍历数组，调用上面的函数检测是否有子串，有则返回。
			示例: 'line-height'.indexOf(['line','height'])
		*/
/*276*/		this.toXMLString = function(){
/*277*/			var arr = this.split("&");
/*278*/			var str = new StringBuffer();
/*279*/			for (var i=0,len=arr.length; i<len; i++){
/*280*/				var item = arr[i].split("=");
/*281*/				str.append("<"+item[0]+"><![CDATA["+item[1]+"]]></"+item[0]+">");
/*282*/			}
/*283*/			var rootStr = arguments[0]?arguments[0]:"root";
/*284*/			return "<"+rootStr+">"+str.toString()+"</"+rootStr+">";
/*285*/		};
		/*
			接受参数：string 可选的xml根标签名
			功能：将一个url参数字符串转换为xml字符串。
			实现原理：选以&拆分成数组遍历，将当前维以=拆分成标签和值生成xml，此处用到了StringBuffer()，以提高效率。
			示例: 'abc=123&def=456'.toXMLString('test') //<test><abc><![CDATA[123]]></abc><def><![CDATA[456]]></def></test>
		*/
/*286*/		this.format = function(){
/*287*/			var p = arguments;
/*288*/			return this.replace(/(\{\d+\})/g,function(){
/*289*/				return p[arguments[0].replace(/\D/g,"")];
/*290*/			});		
/*291*/		};
		/*
			接受参数：string... 接受一个或多字符串
			功能：将一个字符串模板中的位置替换为传入的参数。
			实现原理：利用正则表达式匹配出{*}这种格式的数字串，替换的值为函数的返顺值(匹配的值自动传入该函数)。
			函数从匹配的值中匹配出数字，以该数字为下标，返回指定位置的传入参数。
			示例:  '测试一个数字输出:{0}'.format(111); //"测试一个数字输出:111"
		*/
/*292*/		this.uniq = function(){			
/*293*/			var arr = this.split("");
/*294*/			var obj = {};
/*295*/			for(var i=0,j; j=arr[i]; i++){
/*296*/				obj[j] = i;
/*297*/			}
/*298*/			var s = [];
/*299*/			for(var key in obj){
/*300*/				s[obj[key]]=key;
/*301*/			}
/*302*/			return s.join("");
/*303*/		};
		/*
			接受参数：none
			功能：去除符字串中的重复
			实现原理：将字符串拆分成单个，遍历。以每一维的值作为临时对象obj的属性，下标作为该属性的值。
			再遍历临时对象arr，将属性添加到数组。(这个地方巧妙的利用下标还原了原始字符串的位置。
			在某些javascript上擎里for in循环的顺序是不固定的）将数组联合成一个字符串返回。
			示例:  '测试一个数字输出:{0}'.format(111); //"测试一个数字输出:111"
		*/
/*304*/	},
/*305*/	Function : function(){
/*306*/		this.bind = function() {
/*307*/			var __method = this, args = $A(arguments), object = args.shift();
/*308*/			return function() {
/*309*/				return __method.apply(object, args.concat($A(arguments)));
/*310*/			}
/*311*/		};
		/*
			接受参数：none
			功能：返回一个绑定了对象的方法
			实现原理：先暂存当前函数为__method ，args为参数数组。取args的第一维为当前对象。
			返回一个函数。该函数利用闭包访问__method暂存的函数。使用apply替换this指向，并传入参数。
			示例: obj = {a:1};f = function(){console.log(this.a)};e = f.bind(obj); e(); //弹出对话框1
		*/
/*312*/	},
/*313*/	StringBuffer : function(){
/*314*/		this.append = function(){this.data.push(arguments[0]);return this};
			//在stringbuffer对象中添加一维
/*315*/		this.toString = function(){return this.data.join(arguments[0]||"")};
			//返回字符串。
/*316*/		this.length = function(){return this.data.length};
			//返回长度
/*317*/		this.clear = function(){this.data.length=0; return this;}
			//清空
/*318*/	},
		//stringbuffer对象是用在字符串多次做+(并连)操作的时候。利用数组将添加的字符串加入队列。在用的时候数组联合成的字符串。
/*319*/	NameSpace : function(){
/*320*/		this.copyChild = function(ns){
/*321*/			for (var key in ns){
/*322*/				this[key] = ns[key];
/*323*/			}
/*324*/			return this;
/*325*/		};
/*326*/	}
		//名称空间。添加的copyChild用来将一个对象的属性复制过来。
/*327*/};
/*328*/
/*329*/$._Method.Array.apply(Array.prototype);
		//将Array.prototype作为当前上下文对象调用$._Method.Array函数。来扩充数组原型
/*330*/$._Method.String.apply(String.prototype);
		//将String.prototype作为当前上下文对象调用$._Method.String函数。来扩充字符串原型
/*331*/$._Method.Function.apply(Function.prototype);
		//将Function.prototype作为当前上下文对象调用$._Method.Function函数。来扩充函数原型
/*332*/$._Method.StringBuffer.apply(StringBuffer.prototype);
		//将StringBuffer.prototype作为当前上下文对象调用$._Method.StringBuffer函数。来扩充StringBuffer原型
/*333*/$._Method.NameSpace.apply(NameSpace.prototype);
		//将NameSpace.prototype作为当前上下文对象调用$._Method.NameSpace函数来扩展NameSpace原型
/*334*/
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++未完待续
myJSFrame源代码分析(7)
本篇内容：浏览器判断、Ajax封装、Cookie封装
/+++++++++++++++++++++++++++++以下为正文部份++++++++++++++++++++++++++++++++++++++++
/*335*/$.Browse = {
/*336*/	isIE : function(){return navigator.userAgent.hasSubString("MSIE");},
/*337*/	isFF : function(){return navigator.userAgent.hasSubString("Firefox");},
/*338*/	isOpera : function(){return navigator.userAgent.hasSubString("Opera")},
/*339*/	isSafari : function(){return navigator.userAgent.hasSubString("Safari");},
/*340*/	isGecko : function(){return navigator.userAgent.hasSubString("Gecko");},
/*341*/	IEVer : function(){return $.Browse.isIE() ? parseInt(navigator.userAgent.split(";")[1].trim().split(" ")[1]) : 0;}
/*342*/};
			/*浏览器判断函数
				isIE,判断是否为IE浏览器
				isFF,判断是否为Firefox浏览器
				isOpera判断是否为Opera浏览器
				isSafari判断是否为Apple Safari浏览器
				isGecko判断是否为Gecko内核浏览器
				IEVer 如果浏览器是IE则显示版本号
				
				实现原理，navigator对象中的userAgent信息保存着用户提交的http头信息。该信息中包含着浏览器版本信息，以及支持插件等等。
				通过在navigator对象的userAgent中查找指定字符串，来判断浏览器类型。某些浏览器可修改这个头。
				navigator对象是一个宿主对象。由浏览器环境提供。
			*/
/*343*/$(document);
			//扩展document对象，让document拥有Element扩展。
/*344*/
/*345*/var Ajax={
/*346*/	xmlhttp:function (){
/*347*/		var obj = null;	
/*348*/		try{
/*349*/			obj = new ActiveXObject('Msxml2.XMLHTTP');
/*350*/		}catch(e){
/*351*/			try{
/*352*/				obj = new ActiveXObject('Microsoft.XMLHTTP');
/*353*/			}catch(e){
/*354*/				obj = new XMLHttpRequest();
/*355*/			}
/*356*/		}
/*357*/		return Ajax.xmlObjCache = obj;
/*358*/	},xmlObjCache:null
/*359*/};
			/*
				初始化Ajax对象。xmlhttp方法初始化xmlhttp组件。
			*/
/*360*/Ajax.Request=function (){
/*361*/	if(arguments.length<2)return ;
		//如果传入参数长度小于2个直接退出。
/*362*/	var para = {asynchronous:true,method:"GET",parameters:""};
		//初始化xmlhttp参数对象
/*363*/	for (var key in arguments[1]){
/*364*/		para[key] = arguments[1][key];
/*365*/	}
		//遍历xmlhttp的参数对象，将传入的值赋给xmlhttp参数对象。
/*366*/	var _x= Ajax.xmlhttp(); //Ajax.xmlObjCache || 
		//初始化xmlhttp组件
/*367*/	var _url=arguments[0];
		//初始化url //请求将要发送的路径
/*368*/	if(para["parameters"].length>0) para["parameters"]+='&_=';
		//如果参数不为空，则加上&_=
/*369*/	if(para["method"].toUpperCase()=="GET") _url+=(_url.match(/\?/)?'&':'?')+para["parameters"];
		//如果提交方法为GET则检测url中是否有?(问号)如果有则用'&"连接参数，如果没有则用'?'连接参娄
/*370*/	_x.open(para["method"].toUpperCase(),_url,para["asynchronous"]);
		//发起请求
/*371*/	_x.onreadystatechange=Ajax.onStateChange.bind(_x,para);
		//绑定事件（用到了扩展给Function的bind方法
/*372*/	if(para["method"].toUpperCase()=="POST")_x.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//如果是post方式提交，则发送post头
/*373*/	for (var ReqHeader in para["setRequestHeader"]){
/*374*/		_x.setRequestHeader(ReqHeader,para["setRequestHeader"][ReqHeader]);
/*375*/	}
		//如果传入的参数有http头信息，则遍历设置头信息。如果请求的页面是GB2312为了确保返回值不是乱码，需调置头信息。
/*376*/	_x.send(para["method"].toUpperCase()=="POST"?(para["postBody"]?para["postBody"]:para["parameters"]):null);
		//发送请求
/*377*/	return _x;
		//返回当前xmlhttp对象实例
/*378*/};
/*379*/Ajax.onStateChange = function(para){
/*380*/	if(this.readyState==4){
/*381*/		if(this.status==200)
/*382*/			para["onComplete"]?para["onComplete"](this):"";
/*383*/		else{
/*384*/			para["onError"]?para["onError"](this):"";
/*385*/		}
/*386*/	}
/*387*/};
		/*回调函数
			ajax请求分为同步和异步两种模式。
			同步模式下，send发送请求后，执行的代码会被挂起在那一行，等待返回结果后继续执行。
			异步模式下，send发关请求后，继续执行，当返回结果的时候，会用调用注册的回调函数。
			(现在各个框架提供的ajax多为异步模式)
			readState是当前请求的状态 4表示整个请求过成完毕
			status是返回的状态 200表示返回正确
			如果返回值不是200则调用onError错误处理函数。
		*/
/*388*/$.Ajax = {
/*389*/	Request : function(url,_method,para,complete,error){return Ajax.Request(url,{method:_method||"get",parameters:para||"",onComplete:complete,onError:error});},
/*390*/	get	: function(url,complete,error){ return $.Ajax.Request(url+(url.indexOf("?")==-1?"?":"&")+Math.random(),"get","",complete,error); },
/*391*/	post : function(url,para,complete,error){ return $.Ajax.Request(url,"post",para,complete,error);},
/*392*/	postXML : function(url,xmlString,complete,error){return myAjax = new Ajax.Request(url,{method:"post",postBody:xmlString,setRequestHeader:{"content-Type":"text/xml"},onComplete:complete,onError:error});},
/*393*/	update : function(url,id){ return $.Ajax.Request(url,(arguments[2]?"post":"get"),(arguments[2]?arguments[2]:Math.random()),function(x){if("INPUT,SELECT,BUTTON,TEXTAREA".hasSubString($(id).tagName,",")){$(id).value=x.responseText;}else{$(id).innerHTML=x.responseText;}});}
/*394*/};
		/*
			在$上面挂载Ajax对象，带有5个方法。
			这5个方法均是在上面Ajax对象的基础上建立的。
			Request：发送一个请求，可手动指定所有请求参数。
			get: 发送一个get请求
			post: 发送一个post请求
			postXML:发送一个post请求，附带的值是一个xml字符串
			update: 发送一个请求，将返回的值赋给指定ID的容器
		*/
/*395*/$.Cookies = {
/*396*/    get : function(n){
			//接受参数n即要获取的cookie名称
/*397*/	    var dc = "; "+document.cookie+"; ";
			//局变dc 值为document.cookie首尾加上;(分号)
/*398*/	    var coo = dc.indexOf("; "+n+"=");
			//局变coo 是一个下标的位置，后面用来标识想要查找的cookie起始位置
/*399*/	    if (coo!=-1){
				//如果存在要查找的cookie
/*400*/		    var s = dc.substring(coo+n.length+3,dc.length);
				//获取从值起始位置。
/*401*/		    return unescape(s.substring(0, s.indexOf("; ")));
				//截取从值起始位置到下一个分号前的内容，调用unescape解码，并返回。
/*402*/	    }else{
/*403*/		    return null;
				//如果不存在指定cookie值则返回空。
/*404*/	    }
/*405*/    },
/*406*/    set : function(name,value,expires,path,domain,secure){
			/*设置cookie接受的参数有
				name cookie名称
				value cookie的值
				expires 过期时间
				path 路径
				domain 路径
				secure 是否只在安全网络上传输
			*/
			
/*407*/        var expDays = expires*24*60*60*1000;
				//将过期时间数值转换为天的毫秒值。
/*408*/        var expDate = new Date();
				//初始化时间
/*409*/        expDate.setTime(expDate.getTime()+expDays);
				//设置过期时间的值
/*410*/        var expString = expires ? "; expires="+expDate.toGMTString() : "";
				//设置写入到cookie里面的过期时间字符串。如果没有设置过期时间，则为空。
/*411*/        var pathString = "; path="+(path||"/");
				//设置路径，如果没有则默认为/根路径。
/*412*/		var domain = domain ? "; domain="+domain : "";
				//设置cookie域
/*413*/        document.cookie = name + "=" + escape(value) + expString + domain + pathString + (secure?"; secure":"");
				//写入cookie
/*414*/    },
/*415*/    del : function(n){
			/*
				n 要删除的cookie的名称
			*/
/*416*/	    var exp = new Date();
				//初始化一个时间变量临时值。
/*417*/	    exp.setTime(exp.getTime() - 1);
				//设置时间值小于当前时间。
/*418*/	    var cval=this.get(n);
				//读取cookie
/*419*/	    if(cval!=null) document.cookie= n + "="+cval+";expires="+exp.toGMTString();
				//如果存在指定的cookie则将指定的cookie的过期时间设置为小于当前时间。使该cookie失效
/*420*/    }
/*421*/};
		/*
			封装的cookie函数
			javascript里面的cookie是通过读取和设置document.cookie的值来实现的。
			读取的值以;(分号)分隔成key=value的形式。
			
		*/
/*422*/$.Form = function(n){
/*423*/	var f = typeof n =="string" ? document.forms[n] : n;
			//定义局变f 如果传入的参数n为字符串，则返回document.forms中以n为下标的表单，则否返回n
/*424*/	$.Form._Method.apply(f);
			//调用下面定义的$.Form._Method扩展f
/*425*/	return f;
			//返回f
/*426*/};
		/*
			获取页面指定表单
			示例：$.Form('form1');
		*/
/*427*/$.Form._Method = function(){
		//$.Form._Method方法集
/*428*/	this.serialize = function(obj){
			//扩展的serialize方法 接受一个参数obj
/*429*/			var arr = this.elements;
					//定义局变arr 值为上下文对象的elements属性;
/*430*/			var elem = {};
					//定义局变elem
/*431*/			for(var i=0,j; j=arr[i]; i++){
						//遍历局变arr
/*432*/				if(j.disabled || !j.name){continue;}
						//如果循环的当前维元素已被禁止或者未定义名称，则跳过。
/*433*/				if(j.type && j.type.toLowerCase().hasSubStrInArr(["radio","checkbox"]) && !j.checked){continue;}
						//如果循环的当前维元素的类型为radio（单元）或者（checkbox）多选，并且示被选择，则跳过。
/*434*/				var na = j.name.toLowerCase();
						//局变na 值为循环的当前维元素的name属性的小写值。
/*435*/				if(typeof elem[na] == "undefined"){
/*436*/					elem[na] = [];
							//如果elem中不存na下标，则赋值elem的na下标为空数组
/*437*/				}
/*438*/				elem[na].push($E(j.value));
						//获取循环的当前维的元素的值，添加到elem的na下标中。
/*439*/			}
/*440*/			return $.Form.serialize(obj,elem);
					//返回一个序列化的数组
/*441*/		};
			/*
				串行化表单，将表单转化成 key1=value1&key2=value2 形式
				接受一个参数，参数为对象。将对象中的键和值添加到串行化的数据中。
			*/
/*442*/};
/*443*/$.Form.serialize = function(obj){
/*444*/	var elem = arguments[1] || {};
		//定义局部变量elem，值为第二个参数，如果未传递第二个参数，则为空对象。
/*445*/	for(var key in obj){
/*446*/		var na = key.toLowerCase();
/*447*/		if(typeof elem[na] == "undefined"){
/*448*/			elem[na] = [];
/*449*/		}
/*450*/		elem[na].push($E(obj[key]));
/*451*/	}
		//遍历obj，对比elem如果elem中该元素为空，则将该元素添加到elem对象
/*452*/	var para = new StringBuffer();
		//定义para字符串缓存对象。
/*453*/	for(var name in elem){
/*454*/		for(var i=0; i<elem[name].length; i++){
/*455*/			para.append(name+"="+elem[name][i]);
/*456*/		}
/*457*/	}
		//将elem对象转化为字符串
/*458*/	return para.toString("&");
		//返回串行化后的字符串
		/*
			虚拟化一个表单，接受的参数为一个对象，将对象生成 键对值 的字符串。
		*/
/*459*/};
/*460*/
/*myJSFrame源代码分析(8)
本篇内容：DOM加载完毕检测及一些快捷方法
/+++++++++++++++++++++++++++++以下为正文部份++++++++++++++++++++++++++++++++++++++++
/*461*/$.Request = function(paras){
/*462*/	var url = location.search;
		//定义局变url值为 url路径中以?(问号)开头的部份
/*463*/	if(!url.hasSubString("?")){return "";}else{url=url.substring(1);};
		//如果url局变中不存在?(问号)则退出，否则取?(问号)以后的部份
/*464*/	var obj = {};
		//定义局变obj为一个空的对象
/*465*/	url.split("&").each(function(p){
		//url以&拆分成数组遍历。
/*466*/		var k = p.split("=");
			//局变k为循还当前维以=(等号)拆分
/*467*/		var n = k[0].toLowerCase();	
			//定义局变n为k的第一维。
/*468*/		obj[n] = k[1] || "";
			//obj中添加一维 以n为属性名，以k的第二维或者""为值。
/*469*/	});
/*470*/	return obj[paras.toLowerCase()] || "";
		//返回要查找的值或者名""空。
/*471*/};
		/*
			析取url参数中的值。
			在[url]http://abc.com/test.do?abc=1&def=2[/url] 这样的页面中 $.Request('abc') 返回值为 1
		*/
/*472*/$.Redirect = function(url,paraStr){
/*473*/	if(!paraStr){
/*474*/		setTimeout(function(){location.href=url;},10);
/*475*/		return;
/*476*/	}
		//如果未定义paraStr参数，则10毫秒后转向参数url标示的地址。
/*477*/	var obj = {};
		//定义局变obj为一个空对象
/*478*/	if(url.indexOf("?")!=-1){
		//如果url中存在问号。
/*479*/		var s = url.substring(url.indexOf("?")+1).split("&");
/*480*/		for(var i=0; i<s.length; i++){
/*481*/			var j=s[i].split("=");
/*482*/			obj[j[0].toString().toLowerCase()]=j[1]||"";
/*483*/		}
			//将s以&折分再以=拆分添加到obj中
/*484*/	}
/*485*/	var t = paraStr.split("&");
/*486*/	for(var i=0; i<t.length; i++){
/*487*/		var j = t[i].split("=");
/*488*/		obj[j[0].toString().toLowerCase()]=j[1]||"";
/*489*/	}
		//将paraStr以&拆分再以=拆分添加obj中
/*490*/	var str = [];
		//定义局变str为一个空数组
/*491*/	for(var p in obj){
/*492*/		str.push(p+"="+obj[p]);
/*493*/	}
		//定obj添加到数组p中
/*494*/	setTimeout(function(){location.href=url.substring(0,url.indexOf("?"))+"?"+str.join("&");},10);
		//10毫秒后转向至url参数所标示地址，并传递paraStr参数。(url所带参数也保留)
/*495*/};
		/*
			跳转至指定页面
			接受两个参数
			url:要跳转到的地址
			paraStr:附带的参数
		*/
/*496*/$.Import = function(url){
/*497*/	var myAjax = new Ajax.Request(
/*498*/		url,
/*499*/		{
/*500*/			asynchronous:false,
/*501*/			onComplete:function(x){
/*502*/				var js = document.createElement("script");
/*503*/				js.type = "text/javascript";
/*504*/				js.defer = "defer";
/*505*/				js.text = x.responseText;
/*506*/				document.getElementsByTagName("head")[0].appendChild(js);			
/*507*/			},
/*508*/			onError:function(x){
/*509*/				console.log("Loading script file occur an error:"+x.statusText);
/*510*/			}
/*511*/		}
/*512*/	);
/*513*/};
		/*
			导入一个外部js文件。
			通过Ajax.Request请求一个外部js文件。
			请求成功后，创建script对象，设置type属性和defer(ie特有延时处理)属性。
			设置script对象的text为加载到的js文本
			将script对象添加到文中。
		*/
/*514*/
/*515*/
/*516*/$.DOMReady = function(f){
/*517*/	$.DOMReady._methodArgument = f;
/*518*/	return $.DOMReady.checkReady();
/*519*/};
/*520*/$.DOMReady.checkReady = function(){
/*521*/	if(document&&document.getElementsByTagName&&document.getElementById&&document.body){
/*522*/		return $.DOMReady._methodArgument();
/*523*/	}
/*524*/	setTimeout("$.DOMReady.checkReady()",10);
/*525*/	return null;
/*526*/}
		/*
			页面加载完后执行。
			首先$.DOMReady函数接受要执行的参数。
			添加到私有属性_methodArgument中
			并调用$.DOMReady.checkReady()检测页面加载是否执行完毕。
			
			$.DOMReady.checkReady通过检测document 以及几个子元素判断页面是否加载完毕。如果加载完毕则执行保存的函数，
			如果没有加载完，就每隔10毫秒执行自身函数。
		*/
/*527*/
/*528*/function $A(list){
/*529*/	var arr = [];
/*530*/	for (var i=0,len=list.length; i<len; i++){
/*531*/		arr[i] = list[i];
/*532*/	}
/*533*/	return arr;
/*534*/};
		/*
			将一个集合转化为一个数组
			常见的将 document.getElementsByTagName获得的集合转化为一个数组
		*/
/*535*/function $D(str){return decodeURIComponent(str);};
		//使用decodeURIComponent解码一个字符串
/*536*/function $E(str){return encodeURIComponent(str);};
		//使用encodeURIComponent编码一个字符串
/*537*/function $V(id){return $(id)?($(id).tagName.hasSubStrInArr(["INPUT","TEXTAREA","SELECT","BUTTON"])?$(id).value : $(id).innerHTML):"";};
		//获取一个指定元素的值
/*538*/window.recycler=(function(){ var t=document.createElement('div');t.id="recycler";return t;})();
		//初始化recycler对象。
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++全篇完