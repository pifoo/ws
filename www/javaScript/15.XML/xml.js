/**
 * js与xml
 * @author hewj
 */

/*
 * 跨浏览器的XML处理  
 */
 
// 解析XML(XML --> DOM)
function createDocument(){	// ie
	if(typeof arguments.callee.activeXString != "string"){
		var versions = ["MSXML2.DOMDocument.6.0","MSXML2.DOMDocument.3.0","MSXML2.DOMDocument"];
		for (var i=0,len=versions.length;i<len;i++){
			try{
				var xmldom = new ActiveXObject(versions[i]);
				arguments.callee.activeXString = versions[i];
				return xmldom;
			}catch(ex){
				// 跳过
   			}
   		}
   	};
   	return new ActiveXOject(arguments.callee.activeXString);
};
function parseXml(xml){	// xml:要解析的XML字符串
	var xmldom = null;
	
	if(typeof DOMParser != "undefined"){
		xmldom =(new DOMParser()).parseFromString(xml,"text/xml");
		var errors = xmldom.getElementsByTagName("parsererror");
		if(errors.length){
			throw new Error("XML parsing error:" + errors[0].textContent);
		}
	}else if(document.implementation.hasFeature("LS","3.0")){
		var implementation = document.implementation;
		var parser = implementation.createLSParser(implementation.MODE_SYNCHRONOUS,null);
		var input = implementation.createLSInput();
		input.stringData = xml;
		xmldom = parser.parse(input);
	}else if(typeof ActiveXObject != "undefined"){
		xmldom = createDocument();
		xmldom.loadXML(xml);
		if(xmldom.parseError != 0){
			throw new Error("XML parsing error:" + xmldom.parseError.reason);
		}
	}else{
		throw new Error("No XML parser available.");
	};
	
	return xmldom;
};  
//demo
var xmlDom = null;
try{
	xmlDom = parseXml("<root><child/></root>"); 
//	alert(xmlDom.documentElement.tagName)
}catch(ex){
	alert(ex.message);
}


// 序列化XML(DOM --> XML)
function serializeXml(xmldom){
	if(typeof XMLSerializer != "undefined"){
		return (new XMLSerializer()).serializeToString(xmldom);
	}else if(document.implementation.hasFeature("LS","3.0")){
		var implementation = document.implementation;
		var serializer = implementation.createLSSerializer();
		return serializer.writeToString(xmldom);
	}else if(typeof xmldom.xml != "undefined"){
		return xmldom.xml;
	}else{
		throw new Error("Could not serialize XML DOM.")
	}
};
//demo
var domXml = serializeXml(xmlDom); // alert(domXml);


/*
 * 跨浏览器使用XPath
 */
function selectSingleNode(context,expression,namespaces){
	var doc = (context.noddType != 9 ? context.ownerDocument : context);
	
	if(typeof doc.evaluate != "undefined"){
		var nsresolver = null;
		if(namespaces instanceof Object){
			nsresolver = function(prefix){
				return namespaces[prefix];
			};
		}
		
		var result = doc.evaluate(expression,context,nsresolver,
									XPathResult.FIRST_ORDERED_NODE_TYPE,null);
		return (result !== null ? result.singleNodeValue : null);
	}else if(typeof context.selectSingleNode != "undefined"){
		// 创建命名空间字符串
		if(namespaces instanceof Object){
			var ns = "";
			for(var prefix in namespaces){
				if(namespaces.hasOwnProperty(prefix)){
					ns += "xmlns:" + prefix + "='" + namespaces[prefix] + "' ";
				}
			}
			doc.setProperty("SelectionNamespaces",ns);
		}
		return context.selectSingleNode(expression);
	}else{
		throw new Error("No XPath engine found.");
	}
};
/*demo
var result = selectSingleNode(xmldom.documentElement,"wrox:book/wrox:author",
								{wrox:"http://www.wrox.com"});
alert(serializeXml(result));
*/

function selectNodes(context,expression,namespaces){
	var doc = (context.noddType != 9 ? context.ownerDocument : context);
	
	if(typeof doc.evaluate != "undefined"){
		var nsresolver = null;
		if(namespaces instanceof Object){
			nsresolver = function(prefix){
				return namespaces[prefix];
			};
		}
		var result = doc.evaluate(expression,context,nsresolver,
									XPathResult.ORDERED_NODE_SNAPSHOT_TYPE,null);
		var nodes = new Array();
		
		if(result !== null ){
			for(var i=0,len=result.snapshotLength; i<len; i++){
				nodes.push(result.snapshotLength(i));
			}
		}
		return nodes;
	}else if(typeof context.selectNodes != "undefined"){
		
		// 创建命名空间字符串
		if(namespaces instanceof Object){
			var ns = "";
			for(var prefix in namespaces){
				if(namespaces.hasOwnProperty(prefix)){
					ns += "xmlns:" + prefix + "='" + namespaces[prefix] + "' ";
				}
			}
			doc.setProperty("SelectionNamespaces",ns);
		}
		var result = context.selectNodes(expression);
		var nodes = new Array();
		for(var i=0,len=result.length;i<len;i++){
			nodes.push(result[i])
		}
		return nodes;
	}else{
		throw new Error("No XPath engine found.");
	}
};
/*demo
var result = selectNodes(xmldom.documentElement,"wrox:book/wrox:author",
							{wrox:"http://www.wrox.com"});
alert(result.lenght);
*/


/*
 * 跨浏览器使用XSLT
 */
function transform(context,xslt){
	if(typeof XSLTProcessor != "undefined"){
		var processor = new XSLTProcessor();
		processor.importStylesheet(xslt);
		
		var result = processor.transformToDocument(context);
		return (new XMLSerializer()).serializeToString(result);
	}else if(typeof context.transformNode != "undefined"){
		return context.transformNode(xslt);
	}else{
		throw new Error("No XSLT processor available.")
	}
};
/*demo
var result = transform(xmldom,xsltdom);
*/












































         