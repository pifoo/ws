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
		  * protected  封装，保护类型
		  * extends
		  */
		 	class Root{
		 		protected function dayin(){
		 			return "Root print. ";
		 		}
		 	}
			
			class Son extends Root{
				function dayin(){//重载,与父类中的方法同名
					//return $this->dayin()."Son print";
		 			return Root::dayin()."Son print";//调用父类的同名方法
		 		}
			}
		 	
			$p = new Son();
			echo $p->dayin()."<br/>";
			
			/*
			 * 抽象关键字：abstract   规范子类方法的名称，并且在子类必须重载这些抽象方法
			 * 抽象方法：只有方法的声明，没有方法的实现
			 */
			abstract class Class1{
				abstract function fun1();//没有{}
				abstract function fun2();
				abstract function fun3();
				function ok(){
					
				}
			}
			class class2 extends class1{
				function fun1(){//都要重载
					echo "第一个";
				}
				function fun2(){
					echo "第二个<br/>";
				}
				function fun3(){
					echo "第三个";
				}
			}
			$p1 = new Class2();
			$p1->fun2();
			
			/*
			 * 类中常用关键字 
			 * fianl 锁,当定义类，不能被继承；当定义方法，不能被重载
			 * self 类似$this，访问静态属性；区别：可以直接访问当前类中的内部成员，不需要实例化
			 * static 静态属性
			 * const 常量(大写，没$)，在类中只能声明对象属性，不能声明对象方法
			 */
			class MyPc{
				public $name = "我的电脑";
				//final 
				function power(){
					echo $this->name.",电脑开机中……";
				}
			}
			class My extends MyPc{
				function power(){
					echo MyPc::power()."************";
				}
			}
			$p2 = new My();
			$p2->power();
		?>
		
		
		
		
		
		
		
		
		
		
	</body>		
</html>
