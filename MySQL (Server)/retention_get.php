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
					."\"id\": "."\"".$row['retention_id']."\"".","
					."\"retention\": ["
					."{"
						."\"retention_userid\": "."\"".$row['retention_userid']."\"".","
						."\"retention_datetime_begin\": "."\"".$row['retention_datetime_begin']."\"".","
						."\"retention_datetime_exit\": "."\"".$row['retention_datetime_exit']."\"".","
						."\"retention_datetime_return\": "."\"".$row['retention_datetime_return']."\""
					."}]}"; 
				$firstRecord = false;
			}
			
			mysql_close();
			
			$data_array_json .= "]";
			echo $data_array_json;
		}
	}
?>