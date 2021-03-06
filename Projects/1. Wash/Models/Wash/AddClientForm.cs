﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class AddClientForm : Form
    {
        public AddClientForm()
        {
            InitializeComponent();
            comboBox1.Items.Add("5%");
            comboBox1.Items.Add("7%");
            comboBox1.Items.Add("10%");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ClientsForm main = this.Owner as ClientsForm;
            if (main != null)
                main.dataGridView1.Rows.Add(textBox1.Text, textBox2.Text, radioButton1.Checked ? comboBox1.SelectedItem.ToString() : numericUpDown1.Value + "%");
            this.Close();
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                comboBox1.Visible = true;
                numericUpDown1.Visible = false;
                numericUpDown2.Enabled = true;
            }
            else
            {
                comboBox1.Visible = false;
                numericUpDown1.Visible = true;
                numericUpDown2.Enabled = false;
            }
        }
    }
}
