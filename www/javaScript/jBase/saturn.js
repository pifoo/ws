/**
 * SaturnJS framework 2.0
 *
 * @author Yazhi Li <delicacylee@gmail.com>
 * @link http://www.saturnphp.com/
 * @copyright Copyright (c) 2011, SaturnJS! Inc. All rights reserved.
 * @license http://developer.saturnphp.com/saturnjs/license/
 * @version 2.0.0
 */

/**
 * 核心类
 * @author delicacylee <delicacylee@gmail.com>
 * @link http://www.saturnphp.com
 * @version: 1.0.0
 */

/* 命名空间 */
window._SaturnJS_Namespace = new function () {
	/* 框架版本 */
	this.version = '2.0.0';
	
	/* JS运行环境 */
	this.runtimeEnvironment = new function () {
		/* SaturnJS根目录 */
		this.sjhome = '.';
		/* 类库根目录 */
		this.classpath = '';
		/* 是否调试JS */
		this.debug = false;
		/* SaturnJS 1:启动 0:关闭 */
		this.state = 1;
		
		/* 注册window */
		this.window = window;
		/* 核心类元素 */
		this.element = null;
		/* 日志 */
		this.logs = [];
		
		/* 获得配置文件 */
		this.config = {
			getConfig : function () {}
		};
		/* 日志记录 */
		this.log = function (log) {
			this.logs[this.logs.length] = log;
		};
	};
}

/* JS主体 */
try {
	/* 简化命名空间 */
	var saturnjs = _SaturnJS_Namespace.runtimeEnvironment;
	
	/* 日志记录初始化 */
	saturnjs.log('SaturnJS 正在初始化...');
	/* 获得Script */
	var scripts = document.getElementsByTagName('SCRIPT');
	var element = saturnjs.element = scripts[scripts.length - 1];
	
	/* 获得参数日志 */
	saturnjs.log('SaturnJS 正在获得系统参数...');
	
	/* 获得SaturnJS目录 */
	saturnjs.sjhome = ((sh = element.getAttribute('sjhome')) != null) ?
		sh : ((index = (src = element.src).replace(/\\/g, '/').lastIndexOf('/')) == -1) ? '.' : src.substring(0, index);
	/* 获得类库目录 */
	saturnjs.classpath = ((cp = element.getAttribute('classpath')) != null) ? cp : saturnjs.sjhome + '/classes';
	/* 获得是否调试 */
	saturnjs.debug = ((debug = element.getAttribute('debug')) != null
		&& (debug.toLowerCase() == 'true')) ? true : false;
		
	/* 获得配置文件 */
	var rtInf = '';
	if (/ sjConfig=([^;]*)/.test(' ' + document.cookie)) {
		rtInf = unescape(RegExp.$1);
	} else {
		var xmlHttp = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
		xmlHttp.open('GET', saturnjs.sjhome + '/rtenv.conf', false);
		try {
			xmlHttp.send(null);	
		} catch (ex) {
			throw 'SaturnJS 配置文件: ' + ex;	
		}
		if (xmlHttp.status == 0 || xmlHttp.status == 200) {
			rtInf = xmlHttp.responseText.replace(/#([^"\n\r]*)((\r\n)|$)/g, '')
				.replace(/\[([^"\n\r]*)\]/g, '').replace(/\r\n(\s)*\r\n/g, '\r\n');
			document.cookie = 'sjConfig=' + escape(rtInf);
		} else {
			throw 'SaturnJS 配置文件: 未找到 rtenv.conf 文件.';
		}
	}
	
	/* 获得配置参数 */
	var cfg = saturnjs.config = new function () {
		var content = rtInf, params = {};
		var element = saturnjs.element;
		var parseParam = function (name) {
			var reg = new RegExp('(\\^|\\r\\n)( |\\t)*('
				+ name + ')( |\\t)*=( |\\t)*(.*)($|\\r\\n)');
			return reg.test(content) ? RegExp.$6.replace(/\s+$/g, '') : null;	
		}
		this.getParameter = function (name) {
			return ((p = params[name]) != null || (p = params[name] = element.getAttribute(name)) != null) ?
				p : (params[name] = parseParam(name));	
		}
	}
	saturnjs.classpath = ((tmp = cfg.getParameter('classpath')) == null) ? saturnjs.classpath : tmp;
	
	/*
	 * 调用系统模块
	 * @param string name	模块名
	 * @return	返回资源
	 */
	var _importSystemModule = function (name) {
		document.write('<script src="'
			+ saturnjs.sjhome + '/bin/'
			+ (((tmpRes = saturnjs.config.getParameter(name)) == null) ?
			(name + '.js') : tmpRes)
			+ '"></script>');	
	}
	
	/* 加载系统类 */
	saturnjs.log('SaturnJS 配置文件: 正在加载系统函数...');
	
	_importSystemModule('exception');
	_importSystemModule('cache');
	_importSystemModule('core');
	_importSystemModule('runtime');
} catch (ex) {
	saturnjs.log((!ex.description) ? ex.toString()
		: ('Error: ' + ex.description));
	saturnjs.log('SaturnJS 配置文件: 加载 saturn.js 错误.');
	alert('SaturnJS 加载错误, 日志: \r\n --------\r\n'
		+ 'URL: ' + document.URL + '\r\n --------\r\n'
		+ saturnjs.logs.join('\r\n'));
} finally {
	saturnjs = scripts = element = void(0);
}

/*
 * 预加载
 * 在执行获得DOM节点的操作时，需要通过预加载的方法进行条用
 * <code>
 * onReady(function(){
 * 		// 逻辑代码
 * });
 * </code>
 * 其他情况下尽量不要使用该功能，会造成执行速度较慢
 */
(function () {
	// 判断onDOMReady方法是否已经被执行
	var isReady = false;
	// 把需要执行的方法先暂存在这个数组里
	var readyList = [];
	// 定时器句柄
	var timer;
	// 预加载函数
	onReady = function (fn) {
		if (isReady) {
			fn.call(document);	
		} else {
			readyList.push(function() {
				return fn.call(this);
			});
		}
		return this;
	}
	// 当DOM加载完毕后执行
	var onDOMReady = function () {
		for (var i = 0; i < readyList.length; i++) {
			readyList[i].apply(document);	
		}
		readyList = null;
	}
	// 绑定 onReady 并移除事件监听器
	var bindReady = function (evt) {
		if (isReady) return;
		isReady = true;
		onDOMReady.call(window);
		if (document.removeEventListener) {
			document.removeEventListener('DOMContentLoaded', bindReady, false);	
		} else if (document.attachEvent) {
			document.detachEvent("onreadystatechange", bindReady);
			if (window == window.top) {
				clearInterval(timer);
				timer = null;	
			}
		}
	}
	// 设置事件监听器
	if (document.addEventListener) {
		document.addEventListener("DOMContentLoaded", bindReady, false);	
	} else if (document.attachEvent) {
		document.attachEvent("onreadystatechange", function(){
			if ((/loaded|complete/).test(document.readyState)) {
				bindReady();	
			}
		});
		if (window == window.top) {
			timer = setInterval(function () {
				try {
					isReady||document.documentElement.doScroll('left');
				} catch (ex) {
					alert('SaturnJS 预加载错误...');
				}
				bindReady();
			}, 5);
		}
	}
})();