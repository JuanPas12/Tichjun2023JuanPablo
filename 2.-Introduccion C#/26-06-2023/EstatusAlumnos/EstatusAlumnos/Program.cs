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
            foreach (var a in ad.Consultar())
            {
                Console.WriteLine(a.nombre);
            }
        }
    }
}
