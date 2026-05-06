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
				string configPath = Path.Combine(Application.StartupPath, "Config", "JRConfig.xml");

				if (File.Exists(configPath))
				{
					XmlDocument xmlDoc = new XmlDocument();
					xmlDoc.Load(configPath);

					XmlNode helloMessageNode = xmlDoc.SelectSingleNode("//helloMessage");
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
	}
}
