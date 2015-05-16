<?php
	$client = $_GET['client'];
	$userID = $_GET['userID'];
	$boosterName = $_GET['boosterName'];
	$levelNumber = $_GET['levelNumber'];
	
	if($client == 1)
	{
		include "config.php";

		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$result = mysql_query("INSERT INTO boosters (boosters_userid, boosters_datetime, boosters_name, boosters_level) VALUES 
				('".$userID."', '".date("Y-m-d H:i:s")."', '".$boosterName."', ".$levelNumber.")", $db);
	
		if(!$result) 
		{
			echo "INSERT [boosters]: Error: ".mysql_error();
			mysql_close();
			exit;
		}else {
			echo "Add new booster in table!";
		}
		mysql_close();
	}
?>