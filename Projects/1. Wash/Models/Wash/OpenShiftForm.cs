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
    public partial class OpenShiftForm : Form
    {

        public OpenShiftForm()
        {
            InitializeComponent();
            comboBox1.Items.Add("Администратор");
            comboBox1.Items.Add("Руководитель");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MainForm form = new MainForm(comboBox1.Text);
            form.Owner = this;
            this.Hide();
            form.Show();
            
        }

        private void comboBox1_SelectedValueChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem != null)
                button1.Enabled = true;
        }

        private void comboBox1_TextChanged(object sender, EventArgs e)
        {
            if (comboBox1.Text == "")
                button1.Enabled = false;
        }

        private void OpenShiftForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (e.CloseReason == CloseReason.UserClosing)
                e.Cancel = false;
        }
    }
}
