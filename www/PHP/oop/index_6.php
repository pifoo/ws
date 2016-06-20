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
			 * __tostring()  可以直接打印对象句柄，从而获得该方法的基本信息或其他内容
			 * __call()  自动吸收错误
			 * clone 克隆对象
			 * clone() 初始化克隆对象
			 * 自动载入(类)
			 *
			 */
			class My {
				public $name = "我的类";
				
				function __tostring() {	//可以返回类的一些基本信息
					echo $this -> name . "这个是空类";  
				}
				
				function __call($n,$v){ //自动吸收错误
					echo "不存在的方法为：".$n."<br/>";
					echo "不存在的值为：".print_r($v);
				}
				
				function __destruct(){
					echo " <br/>清理一个对象";
				}
				
				function __clone(){//克隆时初始化对象
					$this->name="你的类";
				}
			}
	
			$p = new My();
			
			//$p->demo("一",6);
			
			//$b=$p; //输出一次：清理对象
			
			$b=clone $p; //输出两次：清理对象
			
			echo $b->name; 
			
			
			//自动转入类
			/*
			 * 替代多个include()载入多个文类
			 */
			function __autoload($name){
				
				include("$name.php");
			}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		?>
	</body>
</html>
