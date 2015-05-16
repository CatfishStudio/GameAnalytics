<?php
	$client = $_GET['client'];
	$userID = $_GET['userID'];
	$stepName = $_GET['stepName'];
	$travelTimeMinutes = $_GET['travelTimeMinutes'];
	
	if($client == 1)
	{
		include "config.php";
		
		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$result = mysql_query("INSERT INTO tutorial (tutorial_userid, tutorial_datetime, tutorial_step_name, tutorial_travel_time_minutes) VALUES 
				('".$userID."', '".date("Y-m-d H:i:s")."', '".$stepName."', ".$travelTimeMinutes.")", $db);
	
		if(!$result) 
		{
			echo "INSERT [tutorial]: Error: ".mysql_error();
			mysql_close();
			exit;
		}else {
			echo "Add new tutorial in table!";
		}
		mysql_close();
	}
?>