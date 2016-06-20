<?php 
	session_start();
	echo $_SESSION['foo']."</br>"; /* bar */ 
	if (md5($_SERVER['HTTP_USER_AGENT']) != $_SESSION['HTTP_USER_AGENT']) {
		echo "!=";
    } 
?>