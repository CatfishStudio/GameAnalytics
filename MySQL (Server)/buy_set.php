<?php
	$client = $_GET['client'];
	$userID = $_GET['userID'];
	$name = $_GET['name'];
	$number = $_GET['number'];
	$price = $_GET['price'];
	$view = $_GET['view'];
	$location = $_GET['location'];
	
	if($client == 1)
	{
		include "config.php";
		
		$sum = $price * $number;

		$db = mysql_connect($server, $uid, $pass);
		mysql_select_db($database,$db);
		$result = mysql_query("INSERT INTO buys (buys_userid, buys_datetime, buys_object_name, buys_number, buys_price, buys_sum, buys_view, buys_location) VALUES 
				('".$userID."', '".date("Y-m-d H:i:s")."', '".$name."', ".$number.", ".$price.", ".$sum.", '".$view."', '".$location."')", $db);
	
		if(!$result) 
		{
			echo "INSERT buys: Error: ".mysql_error();
			mysql_close();
			exit;
		}else {
			echo "Add new buy in table!";
		}
		mysql_close();
	}
?>