using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntroduccionCS
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string nombre;
            string ap;
            string am;
            byte edad;

            //Obtener el nombre
            Console.WriteLine("Proporciona tu nombre");
            nombre = Console.ReadLine();

            //Obtener el apellido paterno
            Console.WriteLine("Poroporciona tu primer apellido");
            ap = Console.ReadLine();

            //Obtener el apellido materno
            Console.WriteLine("Proporciona tu segundo apellido");
            am = Console.ReadLine();

            //Obtener la edad
            Console.WriteLine("Proporciona tu edad");
            edad = Convert.ToByte(Console.ReadLine());

            Console.WriteLine(Cadenas.HolaMundo(nombre, ap, am, edad));
        }
    }
}
