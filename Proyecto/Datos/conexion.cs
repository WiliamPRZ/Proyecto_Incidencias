using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;


namespace Datos
{
    public class conexion
    {
        public static SqlException ESalida;
        public static SqlConnection ConectaBD(String strConec)
        {

            SqlConnection conn = new SqlConnection(strConec);
            try
            {
                conn.Open();
            }
            catch (SqlException ex)
            {

                ESalida = ex;
                return null;
            }

            return conn;
        }

        public static SqlConnection ObtenerConexion()
        {
            SqlConnection conn;
            try
            {
                conn = ConectaBD(StringCon());

            }
            catch (Exception ex)
            {
                conn = null;
                throw ex;
            }

            return conn;
        }

        public static string StringCon()
        {
            string conn = "";
            try
            {
                conn = "Data Source=DESKTOP-56GDEAT\\SQLEXPRESS;Initial Catalog=incidencias;Integrated Security=True;Encrypt=False";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return conn;
        }

    }
}
