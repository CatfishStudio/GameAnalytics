package gameAnalitics.levels 
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
	public class LevelsDiagramUserID extends Sprite 
	{
		private var _diagram:Shape;
		private var _query:Query;
		
		private var _userID:String;
		private var _levels:Array = [];
		private var _levelsFull:Array = [];
		
		private var _label:Label;
		private var _label1:Label = new Label();
		private var _label2:Label = new Label();
		
		public function LevelsDiagramUserID(userID:String) 
		{
			super();
			
			_userID = userID;
			
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
			_label1.text = "Затраченое\nвремя"; 
			_label1.x = 10;
			_label1.y = 0;
			_label1.width = 200;
			_label1.height = 100;
			addChild(_label1);
			
			_label2.text = "Уровни"; 
			_label2.x = 550;
			_label2.y = 245;
			_label2.width = 200;
			_label2.height = 100;
			addChild(_label2);
			
			//-----------------------------------
			for (var i:int = 0; i < 5; i++)
			{
				var value:int = 2 * i;
				_label = new Label();
				_label.text = value.toString(); 
				_label.x = 35;
				_label.y = 250 - (50 * i);
				_label.width = 50;
				_label.height = 50;
				addChild(_label);
				
				if (i != 0)
				{
					_diagram = new Shape();
					_diagram.graphics.lineStyle(1, 0xCCCCCC, 1);
					_diagram.graphics.beginFill(0xFF0000); 
					_diagram.graphics.moveTo(50, 260 - (50 * i));
					_diagram.graphics.lineTo(550, 260 - (50 * i));
					addChild(_diagram);
				}
			}
			//----------------------------------
			
			getData();
		}
		
		/* Получить данные с сервера ====================================== */
		private function getData():void
		{
			var sqlCommand:String = "SELECT * FROM levels WHERE(levels_userid = '" + _userID + "') ORDER BY levels_step_name";;
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "levels_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildDiagram);
		}
		/* ================================================================ */
		
		/* ДИАГРОММА ====================================================== */
		private function buildDiagram(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			_levels = [];
			_levelsFull = [];
			
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].level) 
				{
					_levelsFull.push( {
						step:json_data[i].level[k].levels_step_name,
						num:json_data[i].level[k].levels_number,
						time:json_data[i].level[k].levels_travel_time_minutes,
						data:json_data[i].level[k].levels_datetime,
						count:1
					});
					
					
					if(_levels.length != 0){
						if (_levels[_levels.length - 1]["step"] == json_data[i].level[k].levels_step_name)
						{
							_levels[_levels.length - 1]["count"]++;
							_levels[_levels.length - 1]["time"] = int(_levels[_levels.length - 1]["time"]) + int(json_data[i].level[k].levels_travel_time_minutes);
							_levels[_levels.length - 1]["data"] = json_data[i].level[k].levels_datetime;
						}else{
							_levels.push( {
								step:json_data[i].level[k].levels_step_name,
								num:json_data[i].level[k].levels_number,
								time:json_data[i].level[k].levels_travel_time_minutes,
								data:json_data[i].level[k].levels_datetime,
								count:1
							});
						}
					}else {
						_levels.push( {
							step:json_data[i].level[k].levels_step_name,
							num:json_data[i].level[k].levels_number,
							time:json_data[i].level[k].levels_travel_time_minutes,
							data:json_data[i].level[k].levels_datetime,
							count:1
						});
					}
				}
			}
			
			var xStart:Number = 0;
			var yStart:Number = 0;
			var xEnd:Number = 0;
			var yEnd:Number = 0;
			
			var count:int = 0;
			var step:int = 450 / _levels.length;
			
			for (var index:int = 0; index < _levels.length; index++)
			{
				_label = new Label(); // наименование этапа
				_label.text = _levels[index]["step"]; 
				_label.x = 80 + (step * count);
				_label.y = 250;
				_label.width = 100;
				_label.height = 50;
				addChild(_label);
					
				_diagram = new Shape(); // точка на диаграмме
				_diagram.graphics.lineStyle(1, 0x880000, 1);
				_diagram.graphics.beginFill(0xFF0000); 
				_diagram.graphics.drawCircle(100 + (step * count), 260 - (50 * _levels[index]["time"] / 2), 5);
				addChild(_diagram);
				
				_label = new Label(); // количество попыток отображается на точке на диаграмме
				_label.text = _levels[index]["count"]; 
				_label.x = 95 + (step * count);
				_label.y = 240 - (50 * _levels[index]["time"] / 2);
				_label.width = 50;
				_label.height = 50;
				addChild(_label);
					
				if (xStart == 0 && yStart == 0)
				{
					xStart = 100 + (step * count);
					yStart = 260 - (50 * _levels[index]["time"] / 2);
				}else {
					xEnd = 100 + (step * count);
					yEnd = 260 - (50 * _levels[index]["time"] / 2);
						
					_diagram = new Shape();
					_diagram.graphics.lineStyle(1, 0x550000, 1);
					_diagram.graphics.beginFill(0xFF0000); 
					_diagram.graphics.moveTo(xStart, yStart)
					_diagram.graphics.lineTo(xEnd, yEnd);
					addChild(_diagram);
						
					xStart = xEnd; yStart = yEnd; xEnd = 0; yEnd = 0;
				}
					
				count++;
			}
			
			if (_levels.length != 0)
			{
				_label = new Label(); // дата завершения
				_label.text = "Дата начала: " + _levels[0]["data"] + "\nДата завершения: " + _levels[_levels.length - 1]["data"]; 
				_label.x = 350;
				_label.y = 5;
				_label.width = 250;
				_label.height = 50;
				addChild(_label);
			}
			
			buildTable();
		}
		
		/* ТАБЛИЦА ======================================================== */
		private function buildTable():void
		{
			var _dataGrid:DataGrid = new DataGrid();
			_dataGrid.columns = ["step", "num", "time", "data", "count"];
			_dataGrid.dataProvider = new DataProvider(_levelsFull); 
			
			_dataGrid.setSize(600, 150);
			_dataGrid.move(0, 325);
			_dataGrid.rowHeight = 20;
			
			_dataGrid.columns[0].headerText = "Этап";
			_dataGrid.columns[0].width = 200;
			_dataGrid.columns[1].headerText = "Номер";
			_dataGrid.columns[1].width = 50;
			_dataGrid.columns[2].headerText = "Время";
			_dataGrid.columns[2].width = 100;
			_dataGrid.columns[3].headerText = "Дата";
			_dataGrid.columns[3].width = 150;
			_dataGrid.columns[4].headerText = "Попытки";
			_dataGrid.columns[4].width = 100;
			
			
			_dataGrid.resizableColumns = true; 
			_dataGrid.selectable = false;
			_dataGrid.editable = false;
			
			
			_dataGrid.verticalScrollPolicy = ScrollPolicy.AUTO; // полоса прокрутки
			_dataGrid.horizontalScrollPolicy = ScrollPolicy.AUTO; // полоса прокрутки
			
			addChild(_dataGrid);
		}
		/* ================================================================ */
		
	}

}