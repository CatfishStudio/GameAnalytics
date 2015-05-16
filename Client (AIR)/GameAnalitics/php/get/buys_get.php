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
					."\"id\": "."\"".$row['buys_id']."\"".","
					."\"buy\": ["
					."{"
						."\"buys_userid\": "."\"".$row['buys_userid']."\"".","
						."\"buys_datetime\": "."\"".$row['buys_datetime']."\"".","
						."\"buys_object_name\": "."\"".$row['buys_object_name']."\"".","
						."\"buys_number\": "."\"".$row['buys_number']."\"".","
						."\"buys_price\": "."\"".$row['buys_price']."\"".","
						."\"buys_sum\": "."\"".$row['buys_sum']."\"".","
						."\"buys_view\": "."\"".$row['buys_view']."\"".","
						."\"buys_location\": "."\"".$row['buys_location']."\""
					."}]}"; 
				$firstRecord = false;
			}
			
			mysql_close();
			
			$data_array_json .= "]";
			echo $data_array_json;
		}
	}
?>