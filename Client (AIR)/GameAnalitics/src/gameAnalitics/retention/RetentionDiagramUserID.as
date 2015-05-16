package gameAnalitics.retention 
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
	public class RetentionDiagramUserID extends Sprite 
	{
		private var _diagram:Shape;
		private var _query:Query;
		
		private var _userID:String;
		private var _retention:Array = [];
		private var _retentionFull:Array = [];
		
		private var _label:Label;
		private var _label1:Label = new Label();
		private var _label2:Label = new Label();
		
		public function RetentionDiagramUserID(userID:String) 
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
			
			_label2.text = "Действие"; 
			_label2.x = 540;
			_label2.y = 250;
			_label2.width = 200;
			_label2.height = 100;
			addChild(_label2);
			
			getDataFromTable();
		}
		
		/* Получить данные с сервера ====================================== */
		private function getDataFromTable():void
		{
			var sqlCommand:String = "SELECT * FROM retention WHERE(retention_userid = '" + _userID + "')";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "retention_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildTable);
		}
		/* ================================================================ */
		
		/* ТАБЛИЦА ======================================================== */
		private function buildTable(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			_retentionFull = [];
			
			var totalBegin:int = 0;
			var totalExit:int = 0;
			var totalReturn:int = 0;
			
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].retention) 
				{
					var gameBegin:String = String(json_data[i].retention[k].retention_datetime_begin) == "1900-01-01 00:00:00" ? "-" : String(json_data[i].retention[k].retention_datetime_begin);
					var gameExit:String = String(json_data[i].retention[k].retention_datetime_exit) == "1900-01-01 00:00:00" ? "-" : String(json_data[i].retention[k].retention_datetime_exit);
					var gameReturn:String = String(json_data[i].retention[k].retention_datetime_return) == "1900-01-01 00:00:00" ? "-" : String(json_data[i].retention[k].retention_datetime_return);
					
					if (gameBegin != "-") totalBegin++;
					if (gameExit != "-") totalExit++;
					if (gameReturn != "-") totalReturn++;
					
					_retentionFull.push( {
						user:json_data[i].retention[k].retention_userid,
						beginGame:gameBegin,
						exitGame:gameExit,
						returnGame:gameReturn,
						count:1
					});
				}
			}
			
			if(_retentionFull.length !=0 ){
				_label = new Label(); // дата завершения тутора
				_label.text = "Начало: " + totalBegin.toString() + " (раз) \nВыход: " + totalExit.toString() + " (раз) \nВозвраты: " + totalReturn.toString() + " (раз)"; 
				_label.x = 350;
				_label.y = 5;
				_label.width = 250;
				_label.height = 50;
				addChild(_label);
			}
			
			
			
			var _dataGrid:DataGrid = new DataGrid();
			_dataGrid.columns = ["beginGame", "exitGame", "returnGame"];
			_dataGrid.dataProvider = new DataProvider(_retentionFull); 
			
			_dataGrid.setSize(600, 150);
			_dataGrid.move(0, 325);
			_dataGrid.rowHeight = 20;
			
			_dataGrid.columns[0].headerText = "Начало";
			_dataGrid.columns[0].width = 200;
			_dataGrid.columns[1].headerText = "Выход";
			_dataGrid.columns[1].width = 200;
			_dataGrid.columns[2].headerText = "Возврат";
			_dataGrid.columns[2].width = 200;
			
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
			var mark:Array = ["Начало", "Выход", "Возврат"];
			for (var i:int = 0; i < mark.length; i++)
			{
				
				_retention.push( {
					name: mark[i],
					num:0,
					count:0
				});
			}
			
			for (var k:int = 0; k < _retentionFull.length; k++)
			{
				if (_retentionFull[k]["beginGame"] != "-") _retention[0]["num"]++;
				if (_retentionFull[k]["exitGame"] != "-") _retention[1]["num"]++;
				if (_retentionFull[k]["returnGame"] != "-") _retention[2]["num"]++;
			}
			
			buildDiagram();
		}
		/* ================================================================ */
		
		/* ДИАГРОММА ====================================================== */
		private function buildDiagram():void
		{
			var length:int = _retentionFull.length;
			
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
			var step:int = 450 / _retention.length;
			
			var X:Number = 0;
			var Y:Number = 0;
			
			for (var index:int = 0; index < _retention.length; index++)
			{
				_label = new Label(); // наименование 
				_label.text = _retention[index]["name"]; 
				_label.x = 80 + (step * count);
				_label.y = 250;
				_label.width = 100;
				_label.height = 50;
				addChild(_label);
					
				_diagram = new Shape(); // точка на диаграмме
				_diagram.graphics.lineStyle(1, 0x880000, 1);
				_diagram.graphics.beginFill(0xFF0000);
				X = 100 + (step * count);
				Y = 250 - (length < 4 ? 50 * int(_retention[index]["num"]) : (50 / Math.ceil(length / 4)) * int(_retention[index]["num"]));
				_diagram.graphics.drawCircle(X, Y, 5);
				addChild(_diagram);
				
				_label = new Label(); // количество 
				_label.text = _retention[index]["num"]; 
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