/*
 * Сделано в SharpDevelop.
 * Пользователь: Somov Evgeniy
 * Дата: 02.05.2015
 * Время: 13:52
 * 
 * Для изменения этого шаблона используйте Сервис | Настройка | Кодирование | Правка стандартных заголовков.
 */
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using Analitics.analitics;

namespace Analitics
{
	/// <summary>
	/// Description of MainForm.
	/// </summary>
	public partial class MainForm : Form
	{
		public MainForm()
		{
			//
			// The InitializeComponent() call is required for Windows Forms designer support.
			//
			InitializeComponent();
			
			//
			// TODO: Add constructor code after the InitializeComponent() call.
			//
		}
		
		void MainFormLoad(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.userID = "123456789";
			Analitics.analitics.Analitics.userName = "admin";
			Analitics.analitics.Analitics.userLocation = "no";
		}
		
		void Button1Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.User(textBox1.Text, textBox2.Text, textBox3.Text);
		}
		
		void Button2Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.Tutorial(textBox4.Text, Convert.ToInt32(textBox5.Text));
		}
		
		void Button3Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.Level(textBox6.Text, Convert.ToInt32(textBox7.Text), Convert.ToInt32(textBox8.Text));
		}
		
		void Button4Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.Booster(textBox9.Text, Convert.ToInt32(textBox10.Text));
		}
		
		void Button5Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.Buy(textBox11.Text, textBox12.Text, textBox13.Text, textBox14.Text, textBox15.Text);
		}
		
		void Button6Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.TestingAB(textBox16.Text, textBox17.Text);
		}
		
		void Button8Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.Retention(comboBox2.Text);
		}
		
		void Button7Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.Error(comboBox1.Text, textBox18.Text);
		}
		
		void Button9Click(object sender, EventArgs e)
		{
			Analitics.analitics.Analitics.serverPath = textBox19.Text;
		}
	}
}
