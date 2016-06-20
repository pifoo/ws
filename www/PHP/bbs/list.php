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
		?>

		<table width=500 border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#add3ef">
		<?php
			$sql = "SELECT * FROM message ORDER BY id DESC";
			$query = mysql_query($sql);
			while ($row = mysql_fetch_array($query)) {
		?>
			<tr bgcolor="#eff3ff">
				<td>标题：<?= $row[title] ?> 用户：<?= $row[user] ?></td>
			</tr>
			<tr bgColor="#ffffff">
				<td>内容：<?= $row[content] ?></td>
			</tr>
			
		<?php
			}
		?>
		</table>
	</body>
</html>