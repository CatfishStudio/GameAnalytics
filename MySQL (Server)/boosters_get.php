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
					."\"id\": "."\"".$row['boosters_id']."\"".","
					."\"booster\": ["
					."{"
						."\"boosters_userid\": "."\"".$row['boosters_userid']."\"".","
						."\"boosters_datetime\": "."\"".$row['boosters_datetime']."\"".","
						."\"boosters_name\": "."\"".$row['boosters_name']."\"".","
						."\"count_boosters\": "."\"".$row['count_boosters']."\"".","
						."\"boosters_level\": "."\"".$row['boosters_level']."\""
					."}]}"; 
				$firstRecord = false;
			}
			
			mysql_close();
			
			$data_array_json .= "]";
			echo $data_array_json;
		}
	}
?>