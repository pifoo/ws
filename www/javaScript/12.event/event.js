/**
 * 事件
 * @author hewj
 */
 
// 去掉字符串两端的所有空格
String.prototype.trim = function(){
		return this.replace(/^\s+/,'').replace(/\s+$/,'')
}; 


// 跨浏览器事件处理 
var EventUtil = {
	// 添加事件监听
	addHandler: function(element,type,handler){
		if(element.addEventListener){
			element.addEventListener(type,handler,false);	// DOM2级事件处理
		} else if(element.attachEvent){
			element.attachEvent("on"+type,handler);			// IE事件处理
		} else {
			element["on" + type] = handler;					// DOM0级事件处理
		}
	},
	// 移除事件监听
	removeHandler: function(element,type,handler){			
		if(element.removeEventListener){
			element.removeEventListener(type,handler,false);
		} else if(element.detachEvent){
			element.detachEvent("on"+type,handler);
		} else {
			element["on" + type] = handler;
		}
	},
	
	// 获取事件对象event
	getEvent:function(event){								
		return event ? event : window.event;				// IE中，event对象作为window对象的属性存在
	},
	// 取得事件目标
	getTarget:function(event){								
		return event.target || event.srcElement;
	},
	// 取消事件的默认行为
	preventDefault:function(event){							
		if(event.preventDefault){
			event.preventDefault();
		}else{
			event.returnValue = false; 						// IE
		}
	},
	
	// 相关元素
	getRelatedTarget:function(event){						
		// relatedTarget属性只对mouseover,mouseout事件才包含值,对于其它事件值为null
		if(event.relatedTarget){
			return event.relatedTarget;
		}else if(event.toElement){
			return event.toElement;							// IE mouseover
		}else if(event.fromElement){
			return event.fromElement;						// IE mouseout
		}else{
			return null;
		}
	},
	
	// 取得鼠标按钮值
	getMouseBtn:function(event){
		// mousedown和mouseup事件在其event对象存在一个button属性，button属性可能有三个值							
		if(document.implementation.hasFeature("MouseEvents","2.0")){
			return event.button;
		}else{
			switch(event.button){
				case 1:
				case 3:
				case 5:
				case 5:
					return 0;	// 主鼠标按钮
				case 2:
				case 6:
					return 2;	// 次鼠标按钮
				case 4:
					return 1;	// 鼠标滚轮
			}
		}
	},
	
	// 得到键码值
	getCharCode:function(event){							
		if(typeof event.charCode == "number"){
			return event.charCode;
		}else{
			return event.keyCode;	// IE or Opera
		}
	},// String.fromCharCode() 可将得到的字符编码转换成实际的字符
	
	// 取得鼠标滚轮增量值
	getWheelDelta:function(event){							
		if(event.wheelDelta){
			return (client.engine.opera && client.engine.opera < 9.5 ? -event.wheelDelta : event.wheelDelta); 
		}else{
			return -event.detail * 40;
		}
	},
	
	/***************************************************/
	
	// 取消事件冒泡
	stopPropagation:function(event){						
		if(event.stopPropagation){
			event.stopPropagation();
		}else{
			event.cancelBubble = true;
		}
	}
	
	
};