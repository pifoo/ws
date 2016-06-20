/**
 * @author Hewj
 */

        
//cookie操作有三种：读取、写入、删除   
var CookieUtil = {
	
	get:function(name){
		var cookieName = encodeURIComponent(name) + "=",
			conkieStart = document.cookie.indexOf(cookieName),
			cookieValue = null;
			
		if(cookieStart > -1){
			var cookieEnd = document.cookie.indexOf(";",cookieStart)
			if(cookieEnd == -1){
				cookieEnd = document.cookie.length;
			}
			cookieValue = decodeURIComponent(document.cookie.substring(cookieStart + 
				cookieName.length,cookieEnd));
		}
		return cookieValue;
	},
	
	set:function(name,value,expires,path,domain,secure){
		var cookieText = encodeURIComponent(name) + "=" +
						 encodeURIComponent(value);
		
		if(expires instanceof Date){
			cookieText += "; expires=" + expires.toGMTString();
		}
		
		if(path){
			cookieText += "; path=" + path;
		}
		
		if(domain){
			cookieText += "; domain=" + domain;
		}
		
		if(secure){
			cookieText += "; secure";
		}
		
		document.cookie = cookieText;
	},
	
	unset:function(name,path,domain,secure){
		this.set(name,"",new Date(0),path,domain,secure);
	}
	
};
	

/*
 * 子cookie(存放在单个cookie中的更小段的数据。也就是使用cookie值来存储多个名称-值对)
 * 格式 ：name = name1=value & name2=value2 & name3=value3 & name4=value4 & name5=value5
 */
var SubCookieUtil = {
	
	get:function(name,subName){
		var subCookies = this.getAll(name);
		if(subCookies){
			return subCookies[subName];
		}else{
			return null;
		}
	},
	
	getAll:function(name){
		var cookieName = encodeURIComponent(name) + "=",
			cookieStart = document.cookie.indexOf(cookieName),
			cookieValue = null,
			result = {};
		
		if(cookieStart > -1){
			var cookieEnd = document.cookie.indexof(",",cookieStart)
			if(cookieEnd == -1){
				cookieEnd = document.cookie.length;
			}
			cookieValue = document.cookie.substring(cookieStart +
				cookieName.length,cookieEnd);
			
			if(cookieValue.length > 0){
				var subCookies = cookieValue.split(" & ");
				
				for(var i=0,len=subCookies.length;i<len;i++){
					var parts = subCookies[i].split("=");
					result[decodeURIComponent(parts[0])] = decodeURIComponent(parts[1]);
				}
				return result;
			}
		}
		
		return null;
	},
	
	set:function(name,subName,value,expires,path,domain,secure){
		var subcookies = this.getAll(name) || {};
		subcookies[subName] = value;
		this.setAll(name,subcookies,expires,path,domain,secure);
	},
	
	setAll:function(name,subcookies,expires,path,domain,secure){
		var cookieText = encodeURIComponent(name) + "=";
		var subcookieParts = new Array();
		
		for(var subName in subcookies){
			if(subName.length > 0 && subcookies.hasOwnProperty(subName)){
				subcookieParts.push(encodeURIComponent(subName)) + "=" +
					encodeURIComponent(subcookies[subName]);
			}
		}
		
		if(cookieParts.lenght > 0){
			cookieText += subcookieParts.join(" & ");
			
			if(expires instanceof Date){
				cookieText += "; expires=" + expires.toGMTString();
			}
			
			if(path){
				cookieText += "; path=" + paht;
			}
			
			if(domain){
				cookieText += "; domain=" + domain;
			}
			
			if(secure){
				cookieText += "; secure";
			}
		}else{
			cookieText += "; expires=" +  (new Date(0)).toGMTString();
		}
		
		document.cookie = cookieText;
	},
	
	unset:function(name,subName,path,domain,secure){
		var subcookies = this.getAll(name);
		if(subcookies){
			delete subcookies[subName];
			this.setAll(name,subcookies,null,path,domian,secure);
		}
	},
	
	unsetAll:function(name,path,domain,secure){
		this.setAll(name,null,new Date(0),path,domain,secure);
	}
	
};// cookie end
