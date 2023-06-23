//Referencias a DLL's
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
///////////////////////////////////////
// Espacios de nombres, todo se maneja por esto
namespace HolaMundo
{ 
        // Clase con modificador de acceso interno, clase y nombre de clase
    internal class Program
    {
        //Modificador de acceso estatico, valor de retorno void, metodo main, parametros
        static void Main(string[] args)
        {
            string nombre;

            //Mostrar un mensaje por consola
            Console.WriteLine("¿Cual es tu nombre?");
            //Leer escritura de usuario
            nombre = Console.ReadLine();

            //Console.WriteLine("Hola, ¿Como estas " +  nombre + "?");

            //Invocar un metodo estatico. Tipo clase.

            string retornoMetodo = Saludo.SaludarEstatico(nombre);
            Console.WriteLine(retornoMetodo);   

            //Invocar un metodo no estatico. Tipo objeto.
            //Se debe instanciar la clase
            Saludo objetoSaludo = new Saludo();
            Console.WriteLine(objetoSaludo.Saludar(nombre));

            Console.ReadKey();

            
        }
    }
}
