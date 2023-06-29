using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//Crear la clase CalculadoraIMSS 
namespace IMSS
{
    internal class CalculadoraIMSS
    {
        /*d) Crear un método estático Calcular el cual calcule las siguientes 
        aportaciones, recibiendo el Salario Base de Cotización (SBC), la Unidad de 
        Medida de Actualización (UMA), y un indicador de  si es Patrón o 
        Trabajador. El método deberá hacer los siguientes cálculos, con base en los 
        parámetros recibidos y regresar los resultados en la Estructura 
        Aportaciones */
        public static Aportaciones Calcular(decimal SBC, decimal UMA, byte puesto)
        {
            Aportaciones A = new Aportaciones();
            if (puesto == 1)
            {
                A.EnfermedadMaternidad = ((SBC - (3 * UMA)) / 100) * 1.1m;
                A.InvalidezVida = (SBC / 100) * 1.75m;
                A.Retiro = (SBC / 100) * 2m;
                A.Cesantia = (SBC / 100) * 3.150m;
                A.Infonavit = (SBC / 100) * 5;
            }
            else if (puesto == 2)
            {
                A.EnfermedadMaternidad = ((SBC - (3 * UMA)) / 100) * 0.4m;
                A.InvalidezVida = (SBC / 100) * 0.625m;
                A.Retiro = 0;
                A.Cesantia = (SBC / 100) * 1.125m;
                A.Infonavit = 0;
            }
            return A;
        }

        /*e) Crear el Método estático Presentación, el cual solicitará al usuario el 
        Salario Base de Cotización, la Unidad de Medida de Actualización, y el 
        indicador de, si, el cálculo se requiere para el Patrón o para el Trabajador, 
        con ello llamar al método Calcular, y mostrar los resultados, así como el 
        total */

        public static void Presentacion()
        {
            Console.WriteLine("Ingresa el Salario Base de Cotización (SBC)");
            decimal SBC = Convert.ToDecimal(Console.ReadLine());
            Console.WriteLine("Ingresa la Unidad de Medida de Actualización (UMAS)");
            decimal UMAS = Convert.ToDecimal(Console.ReadLine());
            Console.WriteLine("Elige el puesto de trabajo: \n 1.- Patrón \n 2.- Trabajador");
            byte puesto = Convert.ToByte(Console.ReadLine());

            Aportaciones aportaciones = new Aportaciones();
            aportaciones = Calcular(SBC, UMAS, puesto);
            Console.WriteLine($"Enfermedades y Maternidad: {aportaciones.EnfermedadMaternidad} \n " +
                $"Invalidez y Vida: {aportaciones.InvalidezVida} \n Retiro: {aportaciones.Retiro} \n" +
                $"Cesantia: {aportaciones.Cesantia} \n Credito Infonavit: {aportaciones.Infonavit}");
        }
    }
}