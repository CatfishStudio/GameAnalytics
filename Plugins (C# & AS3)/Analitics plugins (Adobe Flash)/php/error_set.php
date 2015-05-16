<?php
	$client = $_GET['client'];
	$userID = $_GET['userID'];
	$type = $_GET['type'];
	$location = $_GET['location'];
	
	if($client == 1)
	{
		include "config.php";

		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$result = mysql_query("INSERT INTO errors (errors_userid, errors_datetime, errors_type, errors_location) VALUES 
				('".$userID."', '".date("Y-m-d H:i:s")."', '".$type."', '".$location."')", $db);
	
		if(!$result) 
		{
			echo "INSERT [errors]: Error: ".mysql_error();
			mysql_close();
			exit;
		}else {
			echo "Add new error in table!";
		}
		mysql_close();
	}
?>