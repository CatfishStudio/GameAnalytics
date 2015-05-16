package gameAnalitics.buys 
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
	public class BuysDiagramUserID extends Sprite 
	{
		private var _diagram:Shape;
		private var _query:Query;
		
		private var _userID:String;
		private var _buys:Array = [];
		private var _buysFull:Array = [];
		
		private var _label:Label;
		private var _label1:Label = new Label();
		private var _label2:Label = new Label();
		
		public function BuysDiagramUserID(userID:String) 
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
			
			_label2.text = "Товар"; 
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
			var sqlCommand:String = "SELECT * FROM buys WHERE(buys_userid = '" + _userID + "') ORDER BY buys_datetime";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "buys_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildTable);
		}
		/* ================================================================ */
		
		/* ТАБЛИЦА ======================================================== */
		private function buildTable(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			_buysFull = [];
						
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].buy) 
				{
					_buysFull.push( {
						user:json_data[i].buy[k].buys_userid,
						name:json_data[i].buy[k].buys_object_name,
						num:json_data[i].buy[k].buys_number,
						price:json_data[i].buy[k].buys_price,
						sum:json_data[i].buy[k].buys_sum,
						view:json_data[i].buy[k].buys_view,
						location:json_data[i].buy[k].buys_location,
						data:json_data[i].buy[k].buys_datetime,
						count:1
					});
				}
			}
			
			if(_buysFull.length !=0 ){
				_label = new Label(); // дата завершения тутора
				_label.text = "Дата начала: " + _buysFull[0]["data"] + "\nДата завершения: " + _buysFull[_buysFull.length - 1]["data"]; 
				_label.x = 350;
				_label.y = 5;
				_label.width = 250;
				_label.height = 50;
				addChild(_label);
			}
			
			
			
			var _dataGrid:DataGrid = new DataGrid();
			_dataGrid.columns = ["data", "name", "num", "price", "sum", "view", "location"];
			_dataGrid.dataProvider = new DataProvider(_buysFull); 
			
			_dataGrid.setSize(600, 150);
			_dataGrid.move(0, 325);
			_dataGrid.rowHeight = 20;
			
			_dataGrid.columns[0].headerText = "Дата";
			_dataGrid.columns[0].width = 150;
			_dataGrid.columns[1].headerText = "Товар";
			_dataGrid.columns[1].width = 100;
			_dataGrid.columns[2].headerText = "Кол-во";
			_dataGrid.columns[2].width = 50;
			_dataGrid.columns[3].headerText = "Цена";
			_dataGrid.columns[3].width = 50;
			_dataGrid.columns[4].headerText = "Сумма";
			_dataGrid.columns[4].width = 50;
			_dataGrid.columns[5].headerText = "Вид валюты";
			_dataGrid.columns[5].width = 100;
			_dataGrid.columns[6].headerText = "Место оплаты";
			_dataGrid.columns[6].width = 50;
			
			
			
			_dataGrid.resizableColumns = true; 
			_dataGrid.selectable = false;
			_dataGrid.editable = false;
			
			
			_dataGrid.verticalScrollPolicy = ScrollPolicy.AUTO; // полоса прокрутки
			_dataGrid.horizontalScrollPolicy = ScrollPolicy.ON; // полоса прокрутки
			
			addChild(_dataGrid);
			
			getData();
		}
		/* ================================================================ */
		
		/* Получить данные с сервера ====================================== */
		private function getData():void
		{
			var sqlCommand:String = "SELECT buys_userid, buys_datetime, buys_object_name, buys_view, buys_location, buys_price, SUM(buys_number) AS buys_number, SUM(buys_sum) AS buys_sum FROM buys WHERE(buys_userid = '" + _userID + "') GROUP BY buys_object_name ORDER BY buys_object_name";
			
			_query = new Query();
			_query.performRequest(Resource.serverPath + "buys_get.php?client=1&sqlcommand=" + sqlCommand);
			_query.addEventListener("complete", buildDiagram);
		}
		/* ================================================================ */
		
		/* ДИАГРОММА ====================================================== */
		private function buildDiagram(event:Object):void
		{
			var json_str:String = (_query.getResult as String);
			var json_data:Array = gameAnalitics.json.JSON.decode(json_str);
			
			var length:int = 0;
			
			_buys = [];
			
			for (var i:Object in json_data) 
			{
				for (var k:Object in json_data[i].buy) 
				{
					if (length <= int(json_data[i].buy[k].buys_number)) length = int(json_data[i].buy[k].buys_number);
					_buys.push( {
						user:json_data[i].buy[k].buys_userid,
						name:json_data[i].buy[k].buys_object_name,
						data:json_data[i].buy[k].buys_datetime,
						num:json_data[i].buy[k].buys_number,
						price:json_data[i].buy[k].buys_price,
						sum:json_data[i].buy[k].buys_sum,
						view:json_data[i].buy[k].buys_view,
						location:json_data[i].buy[k].buys_location,
						count:json_data[i].buy[k].buys_number
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
			var step:int = 450 / _buys.length;
			
			var X:Number = 0;
			var Y:Number = 0;
			
			for (var index:int = 0; index < _buys.length; index++)
			{
				_label = new Label(); // наименование 
				_label.text = _buys[index]["name"]; 
				_label.x = 80 + (step * count);
				_label.y = 250;
				_label.width = 100;
				_label.height = 50;
				addChild(_label);
					
				_diagram = new Shape(); // точка на диаграмме
				_diagram.graphics.lineStyle(1, 0x880000, 1);
				_diagram.graphics.beginFill(0xFF0000);
				X = 100 + (step * count);
				Y = 250 - (length < 4 ? 50 * int(_buys[index]["num"]) : (50 / Math.ceil(length / 4)) * int(_buys[index]["num"]));
				_diagram.graphics.drawCircle(X, Y, 5);
				addChild(_diagram);
				
				_label = new Label(); // количество 
				_label.text = _buys[index]["num"]; 
				_label.x = 95 + (step * count);
				_label.y = Y - 20;
				_label.width = 50;
				_label.height = 50;
				addChild(_label);
				
				_label = new Label(); // количество 
				_label.text = _buys[index]["sum"]; 
				_label.x = 95 + (step * count);
				_label.y = Y + 5;
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