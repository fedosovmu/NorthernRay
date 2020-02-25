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
    public partial class PutMoneyTableForm : Form
    {
        public int money = 0;

        public PutMoneyTableForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            PutMoneyForm form = new PutMoneyForm();
            form.Owner = this;
            form.Show();
        }

        private void PutMoneyTableForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            MainForm main = this.Owner as MainForm;
            if (main != null)
                main.takemoney(-money);
        }
    }
}
