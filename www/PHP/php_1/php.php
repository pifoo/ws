<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title>PHP Demo</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<link href="../css/global.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
        var s = document.title.split("");
        setInterval( function() {
            s.push(s.shift());
            document.title = s.join("");
        },1000);
	</script>
</head>
<body>
	<?php	
		while ($row = mysql_fetch_array($query)) {
			//print_r($row);
			//echo "</br> -->";
			//echo $row[0]."</br>";
			//echo $row[0];
		}
		echo mysql_num_rows($query);
	?>
	
	<?php
		//php里的页面相互调用 
		/*
		 * require()与 require_onec()    require_onec()同一个文件只读取一次
		 * 通常放在php程序的最前面，php程序在执行前，就会先读入require所指定引入的文件，如果出现错误是致命的。
		 * 
		 * include()与 include_once()    include_once()同一个文件只读取一次
		 * 可以放在php程序的任何一个位置，php程序在执行到时，才会先读入include所指定引入的文件，如果出现错误将会提示。
		 * 
		 * require('con.php');
		 * include('con.php');
		 * 
		 */
		
		
		
		
		
		
	?>
	<script src="http://debug.phonegap.com/target/target-script-min.js#anonymous"></script>
	
</body>
</html>
