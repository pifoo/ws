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
		  * 多态
		  * 运算符：instanceof   用来测定一个给定的对象是否来自指定的对象类
		  */
		 class A{};
		 class B{};
		 $thing = new A();
		 if($thing instanceof A){
		 	echo "A<br/>";
		 }
		 if($thing instanceof B){
	 		echo "B<br/>";
		 }	
		 
		 
		 interface myusb{
		 	function type();
			function alert();
		 }
		 class zip implements myusb{
		 	function type(){
		 		echo "2.0";
		 	}
			function alert(){
				echo "正在检查……U盘驱动";
			}
			
		 }
		 class mp3 implements myusb{
		 	function type(){
		 		echo "1.0";
		 	}
			function alert(){
				echo "正在检查……mp3盘驱动";
			}
			
		 }
		 
		 class mypc{
		 	function pcusb($what){//接收一个设备（对象）
		 		$what->type()."<br/>";
				$what->alert();
		 	}
		 }
		 
		 $p = new mypc();
		 $zip = new zip();
		 $mp3 = new mp3();
		 
		 $p->pcusb($zip);
		 $p->pcusb($mp3);
		 
		 
		 
		?>
		
		
		
		
		
		
		
		
		
		
	</body>	
</html>
