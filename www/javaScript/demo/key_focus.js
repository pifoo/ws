$(function(){
	
	var currentObj = null; //当前高亮对象
	var bannercs = new Array();
	var forlds = new Array();

	$.each($(".bannerc div"), function(i, obj){	
		bannercs[i] = $(obj);
	});
	
	$.each($(".footercleft ul li"), function(i, obj){
		forlds[i] = $(obj).find("img");
	}); 

	var form0 = $(".topnvar form");
	var form1 = $(".footerbotl form");
	var form2 = $(".footerbotr form");
	
	into();

	/**
	 *初始化对象
	**/
	function into(){
		var bigImgObj0 = new Point(bannercs[0],0);
		var bigImgObj1 = new Point(bannercs[1],0);
		var bigImgObj2 = new Point(bannercs[2],0);

		var forldObj0 = new Point(forlds[0],0);
		var forldObj1 = new Point(forlds[1],0);
		var forldObj2 = new Point(forlds[2],0);
		var forldObj3 = new Point(forlds[3],0);
		var forldObj4 = new Point(forlds[4],0);
		var forldObj5 = new Point(forlds[5],0);
		var forldObj6 = new Point(forlds[6],0);
		var forldObj7 = new Point(forlds[7],0);
		var forldObj8 = new Point(forlds[8],0);
		var forldObj9 = new Point(forlds[9],0);

		var formObj0 = new Point(form0,1);
		var formObj1 = new Point(form1,1);
		var formObj2 = new Point(form2,1);

		bigImgObj0.setUp(formObj0);
		bigImgObj0.setDown(forldObj0);
		bigImgObj0.setRight(bigImgObj1);

		bigImgObj1.setUp(formObj0);
		bigImgObj1.setDown(forldObj2);
		bigImgObj1.setLeft(bigImgObj0);
		bigImgObj1.setRight(bigImgObj2);

		bigImgObj2.setUp(formObj0);
		bigImgObj2.setDown(forldObj4);
		bigImgObj2.setLeft(bigImgObj1);
		
		forldObj0.setUp(bigImgObj0);
		forldObj0.setDown(forldObj5);
		forldObj0.setLeft(null);
		forldObj0.setRight(forldObj1);

		forldObj1.setUp(bigImgObj0);
		forldObj1.setDown(forldObj6);
		forldObj1.setLeft(forldObj0);
		forldObj1.setRight(forldObj2);

		forldObj2.setUp(bigImgObj1);
		forldObj2.setDown(forldObj7);
		forldObj2.setLeft(forldObj1);
		forldObj2.setRight(forldObj3);

		forldObj3.setUp(bigImgObj2);
		forldObj3.setDown(forldObj8);
		forldObj3.setLeft(forldObj2);
		forldObj3.setRight(forldObj4);

		forldObj4.setUp(bigImgObj2);
		forldObj4.setDown(forldObj9);
		forldObj4.setLeft(forldObj3);
		forldObj4.setRight(null);

		forldObj5.setUp(forldObj0);
		forldObj5.setDown(formObj1);
		forldObj5.setLeft(null);
		forldObj5.setRight(forldObj6);

		forldObj6.setUp(forldObj1);
		forldObj6.setDown(formObj1);
		forldObj6.setLeft(forldObj5);
		forldObj6.setRight(forldObj7);

		forldObj7.setUp(forldObj2);
		forldObj7.setDown(formObj2);
		forldObj7.setLeft(forldObj6);
		forldObj7.setRight(forldObj8);

		forldObj8.setUp(forldObj3);
		forldObj8.setDown(formObj2);
		forldObj8.setLeft(forldObj7);
		forldObj8.setRight(forldObj9);

		forldObj9.setUp(forldObj4);
		forldObj9.setDown(formObj2);
		forldObj9.setLeft(forldObj8);
		forldObj9.setRight(null);

		formObj0.setUp(null);
		formObj0.setDown(bigImgObj1);
		formObj0.setLeft(null);
		formObj0.setRight(null);


		formObj1.setUp(forldObj5);
		formObj1.setDown(null);
		formObj1.setLeft(null);
		formObj1.setRight(formObj2);

		formObj2.setUp(forldObj7);
		formObj2.setDown(null);
		formObj2.setLeft(formObj1);
		formObj2.setRight(null);

		currentObj = bigImgObj1;

		currentObj.getIndex().css("-webkit-box-shadow","#FFF 0px 0px 18px 6px").css("z-index","1");
	}

	$("body").eq(0).mouseover(function(){
		hideFocus();
	});
	$("body").eq(0).mouseout(function(){
		 showFocus();
	});
	/**
	 *监控键值
	**/
	document.onkeydown = grabEvent;
	function grabEvent(e){

		switch(e.which){
			case 1:
			case 38: //UP
				keyUp();
				return 0;
				break;
			case 2:
			case 40: //DOWN
				keyDown();
				return 0;
				break;
			case 3:
			case 37: //LEFT
				keyLeft();
				return 0;
				break;
			case 4:
			case 39: //RIGHT
				keyRight();
				return 0;
				break;
			case 13:
				doSelect();
				return 0;
				break;
			case 372:	//上翻页
			case 373:	//下翻页
				//return 0;
				break;
			case 27:
			case 340:
				goBack();
				return 0;
				break;
			case 513:
				//gotoIndex();
				//return 0;
				break;
			case 835:
				//gotoIndex();
				//return 0;
				break;
			case 832:
				//gotoIndex();
				//return 0;
				break;
		}
		
	}

	function keyUp(){

		if(currentObj.getIsLock()){
			return;  //退出当前函数，返回undefined 
		}

		if(currentObj.getUp() != null && currentObj.getUp() != undefined){
			hideFocus();
			currentObj = currentObj.getUp();
			showFocus();
		}
	}

	function keyDown(){

		if(currentObj.getIsLock()){
			return;
		}

		if(currentObj.getDown() != null && currentObj.getDown() != undefined){
			hideFocus();
			currentObj = currentObj.getDown();
			showFocus();
		}
	}

	function keyLeft(){
		if(currentObj.getIsLock()){
			return;
		}

		if(currentObj.getLeft() != null && currentObj.getLeft() != undefined){
			hideFocus();
			currentObj = currentObj.getLeft();
			showFocus();
		}
	}

	function keyRight(){
		if(currentObj.getIsLock()){
			return;
		}

		if(currentObj.getRight() != null && currentObj.getRight() != undefined){
			hideFocus();
			currentObj = currentObj.getRight();
			showFocus();
		}
	}

	function doSelect(){
		if(currentObj.getNtype() == 1){
			if(!currentObj.getIsLock()){
				currentObj.getIndex().find("input:eq(0)").focus();
				currentObj.setIsLock(true);
				currentObj.getIndex().one("submit",function (){
					return false;
				});
				
			}else{
				currentObj.getIndex().submit();
			}
		}else if(currentObj.getNtype() == 0){
			//currentObj.getIndex().click();
			//location.href =
		}
	}

	function goBack(){
		if(currentObj.getIsLock()){
			currentObj.getIndex().find("input:eq(0)").blur();
			currentObj.setIsLock(false);
		}
	}

	function hideFocus(){
		currentObj.getIndex().css("-webkit-box-shadow","").css("z-index","");
	}

	function showFocus(){
		currentObj.getIndex().css("-webkit-box-shadow","#FFF 0px 0px 18px 6px").css("z-index","1");
	}

}); 

/**
 *定义高亮对象
**/
function Point(index,nType,url){
	this.index = index;  //html元素
	this.up = null;
	this.down = null;
	this.left = null;
	this.right = null; 
	this.nType = nType;	//类型 0 连接 1 文本
	this.isLock = false; //是否锁定
	this.url = url;
}

Point.prototype.setUp = function(obj){
	this.up = obj;
}

Point.prototype.setDown = function(obj){
	this.down = obj;
}

Point.prototype.setLeft = function(obj){
	this.left = obj;
}

Point.prototype.setRight = function(obj){
	this.right = obj;
}

Point.prototype.setIsLock = function(isLock){
	this.isLock = isLock;
}

Point.prototype.setUrl = function(url){
	this.url = url;
}

Point.prototype.getIndex = function(){
	return this.index;
}

Point.prototype.getUp = function(){
	return this.up;
}

Point.prototype.getDown = function(){
	return this.down;
}

Point.prototype.getLeft = function(){
	return this.left;
}

Point.prototype.getRight = function(){
	return this.right;
}

Point.prototype.getNtype = function(){
	return this.nType;
}

Point.prototype.getIsLock = function(){
	return this.isLock;
}

Point.prototype.getUrl = function(){
	return this.url;
}

	
