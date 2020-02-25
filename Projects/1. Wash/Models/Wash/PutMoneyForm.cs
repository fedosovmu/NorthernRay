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
    public partial class PutMoneyForm : Form
    {
        public PutMoneyForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            PutMoneyTableForm main = this.Owner as PutMoneyTableForm;
            if (main != null)
            {
                main.money += decimal.ToInt32(numericUpDown1.Value);
                main.dataGridView1.Rows.Add(System.DateTime.Now.ToString(), numericUpDown1.Value, richTextBox1.Text);
            }
            this.Close();
        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {
            if (richTextBox1.Text.Trim() != "" && numericUpDown1.Value > 0)
                button1.Enabled = true;
        }

        private void numericUpDown1_ValueChanged(object sender, EventArgs e)
        {
            if (richTextBox1.Text.Trim() != "" && numericUpDown1.Value > 0)
                button1.Enabled = true;
        }
    }
}
