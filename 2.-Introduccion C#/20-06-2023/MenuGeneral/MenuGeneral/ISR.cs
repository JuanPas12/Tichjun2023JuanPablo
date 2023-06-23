using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MenuGeneral
{
    internal class ISR
    {

        /*2) En la clase ISR, crear el método CargarTabla el cual recibirá el nombre del 
        archivo que contiene los datos correspondientes para cargarla en un 
        arreglo con la Tabla del ISR */

        static decimal[,] _TablaISR = new decimal[21, 5];
        public static void CargarTabla(string ruta)
        {
            StreamReader streamReader = new StreamReader(ruta);
            
            string[] s;
            string sTemp;
            for(int i = 0; i < _TablaISR.GetLength(0); i++)
            {
                sTemp = streamReader.ReadLine();
                s = sTemp.Split(',');
                for (int j = 0; j < _TablaISR.GetLength(1); j++)
                {
                    _TablaISR[i, j] = Convert.ToDecimal(s[j]);
                }
            }

        }

        /*3) En la clase ISR, crear  el método llamado Calcular, el cual recibirá como 
        parámetro impuesto el Sueldo Mensual, con base en cual calculará el ISR 
        quincenal a pagar, regresando el ISR calculado, bajo el “Procedimiento del 
        Calculo del ISR” . */

        private static decimal Calcular(decimal sueldoMensual)
        {
            decimal isr = 0;
            decimal limInf, limSup;
            decimal sueldoQuincenal = sueldoMensual / 2;
            for (int i = 0; i < _TablaISR.GetLength(0); i++)
            {
                limInf = _TablaISR[i, 0];    
                limSup = _TablaISR[i, 1];
                if (sueldoQuincenal >= limInf && sueldoQuincenal <= limSup)
                {
                    isr = sueldoQuincenal - limInf;
                    isr = isr * (_TablaISR[i, 3]/ 100);
                    isr = (isr + _TablaISR[i, 2]) - _TablaISR[i, 4];
                }
            }
            return isr;
        }

        /*4) Crear el método presentación el tendrá la siguiente interacción con el 
        usuario: 
            i. Solicitar el nombre del archivo que contiene la tabla del ISR 
            ii. Invocar al método CargarTablaISR 
            iii. Solicitar el sueldo mensual 
            iv. Invocar al método Calcular 
            v. Mostrar el ISR a pagar */

        public static void Presentacion()
        {
            // i.
            Console.WriteLine("Proporciona la ruta de la tabla");
            string ruta = Console.ReadLine();

            // ii.
            CargarTabla(ruta);
            
            // iii.
            Console.WriteLine("Proporcione su salario mensual");
            decimal salarioMensual = Convert.ToDecimal(Console.ReadLine());

            // iv & v.
            Console.WriteLine($"ISR a pagar: {Calcular(salarioMensual).ToString("C")}");

        }
    }
}
