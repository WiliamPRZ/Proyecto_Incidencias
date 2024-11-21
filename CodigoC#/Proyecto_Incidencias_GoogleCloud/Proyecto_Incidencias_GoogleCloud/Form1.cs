using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Proyecto_Incidencias_GoogleCloud
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnInicio_Click(object sender, EventArgs e)
        {
            usuario admin = new usuario();

            string usuario = txtusuario.Text.ToString();
            string contra = txtcontra.Text;
            admin.Show();
            this.Hide();
        }

        private void txtcontra_KeyPress(object sender, KeyPressEventArgs e)
        {
            // Permite la tecla de retroceso (para borrar)
            if (Char.IsControl(e.KeyChar))
            {
                return;
            }

            // Verifica si el carácter ingresado no es un número
            if (!Char.IsLetterOrDigit(e.KeyChar))
            {
                e.Handled = true; // Cancela el ingreso de la tecla no permitida
            }
            else
            {
                e.Handled = true;
                txtcontra.Text = txtcontra.Text + "*";
            }
        }
    }
}
