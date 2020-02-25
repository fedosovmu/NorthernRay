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
    public partial class TakeMoneyTableForm : Form
    {
        public int money = 0;

        public TakeMoneyTableForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            TakeMoneyForm form = new TakeMoneyForm();
            form.Owner = this;
            form.Show();
        }

        private void TakeMoneyTableForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            MainForm main = this.Owner as MainForm;
            if (main != null)
                main.takemoney(money);
        }
    }
}
