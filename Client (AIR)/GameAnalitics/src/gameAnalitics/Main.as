package gameAnalitics
{
	import air.update.logging.Level;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	import fl.controls.Button;
	import fl.controls.TextInput;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	import fl.data.DataProvider; 
	import fl.events.ComponentEvent;
	
	import gameAnalitics.resource.Resource;
	import gameAnalitics.tutorial.Tutorial;
	import gameAnalitics.levels.Levels;
	import gameAnalitics.boosters.Boosters;
	import gameAnalitics.buys.Buys;
	import gameAnalitics.testingAB.TestingAB;
	import gameAnalitics.retention.Retention;
	import gameAnalitics.errors.Errors;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Main extends Sprite 
	{
		private var _button1:Button = new Button();
		private var _label1:Label = new Label();
		
		private var _button2:Button = new Button();
		private var _label2:Label = new Label();
		
		private var _button3:Button = new Button();
		private var _label3:Label = new Label();
		
		private var _button4:Button = new Button();
		private var _label4:Label = new Label();
		
		private var _button5:Button = new Button();
		private var _label5:Label = new Label();
		
		private var _button6:Button = new Button();
		private var _label6:Label = new Label();
		
		private var _button7:Button = new Button();
		private var _label7:Label = new Label();
		
		private var _textBox8:TextInput = new TextInput();
		private var _label8:Label = new Label();
		
		private var _labelAutor:Label = new Label();
		
		public function Main() 
		{
			showBackground();
			showForm();
		}
		
		private function showBackground():void
		{
			var bitmapBG:Bitmap = new Resource.ImageBackground1();
			bitmapBG.smoothing = true;
			addChild(bitmapBG);
			bitmapBG = new Resource.ImageBackground2();
			bitmapBG.smoothing = true;
			bitmapBG.x = 400;
			bitmapBG.y = 350;
			addChild(bitmapBG);
			bitmapBG = null;
		}
		
		private function showForm():void
		{
			_button1.label = "Tutorial";
			_button1.name = Resource.TUTORIAL;
			_button1.x = 20; _button1.y = 115;
			_button1.width = 200;
			_button1.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			addChild(_button1);
			
			_label1.text = "Tutorial - информация о прохождении пользователем обучения в игре.\nПоказывает общую сложность и время прохождения, количество попыток."; 
			_label1.x = 250;
			_label1.y = 110;
			_label1.width = 500;
			_label1.height = 100;
			addChild(_label1);
			
			_button2.label = "Levels";
			_button2.name = Resource.LEVELS;
			_button2.x = 20; _button2.y = 155;
			_button2.width = 200;
			_button2.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			addChild(_button2);
			
			_label2.text = "Levels - информация о прохождении пользователем уровней в игре.\nПоказывает общую сложность и время прохождения, количество попыток."; 
			_label2.x = 250;
			_label2.y = 150;
			_label2.width = 550;
			_label2.height = 100;
			addChild(_label2);
			
			_button3.label = "Boosters";
			_button3.name = Resource.BOOSTERS;
			_button3.x = 20; _button3.y = 195;
			_button3.width = 200;
			_button3.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			addChild(_button3);
			
			_label3.text = "Boosters - раздел активного использования бустеров. \nПоказывается место и предпочтение использования бустера."; 
			_label3.x = 250;
			_label3.y = 190;
			_label3.width = 500;
			_label3.height = 100;
			addChild(_label3);
			
			_button4.label = "Buys";
			_button4.name = Resource.BUYS;
			_button4.x = 20; _button4.y = 235;
			_button4.width = 200;
			_button4.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			addChild(_button4);
			
			_label4.text = "Buys - раздел совершенных покупок пользователем в игре. \nПоказывается тип товара, товар, количество, цена и место покупки."; 
			_label4.x = 250;
			_label4.y = 230;
			_label4.width = 500;
			_label4.height = 100;
			addChild(_label4);
			
			_button5.label = "AB Testing";
			_button5.name = Resource.AB_TESTING;
			_button5.x = 20; _button5.y = 275;
			_button5.width = 200;
			_button5.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			addChild(_button5);
			
			_label5.text = "AB Testing - раздел АВ тестирования. \nПоказывается сессия и соответствующая ей информация."; 
			_label5.x = 250;
			_label5.y = 270;
			_label5.width = 500;
			_label5.height = 100;
			addChild(_label5);
			
			_button6.label = "Retention";
			_button6.name = Resource.RETENTION;
			_button6.x = 20; _button6.y = 315;
			_button6.width = 200;
			_button6.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			addChild(_button6);
			
			_label6.text = "Retention - раздел регистрации активности пользователя. \nПоказывается общая информация входа, выхода и возврата в игру."; 
			_label6.x = 250;
			_label6.y = 310;
			_label6.width = 500;
			_label6.height = 100;
			addChild(_label6);
			
			_button7.label = "Errors";
			_button7.name = Resource.ERRORS;
			_button7.x = 20; _button7.y = 355;
			_button7.width = 200;
			_button7.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			addChild(_button7);
			
			_label7.text = "Errors - журнал зарегистрированных ошибок в игре. \nПоказывается информация о выявленных ошибках в игре."; 
			_label7.x = 250;
			_label7.y = 350;
			_label7.width = 500;
			_label7.height = 100;
			addChild(_label7);
			
			_textBox8.text = Resource.serverPath;
			_textBox8.x = 20; 	_textBox8.y = 400; _textBox8.width = 200;
			addChild(_textBox8);
			
			_label8.text = "Укажите путь к серверу на котором находится \nсистема обработки данных."; 
			_label8.x = 250;
			_label8.y = 395;
			_label8.width = 500;
			_label8.height = 100;
			addChild(_label8);
			
			_labelAutor.text = "2015 © Somov Evgeniy"; 
			_labelAutor.x = 5;
			_labelAutor.y = 570;
			_labelAutor.width = 500;
			_labelAutor.height = 50;
			addChild(_labelAutor);
		}
		
		
		private function onButtonMouseClick(e:MouseEvent):void 
		{
			Resource.serverPath = _textBox8.text;
			if (e.currentTarget.name == Resource.TUTORIAL) new Tutorial();
			if (e.currentTarget.name == Resource.LEVELS) new Levels();
			if (e.currentTarget.name == Resource.BOOSTERS) new Boosters();
			if (e.currentTarget.name == Resource.BUYS) new Buys();
			if (e.currentTarget.name == Resource.AB_TESTING) new TestingAB();
			if (e.currentTarget.name == Resource.RETENTION) new Retention();
			if (e.currentTarget.name == Resource.ERRORS) new Errors();
		}
	}
	
}