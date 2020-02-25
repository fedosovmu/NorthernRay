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
    public partial class AddRecord2Form : Form
    {
        private int num;

        public AddRecord2Form(int number)
        {
            InitializeComponent();

            label1.Text += num = number;
            comboBox1.Items.Add("ВАЗ");
            comboBox1.Items.Add("ТОЙОТА");
            comboBox1.Items.Add("ЛЕКСУС");

            dataGridView1.Rows.Add("Накачка", "4", "50");
            textBox3.Text = "200";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MainForm main = this.Owner as MainForm;
            if (main != null)
            {
                main.sum2 += int.Parse(textBox3.Text);
                main.label7.Text = (int.Parse(main.label7.Text) + int.Parse(textBox3.Text)).ToString();
                main.label8.Text = (int.Parse(main.label8.Text) + int.Parse(textBox3.Text)).ToString();
                main.dataGridView2.Rows.Add(num, System.DateTime.Now.ToString(),
                    (comboBox1.SelectedValue ?? comboBox1.Text) + " " + (comboBox2.SelectedValue ?? comboBox2.Text),
                    textBox1.Text, textBox3.Text, dataGridView1.Rows[0].Cells[0].Value.ToString());
            }
            this.Close();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            comboBox2.Text = "";
            if (comboBox1.SelectedItem == null)
                return;
            if (comboBox1.SelectedItem.ToString() == "ВАЗ")
            {
                comboBox2.Items.Clear();
                comboBox2.Items.Add("2107");
                comboBox2.Items.Add("21099");
                comboBox2.Items.Add("2112");
            }
            else if (comboBox1.SelectedItem.ToString() == "ТОЙОТА")
            {
                comboBox2.Items.Clear();
                comboBox2.Items.Add("КАМРИ");
                comboBox2.Items.Add("КОРОЛЛА");
            }
            else if (comboBox1.SelectedItem.ToString() == "ЛЕКСУС")
            {
                comboBox2.Items.Clear();
                comboBox2.Items.Add("RX-300");
            }
            else if (comboBox1.SelectedItem.ToString() == "КРАЗ")
            {
                comboBox2.Items.Clear();
                comboBox2.Items.Add("6510");
                comboBox2.Items.Add("65053");
            }
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                panel3.Visible = false;
                panel6.Visible = true;
            }
            else
            {
                panel3.Visible = true;
                panel6.Visible = false;
            }
        }
    }
}
