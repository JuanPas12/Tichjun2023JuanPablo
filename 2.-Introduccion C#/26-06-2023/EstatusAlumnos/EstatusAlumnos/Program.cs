using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EstatusAlumnos
{
    internal class Program
    {
        static void Main(string[] args)
        {
            ADOEstatus ad = new ADOEstatus();
            Estatus est = new Estatus();
            est.id = 110;
            est.clave = "FND";
            est.nombre = "Fracasando";
            ad.Actualizar(est);
        }
    }
}
