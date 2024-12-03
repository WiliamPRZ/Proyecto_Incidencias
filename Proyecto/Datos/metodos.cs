using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class metodos
    {
        public static string InicioSesion(int id)
        {
            string rpta = "";

            SqlConnection conn = null;
            try
            {
                conn = conexion.ObtenerConexion();
                SqlCommand comando = new SqlCommand("InicioSesion", conn);
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@idUsuario", id);
            }
            return "";
        }
    }

}
