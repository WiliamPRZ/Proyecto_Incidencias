using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clases
{
    public class Incidencia
    {
        public int IdUsuarioReport { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public int IdError { get; set; }
        public int IdEstado { get; set; }
        public int IdSistema { get; set; }

        // Constructor
        public Incidencia(int idUsuarioReport, string titulo, string descripcion,  int idError, int idEstado, int idSistema)
        {
            IdUsuarioReport = idUsuarioReport;
            Titulo = titulo;
            Descripcion = descripcion;
            IdError = idError;
            IdEstado = idEstado;
            IdSistema = idSistema;
        }


    }
}
