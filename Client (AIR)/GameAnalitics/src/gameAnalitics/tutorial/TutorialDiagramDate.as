package gameAnalitics.tutorial 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	
	import fl.controls.Label;
	import fl.controls.DataGrid;
	import fl.data.DataProvider;
	import fl.controls.ScrollPolicy;
	
	import gameAnalitics.json.JSON;
	import gameAnalitics.plugin.Query;
	import gameAnalitics.resource.Resource;
	
	/**
	 * ...
	 * @author Somov Evgeniy
	 */
	
	public class TutorialDiagramDate extends Sprite 
	{
		private var _diagram:Shape;
		private var _query:Query;
		
		private var _month:String;
		private var _year:String;
		private var _tutorial:Array = [];
		private var _tutorialFull:Array = [];
		
		private var _label:Label;
		private var _label1:Label = new Label();
		private var _label2:Label = new Label();
		
		public function TutorialDiagramDate(month:String, year:String) 
		{
			super();
			
			_month = month;
			_year = year;
			_diagram = new Shape();
			_diagram.graphics.lineStyle(2, 0x804040, 1);
			_diagram.graphics.beginFill(0xFFFFFF, 1);
			_diagram.graphics.drawRect(0, 0, 600, 300);
			_diagram.graphics.endFill();
			_diagram.alpha = 0.4;
			
			_diagram.graphics.lineStyle(1, 0x000000, 1);
			_diagram.graphics.beginFill(0xFF0000); 
			_diagram.graphics.moveTo(50, 280)
			_diagram.graphics.lineTo(50, 15);

			_diagram.graphics.lineStyle(1, 0x000000, 1);
			_diagram.graphics.beginFill(0xFF0000); 
			_diagram.graphics.moveTo(25, 250)
			_diagram.graphics.lineTo(550, 250);
			
			addChild(_diagram);
			
			//-----------------------------------
			_label1.text = "Время / Кол-во раз"; 
			_label1.x = 10;
			_label1.y = 0;
			_label1.width = 200;
			_label1.height = 100;
			addChild(_label1);
			
			_label2.text = "Этапы\nтутора"; 
			_label2.x = 550;
			_label2.y = 235;
			_label2.width = 200;
			_label2.height = 100;
			addChild(_label2);
			
			
			
			getDataFromTable();
		}
		
		/* Получить данные с сервера ====================================== */
		private function getDataFromTable():void
		{
			var sqlCommand:String = "SELECT * FROM tutorial WHERE tutorial_datetime BETWEEN '" + _year + "-" + _month + "-" + "01' AND '" + _year + "-" + _month + "-" + "30' ORDER BY tutorial_userid";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "tutorial_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildTable);
		}
		/* ================================================================ */
		
		
		/* ТАБЛИЦА ======================================================== */
		private function buildTable(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			var userCount:int = 0;
			var lastUser:String;
			
			_tutorialFull = [];
						
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].tutorial) 
				{
					_tutorialFull.push( {
						user:json_data[i].tutorial[k].tutorial_userid,
						step:json_data[i].tutorial[k].tutorial_step_name,
						time:json_data[i].tutorial[k].tutorial_travel_time_minutes,
						data:json_data[i].tutorial[k].tutorial_datetime,
						count:1
					});
					
					if (lastUser == "")
					{
						lastUser = json_data[i].tutorial[k].tutorial_userid;
						userCount++;
					}
					else {
						if (lastUser != json_data[i].tutorial[k].tutorial_userid)
						{
							lastUser = json_data[i].tutorial[k].tutorial_userid;
							userCount++;
						}
					}
					
				}
			}
			
			_label = new Label(); // дата завершения тутора
			_label.text = "Дата отчета: " + _month.toString() + "." + _year.toString() + "\nКоличество пользователей: " + userCount.toString(); 
			_label.x = 350;
			_label.y = 5;
			_label.width = 250;
			_label.height = 50;
			addChild(_label);
			
			
			
			var _dataGrid:DataGrid = new DataGrid();
			_dataGrid.columns = ["user", "step", "time", "data"];
			_dataGrid.dataProvider = new DataProvider(_tutorialFull); 
			
			_dataGrid.setSize(600, 150);
			_dataGrid.move(0, 325);
			_dataGrid.rowHeight = 20;
			
			_dataGrid.columns[0].headerText = "Пользователь";
			_dataGrid.columns[0].width = 100;
			_dataGrid.columns[1].headerText = "Этап";
			_dataGrid.columns[1].width = 150;
			_dataGrid.columns[2].headerText = "Время";
			_dataGrid.columns[2].width = 100;
			_dataGrid.columns[3].headerText = "Дата";
			_dataGrid.columns[3].width = 150;
			
			
			_dataGrid.resizableColumns = true; 
			_dataGrid.selectable = false;
			_dataGrid.editable = false;
			
			
			_dataGrid.verticalScrollPolicy = ScrollPolicy.AUTO; // полоса прокрутки
			_dataGrid.horizontalScrollPolicy = ScrollPolicy.AUTO; // полоса прокрутки
			
			addChild(_dataGrid);
			
			getData();
		}
		/* ================================================================ */
		
		
		/* Получить данные с сервера ====================================== */
		private function getData():void
		{
			var sqlCommand:String = "SELECT tutorial_userid, tutorial_datetime, tutorial_step_name, SUM(tutorial_travel_time_minutes) AS tutorial_travel_time_minutes FROM tutorial WHERE tutorial_datetime BETWEEN '" + _year + "-" + _month + "-" + "01' AND '" + _year + "-" + _month + "-" + "30' GROUP BY tutorial_step_name  ORDER BY tutorial_step_name";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "tutorial_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildDiagram);
		}
		/* ================================================================ */
		
		/* ДИАГРОММА ====================================================== */
		private function buildDiagram(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			var length:int = 0;
			
			_tutorial = [];
			
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].tutorial) 
				{
					if (length <= int(json_data[i].tutorial[k].tutorial_travel_time_minutes)) length = int(json_data[i].tutorial[k].tutorial_travel_time_minutes);
					_tutorial.push( {
						step:json_data[i].tutorial[k].tutorial_step_name,
						time:json_data[i].tutorial[k].tutorial_travel_time_minutes,
						count:countTry(json_data[i].tutorial[k].tutorial_step_name)
					});
				}
			}
			
			
			//- ОСЬ Y ----------------------------------
			for (var j:int = 0; j < 5; j++)
			{
				var value:int = length < 4 ? 1 * j : Math.ceil(length / 4) * j;
				_label = new Label();
				_label.text = value.toString(); 
				_label.x = 35;
				if (j == 0) _label.y = 250 - (50 * j);
				else _label.y = 240 - (50 * j);
				_label.width = 50;
				_label.height = 50;
				addChild(_label);
				
				if (j != 0)
				{
					_diagram = new Shape();
					_diagram.graphics.lineStyle(1, 0xCCCCCC, 1);
					_diagram.graphics.beginFill(0xFF0000); 
					_diagram.graphics.moveTo(50, 250 - (50 * j));
					_diagram.graphics.lineTo(550, 250 - (50 * j));
					addChild(_diagram);
				}
			}
			//----------------------------------
			
			var count:int = 0;
			var step:int = 450 / _tutorial.length;
			
			var X:Number = 0;
			var Y:Number = 0;
			var WIDTH:Number = 0;
			var HEIGHT:Number = 0;
			
			for (var index:int = 0; index < _tutorial.length; index++)
			{
				/* Наименование этапа */
				_label = new Label(); 
				_label.text = _tutorial[index]["step"]; 
				_label.x = 80 + (step * count);
				_label.y = 250;
				_label.width = 100;
				_label.height = 50;
				addChild(_label);
				
				/* Столбец затраченного времени */
				WIDTH = 10;
				HEIGHT =  length < 4 ? 50 * int(_tutorial[index]["time"]) : (50 / Math.ceil(length / 4)) * int(_tutorial[index]["time"]);
				X = 80 + (step * count);
				Y = 250 - HEIGHT;
				
				_diagram = new Shape(); // Столбец затраченого времени
				_diagram.graphics.lineStyle(1, 0x880000, 1);
				_diagram.graphics.beginFill(0xFF0000); 
				_diagram.graphics.drawRect(X, Y, WIDTH, HEIGHT);
				addChild(_diagram);
				
				_label = new Label(); // количество затраченного времени
				_label.text = _tutorial[index]["time"]; 
				_label.x = 80 + (step * count);
				_label.y = Y - 15;
				_label.width = 50;
				_label.height = 50;
				addChild(_label);
				
				/* Столбец количества попыток */
				WIDTH = 10;
				HEIGHT =  length < 4 ? 50 * int(_tutorial[index]["count"]) : (50 / Math.ceil(length / 4)) * int(_tutorial[index]["count"]);
				X = 100 + (step * count);
				Y = 250 - HEIGHT;
				
				_diagram = new Shape(); // Столбец затраченого времени
				_diagram.graphics.lineStyle(1, 0x0000FF, 1);
				_diagram.graphics.beginFill(0x0080FF); 
				_diagram.graphics.drawRect(X, Y, WIDTH, HEIGHT);
				addChild(_diagram);
				
				_label = new Label(); // количество попыток
				_label.text = _tutorial[index]["count"]; 
				_label.x = 100 + (step * count);
				_label.y = Y - 15;
				_label.width = 50;
				_label.height = 50;
				addChild(_label);
				
				count++;
			}
			
			
		}
		
		private function countTry(stepName:String):int
		{
			var count:int = 0;
			for (var i:int = 0; i < _tutorialFull.length; i++)
			{
				if (_tutorialFull[i]["step"] == stepName) count++;
			}
			return count;
		}
		
		
		
		
	}

}