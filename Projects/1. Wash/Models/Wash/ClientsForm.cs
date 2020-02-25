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
    public partial class ClientsForm : Form
    {
        public ClientsForm()
        {
            InitializeComponent();
            dataGridView1.Rows.Add("Клиент 1", "А112АО174", "7%");
            dataGridView1.Rows.Add("Клиент 2", "Р834ВН74", "5%");
            dataGridView1.Rows.Add("Клиент 3", "С900СТ66", "5%");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            AddClientForm form = new AddClientForm();
            form.Owner = this;
            form.Show();
        }
    }
}
