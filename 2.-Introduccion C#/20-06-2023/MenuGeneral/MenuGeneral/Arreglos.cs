using System;
using System.Collections.Generic;
using System.IO.IsolatedStorage;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

/*a) Crear la Clase Arreglos, dentro de ella crear el método estático Cadenas, el 
cual deberá tener la siguiente Interacción */
namespace MenuGeneral
{
    internal class Arreglos
    {
        public static void Cadenas()
        {
            Console.WriteLine("¿Cuantos nombres tienes?");
            byte nNombres = Convert.ToByte(Console.ReadLine());
            Console.WriteLine("Porporciona tu nombre completo");
            string nombre = Console.ReadLine();

            //Separamos el nombre introducido y lo gurdamos en un arrelgo

            string[] partesNombre = nombre.Split(' ');
            Console.WriteLine("");
            Console.WriteLine("Hola");
            for (int i = 0; i < partesNombre.Length; i++)
            {
                Console.WriteLine($"{partesNombre[i]}");
            }

            //Apellido vertical
            Console.WriteLine("");
            Console.WriteLine("Apellido Vertical");
            if (nNombres == 1 ) {
                string apellido = partesNombre[1];
                for (int i = 0; i < apellido.Length; i++)
                {
                    Console.WriteLine(apellido[i]);
                }
            }else if (nNombres == 2 )
            {
                string apellido = partesNombre[2];
                for (int i = 0; i < apellido.Length; i++)
                {
                    Console.WriteLine(apellido[i]);
                }
            }
        }

        /*b) Crear el método estático Enteros en la clase Arreglos, el cual deberá 
        solicitar 5 números enteros y determinar cual número es el que tiene el 
        valor máximo */

        public static void Enteros()
        {
            int[] arregloNumero =  new int[5];
            Console.WriteLine("Ingresa el primer numero");
            arregloNumero[0] = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Ingresa el segundo numero");
            arregloNumero[1] = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Ingresa el tercer numero");
            arregloNumero[2] = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Ingresa el cuarto numero");
            arregloNumero[3] = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Ingresa el quinto numero");
            arregloNumero[4] = Convert.ToInt32(Console.ReadLine());

            for (int i = 0; i < arregloNumero.Length - 1; i++)
            {
                for (int j = 0; j < arregloNumero.Length - i - 1; j++)
                {
                    if (arregloNumero[j] > arregloNumero[j + 1])
                    {
                        int temp = arregloNumero[j];
                        arregloNumero[j] = arregloNumero[j + 1];
                        arregloNumero[j + 1] = temp;
                    }
                }
            }
            Console.WriteLine($"El número mayor es: {arregloNumero[arregloNumero.Length - 1]}");
            Console.WriteLine($"El número menor es: {arregloNumero[0]}");
        }

        /*c) En la Clase Arreglos  crear un método estático ConvierteATipoOracion que 
        tome como parámetro un string y regrese otro string habiendo colocado la 
        rimera letra de cada palabra en mayúscula. */

        public static string ConvierteATipoOracion (string cadena)
        {
            cadena = cadena.Trim();
            string[] partesCadena = cadena.Split(' ');
            string temp;
            for (int i = 0; i < partesCadena.Length; i++)
            {
                temp = partesCadena[i].Substring(0, 1);
                temp = temp.ToUpper();
                temp = temp + (partesCadena[i].Substring(1, (partesCadena[i].Length - 1))).ToLower();
                partesCadena[i] = temp;
            }
            return String.Join(" ", partesCadena);
        }
    }
}
