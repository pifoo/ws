<?php
    /*
	 * cookie与session
	 */
	if ($_GET[out]) {
				setcookie('id','');
		setcookie('pass','');
	}
	if($_POST[name] && $_POST[password]){
		setcookie('id',$_POST[name]);
		setcookie('pass',$_POST[password]);
	}
	
	if ($_COOKIE[id] && $_COOKIE[pass]) {
		echo "登陆成功<br/>用户名：".$_COOKIE[id].'<br/>密码：'.$_COOKIE[pass];	
		echo "<a href='cookieAndSession.php?out=out'>退出</a>";
	}
	
	
?>
<form action="" method="post">
	<input type="text" name="name" /> <br/>
	<input type="password" name="password" /><br />
	<input type="submit" value="登陆" />
</form>