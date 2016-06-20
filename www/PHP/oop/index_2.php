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
		  * public 表示全局，类内部、外部子类都可以访问
		  * protected 表示受保护的，只能本类或子类或父类中可以访问
		  * private 表示私有的，只有本类内部可以使用
		  * get()
		  * set()
		  */
			class MyPc {
				//public $name;
				private $name;

				function __construct($name){
					return $this->name = $name;
				}
				function __get($name){//间接访问
					return $this->name."=======";
				}
				function __set($n,$v){
					if($v == "我的电脑"){
						$this->$n=$v;
					}
				}
				
				private function power(){
					return $this->name."打开电源，正在开机……";
				}
				
				function ok(){
					return $this->power()."开机成功！<br/>";
				}
			}
			
			$pc1 = new MyPc("家用电脑");
			echo $pc1->ok();
			$pc1->name = "我的电脑";
			//$pc1->name = "我的safas";
			echo $pc1->name;
		?>
		
		
		
		
		
		
		
		
		
		
	</body>		
</html>
