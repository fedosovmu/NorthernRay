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
    public partial class MainForm : Form
    {
        int count = 0, count2 = 0;
        public int sum1 = 2330, sum2 = 0;
        public List<string> record = new List<string>();
        
        public void takemoney(int sum)
        {
            label8.Text = (int.Parse(label8.Text) - sum).ToString();
        }

        public MainForm(string userName)
        {
            InitializeComponent();

            label2.Text += System.DateTime.Now.ToShortDateString();
            if (userName == "Руководитель")
            {
                button5.Visible = true;
                comboBox1.Visible = false;
                label3.Visible = false;
                спискиToolStripMenuItem.Enabled = true;
                отчётыToolStripMenuItem.Enabled = true;
            }
            comboBox1.Items.Add("[Не выбрано]");
            comboBox1.Items.Add("Администратор 1");
            comboBox1.Items.Add("Администратор 2");
            comboBox1.Items.Add("Администратор 3");
            comboBox1.SelectedIndex = 0;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                CopyAddRecordForm form = new CopyAddRecordForm(++count);
                form.Owner = this;
                form.Show();
            }
            else
            {
                AddRecord2Form form = new AddRecord2Form(++count2);
                form.Owner = this;
                form.Show();
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Вы действительно хотите удалить запись?", "Удаление", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
                if (MessageBox.Show("ЭТО ДЕЙСТВИЕ НЕОБРАТИМО! Подтвердите удаление.", "Подтверждение удаления", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning) == System.Windows.Forms.DialogResult.OK)
                    if (dataGridView1.SelectedRows.Count > 0)
                        dataGridView1.Rows.Remove(dataGridView1.SelectedRows[0]);
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex != 0)
                if (MessageBox.Show("Открыть смену под именем " + comboBox1.SelectedItem.ToString() + "?", "Открытие смены", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
                {
                    comboBox1.Visible = false;
                    label3.Text += comboBox1.SelectedItem.ToString();

                    dataGridView1.Rows.Add(new object[] { ++count, System.DateTime.Now.ToShortDateString() + " 14:00", "ВАЗ 2107", "У311ВР174", 150, "1.3.Бесконтактная мойка" });
                    dataGridView1.Rows.Add(new object[] { ++count, System.DateTime.Now.ToShortDateString() + " 14:42", "ЛЕКСУС RX-300", "О119ОА174", 700, "2.1. Влажная уборка салона, 1.3.Бесконтактная мойка, коврики" });
                    dataGridView1.Rows.Add(new object[] { ++count, System.DateTime.Now.ToShortDateString() + " 15:59", "МАЗ", "Х009ММ66", 580, "4.6.Сбивка наледи" });
                    dataGridView1.Rows.Add(new object[] { ++count, System.DateTime.Now.ToShortDateString() + " 16:23", "ГАЗель", "М497ТС74", 900, "1.3.Бесконтактная мойка, 3.2.уборка кабины" });
                    label7.Text = label8.Text = "2330";
                    button1.Enabled = button2.Enabled = radioButton1.Enabled = radioButton2.Enabled = true;
                    кассаToolStripMenuItem.Enabled = true;
                    отчётыToolStripMenuItem.Enabled = true;
                    отчетЗаСменуToolStripMenuItem.Enabled = false;
                    закрытьСменуToolStripMenuItem.Enabled = true;
                    обновитьToolStripMenuItem.Enabled = true;
                }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            UnconfirmedCarsForm form = new UnconfirmedCarsForm();
            form.Owner = this;
            form.Show();
        }


        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
            {
                dataGridView1.Visible = true;
                dataGridView2.Visible = false;
            }
            else
            {
                dataGridView1.Visible = false;
                dataGridView2.Visible = true;
            }
        }

        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            OpenShiftForm main = this.Owner as OpenShiftForm;
            if (main != null)
                main.Show();
            e.Cancel = true;
            this.Hide();
        }

        private void клиентыToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ClientsForm form = new ClientsForm();
            form.Show();
        }

        private void отчетЗаСменуToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ReportsForm form = new ReportsForm();
            form.Show();
        }

        private void снятиеНаличныхToolStripMenuItem_Click(object sender, EventArgs e)
        {
            TakeMoneyTableForm form = new TakeMoneyTableForm();
            form.Owner = this;
            form.Show();
        }

        private void настройкиToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DiscountControlForm form = new DiscountControlForm();
            form.Show();
        }

        private void закрытьСменуToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Вы действительно хотите закрыть смену?", "Закрытие смены", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
            {
                DayReport form = new DayReport(sum1, sum2, int.Parse(label8.Text));
                form.Owner = this;
                form.Show();
                this.Close();
            }
        }

        private void dataGridView1_CellMouseDoubleClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            CopyAddRecordForm form = new CopyAddRecordForm();
            form.Owner = this;
            form.Show();
        }

        private void внесениеНаличныхToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PutMoneyTableForm form = new PutMoneyTableForm();
            form.Owner = this;
            form.Show();
        }

        private void текущийОтчётToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DayReport form = new DayReport(2500, 700, 2800);
            form.Show();
        }


    }
}
