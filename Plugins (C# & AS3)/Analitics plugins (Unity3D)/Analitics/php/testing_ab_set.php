<?php
	$client = $_GET['client'];
	$userID = $_GET['userID'];
	$session = $_GET['session'];
	$record = $_GET['record'];
	
	if($client == 1)
	{
		include "config.php";

		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$result = mysql_query("INSERT INTO ab_testing (ab_testing_userid, ab_testing_datetime, ab_testing_session, ab_testing_record) VALUES 
				('".$userID."', '".date("Y-m-d H:i:s")."', '".$session."', '".$record."')", $db);
	
		if(!$result) 
		{
			echo "INSERT [ab_testing]: Error: ".mysql_error();
			mysql_close();
			exit;
		}else {
			echo "Add new ab_testing in table!";
		}
		mysql_close();
	}
?>