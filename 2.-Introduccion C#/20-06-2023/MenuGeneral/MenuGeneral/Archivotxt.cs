using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Pipes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MenuGeneral
{
    internal class Archivotxt
    {
        /*2. Leer Archivo txt 
        Crear el método MostrarTxt a fin de que muestre en pantalla todos los registros del 
        archivo cuyo nombre recibe como parámetro; */

        public static string MostrarTxt(string ruta)
        {
            string linea;
            StreamReader archivo = new StreamReader(@ruta);
            linea = archivo.ReadToEnd();
            return linea;
        }

        /*3. Leer  Archivocsv 
        Crear el método MostrarCSV a fin de que muestre en pantalla cada uno de los campos 
        por separados de cada uno de los registros del archivo cuyo nombre recibe como 
        parámetro; 
        3.1. Copiar los registros de la Tabla de Alumnos en una hoja de excel  
        3.2. Desde Excel crear el archivo Alumnos.cvs en formato cvs 
        3.3. En la clase ArchivoTxt, crear el método estático MostrarCSV, el cual recibirá como 
        parámetro el nombre (incluyendo la ruta) del archivo a leer, y deberá  mostrar por 
        pantalla una línea por cada dato 
        3.4. Incluir la opción “Mostrar ArchivoCSV” correspondiente, en el método Main de la 
        Clase Program, desde el cual solicitará al usuario el archivo a leer e invocará al 
        método MostrarCSV de la clase ArchivoTxt */

        public static string Mostrarcsv(string ruta)
        {
            string linea;
            StreamReader archivo = new StreamReader(@ruta);
            linea = archivo.ReadToEnd();
            return linea;
        }

        /*4. Presentación 
        Crear el método Presentación el cual tendrá la siguiente interacción con el usuario 
        4.1. Solicitar el nombre del archivo txt  que requiere que se muestren en pantalla todos sus registros; 
        4.2. Invocar al método MostarTxT 
        4.3. Solicitar el nombre del archivo CSV  que requiere que se muestren en pantalla todos los datos de cada uno de los registros que contiene; 
        4.4. Invocar al método MostarCSV 
        4.5. Incluir la opción “Mostrar Archivo Txt” correspondiente, en el método Main de la Clase Program, desde el cual solicitará al usuario el archivo a leer e invocará al método Mostrar de la clase ArchivoTxt 
        Invocar el método Presentación de la clase ArchivoTxt, cuando se seleccione la Opción  5 del Menu General. */

        public static void Presentacion()
        {
            Console.WriteLine("Ingrese la ruta del archivo TXT");
            string rutaTXT = Console.ReadLine();
            Console.WriteLine(MostrarTxt(rutaTXT));
            Console.WriteLine("\n --------------------------------------------------------------------------- \n");
            Console.WriteLine("Ingrese la ruta del archivo CSV");
            string rutaCSV = Console.ReadLine();
            Console.WriteLine(Mostrarcsv(rutaCSV));
        }

        /*1. Escribir  Archivo txt 
        1.1. En la clase ArchivoTxt, crear el método EscribirTxt que reciba como 
        parámetro el nombre (incluyendo la ruta) del archivo a escribir, y un 
        parámetro booleno que indique si será nuevo o se adicionaran registros, 
        asimismo indique en que código se quiere escribir (UTF7,UTF8,Unicod, 
        UTF32,ASCII) 
        1.1.1. El método deberá solicitar el nombre, primer apellido y segundo apellido, 
        edad y estado del alumno de manera independiente, y lo deberá escribir en el 
        archivo en una sola línea separado por comas 
        1.1.2. Cada vez que se termine de procesar un alumno, deberá preguntar si 
        desea agregar un nuevo alumno, terminando el proceso hasta que el usuario 
        responda que no desea agregar otro registro. 
        1.1.3. Invocar el método ExcribirTXT de la clase ArchivoTxt, cuando se seleccione 
        la Opción  6 del Menu General. */

        public static void EscribirTxt (string ruta, bool estatus, int formato = 0)
        {
            //Obtenemos en que codificación se creara el archivo.
            Encoding codigo = Encoding.Default;
            switch (formato)
            {
                case 1:
                    codigo = Encoding.UTF7;
                    break;
                case 2:
                    codigo = Encoding.UTF8;
                    break;
                case 3:
                    codigo = Encoding.Unicode;
                    break;
                case 4:
                    codigo = Encoding.UTF32;
                    break;
                case 5:
                    codigo = Encoding.ASCII;
                    break;
                default:
                    codigo = Encoding.Default;
                    break;
            }

            //Comprobamos si el archivo ya existe.
            string ans = "Si";
            if (estatus == true)
            {
                //Si existe solo procedemos a añadir lineas, ya no se asigna la codificación.
                while (ans == "si" || ans == "Si")
                {
                    Console.WriteLine("Escribe el nombre");
                    string nombre = Console.ReadLine();

                    Console.WriteLine("Escribe el primer apellido");
                    string primerApellido = Console.ReadLine();

                    Console.WriteLine("Escribe el segundo apellido");
                    string segundoApellido = Console.ReadLine();

                    Console.WriteLine("Escribe la edad");
                    byte edad = Convert.ToByte(Console.ReadLine());

                    Console.WriteLine("Escribe tu estado de origen");
                    string estadoOrigen = Console.ReadLine();

                    StreamWriter archivo = new StreamWriter(ruta, estatus);
                    archivo.WriteLine($"{nombre}, {primerApellido}, {segundoApellido}, {edad}, {estadoOrigen}");
                    archivo.Close();
                    Console.WriteLine("Registro guardado correctamente, ¿Desea agregar otro registro?");
                    ans = Console.ReadLine();
                    Console.Clear();
                }
            }
            else
            {
                //Al no existir el archivo procedemos a crearlo y ahora si se le asigna una codificación
                while (ans == "si" || ans == "Si")
                {
                    Console.WriteLine("Escribe el nombre");
                    string nombre = Console.ReadLine();

                    Console.WriteLine("Escribe el primer apellido");
                    string primerApellido = Console.ReadLine();

                    Console.WriteLine("Escribe el segundo apellido");
                    string segundoApellido = Console.ReadLine();

                    Console.WriteLine("Escribe la edad");
                    byte edad = Convert.ToByte(Console.ReadLine());

                    Console.WriteLine("Escribe tu estado de origen");
                    string estadoOrigen = Console.ReadLine();

                    StreamWriter archivo = new StreamWriter(ruta, estatus, codigo);
                    archivo.WriteLine($"{nombre}, {primerApellido}, {segundoApellido}, {edad}, {estadoOrigen}");
                    archivo.Close();
                    estatus = true;
                    Console.WriteLine("Registro guardado correctamente, ¿Desea agregar otro registro?");
                    ans = Console.ReadLine();
                    Console.Clear();
                }
            }
        }
    }
}
