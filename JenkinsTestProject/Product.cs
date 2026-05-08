using System;

namespace JenkinsTestProject
{
	internal class Product
	{
		public string Name { get; internal set; }
		public DateTime Expiry { get; internal set; }
		public string[] Sizes { get; internal set; }
	}
}