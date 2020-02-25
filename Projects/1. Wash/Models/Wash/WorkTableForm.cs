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
    public partial class WorkTableForm : Form
    {
        public object[] row;
        public int summ;

        public WorkTableForm()
        {
            InitializeComponent();

            dataGridView1.Rows.Add(new object[] { false, "1.1. Экспресс-мойка", 130 });
            dataGridView1.Rows.Add(new object[] { false, "1.3. Мойка бесконтактная", 190 });
            dataGridView1.Rows.Add(new object[] { false, "2.1. Влажная уборка салона", 220 });
            dataGridView1.Rows.Add(new object[] { false, "2.3. Пылесос салона", 190 });
            dataGridView1.Rows.Add(new object[] { false, "2.4. Чистка стекол", 150 });
            dataGridView1.Rows.Add(new object[] { false, "2.7. Полировка пластика салона", 200 });
        }

        private void button1_Click(object sender, EventArgs e)
        {
            List<object[]> list = new List<object[]>();
            CopyAddRecordForm main = this.Owner as CopyAddRecordForm;
            if (main != null)
                for (int i = 0; i < dataGridView1.RowCount - 1; i++)
                    if (Boolean.Parse(dataGridView1.Rows[i].Cells[0].Value.ToString().Trim()))
                    {
                        main.sum(int.Parse(dataGridView1.Rows[i].Cells[2].Value.ToString()));
                        main.dataGridView1.Rows.Add(new object[] {dataGridView1.Rows[i].Cells[1].Value.ToString(), dataGridView1.Rows[i].Cells[2].Value.ToString(), 1 });
                    }
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            CustomWorkForm form = new CustomWorkForm();
            form.Owner = this;
            this.Hide();
            form.Show();
        }

        private void WorkTableForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            CopyAddRecordForm main = this.Owner as CopyAddRecordForm;
            if (main != null && row != null && summ != 0)
            {
                main.dataGridView1.Rows.Add(row);
                main.sum(summ);
            }
        }

    }
}
