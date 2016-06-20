<?php 
	session_start();
	$_SESSION['foo'] = 'barq'; 
	$_SESSION['HTTP_USER_AGENT'] = md5($_SERVER['HTTP_USER_AGENT']); 
?> 
        
<a href="continue.php">continue.php</a>