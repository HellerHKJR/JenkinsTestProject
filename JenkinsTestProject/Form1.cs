using Newtonsoft.Json;
using NumberFunction;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml;

namespace JenkinsTestProject
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}

		private void button1_Click(object sender, EventArgs e)
		{
			MessageBox.Show("Hello, Jenkins!");
		}

		private void Form1_Load(object sender, EventArgs e)
		{
			try
			{

				string configPath = Path.Combine(Application.StartupPath, "Config", Properties.Settings.Default.StartupArg);

				if (File.Exists(configPath))
				{
					XmlDocument xmlDoc = new XmlDocument();
					xmlDoc.Load(configPath);

					XmlNode helloMessageNode = xmlDoc.SelectSingleNode("//Caption");
					if (helloMessageNode != null)
					{
						this.Text = helloMessageNode.InnerText;
					}
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show($"Error loading config: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		private void button2_Click(object sender, EventArgs e)
		{
			Random rnd = new Random();
			int randomNumber = rnd.Next(1, 101);

			MessageBox.Show($"Generated random number: {NumberFunctions.Add(randomNumber, 10)}");
		}

		private void button3_Click(object sender, EventArgs e)
		{
			Product product = new Product();
			product.Name = "Apple";
			product.Expiry = new DateTime(2008, 12, 28);
			product.Sizes = new string[] { "Small" };

			string json = JsonConvert.SerializeObject(product, Newtonsoft.Json.Formatting.Indented);
			// {
			//   "Name": "Apple",
			//   "Expiry": "2008-12-28T00:00:00",
			//   "Sizes": [
			//     "Small"
			//   ]
			// }

			MessageBox.Show($"Json test: {json}");
		}
	}
}
