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
		  * 接口:一种成员属性全部为抽象或常量的特殊抽象类
		  * interface
		  * implements
		  * 单继承，多接口
		  */
			interface demo{
				const NAME = "名字";//对象属性须为常量
				
				function fun1();//对象方法为抽象方法，无须加abstract
				function fun2();
			}
			interface demo2{				
				function fun3();
				function fun4();
			}
			interface demo3{				
				const PLAY="播放";
				function fun5();
			}
			
			class MyPc implements demo,demo2{
				//须重载抽象内容
				function fun1(){
					echo "-1---------------------<br/>";
				}
				function fun2(){
					echo "-2---------------------<br/>";
				}
				function fun3(){
					echo "-3---------------------<br/>";
				}
				function fun4(){
					echo "-4---------------------<br/>";
				}
			}
			
			$p = new  MyPc();
			$p->fun1();
			$p->fun2();
			$p->fun3();
			$p->fun4();
			echo MyPc::NAME."<br/>";
			
			class mpc extends MyPc implements demo3{
				function fun5(){
					echo "-5---------------------<br/>";
				}
			}
			$p1 = new mpc();
			echo mpc::NAME."<br/>";
			$p1->fun1();
			$p1->fun3();
			$p1->fun5();
		?>
		
		
		
		
		
		
		
		
		
		
	</body>	
</html>
