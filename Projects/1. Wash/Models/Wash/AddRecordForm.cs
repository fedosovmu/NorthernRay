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
    public partial class CopyAddRecordForm : Form
    {
        private int _sum = 0;
        private object[] _obj;
        private float discount = 1.0F;

        public int num;

        public object[] obj { set { _obj = value; dataGridView1.Rows.Add(_obj); } get { return _obj; } }
        public void sum(int value)
        {
            _sum += value;
            textBox3.Text = Math.Round(_sum * discount).ToString();
        }

        public CopyAddRecordForm()
        {
            InitializeComponent();
            comboBox1.Items.Add("ВАЗ");
            comboBox1.SelectedIndex = 0;
            comboBox1.Enabled = false;

            comboBox2.Items.Add("2107");
            comboBox2.SelectedIndex = 0;
            comboBox2.Enabled = false;

            textBox1.Text = "У311ВР174";
            textBox1.Enabled = false;

            textBox2.Text = "Категория 1";
            textBox2.Enabled = false;

            textBox4.Text = "Владелец";
            textBox4.Enabled = false;

            textBox3.Text = "150";
            dataGridView1.Rows.Add("Бесконтактная мойка", "150", "1");
            //button3.Enabled = button2.Enabled = false;
            numericUpDown1.Value = 150;
            radioButton1.Enabled = radioButton2.Enabled = radioButton3.Enabled = radioButton4.Enabled = false;
            button1.Click -= button1_Click;
        }

        public CopyAddRecordForm(int number)
        {
            InitializeComponent();
            label1.Text += num = number;
            comboBox1.Items.Add("ВАЗ");
            comboBox1.Items.Add("ТОЙОТА");
            comboBox1.Items.Add("ЛЕКСУС");

            comboBox3.Items.Add("Компания 1");
            comboBox3.Items.Add("ООО 2");
            comboBox3.Items.Add("ЗАО 3");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MainForm main = this.Owner as MainForm;
            string works = "";
            for (int i = 0; i < dataGridView1.RowCount - 1; i++)
                works += dataGridView1.Rows[i].Cells[0].Value.ToString() + " ";
            if (main != null)
                {
                    main.sum1 += int.Parse(textBox3.Text);
                    main.label7.Text = (int.Parse(main.label7.Text) + int.Parse(textBox3.Text)).ToString();
                    main.label8.Text = (int.Parse(main.label8.Text) + int.Parse(textBox3.Text)).ToString();
                    main.dataGridView1.Rows.Add(num, System.DateTime.Now.ToString(),
                        (comboBox1.SelectedValue ?? comboBox1.Text) + " " + (comboBox2.SelectedValue ?? comboBox2.Text),
                        textBox1.Text, textBox3.Text, works);
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
                textBox2.Text = "";
                comboBox2.Items.Add("2107");
                comboBox2.Items.Add("21099");
                comboBox2.Items.Add("2112");
            }
            else if (comboBox1.SelectedItem.ToString() == "ТОЙОТА")
            {
                comboBox2.Items.Clear();
                textBox2.Text = "";
                comboBox2.Items.Add("КАМРИ");
                comboBox2.Items.Add("КОРОЛЛА");
            }
            else if (comboBox1.SelectedItem.ToString() == "ЛЕКСУС")
            {
                comboBox2.Items.Clear();
                textBox2.Text = "";
                comboBox2.Items.Add("RX-300");
            }
            else if (comboBox1.SelectedItem.ToString() == "КРАЗ")
            {
                comboBox2.Items.Clear();
                textBox2.Text = "";
                comboBox2.Items.Add("6510");
                comboBox2.Items.Add("65053");
            }
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem == null || comboBox2.SelectedItem == null)
                return;
            if (comboBox1.SelectedItem.ToString() == "ВАЗ" && comboBox2.SelectedItem != null)
            {
                textBox2.Text = "Категория 1";
                textBox2.Enabled = false;
            }
            else if (comboBox1.SelectedItem.ToString() == "ТОЙОТА" && comboBox2.SelectedItem != null)
            {
                textBox2.Text = "Категория 2";
                textBox2.Enabled = false;
            }
            else if (comboBox2.SelectedItem.ToString() == "RX-300")
            {
                textBox2.Text = "Категория 3";
                textBox2.Enabled = false;
            }
            else if (comboBox1.SelectedItem.ToString() == "КРАЗ" && comboBox2.SelectedItem != null)
            {
                textBox2.Text = "Грузовой";
                textBox2.Enabled = false;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            WorkTableForm form = new WorkTableForm();
            form.Owner = this;
            form.Show();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (textBox1.Text == "111")
            {
                textBox4.Text = "Фамилия 1";
                discount = 0.95F;
                textBox3.Text = (_sum * discount).ToString();
                label10.Text = "Скидка: 5%";
                label10.Visible = true;
            }
            else if (textBox1.Text == "222")
            {
                textBox4.Text = "Фамилия 2";
                discount = 0.93F;
                textBox3.Text = (_sum * discount).ToString();
                label10.Text = "Скидка: 7%";
                label10.Visible = true;
            }
            else
            {
                textBox4.Text = "";
                discount = 1.0F;
                textBox3.Text = (_sum * discount).ToString();
                label10.Visible = false;
            }

        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                label9.Visible = true;
                label17.Visible = false;
                comboBox3.Visible = false;
                textBox4.Visible = true;
                button2.Text = "Прайс";
                button2.ForeColor = Color.Black;
                panel3.Visible = false;
                panel6.Visible = true;
            }
            else
            {
                label9.Visible = false;
                label17.Visible = true;
                comboBox3.Visible = true;
                textBox4.Visible = false;
                button2.Text = "Их прайс";
                button2.ForeColor = Color.Purple;
                panel3.Visible = true;
                panel6.Visible = false;
            }
        }

        private void comboBox1_TextChanged(object sender, EventArgs e)
        {
            textBox2.Text = "";
            textBox2.Enabled = true;
        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            comboBox1.SelectedIndex = comboBox1.SelectedIndex = -1;
            textBox2.Text = "";
            if (radioButton3.Checked)
            {
                comboBox1.Items.Clear();
                comboBox1.Items.Add("ВАЗ");
                comboBox1.Items.Add("ТОЙОТА");
                comboBox1.Items.Add("ЛЕКСУС");
                numericUpDown1.Value = numericUpDown2.Value = numericUpDown3.Value = 0;
            }
            else
            {
                comboBox1.Items.Clear();
                comboBox1.Items.Add("КРАЗ");
                numericUpDown1.Value = numericUpDown2.Value = numericUpDown3.Value = 0;
            }
        }

        private void dataGridView1_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            sum(-_sum);
            for (int i = 0; i < dataGridView1.RowCount - 1; i++)
                sum(int.Parse(dataGridView1.Rows[i].Cells[1].Value.ToString()) * int.Parse(dataGridView1.Rows[i].Cells[2].Value.ToString()));
        }

    }
}
