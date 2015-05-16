/*
 * Сделано в SharpDevelop.
 * Пользователь: Somov Evgeniy
 * Дата: 02.05.2015
 * Время: 14:27
 * 
 * Для изменения этого шаблона используйте Сервис | Настройка | Кодирование | Правка стандартных заголовков.
 */
using System;
using Analitics.analitics;

namespace Analitics.analitics
{
	/// <summary>
	/// Description of Analitics.
	/// </summary>
	public static class Analitics
	{
		/*
		public Analitics()
		{
		}
		*/
		
		/* ПУТЬ К СЕРВЕРУ */
		public static String serverPath = "http://localhost/ga/";
		
		/* ОСНОВНАЯ ИНФОРМАЦИЯ ПОЛЬЗОВАТЕЛЯ */
		public static String userID;
		public static String userName;
		public static String userLocation;
		
		/* КОНСТАНТЫ */
		public const String ACTION_BEGIN = "begin";
		public const String ACTION_EXIT = "exit";
		public const String ACTION_RETURN = "return";
		
		public const String ERROR_LOW = "low";
		public const String ERROR_NORMAL = "normal";
		public const String ERROR_HIGHT = "hight";
		public const String ERROR_URGENT = "urgent";
		public const String ERROR_IMMEDIATE = "immediate";
		
		private static Query query = new Query();
		
		/* ИДЕНТИФИКАЦИЯ ПОЛЬЗОВАТЕЛЯ */
		public static void User(String _userID, String _userName, String _userLocation)
		{
			userID = _userID;
			userName = _userName;
			userLocation = _userLocation;
			
			query = new Query();
			query.performRequest(serverPath + "user_set.php?client=1&userID=" + userID + "&userName=" + userName + "&userLocation=" + userLocation);
		}
		
		/* TUTORIAL */
		public static void Tutorial(String stepName, int travelTimeMinutes)
		{
			query = new Query();
			query.performRequest(serverPath + "tutorial_set.php?client=1&userID=" + userID + "&stepName=" + stepName + "&travelTimeMinutes=" + travelTimeMinutes);
		}
		
		/* LEVEL */
		public static void Level(String stepName, int number, int travelTimeMinutes)
		{
			query = new Query();
			query.performRequest(serverPath + "level_set.php?client=1&userID=" + userID + "&stepName=" + stepName + "&number=" + number + "&travelTimeMinutes=" + travelTimeMinutes);
		}
		
		/* BOOSTER */
		public static void Booster(String boosterName, int levelNumber)
		{
			query = new Query();
			query.performRequest(serverPath + "booster_set.php?client=1&userID=" + userID + "&boosterName=" + boosterName + "&levelNumber=" + levelNumber);
		}
		
		/* BUY */
		public static void Buy(String name, String number, String price, String view, String location)
		{
			query = new Query();
			query.performRequest(serverPath + "buy_set.php?client=1&userID=" + userID + "&name=" + name + "&number=" + number + "&price=" + price + "&view=" + view + "&location=" + location);
		}
		
		/* AB TESTING */
		public static void TestingAB(String session, String record)
		{
			query = new Query();
			query.performRequest(serverPath + "testing_ab_set.php?client=1&userID=" + userID + "&session=" + session + "&record=" + record);
		}
		
		/* RETENTION */
		public static void Retention(String action)
		{
			query = new Query();
			query.performRequest(serverPath + "retention_set.php?client=1&userID=" + userID + "&action=" + action);
		}
		
		/* ERROR */
		public static void Error(String type, String location)
		{
			query = new Query();
			query.performRequest(serverPath + "error_set.php?client=1&userID=" + userID + "&type=" + type + "&location=" + location);
		}
	}
}
