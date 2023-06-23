using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MenuGeneral
{
    internal class Program
    {
        static void Main(string[] args)
        {
            /*a) En el método Main de la clase Program del poyecto MenuGeneral, crear 
el          siguiente Menu: */
            string leerConsola = "";
            while ( !(leerConsola == "F" || leerConsola == "f"))
            {
                Console.WriteLine("MENU GENERAL \n" +
                    "1.- Cadenas \n" +
                    "2.- Enteros \n" +
                    "3.- ConvierteATipoOracion \n" +
                    "4.- Póliza \n" +
                    "5.- Archivos \n" +
                    "6.- Escribir Archivo txt \n" +
                    "7.- Calcular ISR \n" +
                    "8.- Opcion 8 \n" +
                    "F.- Termina \n");
                leerConsola = Console.ReadLine();
                Console.Clear();
                switch (leerConsola)
                {
                    case "1":
                        Console.WriteLine("Usted seleccionó la opción Cadenas");
                        Arreglos.Cadenas();
                        Console.WriteLine("---------------------------------------------------");
                        break;
                    case "2":
                        Console.WriteLine("Usted seleccionó la opción Enteros");
                        Arreglos.Enteros();
                        Console.WriteLine("---------------------------------------------------");
                        break;
                    case "3":
                        Console.WriteLine("Usted seleccionó la opción ConvierteATipoOracion");
                        Console.WriteLine("Ingresa tu oracion");
                        string oracion = Arreglos.ConvierteATipoOracion(Console.ReadLine());
                        Console.WriteLine(oracion);
                        Console.WriteLine("---------------------------------------------------");
                        break;
                    case "4":
                        Console.WriteLine("Usted seleccionó la opción Póliza");
                        Poliza.Presentacion();
                        Console.WriteLine("---------------------------------------------------");
                        break;
                    case "5":
                        Console.WriteLine("Usted seleccionó la opción Archivos");
                        Archivotxt.Presentacion();
                        Console.WriteLine("---------------------------------------------------");
                        break;
                    case "6":
                        Console.WriteLine("Usted seleccionó la opción Escribir Archivo txt");
                        Console.WriteLine("Ingresa la ruta del archivo");
                        string ruta = Console.ReadLine();
                        Console.WriteLine("¿El archivo ya existe o se va a crear? \n 1.- Existe \n 2.- Se va a crear");
                        byte est = Convert.ToByte(Console.ReadLine());
                        bool estatus;
                        if (est == 1)
                        {
                            estatus = true;
                            Archivotxt.EscribirTxt(ruta, estatus);
                        }
                        else
                        {
                            estatus = false;
                            Console.WriteLine("Elige el tipo de codificación \n 1.- UTF7 \n 2.- UTF8 \n 3.- Unicode \n 4.- UTF32 \n 5.- ASCII");
                            byte codificacion = Convert.ToByte(Console.ReadLine());
                            Archivotxt.EscribirTxt(ruta, estatus, codificacion);
                        }
                        Console.WriteLine("---------------------------------------------------");
                        break;
                    case "7":
                        Console.WriteLine("Usted seleccionó la opción Calcular ISR");
                        ISR.Presentacion();
                        Console.WriteLine("---------------------------------------------------");
                        break;
                    case "8":
                        Console.WriteLine("Usted seleccionó la opción 8");
                        Console.WriteLine("---------------------------------------------------");
                        break;
                    case "F":
                    case "f":
                        Console.WriteLine("Hasta luego :D");
                        break;
                    default:
                        Console.WriteLine("Opción invalida, porfavor verifique que este escogiendo una opción existente de el menú");
                        break;
                }
            }
    }
}
}
