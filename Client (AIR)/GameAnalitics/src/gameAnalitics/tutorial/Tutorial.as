package gameAnalitics.tutorial 
{
	import flash.display.NativeWindow; 
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fl.controls.Button;
	import fl.controls.TextInput;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	import fl.data.DataProvider;
	
	import gameAnalitics.tutorial.TutorialDiagramUserID;
	import gameAnalitics.tutorial.TutorialDiagramDate;
		
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	public class Tutorial extends NativeWindowInitOptions 
	{
		private var _newWindow:NativeWindow;
		
		private var _diagramUserID:TutorialDiagramUserID;
		private var _diagramDate:TutorialDiagramDate;
		
		private var _label1:Label = new Label();
		private var _label2:Label = new Label();
		private var _textBox2:TextInput = new TextInput();
		private var _button2:Button = new Button();
		
		private var month:Array = new Array( 
			{label:"Январь", data:"01" },
			{label:"Февраль", data:"02" },
			{label:"Март", data:"03" },
			{label:"Апрель", data:"04" },
			{label:"Май", data:"05" },
			{label:"Июнь", data:"06" },
			{label:"Июль", data:"07" },
			{label:"Август", data:"08" },
			{label:"Сентябрь", data:"09" },
			{label:"Октябрь", data:"10" },
			{label:"Ноябрь", data:"11"},
			{label:"Декабрь", data:"12"} 
		);
		private var _label3:Label = new Label();
		private var _comboBox3:ComboBox = new ComboBox();
		private var _textBox3:TextInput = new TextInput();
		private var _button3:Button = new Button();
		
		public function Tutorial() 
		{
			super();
			
			transparent = false; 
			systemChrome = NativeWindowSystemChrome.STANDARD; 
			type = NativeWindowType.NORMAL; 
     
			_newWindow = new NativeWindow(this); 
			_newWindow.title = "Tutorial"; 
			_newWindow.width = 650; 
			_newWindow.height = 650; 
			_newWindow.stage.color = 0xFFFFFF;
			_newWindow.alwaysInFront = true; // всегда поверх других окон
			
			_newWindow.stage.align = StageAlign.TOP_LEFT; 
			_newWindow.stage.scaleMode = StageScaleMode.NO_SCALE; 
			_newWindow.activate();
			
			showForm();
		}
		
		
		private function showForm():void
		{
			_label1.text = "Выберите фильтры по которым следует вывести данные:"; 
			_label1.x = 5; _label1.y = 5; _label1.width = 500; _label1.height = 100;
			_newWindow.stage.addChild(_label1);
			//----------------------------------
			_label2.text = "ID пользователя:"; 
			_label2.x = 5; _label2.y = 30; _label2.width = 500; _label2.height = 100;
			_newWindow.stage.addChild(_label2);
			
			_textBox2.text = "";
			_textBox2.x = 100; 	_textBox2.y = 25; _textBox2.width = 100;
			_newWindow.stage.addChild(_textBox2);
			
			_button2.label = "Показать";
			_button2.name = "USER_ID";
			_button2.x = 210; _button2.y = 25;
			_button2.width = 100;
			_button2.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			_newWindow.stage.addChild(_button2);
			//-----------------------------------
			_label3.text = "Дата:"; 
			_label3.x = 5; _label3.y = 65; _label3.width = 500; _label3.height = 100;
			_newWindow.stage.addChild(_label3);
			
			_comboBox3.x = 40; 
			_comboBox3.y = 60;
			_comboBox3.dropdownWidth = 200; 
			_comboBox3.width = 100;  
			_comboBox3.selectedIndex = 0;
			_comboBox3.dataProvider = new DataProvider(month); 
			_newWindow.stage.addChild(_comboBox3);
						
			_textBox3.text = "2015";
			_textBox3.x = 150; 	_textBox3.y = 60; _textBox3.width = 50;
			_newWindow.stage.addChild(_textBox3);
			
			_button3.label = "Показать";
			_button3.name = "DATE";
			_button3.x = 210; _button3.y = 60;
			_button3.width = 100;
			_button3.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			_newWindow.stage.addChild(_button3);
		}
		
		private function onButtonMouseClick(e:MouseEvent):void 
		{
			if (_newWindow.stage.getChildByName("TutorialDiagramUserID") != null) _newWindow.stage.removeChild(_diagramUserID);
			if (_newWindow.stage.getChildByName("TutorialDiagramDate") != null) _newWindow.stage.removeChild(_diagramDate);
			
			if (e.currentTarget.name == "USER_ID")
			{
				_diagramUserID = new TutorialDiagramUserID(_textBox2.text);
				_diagramUserID.name = "TutorialDiagramUserID";
				_diagramUserID.x = 5;
				_diagramUserID.y = 100;
				_newWindow.stage.addChild(_diagramUserID);
			}
			if (e.currentTarget.name == "DATE")
			{
				_diagramDate = new TutorialDiagramDate(_comboBox3.selectedItem.data, _textBox3.text);
				_diagramDate.name = "TutorialDiagramDate";
				_diagramDate.x = 5;
				_diagramDate.y = 100;
				_newWindow.stage.addChild(_diagramDate);
			}
		}
		
	}

}