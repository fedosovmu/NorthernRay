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
    public partial class UnconfirmedCarsForm : Form
    {
        public UnconfirmedCarsForm()
        {
            InitializeComponent();
            dataGridView1.Rows.Add(new object[] { false, "Лада", "Калина", "1" });
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MainForm main = this.Owner as MainForm;
            main.button5.Visible = false;
            this.Close();
        }
    }
}