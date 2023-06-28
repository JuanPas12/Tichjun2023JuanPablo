using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Datos;
using Entidades;

namespace Negocio
{
    public class NEstatusAlumnos
    {
        DEstatusAlumno est = new DEstatusAlumno();
        
        public List<EstatusAlumnos> Consultar()
        {
            return est.Consultar();
        }

        public EstatusAlumnos Consultar(int id)
        {
            return est.Consultar(id);
        }
    }
}
