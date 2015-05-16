package gameAnalitics.resource 
{
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class Resource 
	{
		[Embed(source = '../../../images/background1.png')]
		public static var ImageBackground1:Class;
		[Embed(source = '../../../images/background2.png')]
		public static var ImageBackground2:Class;
		
		public static const TUTORIAL:String = "Tutorial";
		public static const LEVELS:String = "Levels";
		public static const BOOSTERS:String = "Boosters";
		public static const BUYS:String = "Buys";
		public static const AB_TESTING:String = "AB Testing";
		public static const RETENTION:String = "Retention";
		public static const ERRORS:String = "Errors";
		
		public static var serverPath:String = "http://localhost/ga/";
	}

}