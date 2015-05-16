<?php
	$client = $_GET['client'];
	$userID = $_GET['userID'];
	$stepName = $_GET['stepName'];
	$number = $_GET['number'];
	$travelTimeMinutes = $_GET['travelTimeMinutes'];
	
	if($client == 1)
	{
		include "config.php";

		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$result = mysql_query("INSERT INTO levels (levels_userid, levels_datetime, levels_step_name, levels_number, levels_travel_time_minutes) VALUES 
				('".$userID."', '".date("Y-m-d H:i:s")."', '".$stepName."', ".$number.", ".$travelTimeMinutes.")", $db);
	
		if(!$result) 
		{
			echo "INSERT [levels]: Error: ".mysql_error();
			mysql_close();
			exit;
		}else {
			echo "Add new level in table!";
		}
		mysql_close();
	}
?>