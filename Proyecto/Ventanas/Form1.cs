using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Datos;

namespace Ventanas
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnInicio_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtcontra.Text) || String.IsNullOrEmpty(txtusuario.Text))
            {
                MessageBox.Show("Algunos de los campos se encuentra vacio.");
            }
            else
            {
                
            }
        }
    }
}
