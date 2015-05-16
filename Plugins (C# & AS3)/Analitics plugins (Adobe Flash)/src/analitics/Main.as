package analitics
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextFormat;
	
	import fl.controls.Button;
	import fl.controls.TextInput;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	import fl.data.DataProvider; 
	import fl.events.ComponentEvent;
	
	import analitics.Analitics;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class Main extends Sprite 
	{
		[Embed(source = '../../images/background.jpg')]
		private var ImageBG:Class;
		private var _background:Bitmap = new ImageBG();
		
		
		private var _label0:Label = new Label();
		
		private var _button1:Button = new Button();
		private var _label1:Label = new Label();
		private var _textBox1_1:TextInput = new TextInput();
		private var _textBox1_2:TextInput = new TextInput();
		private var _textBox1_3:TextInput = new TextInput();
		
		private var _button2:Button = new Button();
		private var _label2:Label = new Label();
		private var _textBox2_1:TextInput = new TextInput();
		private var _textBox2_2:TextInput = new TextInput();
		
		private var _button3:Button = new Button();
		private var _label3:Label = new Label();
		private var _textBox3_1:TextInput = new TextInput();
		private var _textBox3_2:TextInput = new TextInput();
		private var _textBox3_3:TextInput = new TextInput();
		
		private var _button4:Button = new Button();
		private var _label4:Label = new Label();
		private var _textBox4_1:TextInput = new TextInput();
		private var _textBox4_2:TextInput = new TextInput();
		
		private var _button5:Button = new Button();
		private var _label5:Label = new Label();
		private var _textBox5_1:TextInput = new TextInput();
		private var _textBox5_2:TextInput = new TextInput();
		private var _textBox5_3:TextInput = new TextInput();
		private var _textBox5_4:TextInput = new TextInput();
		private var _textBox5_5:TextInput = new TextInput();
		
		private var _button6:Button = new Button();
		private var _label6:Label = new Label();
		private var _textBox6_1:TextInput = new TextInput();
		private var _textBox6_2:TextInput = new TextInput();
		
		private static var retentionType:Array = new Array( 
			{label:Analitics.ACTION_BEGIN, data:Analitics.ACTION_BEGIN},
			{label:Analitics.ACTION_EXIT, data:Analitics.ACTION_EXIT}, 
			{label:Analitics.ACTION_RETURN, data:Analitics.ACTION_RETURN}
		); 
		private var _button7:Button = new Button();
		private var _label7:Label = new Label();
		private var _comboBox7:ComboBox = new ComboBox();
		
		private static var errorType:Array = new Array( 
			{label:Analitics.ERROR_LOW, data:Analitics.ERROR_LOW},
			{label:Analitics.ERROR_NORMAL, data:Analitics.ERROR_NORMAL }, 
			{label:Analitics.ERROR_HIGHT, data:Analitics.ERROR_HIGHT }, 
			{label:Analitics.ERROR_URGENT, data:Analitics.ERROR_URGENT}, 
			{label:Analitics.ERROR_IMMEDIATE, data:Analitics.ERROR_IMMEDIATE}
		);
		private var _button8:Button = new Button();
		private var _label8:Label = new Label();
		private var _comboBox8:ComboBox = new ComboBox();
		private var _textBox8:TextInput = new TextInput();
		
		private var _button9:Button = new Button();
		private var _label9:Label = new Label();
		private var _textBox9:TextInput = new TextInput();
		
		
		private var _labelResult:Label = new Label();
		private var _labelAutor:Label = new Label();
		
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_background.x = 250;
			_background.y = 300;
			addChild(_background);
			
			Analitics.userID = "123456789";
			Analitics.userName = "admin";
			Analitics.userLocation = "no";
			
			//Analitics.User("123456789", "admin", "no");
			//Analitics.Tutorial("TutorStep1", 2);
			//Analitics.Level("Level1", 1, 5);
			//Analitics.Booster("Booster-1", 10);
			//Analitics.Buy("Booster-1", 1.5, 2.5, "Спайс", "Level1");
			//Analitics.TestingAB("A", "Цена1");
			//Analitics.Retention(Analitics.ACTION_RETURN);
			//Analitics.Error("low bug", "tutor-step-5");
			
			menu();
		}
		
		private function menu():void
		{
			var myFont:Font = new Font();
 			var myTextFormat:TextFormat = new TextFormat();
			myTextFormat.font = myFont.fontName;
			myTextFormat.size = 21;

			_label0.text = "Information system game analitics \nДля игр разработанных на платформе Adobe Flash";
			_label0.x = 5; _label0.y = 10; _label0.width = 800; _label0.height = 200; 
			//_label0.setStyle("embedFonts", true);
			_label0.setStyle("textFormat", myTextFormat);
			addChild(_label0);
			
			/*-------------------------------------------*/
			_textBox1_1.text = Analitics.userID; _textBox1_1.x = 10; _textBox1_1.y = 80; _textBox1_1.width = 150;
			addChild(_textBox1_1);
			_textBox1_2.text = Analitics.userName; _textBox1_2.x = 170; _textBox1_2.y = 80; _textBox1_2.width = 150;
			addChild(_textBox1_2);
			_textBox1_3.text = Analitics.userLocation; _textBox1_3.x = 330; _textBox1_3.y = 80; _textBox1_3.width = 150;
			addChild(_textBox1_3);
			
			_button1.label = "Users";
			_button1.x = 490; _button1.y = 80; _button1.width = 100;
			_button1.addEventListener(MouseEvent.CLICK, onButton1MouseClick);
			addChild(_button1);
			
			_label1.text = "Идентификатор пользователя; Имя пользователя;                  Местоположение пользователя."; 
			_label1.x = 10; _label1.y = 100; _label1.width = 500; _label1.height = 50;
			addChild(_label1);
			
			/*-------------------------------------------*/
			_textBox2_1.text = "STEP NAME"; _textBox2_1.x = 10; _textBox2_1.y = 125; _textBox2_1.width = 150;
			addChild(_textBox2_1);
			_textBox2_2.text = "0"; _textBox2_2.x = 170; _textBox2_2.y = 125; _textBox2_2.width = 150;
			addChild(_textBox2_2);
			
			_button2.label = "Tutorial";
			_button2.x = 490; _button2.y = 125; _button2.width = 100;
			_button2.addEventListener(MouseEvent.CLICK, onButton2MouseClick);
			addChild(_button2);
			
			_label2.text = "Имя этапа туториала;              Затраченное время в минутах."; 
			_label2.x = 10; _label2.y = 145; _label2.width = 500; _label2.height = 50;
			addChild(_label2);
			
			
			/*-------------------------------------------*/
			_textBox3_1.text = "LEVEL NAME"; _textBox3_1.x = 10; _textBox3_1.y = 170; _textBox3_1.width = 150;
			addChild(_textBox3_1);
			_textBox3_2.text = "0"; _textBox3_2.x = 170; _textBox3_2.y = 170; _textBox3_2.width = 150;
			addChild(_textBox3_2);
			_textBox3_3.text = "0"; _textBox3_3.x = 330; _textBox3_3.y = 170; _textBox3_3.width = 150;
			addChild(_textBox3_3);
			
			_button3.label = "Level";
			_button3.x = 490; _button3.y = 170;	_button3.width = 100;
			_button3.addEventListener(MouseEvent.CLICK, onButton3MouseClick);
			addChild(_button3);
			
			_label3.text = "Имя уровня;                                Номер уровня;                           Затраченное время в минутах."; 
			_label3.x = 10; _label3.y = 190; _label3.width = 500; _label3.height = 50;
			addChild(_label3);
			
			
			/*-------------------------------------------*/
			_textBox4_1.text = "BOOSTER NAME"; _textBox4_1.x = 10; _textBox4_1.y = 215; _textBox4_1.width = 150;
			addChild(_textBox4_1);
			_textBox4_2.text = "0"; _textBox4_2.x = 170; _textBox4_2.y = 215; _textBox4_2.width = 150;
			addChild(_textBox4_2);
			
			_button4.label = "Booster";
			_button4.x = 490; _button4.y = 215; _button4.width = 100;
			_button4.addEventListener(MouseEvent.CLICK, onButton4MouseClick);
			addChild(_button4);
			
			_label4.text = "Наименование бустера;              Номер уровня."; 
			_label4.x = 10; _label4.y = 235; _label4.width = 500; _label4.height = 50;
			addChild(_label4);
			
			/*-------------------------------------------*/
			_textBox5_1.text = "NAME"; _textBox5_1.x = 10; _textBox5_1.y = 260; _textBox5_1.width = 100;
			addChild(_textBox5_1);
			_textBox5_2.text = "0"; _textBox5_2.x = 120; _textBox5_2.y = 260; _textBox5_2.width = 50;
			addChild(_textBox5_2);
			_textBox5_3.text = "0"; _textBox5_3.x = 180; _textBox5_3.y = 260; _textBox5_3.width = 50;
			addChild(_textBox5_3);
			_textBox5_4.text = "VIEW"; _textBox5_4.x = 240; _textBox5_4.y = 260; _textBox5_4.width = 115;
			addChild(_textBox5_4);
			_textBox5_5.text = "LOCATION"; _textBox5_5.x = 365; _textBox5_5.y = 260; _textBox5_5.width = 115;
			addChild(_textBox5_5);
			
			_button5.label = "Buy";
			_button5.x = 490; _button5.y = 260; _button5.width = 100;
			_button5.addEventListener(MouseEvent.CLICK, onButton5MouseClick);
			addChild(_button5);
			
			_label5.text = "Наименование;          Кол-во;        Цена;          Вид;                                   Место."; 
			_label5.x = 10; _label5.y = 280; _label5.width = 500; _label5.height = 50;
			addChild(_label5);
			
			
			/*-------------------------------------------*/
			_textBox6_1.text = "SESSION"; _textBox6_1.x = 10; _textBox6_1.y = 305; _textBox6_1.width = 150;
			addChild(_textBox6_1);
			_textBox6_2.text = "RECORD"; _textBox6_2.x = 170; _textBox6_2.y = 305; _textBox6_2.width = 150;
			addChild(_textBox6_2);
			
			_button6.label = "AB testing";
			_button6.x = 490; _button6.y = 305; _button6.width = 100;
			_button6.addEventListener(MouseEvent.CLICK, onButton6MouseClick);
			addChild(_button6);
			
			_label6.text = "Сессия А/В;                                 Запись."; 
			_label6.x = 10; _label6.y = 325; _label6.width = 500; _label6.height = 50;
			addChild(_label6);
			
			/*-------------------------------------------*/
			_comboBox8.x = 10; _comboBox8.y = 350;	_comboBox8.dropdownWidth = 200; _comboBox8.width = 150;  
			_comboBox8.selectedIndex = 0;
			_comboBox8.dataProvider = new DataProvider(errorType); 
			_comboBox8.addEventListener(Event.CHANGE, changeHandlerComboBox8); 
			this.addChild(_comboBox8);
			
			_textBox8.text = "LOCATION"; _textBox8.x = 170; _textBox8.y = 350; _textBox8.width = 150;
			addChild(_textBox8);
			
			_button8.label = "Error";
			_button8.x = 490; _button8.y = 350; _button8.width = 100;
			_button8.addEventListener(MouseEvent.CLICK, onButton8MouseClick);
			addChild(_button8);
			
			_label8.text = "Тип ошибки;                                 Место где произошла."; 
			_label8.x = 10; _label8.y = 370; _label8.width = 500; _label8.height = 50;
			addChild(_label8);
			
			
			/*-------------------------------------------*/
			_comboBox7.x = 10; _comboBox7.y = 395;	_comboBox7.dropdownWidth = 200; _comboBox7.width = 150;  
			_comboBox7.selectedIndex = 0;
			_comboBox7.dataProvider = new DataProvider(retentionType); 
			_comboBox7.addEventListener(Event.CHANGE, changeHandlerComboBox7); 
			this.addChild(_comboBox7);
			
			_button7.label = "Retention";
			_button7.x = 170; _button7.y = 395; _button7.width = 100;
			_button7.addEventListener(MouseEvent.CLICK, onButton7MouseClick);
			addChild(_button7);
			
			_label7.text = "Действие в игре"; 
			_label7.x = 10; _label7.y = 415; _label7.width = 500; _label7.height = 50;
			addChild(_label7);
			
			/*-------------------------------------------*/
			
			_textBox9.text = Analitics.serverPath; _textBox9.x = 10; _textBox9.y = 460; _textBox9.width = 150;
			addChild(_textBox9);
			
			_button9.label = "Server path";
			_button9.x = 170; _button9.y = 460; _button9.width = 100;
			_button9.addEventListener(MouseEvent.CLICK, onButton9MouseClick);
			addChild(_button9);
			
			/*-------------------------------------------*/
			_labelResult.text = "..."; 
			_labelResult.x = 600;
			_labelResult.y = 20;
			_labelResult.width = 300;
			_labelResult.height = 50;
			addChild(_labelResult);
			
			_labelAutor.text = "2015 © Somov Evgeniy"; 
			_labelAutor.x = 5;
			_labelAutor.y = 570;
			_labelAutor.width = 500;
			_labelAutor.height = 50;
			addChild(_labelAutor);
		}
		
		private function onButton1MouseClick(e:MouseEvent):void 
		{
			Analitics.User(_textBox1_1.text, _textBox1_2.text, _textBox1_3.text);
			_labelResult.text = "User - complite!";
		}
		
		private function onButton2MouseClick(e:MouseEvent):void 
		{
			removeEventListener(MouseEvent.CLICK, onButton2MouseClick);
			Analitics.Tutorial(_textBox2_1.text, int(_textBox2_2.text));
			_labelResult.text = "Tutorial - complite!";
		}
		
		private function onButton3MouseClick(e:MouseEvent):void 
		{
			Analitics.Level(_textBox3_1.text, int(_textBox3_2.text), int(_textBox3_3.text));
			_labelResult.text = "Level - complite!";
		}
		
		private function onButton4MouseClick(e:MouseEvent):void 
		{
			Analitics.Booster(_textBox4_1.text, int(_textBox4_2.text));
			_labelResult.text = "Booster - complite!";
		}
		
		private function onButton5MouseClick(e:MouseEvent):void 
		{
			Analitics.Buy(_textBox5_1.text, Number(_textBox5_2.text), Number(_textBox5_3.text), _textBox5_4.text, _textBox5_5.text);
			_labelResult.text = "Buy - complite!";
		}
		
		private function onButton6MouseClick(e:MouseEvent):void 
		{
			Analitics.TestingAB(_textBox6_1.text, _textBox6_2.text);
			_labelResult.text = "AB testing - complite!";
		}
		
		private function changeHandlerComboBox7(e:Event):void 
		{
			_comboBox7.text = ComboBox(e.target).selectedItem.label;
		}
		
		private function onButton7MouseClick(e:MouseEvent):void 
		{
			Analitics.Retention(_comboBox7.text);
			_labelResult.text = "Retention - complite!";
		}
		
		private function changeHandlerComboBox8(e:Event):void 
		{
			_comboBox8.text = ComboBox(e.target).selectedItem.label;
		}
		
		private function onButton8MouseClick(e:MouseEvent):void 
		{
			Analitics.Error(_comboBox8.text, _textBox8.text);
			_labelResult.text = "Error - complite!";
		}
		
		private function onButton9MouseClick(e:MouseEvent):void 
		{
			Analitics.serverPath = _textBox9.text;
			_labelResult.text = "Server path - complite!";
		}
		
	}
	
}