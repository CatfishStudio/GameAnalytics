package gameAnalitics.testingAB 
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
	public class TestingABDiagramName extends Sprite 
	{
		private var _diagram:Shape;
		private var _query:Query;
		
		private var _record:String;
		private var _testingAB:Array = [];
		private var _testingABFull:Array = [];
		
		private var _label:Label;
		private var _label1:Label = new Label();
		private var _label2:Label = new Label();
		
		public function TestingABDiagramName(record:String) 
		{
			super();
			
			_record = record;
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
			_label1.text = "Показатель"; 
			_label1.x = 10;
			_label1.y = 0;
			_label1.width = 200;
			_label1.height = 100;
			addChild(_label1);
			
			_label2.text = "Сессия"; 
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
			var sqlCommand:String = "SELECT * FROM ab_testing WHERE(ab_testing_record = '" + _record + "') ORDER BY ab_testing_datetime";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "testing_ab_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildTable);
		}
		/* ================================================================ */
		
		/* ТАБЛИЦА ======================================================== */
		private function buildTable(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			_testingABFull = [];
						
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].testing_ab) 
				{
					_testingABFull.push( {
						user:json_data[i].testing_ab[k].ab_testing_userid,
						session:json_data[i].testing_ab[k].ab_testing_session,
						record:json_data[i].testing_ab[k].ab_testing_record,
						data:json_data[i].testing_ab[k].ab_testing_datetime,
						count:1
					});
				}
			}
			
			if(_testingABFull.length !=0 ){
				_label = new Label(); // дата завершения тутора
				_label.text = "Дата начала: " + _testingABFull[0]["data"] + "\nДата завершения: " + _testingABFull[_testingABFull.length - 1]["data"]; 
				_label.x = 350;
				_label.y = 5;
				_label.width = 250;
				_label.height = 50;
				addChild(_label);
			}
			
			
			
			var _dataGrid:DataGrid = new DataGrid();
			_dataGrid.columns = ["data", "session", "user"];
			_dataGrid.dataProvider = new DataProvider(_testingABFull); 
			
			_dataGrid.setSize(600, 150);
			_dataGrid.move(0, 325);
			_dataGrid.rowHeight = 20;
			
			_dataGrid.columns[0].headerText = "Дата";
			_dataGrid.columns[0].width = 150;
			_dataGrid.columns[1].headerText = "Сессия";
			_dataGrid.columns[1].width = 50;
			_dataGrid.columns[2].headerText = "Пользователь";
			_dataGrid.columns[2].width = 150;
			
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
			var sqlCommand:String = "SELECT ab_testing_userid, ab_testing_datetime, ab_testing_session, ab_testing_record, COUNT(ab_testing_session) AS ab_testing_count FROM ab_testing WHERE(ab_testing_record = '" + _record + "') GROUP BY ab_testing_session ORDER BY ab_testing_session";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "testing_ab_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildDiagram);
		}
		/* ================================================================ */
		
		/* ДИАГРОММА ====================================================== */
		private function buildDiagram(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			var length:int = 0;
			
			_testingAB = [];
			
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].testing_ab) 
				{
					if (length <= int(json_data[i].testing_ab[k].ab_testing_count)) length = int(json_data[i].testing_ab[k].ab_testing_count);
					_testingAB.push( {
						user:json_data[i].testing_ab[k].ab_testing_userid,
						session:json_data[i].testing_ab[k].ab_testing_session,
						record:json_data[i].testing_ab[k].ab_testing_record,
						data:json_data[i].testing_ab[k].ab_testing_datetime,
						count:json_data[i].testing_ab[k].ab_testing_count
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
			var step:int = 450 / _testingAB.length;
			
			var X:Number = 0;
			var Y:Number = 0;
			var WIDTH:Number = 0;
			var HEIGHT:Number = 0;
			
			for (var index:int = 0; index < _testingAB.length; index++)
			{
				/* Наименование этапа */
				_label = new Label(); 
				_label.text = _testingAB[index]["session"]; 
				_label.x = 95 + (step * count);
				_label.y = 250;
				_label.width = 100;
				_label.height = 50;
				addChild(_label);
				
				/* Столбец количество использованных бустеров*/
				WIDTH = 20;
				HEIGHT = length < 4 ? 50 * int(_testingAB[index]["count"]) : (50 / Math.ceil(length / 4)) * int(_testingAB[index]["count"]);
				X = 90 + (step * count);
				Y = 250 - HEIGHT;
				
				
				_diagram = new Shape(); // Столбец затраченого времени
				if (int(_testingAB[index]["count"]) >= length)
				{
					_diagram.graphics.lineStyle(1, 0x0000FF, 1);
					_diagram.graphics.beginFill(0x0080FF); 
				}else {
					_diagram.graphics.lineStyle(1, 0x880000, 1);
					_diagram.graphics.beginFill(0xFF0000);
				}
				_diagram.graphics.drawRect(X, Y, WIDTH, HEIGHT);
				addChild(_diagram);
				
				
				_label = new Label(); // количество затраченного времени
				_label.text = _testingAB[index]["count"]; 
				_label.x = 90 + (step * count);
				_label.y = Y - 15;
				_label.width = 50;
				_label.height = 50;
				addChild(_label);
				
					
				count++;
			}
		}
		
		
		
		
		
		
		
		
		
	}

}