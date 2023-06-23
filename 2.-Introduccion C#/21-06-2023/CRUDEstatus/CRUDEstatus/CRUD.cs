using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDEstatus
{
    public class CRUD
    {
        public static List<EstatusAlumnos> _listaEstatusAlumnos = new List<EstatusAlumnos>();

        //Consultar todo
        public static List<EstatusAlumnos> ConsultarTodo()
        {
            return _listaEstatusAlumnos;
        }

        //Consultar Uno
        public static EstatusAlumnos ConsultarUno(int id)
        {
            EstatusAlumnos busqueda;
            busqueda  = _listaEstatusAlumnos.Find(x => x.id == id);
            return busqueda;
        }

        //Agregar
        public static void Agregar(EstatusAlumnos estatus)
        {
            _listaEstatusAlumnos.Add(estatus);
        }

        //Actualizar
        public static void Actualizar(int id, EstatusAlumnos estatus, int o)
        {
            EstatusAlumnos EA = _listaEstatusAlumnos.Find(ea => ea.id == id);
            switch (o)
            {
                case 1:
                    EA.clave = estatus.clave;
                    break;
                case 2:
                    EA.nombre = estatus.nombre;
                    break;
                case 3:
                    EA.clave = estatus.clave;
                    EA.nombre = estatus.nombre;
                    break;
            }
        }

        //Eliminar
        public static void Eliminar(int id)
        {
            _listaEstatusAlumnos.RemoveAll(ea => ea.id == id);
        }
    }
}
