package gameAnalitics.boosters 
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
	public class BoostersDiagramUserID extends Sprite 
	{
		private var _diagram:Shape;
		private var _query:Query;
		
		private var _userID:String;
		private var _boosters:Array = [];
		private var _boostersFull:Array = [];
		
		private var _label:Label;
		private var _label1:Label = new Label();
		private var _label2:Label = new Label();
		
		public function BoostersDiagramUserID(userID:String) 
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
			_label1.text = "Кол-во"; 
			_label1.x = 10;
			_label1.y = 0;
			_label1.width = 200;
			_label1.height = 100;
			addChild(_label1);
			
			_label2.text = "Бустера"; 
			_label2.x = 550;
			_label2.y = 245;
			_label2.width = 200;
			_label2.height = 100;
			addChild(_label2);
			
			
			
			getDataFromTable();
		}
		
		/* Получить данные с сервера ====================================== */
		private function getDataFromTable():void
		{
			var sqlCommand:String = "SELECT * FROM boosters WHERE(boosters_userid = '" + _userID + "') ORDER BY boosters_datetime";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "boosters_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildTable);
		}
		/* ================================================================ */
		
		/* ТАБЛИЦА ======================================================== */
		private function buildTable(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			_boostersFull = [];
						
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].booster) 
				{
					_boostersFull.push( {
						user:json_data[i].booster[k].boosters_userid,
						name:json_data[i].booster[k].boosters_name,
						level:json_data[i].booster[k].boosters_level,
						data:json_data[i].booster[k].boosters_datetime,
						count:1
					});
				}
			}
			
			if(_boostersFull.length !=0 ){
				_label = new Label(); // дата завершения тутора
				_label.text = "Дата начала: " + _boostersFull[0]["data"] + "\nДата завершения: " + _boostersFull[_boostersFull.length - 1]["data"]; 
				_label.x = 350;
				_label.y = 5;
				_label.width = 250;
				_label.height = 50;
				addChild(_label);
			}
			
			
			
			var _dataGrid:DataGrid = new DataGrid();
			_dataGrid.columns = ["data", "name", "level", "count"];
			_dataGrid.dataProvider = new DataProvider(_boostersFull); 
			
			_dataGrid.setSize(600, 150);
			_dataGrid.move(0, 325);
			_dataGrid.rowHeight = 20;
			
			_dataGrid.columns[0].headerText = "Дата";
			_dataGrid.columns[0].width = 150;
			_dataGrid.columns[1].headerText = "Наименование";
			_dataGrid.columns[1].width = 150;
			_dataGrid.columns[2].headerText = "Уровень";
			_dataGrid.columns[2].width = 150;
			_dataGrid.columns[3].headerText = "Количество";
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
			var sqlCommand:String = "SELECT boosters_userid, boosters_name, boosters_level, boosters_datetime, COUNT(boosters_name) AS count_boosters FROM boosters WHERE(boosters_userid = '" + _userID + "') GROUP BY boosters_name ORDER BY boosters_name";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "boosters_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildDiagram);
		}
		/* ================================================================ */
		
		/* ДИАГРОММА ====================================================== */
		private function buildDiagram(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			var length:int = 0;
			
			_boosters = [];
			
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].booster) 
				{
					if (length <= int(json_data[i].booster[k].count_boosters)) length = int(json_data[i].booster[k].count_boosters);
					_boosters.push( {
						user:json_data[i].booster[k].boosters_userid,
						name:json_data[i].booster[k].boosters_name,
						level:json_data[i].booster[k].boosters_level,
						data:json_data[i].booster[k].boosters_datetime,
						count:json_data[i].booster[k].count_boosters
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
				
				if (j > 0)
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
			
			var xStart:Number = 0;
			var yStart:Number = 0;
			var xEnd:Number = 0;
			var yEnd:Number = 0;
			
			var count:int = 0;
			var step:int = 450 / _boosters.length;
			
			var X:Number = 0;
			var Y:Number = 0;
			
			for (var index:int = 0; index < _boosters.length; index++)
			{
				_label = new Label(); // наименование 
				_label.text = _boosters[index]["name"]; 
				_label.x = 80 + (step * count);
				_label.y = 250;
				_label.width = 100;
				_label.height = 50;
				addChild(_label);
					
				_diagram = new Shape(); // точка на диаграмме
				_diagram.graphics.lineStyle(1, 0x880000, 1);
				_diagram.graphics.beginFill(0xFF0000);
				X = 100 + (step * count);
				Y = 250 - (length < 4 ? 50 * int(_boosters[index]["count"]) : (50 / Math.ceil(length / 4)) * int(_boosters[index]["count"]));
				_diagram.graphics.drawCircle(X, Y, 5);
				addChild(_diagram);
				
				_label = new Label(); // количество 
				_label.text = _boosters[index]["count"]; 
				_label.x = 95 + (step * count);
				_label.y = Y - 20;
				_label.width = 50;
				_label.height = 50;
				addChild(_label);
					
				if (xStart == 0 && yStart == 0)
				{
					xStart = 100 + (step * count);
					yStart = Y;
				}else {
					xEnd = 100 + (step * count);
					yEnd = Y;
					
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
		}
		
	}

}