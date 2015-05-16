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
					."\"id\": "."\"".$row['errors_id']."\"".","
					."\"error\": ["
					."{"
						."\"errors_userid\": "."\"".$row['errors_userid']."\"".","
						."\"errors_datetime\": "."\"".$row['errors_datetime']."\"".","
						."\"errors_type\": "."\"".$row['errors_type']."\"".","
						."\"errors_count\": "."\"".$row['errors_count']."\"".","
						."\"errors_location\": "."\"".$row['errors_location']."\""
					."}]}"; 
				$firstRecord = false;
			}
			
			mysql_close();
			
			$data_array_json .= "]";
			echo $data_array_json;
		}
	}
?>