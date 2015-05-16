<?php
	$client = $_GET['client'];
	$userID = $_GET['userID'];
	$action = $_GET['action'];
	
	if($client == 1)
	{
		include "config.php";

		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database, $db);
		
		if ($action == "begin")
		{
			$result = mysql_query("INSERT INTO retention (retention_userid, retention_datetime_begin, retention_datetime_exit, retention_datetime_return) VALUES 
				('".$userID."', '".date("Y-m-d H:i:s")."', '1900-01-01 00:00:00', '1900-01-01 00:00:00')", $db);
		}
		
		if ($action == "exit") 
		{
			$result = mysql_query("INSERT INTO retention (retention_userid, retention_datetime_begin, retention_datetime_exit, retention_datetime_return) VALUES 
				('".$userID."', '1900-01-01 00:00:00', '".date("Y-m-d H:i:s")."', '1900-01-01 00:00:00')", $db);
		}
		
		if ($action == "return") 
		{
			$result = mysql_query("INSERT INTO retention (retention_userid, retention_datetime_begin, retention_datetime_exit, retention_datetime_return) VALUES 
				('".$userID."', '1900-01-01 00:00:00', '1900-01-01 00:00:00', '".date("Y-m-d H:i:s")."')", $db);
		}
		
		if(!$result) 
		{
			echo "INSERT [retention]: Error: ".mysql_error();
			mysql_close();
			exit;
		}else {
			echo "Add new retention in table!";
		}
		mysql_close();
	}
	
?>