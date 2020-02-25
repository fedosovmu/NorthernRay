using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class DayReport : Form
    {
        public DayReport()
        {
            InitializeComponent();
        }

        public DayReport(int sum1, int sum2, int cash)
        {
            InitializeComponent();

            label3.Text += (sum1 + sum2).ToString();
            label4.Text += cash.ToString();
            label6.Text += (sum1 * 0.3).ToString();
            label7.Text += (sum2 * 0.4).ToString();
            label5.Text += "400";
            label8.Text += "100";
            label9.Text += (cash - 400 + 100).ToString();
            label10.Text += "250";
            label11.Text += (cash - 400 + 100 + 250).ToString();
        }
    }
}
