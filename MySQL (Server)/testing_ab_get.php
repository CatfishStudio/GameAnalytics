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
					."\"id\": "."\"".$row['ab_testing_id']."\"".","
					."\"testing_ab\": ["
					."{"
						."\"ab_testing_userid\": "."\"".$row['ab_testing_userid']."\"".","
						."\"ab_testing_datetime\": "."\"".$row['ab_testing_datetime']."\"".","
						."\"ab_testing_session\": "."\"".$row['ab_testing_session']."\"".","
						."\"ab_testing_count\": "."\"".$row['ab_testing_count']."\"".","
						."\"ab_testing_record\": "."\"".$row['ab_testing_record']."\""
					."}]}"; 
				$firstRecord = false;
			}
			
			mysql_close();
			
			$data_array_json .= "]";
			echo $data_array_json;
		}
	}
?>