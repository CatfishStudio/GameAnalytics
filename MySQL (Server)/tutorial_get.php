<?php
	$client = $_GET['client'];
	$sqlcommand = $_GET['sqlcommand'];
	
	if($client == 1)
	{
		include "config.php";
		
		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$query = mysql_query($sqlcommand, $db);
		
		if(!$query) 
		{
			echo "error";
			mysql_close();
			exit;
		}else {
			$firstRecord = true;
			$data_array_json = "[";
			
			while($row = mysql_fetch_array($query))
			{
				if ($firstRecord == false) $data_array_json .= ",{";
				else $data_array_json .= "{";

				$data_array_json .= ""
					."\"id\": "."\"".$row['tutorial_id']."\"".","
					."\"tutorial\": ["
					."{"
						."\"tutorial_userid\": "."\"".$row['tutorial_userid']."\"".","
						."\"tutorial_datetime\": "."\"".$row['tutorial_datetime']."\"".","
						."\"tutorial_step_name\": "."\"".$row['tutorial_step_name']."\"".","
						."\"tutorial_travel_time_minutes\": "."\"".$row['tutorial_travel_time_minutes']."\""
					."}]}"; 
				$firstRecord = false;
			}
			
			mysql_close();
			
			$data_array_json .= "]";
			echo $data_array_json;
		}
	}
?>