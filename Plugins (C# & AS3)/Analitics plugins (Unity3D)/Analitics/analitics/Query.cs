/*
 * Сделано в SharpDevelop.
 * Пользователь: Somov Evgeniy
 * Дата: 02.05.2015
 * Время: 14:58
 * 
 * Для изменения этого шаблона используйте Сервис | Настройка | Кодирование | Правка стандартных заголовков.
 */
using System;
using System.Net;
using System.Windows.Forms;
       
namespace Analitics.analitics
{
	/// <summary>
	/// Description of Query.
	/// </summary>
	public class Query
	{
		WebClient client;
		
		public Query()
		{
			client = new WebClient();
		}
		
		public void performRequest(String filePHP)
		{
			string pagesource = client.DownloadString(filePHP);
			MessageBox.Show(pagesource);
		}
	}
}
