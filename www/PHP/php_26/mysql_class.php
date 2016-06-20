<?php
    /*
	 * class mysql
	 * 制作自己的PHP.MYSQL的类
	 */
	
	class mysql{
		
		private $host;
		private $name;
		private $pass;
		private $table;	//数据库
		
		function __construct($host,$name,$pass,$table){	//初始化
			$this->host=$host;
			$this->name=$name;
			$this->pass=$pass;
			$this->table=$table;
			$this->connect();   //  初始化数据库连接
		}
		
		function connect(){
			$link = mysql_connect($this->host,$this->name,$this->pass) or die(mysql_error());
			mysql_select_db($this->table,$link) or die("没有数据库：".$this->table);
		}
		
		function query($v){	//要执行的操作
			return mysql_query($v);
		}
		
		function error(){
			return mysql_error();
		}
		
	}
	
	$db = new mysql("localhost","root","","newdb");
	
	
?>
