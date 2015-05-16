<?php
	$server = $_POST['server'];
	$uid = $_POST['uid'];
	$pass = $_POST['pass'];
	$database = $_POST['database'];
	
	$create = $_GET['create'];
	
	if($create == null)
	{
		echo "<h1>Information system game analitics</h1>";
		echo "<h2>Create database:</h2>";
		echo "<form action='index.php?create=database' method='post'>";
		echo "<label for='server'>Server:</label><br><input type='text' name='server' id='server' value='localhost'><br>";
		echo "<label for='database'>Database:</label><br><input type='text' name='database' id='database' value='analitics'><br>";
		echo "<label for='Uid'>uid:</label><br><input type='text' name='uid' id='uid' value='root'><br>";
		echo "<label for='pass'>Pass:</label><br><input type='password' name='pass' id='pass' value=''><br>";
		echo "<br><input type='submit' value='Create database' id='bottonGo'>";
		echo "</form>";
		echo "<br><br>";
		echo "<h2>Create tables:</h2>";
		echo "<form action='index.php?create=tables' method='post'>";
		echo "<label for='server'>Server:</label><br><input type='text' name='server' id='server' value='localhost'><br>";
		echo "<label for='database'>Database:</label><br><input type='text' name='database' id='database' value='analitics'><br>";
		echo "<label for='Uid'>uid:</label><br><input type='text' name='uid' id='uid' value='root'><br>";
		echo "<label for='pass'>Pass:</label><br><input type='password' name='pass' id='pass' value=''><br>";
		echo "<br><input type='submit' value='Create tables' id='bottonGo'>";
		echo "</form>";
	}else{
	
		if($create == "database")
		{
			/* Соединение с сервером баз данных */
			$db = mysql_connect($server, $uid, $pass);
			/* Запрос на создание базы данных  */
			$query = mysql_query("CREATE DATABASE ".$database, $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Database not create!";
				exit;
			}else{
				echo "<br><br>Database created!";
			}
			
			echo "<br><br>";
			echo "<form action='index.php' method='post'>";
			echo "<input type='submit' value='Back' id='back'>";
			echo "</form>";
		}
		/*--------------------------------------------------*/
		
		if($create == "tables")
		{
			/* Соединение с сервером баз данных */
			$db = mysql_connect($server, $uid, $pass);
			/*Соединение с базой данных*/
			mysql_select_db($database, $db);
		
			/*Создание таблицы Пользователи (users) =========================== */
			$query = mysql_query("CREATE TABLE users (
				users_id int(7) NOT NULL AUTO_INCREMENT,
				users_userid varchar(255) NOT NULL,
				users_name varchar(255) NOT NULL,
				users_location varchar(255) NOT NULL,
				PRIMARY KEY (users_id),
				UNIQUE KEY users_uid (users_userid)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"users\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"users\" - complete!";
			}
			/*==================================================================*/
	
			
			/*Создание таблицы Тутор (tutorial) =============================== */
			$query = mysql_query("CREATE TABLE tutorial (
				tutorial_id int(10) NOT NULL AUTO_INCREMENT,
				tutorial_userid varchar(255) NOT NULL,
				tutorial_datetime datetime NOT NULL,
				tutorial_step_name varchar(255) NOT NULL,
				tutorial_travel_time_minutes int(5) NOT NULL DEFAULT '0',
				PRIMARY KEY (tutorial_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"tutorial\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"tutorial\" - complete!";
			}
			/*==================================================================*/
			
			/*Создание таблицы Уровни (levels) ================================ */
			$query = mysql_query("CREATE TABLE levels (
				levels_id int(10) NOT NULL AUTO_INCREMENT,
				levels_userid varchar(255) NOT NULL,
				levels_datetime datetime NOT NULL,
				levels_step_name varchar(255) NOT NULL,
				levels_number int(5) NOT NULL DEFAULT '0',
				levels_travel_time_minutes int(5) NOT NULL DEFAULT '0',
				PRIMARY KEY (levels_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"levels\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"levels\" - complete!";
			}
			/*==================================================================*/
			
			/*Создание таблицы Усилители (boosters) =========================== */
			$query = mysql_query("CREATE TABLE boosters (
				boosters_id int(10) NOT NULL AUTO_INCREMENT,
				boosters_userid varchar(255) NOT NULL,
				boosters_datetime datetime NOT NULL,
				boosters_name varchar(255) NOT NULL,
				boosters_level int(5) NOT NULL DEFAULT '0',
				PRIMARY KEY (boosters_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"boosters\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"boosters\" - complete!";
			}
			/*==================================================================*/
			
			/*Создание таблицы Покупки (buys) =========================== */
			$query = mysql_query("CREATE TABLE buys (
				buys_id int(10) NOT NULL AUTO_INCREMENT,
				buys_userid varchar(255) NOT NULL,
				buys_datetime datetime NOT NULL,
				buys_object_name varchar(255) NOT NULL,
				buys_number decimal (18, 2) NOT NULL DEFAULT '0',
				buys_price decimal (18, 2) NOT NULL DEFAULT '0',
				buys_sum decimal (18, 2) NOT NULL DEFAULT '0',
				buys_view varchar(255) NOT NULL,
				buys_location varchar(255) NOT NULL,
				PRIMARY KEY (buys_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"buys\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"buys\" - complete!";
			}
			/*==================================================================*/
			
			/*Создание таблицы AB тестирование (ab_testing) =========================== */
			$query = mysql_query("CREATE TABLE ab_testing (
				ab_testing_id int(10) NOT NULL AUTO_INCREMENT,
				ab_testing_userid varchar(255) NOT NULL,
				ab_testing_datetime datetime NOT NULL,
				ab_testing_session varchar(255) NOT NULL,
				ab_testing_record varchar(255) NOT NULL,
				PRIMARY KEY (ab_testing_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"ab_testing\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"ab_testing\" - complete!";
			}
			/*==================================================================*/
			
			/*Создание таблицы Удержание/Сохранение (retention) =========================== */
			$query = mysql_query("CREATE TABLE retention (
				retention_id int(10) NOT NULL AUTO_INCREMENT,
				retention_userid varchar(255) NOT NULL,
				retention_datetime_begin datetime NOT NULL,
				retention_datetime_exit datetime NOT NULL,
				retention_datetime_return datetime NOT NULL,
				PRIMARY KEY (retention_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"retention\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"retention\" - complete!";
			}
			/*==================================================================*/
			
			
			/*Создание таблицы Журнал ошибок (errors) =========================== */
			$query = mysql_query("CREATE TABLE errors (
				errors_id int(10) NOT NULL AUTO_INCREMENT,
				errors_userid varchar(255) NOT NULL,
				errors_datetime datetime NOT NULL,
				errors_type varchar(255) NOT NULL,
				errors_location varchar(255) NOT NULL,
				PRIMARY KEY (errors_id)
			)", $db);
			/* Проверка успешности выполнения */
			if(!$query){
				echo "<br><br>ERROR!!! Table \"errors\" - error! ";
				echo "<br><br>Error: ", mysql_error();
				$query = mysql_query("DROP DATABASE ".$database, $db);
				exit;
			}else{
				echo "<br><br>Create table \"errors\" - complete!";
			}
			/*==================================================================*/
			
	
			echo "<br><br>";
			echo "<form action='index.php' method='post'>";
			echo "<input type='submit' value='Back' id='back'>";
			echo "</form>";
		}
	}
?>