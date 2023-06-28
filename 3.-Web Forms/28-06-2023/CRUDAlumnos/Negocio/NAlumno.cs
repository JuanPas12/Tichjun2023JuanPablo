using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Datos;
using Entidades;

namespace Negocio
{
    public class NAlumno
    {
        DAlumno a = new DAlumno();
        
        public List<Alumno> Consultar()
        {
            return a.Consultar();
        }

        public Alumno Consultar(int id)
        {
            return a.Consutar(id);
        }

        public void Agregar(Alumno al)
        {
            a.Agregar(al);
        }

        public void Actualizar(Alumno al)
        {
            a.Actualizar(al);
        }

        public void Eliminar(int id)
        {
            a.Eliminar(id);
        }
    }
}
