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
    public partial class ReportsForm : Form
    {
        public ReportsForm()
        {
            InitializeComponent();

            dataGridView1.Rows.Add(new object[] { 1, System.DateTime.Now.ToShortDateString() + " 14:00", "ВАЗ 2107", "У311ВР174", "Бесконтактная мойка", 160, 10, 150, 0, 0});
            dataGridView1.Rows.Add(new object[] { 2, System.DateTime.Now.ToShortDateString() + " 14:42", "LEXUS RX-300", "О119ОА174", "Мойка, коврики, уборка салона", 700, 0, 0, 700, 0 });
            dataGridView1.Rows.Add(new object[] { 3, System.DateTime.Now.ToShortDateString() + " 15:59", "МАЗ", "Х009ММ66", "Сбивка наледи", 600, 20, 580, 0, 0 });
            dataGridView1.Rows.Add(new object[] { 4, System.DateTime.Now.ToShortDateString() + " 16:23", "ГАЗель", "М497ТС74", "Мойка, уборка кабины", 900, 0, 500, 400, 0 });
        }
    }
}
