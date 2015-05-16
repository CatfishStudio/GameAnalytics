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
					."\"id\": "."\"".$row['levels_id']."\"".","
					."\"level\": ["
					."{"
						."\"levels_userid\": "."\"".$row['levels_userid']."\"".","
						."\"levels_datetime\": "."\"".$row['levels_datetime']."\"".","
						."\"levels_step_name\": "."\"".$row['levels_step_name']."\"".","
						."\"levels_number\": "."\"".$row['levels_number']."\"".","
						."\"levels_travel_time_minutes\": "."\"".$row['levels_travel_time_minutes']."\""
					."}]}"; 
				$firstRecord = false;
			}
			
			mysql_close();
			
			$data_array_json .= "]";
			echo $data_array_json;
		}
	}
?>