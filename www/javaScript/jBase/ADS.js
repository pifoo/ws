/**
 * @author hewj
 * Advanced DOM Scripting
 */


//重复一个字符串
if(!String.repeat){
	String.prototype.repeat = function(l){
		return new Array(l+1).join(this);
	}
}

// 去掉字符串两端的所有空格
if(!String.trim){
	String.prototype.trim = function(){
		return this.replace(/^\s+/,'').replace(/\s+$/,'');
		//return this.replace(/^\s+|\s+$/g,'')
	}; 	
}



(function(){
	
	//ADS命名空间
	if(!window.ADS){ window['ADS'] = { } }
	
	
	function isCompatible(other) {
		//作用能力检测来检查必要条件
		if( other === false || 
			!Array.prototype.push ||
			!Object.hasOwnProperty ||
			!document.createElement ||
			!document.getElementsByTagName
			) {
			return false;
		}
		return true;
	};
	window['ADS']['isCompatible'] = isCompatible;
	
	
	/* 把word-word转换为wordWord */
	function camelize(s){
		return s.replace(/-(\w)/g, function(strMatch,p1){ return p1.toUpperCase() });
	}
	window['ADS']['camelize'] = camelize;
	
	
	function $() {
		var elements = new Array();
		
		//查找作为参数提供的所有元素
		for (var i=0; i < arguments.length; i++) {
			var element = arguments[i];
			
			//如果该参数是一个字符串那假设它是一个ID
			if (typeof element == 'string') {
				element = document.getElementById(element);
			};
			
			//如果只提供了一个参数
			//则立即返回这个元素
			if (arguments.lenght == 1) {
				return element;
			};
			//否则，将它添加到数组中
			elements.push(element);
		};
		
		//返回包含多个被请求元素的数组
		return elements;
	};
	window['ADS']['$'] = $;
	
	
	function exampleLibraryMethod(obj) {
		if (!(obj = $(obj))) { return false};
	}
	window['ADS']['exampleLibraryMethod'] = exampleLibraryMethod;
	
	
	function addEvent(node,type,listener) {
		//使用前面的方法检查兼容性以保证平稳退化
		if (!isCompatible()) { return false };
		
		if (!(node = $(node))) { return false };
		
		if (node.addEventListener) {  
			//W3C的方法
			node.addEventListener( type, listener,false);
			return true;	
		} else if (node.attachEvent) {
			//MSIE的方法
			node['e' + type + listener] = listener;
			node[type + listener] = function(){
				node['e' + type + listener](window.event);
			}
			node.attachEvent('on' + type, node[type + listener]);
			return true;
		}
		
		//若两种方法都不具备则返回false
		return false;
	};
	window['ADS']['addEvent'] = addEvent;
	
	
	function removeEvent(node,type,listener) {
		if (!(node = $(node))) { return false };
		
		if (node.removeEventListener) {
			//为W3C的方法
			node.removeEventListener( type,listener,false);
			return ture;
		} else if(node.detachEvent){
			//MSIE的方法
			node.detachEvent('on' + type,node[type + listener]);
			node[type + listener] = null;
			return true;
		};
		//若两种方法都不具备则返回false
		return false;
	};
	window['ADS']['removeEvent'] = removeEvent;
	
	/*
	 * TODO
	 */
	function getElementsByClassName(className,tag,parent) {
		parent = parent || document;
		if (!(parent = $(parent))) { return false };
		
		//查找所有匹配的标签
		var allTags = (tag == "*" && parent.all ) ? parent.all : parent.getElementsByTagName(tag);
		var matchingElements = new Array();
		
		//创建一个正则来判断className是否正确
		className = className.replace(/\-/g,"\\-");
		var regex = new RegExp("(^|\\s)" + className + "(\\s|$)");
		
		var element;
		//检查每个元素
		for (var i=0; i < allTags.length; i++) {
			element = allTags[i];
			if (regex.test(element.className)) {
				matchingElements.push(element);
			}
		};
		//返回任何匹配的元素
		return matchingElements;
	};
	window['ADS']['getElementsByClassName'] = getElementsByClassName;
	
	
	function toggleDisplay(node,value) {
		if(!(node = $(node))){ return false }
		
		if(node.style.display != 'none'){
			node.style.display = "none";
		}else{
			node.style.display = value || '';
		}
		return ture;
	};
	window['ADS']['toggleDisplay'] = toggleDisplay;
	
	
	function insertAfter(node,referenceNode) {
		if(!(node = $(node))){ return false }
		
		if(!(referenceNode = $(referenceNode))){
			return false;
		}
		
		return referenceNode.parentNode.insertBefore(node,referenceNode.nextSibling);
	};
	window['ADS']['insertAfter'] = insertAfter;
	
	
	function removeChildren(parent) {
		if(!(parent = $(parent))){ return false }
		
		//当存在子节点时删除改子节点
		while(parent.firstChild){
			parent.firstChild.parentNode.removeChild(parent.firstChild);
		}
		
		//再返回父元素，以便实现方法边缀
		return parent;
	};
	window['ADS']['removeChildren'] = removeChildren;
	
	
	function prependChild(parent,newChild) {
		if(!(parent = $(parent))){ return false }
		if(!(newChild = $(newChild))){ return false }
		
		if (parent.firstChild) {
			//如果存在一个子节点，则在这个子节点之前插入
			parent.appendChild(newChild);
		} else{
			//如果没有子节点则直接添加
			parent.appendChild(newChild);
		};
		//再返回父元素，以便实现连缀
		return parent;
	};
	window['ADS']['prependChild'] = prependChild;
	
	//改变函数的执行环境
	function bindFunction(obj,func){
		return function(){
			func.apply(obj,arguments);
		}
	}
	window['ADS']['bindFunction'] = bindFunction;
	
	
	window['ADS']['node']={
		ELEMENT_NODE:1				// 元素节点
		,ATTRIBUTE_NODE:2			
		,TEXT_NODE:3				// 文本节点	
		,CDATA_SECTION_NODE:4
		,ENTITY_REFERENCE_NODE:5
		,ENTITY_NODE:6
		,PROCESSING_INSTRUCTION_NODE:7
		,COMMENT_NODE:8
		,DOCUMENT_NODE:9			// Document类型
		,DOCUMENT_TYPE_NODE:10
		,DOCUMENT_FRAGMENT_NODE:11
		,NOTATION_NODE:12		
		,DOCUMENT_POSITION_DISCONNECTED:1
		,DOCUMENT_POSITION_PRECEDING:2
		,DOCUMENT_POSITION_FOLLOWING:4
		,DOCUMENT_POSITION_CONTAINS:8
		,DOCUMENT_POSITION_CONTAINED_BY:16
		,DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC:32
	};
	
	
	function walkElementLinear(func,node){
		var root = node || window.document;
		var nodes = root.getElementsByTagName('*');
		for (var i=0; i < nodes.length; i++) {
		  func.call(nodes[i]);
		};
	}
	window['ADS']['walkElementLinear'] = walkElementLinear;
	
	
	function walkTheDOMRecursive(func,node,depth,returnedFromParent){
		var root = node || window.document;
		var returnedFromParent = func.call(root,depth++,returnedFromParent);
		var node = root.firstChild;
		while(node){
			walkTheDOMRecursive(func,node,depth,returnedFromParent);
			node = node.nextSibling;
		}
	}
	window['ADS']['walkTheDOMRecursive'] = walkTheDOMRecursive;
	
	
	function walkTheDOMWithAttributes(node,func,depth,returnedFromParent){
	 	var root = node || window.document;
	 	returnedFromParent = func(root,depth++,returnedFromParent);
	 	if(root.attributes){
	 		for (var i=0; i < root.attributes.length; i++) {
			   walkTheDOMWithAttributes(root.attributes[i],func,depth-1,returnedFromParent);
			 };
	 	}
	 	if(root.nodeType != ADS.node.ATTRIBUTE_NODE){
	 		node = root.firstChild;
	 		while(node){
	 			walkTheDOMWithAttributes(node,func,depth,returnedFromParent);
	 			node = node.nextSibling;
	 		}
	 	}
	}
	window['ADS']['walkTheDOMWithAttributes'] = walkTheDOMWithAttributes;
	
	
	//取得事件对象
	function getEventObject(W3CEvent){
		return W3CEvent || window.event;
	}
	window['ADS']['getEventObject'] = getEventObject;
	
	
	//阻止冒泡
	function stopPropagation(eventObject){
		eventObject = eventObject || getEventObject(eventObject);
		if(eventObject.stopPropagation){
			eventObject.stopPropagation();
		}else{
			eventObject.cancelBubble = true;
		}
	}
	window['ADS']['stopPropagation'] = stopPropagation;
	
	
	//取消默认动作
	function preventDefault(eventObject){
		eventObject = eventObject || getEventObject(eventObject);
		if(eventObject.preventDefault){
			eventObject.preventDefault();
		}else{
			eventObject.returnValue = false;
		}
	}
	window['ADS']['preventDefault'] = preventDefault;
	
	
	//取得事件目标元素
	function getTarget(eventObject){
		eventObject = eventObject || getEventObject(eventObject);
		
		//如果是W3C或MSIE的模型
		var target = eventObject.target || eventObject.srcElement;
		
		//如果Safari中一样是一个文本节点
		//重新将目标对象指定为父元素
		if(target.nodeType == ADS.node.TEXT_NODE){
			target = node.parentNode;
		}
		
		return target;
	}
	window['ADS']['getTarget'] = getTarget;
	
	
	//鼠标按钮
	function getMouseButton(eventObject){
		eventObject = eventObject || getEventObject(eventObject);
		
		//使用适当的属性初始化一个对象变量
		var buttons = {
			'left':false,
			'middle':false,
			'right':false
		};
		
		//检查eventObject对象的toString()方法的值
		//W3C DOM对象的toString()方法的值
		//方法的返回值应该是MouseEvent
		if(eventObject.toString && eventObject.toString().indexOf('MouseEvent') != -1){
			//W3C方法
			switch(eventObject.button){
				case 0:
					buttons.left = true;
					break;
				case 1:
					buttons.middle = true;
					break;
				case 2:
					buttons.right = true;
					break;
				default:
					break;
			}
		}else if(eventObject.button){
			//MSIE方法
			switch(eventObject.button){
				case 1:
					buttons.left = true;
					break;
				case 2:
					buttons.right = true;
					break;
				case 3:
					buttons.left = true;
					buttons.right = true;
					break;
				case 4:
					buttons.middle = true;
					break;
				case 5:
					buttons.left = true;
					buttons.middle = true;
					break;
				case 6:
					buttons.middle = true;
					buttons.right = true;
					break;
				case 7:
					buttons.left = true;
					buttons.middle = true;
					buttons.right = true;
					break;
				default:
					break;
			}	
		}else{
			return false;
		}
		
		return buttons;
	}
	window['ADS']['getMouseButton'] = getMouseButton;
	
	
	//处理鼠标的位置
	function getPointetPositionInDocument(eventObject){
		eventObject = eventObject || getEventObject(eventObject);
		
		var x = eventObject.pageX || (eventObject.clientX + (document.documentElement.scrollLeft || document.body.scrollLeft));
		
		var y = eventObject.pageY || (eventObject.clientY + (document.documentElement.scrollTop || document.body.scrollTop));

		//现在x和y中包含着鼠标相对于文档原点的坐标
		return {'x':x, 'y':y};
	}
	window['ADS']['getPointetPositionInDocument'] = getPointetPositionInDocument;
	
	//返回按键码值
	function getKeyPressed(eventObject){
		eventObject = eventObject || getEventObject(eventObject);
		
		var code = eventObject.keyCode;
		var value = String.fromCharCode(code);
		return {'code':code,'value':value};
	}
	window['ADS']['getKeyPressed'] = getKeyPressed;
	
	
	//通过ID修改单个元素的样式
	function setStyleById(element,styles){
		//取得对象的引用
		if (!(element = $(element))) { return false };
		
		//循环遍历styles对象并应用每个属性
		for (property in styles) {
			if(!styles.hasOwnProperty(property)) { continue };
			
			if (element.style.setProperty) {
				//DOM2样式规范方法
				element.style.setProperty(uncamelize(property,'-'),styles[property],null)
			} else{
				//备用方法
				element.style[camelize(property)] = styles[property];
			};
		};
		return true;
	}
	window['ADS']['setStyle'] = setStyleById;
	window['ADS']['setStyleById'] = setStyleById;
	
	//通过类名修改多个元素的样式
	function setStylesByClassName(parent,tag,className,styles){
		if (!(parent = $(parent))) { return false };
		var elements = getElementsByClassName(className,tag,parent);
		for (var e=0; e < elements.length; e++) {
			setStylesByClassName(elements[e],styles);
		};
		return true;
	}
	window['ADS']['setStylesByClassName'] = setStylesByClassName;
	
	
	//通过标签名修改多个元素的样式
	function setStylesByTagName(tagname,styles,parent){
		parent = $(parent) || document;
		var elements = parent.getElementsByTagName(tagname);
		for (var e=0; e < elements.length; e++) {
			setStyleById(elements[e],styles);
		};
	}
	window['ADS']['setStylesByTagName'] = setStylesByTagName;
	
	
	//取得包含元素类名的数组
	function getClassNames(element){
		if (!(element = $(element))) { return false };
		
		//用一个空格替换多个空格，然后基于空格分割类名
		return element.className.replace(/\s+/,' ').split(' ');
	}
	window['ADS']['getClassNames'] = getClassNames;
	
	
	//检查元素中是否存在某个类
	function hasClassName (element,className) {
		if(!(element = $(element))) { return false };
		var classes = getClassNames(element);
		for (var i=0; i < classes.length; i++) {
			//检测className是否匹配，如果是则返回true
			if(classes[i] === className ){ return true }
		};
	}
	window['ADS']['hasClassName'] = hasClassName;
	
	
	//为元素添加类
	function addClassName (element,className) {
		if(!(element = $(element))){ return false };
		//将类名添加到当前className末尾，如果没有className的末尾
		element.className += (element.className ? ' ' : '') + className;
		return true;
	}
	window['ADS']['addClassName'] = addClassName;
	
	
	//从元素中删除类
	function removeClassName (element,className) {
		if (!(element = $(element))) { return false };
		var classes = getClassNames(element);
		var length = classes.length;
		//循环遍历数组删除匹配的项，因为从数组中删除项会使数组变短，所以要反射循环
		for (var i=length-1; i >= 0; i--) {
			if (classes[i] === className) { delete(classes[i]) };
		};
		element.className = classes.join(' ');
		return (length == classes.length ? false : true);
	}
	window['ADS']['removeClassName'] = removeClassName;
	
	
	//添加新样式表
	function addStyleSheet (url,media) {
		media = media || 'screen';
		var link = document.createElement('LINK');
		link.setAttribute('rel','stylesheet');
		link.setAttribute('type','text/css');;
		link.setAttribute('href',url);
		link.setAttribute('media',media);
		document.getElementsByTagName('head')[0].appendChild(link);
	}
	window['ADS']['addStyleSheet'] = addStyleSheet;
	
	
	//移除样式表
	function removeStyleSheet (url,media) {
		var styles = getStyleSheets(url,media);
		for (var i=0; i < styles.length; i++) {
			var node = styles[i].ownerNode || styles[i].owningElement;
			//禁用样式表
			styles[i].disabled = true;
			//移除节点
			node.parentNode.removeChild(node);
		};
	}
	window['ADS']['removeStyleSheet'] = removeStyleSheet;
	
	
	//通过URL取得包含所有样式表的数组
	function getStyleSheets (url,media) {
		var sheets = [];
		for (var i=0; i < document.styleSheets.length; i++) {
			if(url && document.styleSheets[i].href.indexOf(url) == -1){
				continue;
			}
			if (media) {
				//规范化media字符串
				media = media.replace(/,\s*/,',');
				var sheetMedia;
				
				if (document.styleSheets[i].media.medeaText) {
					//DOM方法
					sheetMedia = document.styleSheets[i].media.mediaText.replace(/,\s*/,',');
					//Safari会添加额外的逗号和空格
					sheetMedia = sheetMedia.replace(/,\s*$/,',');
				} else{
					//MSIE方法
					sheetMedia = document.styleSheets[i].media.replace(/,\s*/,',');
				};
				//如果media不匹配则跳过
				if (media != sheetMedia) { continue };
			};
			sheets.push(document.styleSheets[i]);
		};
		return sheets;
	}
	window['ADS']['getStyleSheets'] = getStyleSheets;
	
	
	//编辑一条样式规则
	function editCSSRule (selector,styles,url,media) {
		var styleSheets = (typeof url == 'array' ? url : getStyleSheets(url,media));
		
		for (i=0; i < styleSheets.length; i++) {
			//取得规则列表
			//DOM2样式规范方法styleSheets[i].cssRules
			//MSIE方法是styleSheets[i].rules
			var rules = styleSheets[i].cssRules || styleSheets[i].rules;
			if (!rules) { continue };
			
			//由于MSIE默认使用大写故转换为大写形式
			//如果你使用的是区分大小写的ID,则可能会导致冲突
			selector = selector.toUpperCase();
			
			for (var j=0; j < rules.length; j++) {
				//检查是否匹配
				if (rules[j].selectorText.toUpperCase() == selector) {
					for(property in styles){
						if (!styles.hasOwnProperty(property)) { continue };
						//设置新的样式属性
						rules[j].style[camelize(property)] = styles[property];
					}
				};
			};
		};
	}
	window['ADS']['editCSSRule'] = editCSSRule;
	
	
	//添加一条CSS规则
	function addCSSRule (selector,styles,index,url,media) {
		var declaration = '';
		
		//根据styles参数（样式对象）构建声明字符串
		for (property in styles) {
			if(!styles.hasOwnProperty(property)){ continue }
			declaration += property + ':' + styles[property] + ';' ;
		};
		
		var styleSheets = (typeof url == 'array' ? url : getStyleSheets(url,media));
		
		var newIndex;
		for (var i=0; i < styleSheets.length; i++) {
			//添加规则
			if(styleSheets[i].insertRule){
				//DOM2样式规范的方法
				//index = length是列表末尾
				newIndex = (index >= 0 ? index : styleSheets[i].cssRules.length);
				styleSheets[i].insertRule(
					selector + '{' + declaration + '}', newIndex
				);
			}else if (styleSheets[i].addRule) {
				//Microsoft的方法
				//index = -1是列表的末尾
				newIndex = (index >= 0 ? index : -1);
				styleSheets[i].addRule(selector,declaration,newIndex);
			};
		};
	}
	window['ADS']['addCSSRule'] = addCSSRule;
	
	
	//取得一个元素的计算样式 
	function getStyle (element,property) {
		if(!(element = $(element)) || !property){ return false }
		//检测元素的style属性中的值
		var value  = element.style[camelize(property)];
		if (!value) {
			//取得计算的样式值
			if (document.defaultView && document.defaultView.getComputedStyle) {
				//DOM方法
				var css = document.defaultView.getComputedStyle(element,null)
				value = css ? css.getPropertyValue(property) : null;
			}else if (element.currentStyle) {
				//MSIE的方法
				value = element.currentStyle[camelize(property)];
			}
		}
		//返回空字符串而不是auto
		//这样就不必检查suto值了
		return value == 'auto' ? '' : value;	
	}
	window['ADS']['getStyle'] = getStyle;
	window['ADS']['getStyleById'] = getStyleById;
	
	
	
	
	/**
	 * Part 2 浏览器外部通信 251
	 */
	/*
	 * parseJSON(string,filter)
	 * 这是一个在公共域方法http://www.json.org/json2.js基础上进行了少量修改的版本。
	 * 该方法解析JSON文本以生成一个对象或数组。它可能抛出SyntaxError异常
	 */
	function parseJSON (s,filter) {
		var j;
		
		function walk (k,v) {
			var i;
			if(v && typeof v === 'object'){
				for (i in v) {
					if(v.hasOwnProperty(i)){  
						v[i] = walk(i,v[i]);
					}
				}
			}
			return filter(k,v);
		}
		
		//解析通过3个阶段进行。第1阶段，通过正则表达式
		//检测JSON文本，查找非JSON字符。其中，特别关注
		//"O"和"new",因为它们会引起语句的调用 ，还有“=”，
		//因为它会导致变量的值发生改变。不过，为安全起见
		//这里会拒绝所有不希望出现的字符
		
		if(/^("(\\.|[^"\\\n\r])*?"|[,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t])+?$/.test(s)){
			//第2阶段，使用eval函数将JSON文本编译为JavaScript。
			//其中的“{”操作符具有语法上的二义性：即它可以定义一个语句块，也可以表示对象字面量。
			//这里将JSON文本用括号括起来是为了消除这种二义性
			try{
				j = eval('(' + s + ')');
			}catch(e){
				throw new SyntaxError("parseJSON");
			}
		}else{
			throw new SyntaxError("parseJSON");
		}
		
		//在可选的第三阶段，代码递归地遍历了新生成的结构
		//而且将每个名/值对传递给一个过滤函数，以便进行可能的转换
		if(typeof filter === 'function'){
			j = walk('',j);
		}
		return j;
	}
	
	//设置XMLHttpRequest对象的各个不同的部分
	function getRequestObject (url,options) {
		//初始化请求对象
		var req = false;
		if(window.XMLHttpRequest){
			var req = new window.XMLHttpRequest();
		}else if(window.ActiveXObject) {
			var req = new window.ActiveObject('Microsoft.XMLHTTP');
		};
		
		if(!req){return false};
		
		//定义默认的选项
		options = options || {};
		options.method  = options.method || 'GET';
		options.send = options.send || null;
		
		req.onreadystatechange = function () {
			switch(req.readyState){
				case 1:
					//载入中
					if (options.loadedListener) {
						options.loadedListener.apply(req,arguments);
					}
					break;
				case 2:
					//载入完成
					if (options.loadedListener) {
						options.loadedListener.apply(req,arguments);
					}
					break;
				case 3:
					//交互
					if (options.loadedListener) {
						options.ineractiveListener.apply(req,arguments);
					}
					break;
				case 4:
					//完成，如果失败则抛出异常
					try{
						if (req.status && req.status == 200) {
							//针对content-type的特殊侦听器
							//由于pe.match(/\s*([^;]+)\s*(;|头部中可能包含字符集：如
							//Content-Type:text/html;charset=ISO-8859-4
							//因此通过正则表达式提取出所需的部分
							var contentType = req.getResponseHeader('content-type');
							var mimeType = contentType.match(/\s*([^;]+)\s*(;|$)/i/i)[1];
							
							switch(mimeType) {
		                        case 'text/javascript':
		                        case 'application/javascript':
		                            // 响应是javascript,因此以
		                            // req.responseText作为回调的参数
		                            if(options.jsResponseListener) {
		                                options.jsResponseListener.call(
		                                    req,
		                                    req.responseText
		                                );
		                            }
		                            break;
		                        case 'application/json':
		                            // 响应是json，因此需要用匿名函数对   
		                            // req.responseText 进行解析
		                            // 以返回作为回调参数的 JSON 对象
		                            if(options.jsonResponseListener) {
		                                try {
		                                    var json = parseJSON(
		                                        req.responseText
		                                    );
		                                } catch(e) {
		                                    var json = false;
		                                }
		                                options.jsonResponseListener.call(
		                                    req,
		                                    json
		                                );
		                            }
		                            break;
		                        case 'text/xml':
		                        case 'application/xml':
		                        case 'application/xhtml+xml':
		                            // T响应是以XML ，因此以 
		                            // req.responseXML作为回调的参数
		                            // 此时是Document对象
		                            if(options.xmlResponseListener) {
		                                options.xmlResponseListener.call(
		                                    req,
		                                    req.responseXML
		                                );
		                            }
		                            break;
		                        case 'text/html':
		                            // 响应是HTML，因此以
		                            // req.responseText作为回调参数
		                            if(options.htmlResponseListener) {
		                                options.htmlResponseListener.call(
		                                    req,
		                                    req.responseText
		                                );
		                            }
		                            break;
		                    }
		                
		                    // 针对响应成功完成的侦听器
		                    if(options.completeListener) {
		                        options.completeListener.apply(req,arguments);
		                    }
						}else{
							//响应完成但却存在错误
		                    if(options.errorListener) {
		                        options.errorListener.apply(req,arguments);
		                    }
						}
					}catch(e){
						//忽略错误
						console.log('Response Error: ' + e);
					}
					break;
			}
		}
		//开启请求
	    req.open(options.method, url, true);
	    // 添加特殊的头部信息以标示请求
	    req.setRequestHeader('X-ADS-Ajax-Request','AjaxRequest');
	    return req;	
	}
	window['ADS']['getRequestObject'] = getRequestObject;
	
	//通过简单地包装getRequestObject()和send()方法，发送XMLHttpRequest对象的请求
	function ajaxRequest (url,options) {
		var req = getRequestObject(url,options);
		return req.send(options.send);
	}
	window['ADS']['ajaxRequest'] = ajaxRequest;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	function $(id){return document.getElementById(id);}
	function alertNodeName(id) {alert($(id).nodeName);}
	window['ADS'] = {}
	window['ADS']['showNodeName'] = alertNodeName;
	*/
	

	
	
})();
