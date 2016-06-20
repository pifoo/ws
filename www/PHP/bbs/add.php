<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title>PHP Demo</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<link href="/php/css/global.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<?php
	    include ("conn.php");
		
		if($_POST['submit']){
			// 可以用echo输出，检查是否已经取到值
			$sql = "INSERT INTO message (id,user,title,content,lastdate)" .
					"VALUES('','$_POST[user]','$_POST[title]','$_POST[content]',now())";
			mysql_query($sql);
			echo "提交成功";
		}
	?>
	
	<form action="add.php" method="post">
		用户：<input type="text" size="10" name="user" /> <br/>
		标题：<input type="text" name="title" /> <br/>
		内容：<textarea name="content"></textarea> <br/>
		
		<input type="submit" name="submit" value="提交" />
		
	</form>
	
</body>
</html>