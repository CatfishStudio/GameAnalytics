package analitics 
{
	import analitics.Query;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Analitics 
	{
		/* ПУТЬ К СЕРВЕРУ */
		public static var serverPath:String = "http://localhost/ga/"; //"http://localhost/analitics/";
		
		/* ОСНОВНАЯ ИНФОРМАЦИЯ ПОЛЬЗОВАТЕЛЯ */
		public static var userID:String;
		public static var userName:String;
		public static var userLocation:String;
		
		/* КОНСТАНТЫ */
		public static const ACTION_BEGIN:String = "begin";
		public static const ACTION_EXIT:String = "exit";
		public static const ACTION_RETURN:String = "return";
		
		public static const ERROR_LOW:String = "low";
		public static const ERROR_NORMAL:String = "normal";
		public static const ERROR_HIGHT:String = "hight";
		public static const ERROR_URGENT:String = "urgent";
		public static const ERROR_IMMEDIATE:String = "immediate";
		
		private static var query:Query = new Query();
		
		/* ИДЕНТИФИКАЦИЯ ПОЛЬЗОВАТЕЛЯ */
		public static function User(userID:String, userName:String, userLocation:String):void
		{
			userID = userID;
			userName = userName;
			userLocation = userLocation;
			
			query = new Query();
			query.performRequest(serverPath + "user_set.php?client=1&userID=" + userID.toString() + "&userName=" + userName.toString() + "&userLocation=" + userLocation.toString());
			query.addEventListener("complete", onQueryComplete);
		}
		
		/* TUTORIAL */
		public static function Tutorial(stepName:String, travelTimeMinutes:int):void
		{
			query = new Query();
			query.performRequest(serverPath + "tutorial_set.php?client=1&userID=" + userID.toString() + "&stepName=" + stepName.toString() + "&travelTimeMinutes=" + travelTimeMinutes.toString());
			query.addEventListener("complete", onQueryComplete);
		}
		
		/* LEVEL */
		public static function Level(stepName:String, number:int, travelTimeMinutes:int):void
		{
			query = new Query();
			query.performRequest(serverPath + "level_set.php?client=1&userID=" + userID.toString() + "&stepName=" + stepName.toString() + "&number=" + number.toString() + "&travelTimeMinutes=" + travelTimeMinutes.toString());
			query.addEventListener("complete", onQueryComplete);
		}
		
		/* BOOSTER */
		public static function Booster(boosterName:String, levelNumber:int):void
		{
			query = new Query();
			query.performRequest(serverPath + "booster_set.php?client=1&userID=" + userID.toString() + "&boosterName=" + boosterName.toString() + "&levelNumber=" + levelNumber.toString());
			query.addEventListener("complete", onQueryComplete);
		}
		
		/* BUY */
		public static function Buy(name:String, number:Number, price:Number, view:String, location:String):void
		{
			query = new Query();
			query.performRequest(serverPath + "buy_set.php?client=1&userID=" + userID.toString() + "&name=" + name.toString() + "&number=" + number.toString() + "&price=" + price.toString() + "&view=" + view.toString() + "&location=" + location.toString());
			query.addEventListener("complete", onQueryComplete);
		}
		
		/* AB TESTING */
		public static function TestingAB(session:String, record:String):void
		{
			query = new Query();
			query.performRequest(serverPath + "testing_ab_set.php?client=1&userID=" + userID.toString() + "&session=" + session.toString() + "&record=" + record.toString());
			query.addEventListener("complete", onQueryComplete);
		}
		
		/* RETENTION */
		public static function Retention(action:String):void
		{
			query = new Query();
			query.performRequest(serverPath + "retention_set.php?client=1&userID=" + userID.toString() + "&action=" + action.toString());
			query.addEventListener("complete", onQueryComplete);
		}
		
		/* ERROR */
		public static function Error(type:String, location:String):void
		{
			query = new Query();
			query.performRequest(serverPath + "error_set.php?client=1&userID=" + userID.toString() + "&type=" + type.toString() + "&location=" + location.toString());
			query.addEventListener("complete", onQueryComplete);
		}
		
		
		
		private static function onQueryComplete(event:Object):void 
		{
			query.removeEventListener("complete", onQueryComplete);
			trace((query.getResult as String));
			//query = null;
		}
		
	}

}