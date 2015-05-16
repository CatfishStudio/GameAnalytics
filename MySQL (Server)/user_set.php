<?php
	$client = $_GET['client'];
	$userID = $_GET['userID'];
	$userName = $_GET['userName'];
	$userLocation = $_GET['userLocation'];
	
	if($client == 1)
	{
		include "config.php";

		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$result = mysql_query("SELECT * FROM users WHERE users_userid = '".$userID."'", $db);
	
		if(!$result) 
		{
			echo "SELECT [users] Error: ".mysql_error();
			mysql_close();
			exit;
		}else {
			$num_rows = mysql_num_rows($result);
			if ($num_rows <= 0)
			{
			
				$query = mysql_query("INSERT INTO users (users_userid, users_name, users_location) VALUES
				('".$userID."', '".$userName."', '".$userLocation."')", $db);
				/* Проверка успешности выполнения */
				if(!$query){
					echo "INSERT [users] Error: ", mysql_error();
					mysql_close();
					exit;
				}else{
					echo "Add new user in table!";
				}
			}
		}
		mysql_close();
		echo "User detect!";
	}
?>