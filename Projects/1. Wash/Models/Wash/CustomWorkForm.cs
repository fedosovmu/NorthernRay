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
    public partial class CustomWorkForm : Form
    {
        public CustomWorkForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            WorkTableForm main = this.Owner as WorkTableForm;
            if (main != null)
            {
                main.row = new object[] { textBox1.Text, numericUpDown1.Value.ToString(), 1 };
                main.summ = decimal.ToInt32(numericUpDown1.Value);
            }
            main.Close();
            this.Close();
        }
    }
}
