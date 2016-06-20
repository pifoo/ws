<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>PHP Demo</title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
		<link href="../css/global.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var s = document.title.split("");
			setInterval(function() {
				s.push(s.shift());
				document.title = s.join("");
			}, 1000);

		</script>
	</head>
	<body>
		<?php
		/*
			class MyPc{
				public $name;	//成员属性
				var $price;	//向下兼容的一种方式 
				function vod() {	//成员方法
					return "PHP100视频教程";
				}
			}
			// new 对象名（参数）
			
			$pc1 = new MyPc();	//对象实例化
			$pc1->name="MrHe";
			echo $pc1->name;
		 */
		?>
		
		<?php
		/*
			class MyPc {
				public $name;
				public $type;
				
				function vod() {
					return $this->name."，播放电影";
				}
				function game(){
					return $this->vod()."玩游戏";
				}
				function intelnet(){
					return "上网";
				}
			}
			
			$pc1 = new MyPc();
			$pc2 = new MyPc();
			$pc1->name="家用电脑";
			$pc2->name="公司电脑";
			
			echo $pc1->vod()."<br/>";
			echo $pc2->game()."<br/>";
		 * 
		 */
		?>
		
		<?php
		 //$this,__construct();__destruct();
			class MyPc {
				public $name;
				public $type;
				
				/*function MyPc($name){//php4中构造函数初始化
					$this->name = $name;
				}*/
				function __construct($name,$type){//php5中构造函数初始化
					$this->name = $name;
					$this->type = $type;
				}
				
				function vod() {
					return $this->name.$this->type."，播放电影";
				}
				function game(){
					return $this->vod()."玩游戏";
				}
				function intelnet(){
					return "上网";
				}
				
				function __destruct(){//释放，后进先出的原则  所有实例都执行完后才销毁
					echo "<br/>======".$this->name."<br/>";
				}
			}
			
			$pc1 = new MyPc("家用电脑","台式机");
			$pc2 = new MyPc("公司电脑","笔记本");
			
			echo $pc1->vod()."<br/>";
			//$pc1 = null;//当前实例运行完后马上销毁
			echo $pc2->game()."<br/>";
		
		?>
		
		
		
		
		
		
		
		
		
		
	</body>	
</html>
