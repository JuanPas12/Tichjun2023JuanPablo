using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Dynamic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MenuGeneral
{
    internal class Poliza
    {
        public static PolizaResultado Calcular(DateTime fechaInicio, string periodo, int cantidadPeriodos, decimal sumaAsegurada, DateTime fechaNacimiento, string genero)
        {
            //Creamos nuestro objeto PolizaResultado
            PolizaResultado poliza = new PolizaResultado();

            //Creamos la variable fechaFin
            DateTime fechaFin = Convert.ToDateTime("2000-01-01");

            //Añadimos años,  meses o dias dependiendo de lo elegido por el usuario
            if (periodo == "años" || periodo == "año")
            {
                fechaFin = fechaInicio.AddYears(cantidadPeriodos);
                
            }else if(periodo == "meses" || periodo == "mes")
            {
                fechaFin = fechaInicio.AddMonths(cantidadPeriodos);
            }else if(periodo == "dias" || periodo == "dia")
            {
                fechaFin = fechaInicio.AddDays(cantidadPeriodos);
            }
            /*----------------------------------------------------------------------------*/

            //Extraemos las fechas de diferencia
            TimeSpan diferencia = fechaFin.Subtract(fechaInicio);

            //Extraemos los dias de diferencia y los alamcenamos en una variable
            int dias = diferencia.Days;

            //Edad
            int edad = fechaInicio.Year - fechaNacimiento.Year;

            //0 = Femenino
            //1 = Masculino
            decimal[,] factor = new decimal[,]
            {
                {0, 20, 0, 0.05m },
                {21, 30, 0, 0.1m },
                {31, 40, 0, 0.4m },
                {41, 50, 0, 0.5m },
                {51, 60, 0, 0.65m },
                {61, 100, 0, 0.85m },
                {0, 20, 1, 0.05m },
                {21,30, 1, 0.1m },
                {31, 40, 1, 0.4m },
                {41, 50, 1, 0.55m },
                {51, 60, 1, 0.7m },
                {61, 100, 1, 0.9m }
            };

            //Convertimos el genero a un numero entero
            int gen = 0;
            if (genero == "Masculino" || genero == "masculino")
            {
                gen = 1;
            }else if (genero == "Femenino" || genero == "femenino")
            {
                gen = 0;
            }

            decimal factorReal = 0;
            for(int i = 0; i < factor.GetLength(0); i++)
            {
                if ((edad >= factor[i, 0] && edad <= factor[i, 1]) && (factor[i, 2] == gen))
                {
                    factorReal = factor[i, 3];
                }
            }

            poliza.prima = (sumaAsegurada * factorReal) * (dias / 360m);
            poliza.fechaTermino = fechaFin;
            return poliza;
        }

        public static void Presentacion()
        {
            //Obtener fecha de inicio
            Console.WriteLine("Proporciona la fecha de inicio de Vigencia en formato 'yyyy-MM-dd'");
            DateTime fechaInicio = Convert.ToDateTime(Console.ReadLine());

            //Obtener periodo de poliza
            Console.WriteLine("Proporciona por cuanto tiempo quiere la poliza (ejemplo 2 años)");
            string tiempoPoliza = Console.ReadLine();
            tiempoPoliza = tiempoPoliza.Trim();
            string[] arregloTiempoPoliza = tiempoPoliza.Split(' ');
            int cantidadPeriodo = Convert.ToInt32(arregloTiempoPoliza[0]);
            string periodo = arregloTiempoPoliza[1];

            //Obtener la suma asegurada
            Console.WriteLine("Proporciona la suma asegrada");
            decimal sumaAsegurada = Convert.ToDecimal(Console.ReadLine());

            //Obtener fecha de nacimiento
            Console.WriteLine("Proporciona la fecha de nacimiento en formato 'yyyy-MM-dd'");
            DateTime fechaNacimiento = Convert.ToDateTime(Console.ReadLine());

            //Obtener genero
            Console.WriteLine("Proporciona tu genero (Masculino o Femenino)");
            string genero = Console.ReadLine();
            
            //Enviar datos a metodo
            PolizaResultado polizaResultado = new PolizaResultado();
            polizaResultado = Calcular(fechaInicio, periodo, cantidadPeriodo, sumaAsegurada, fechaNacimiento, genero);
            Console.WriteLine($"La Póliza vencerá el {polizaResultado.fechaTermino.ToString("D")} \n" +
                $"La prima a pagar es de {Math.Round(polizaResultado.prima).ToString("C")} pesos");
        }
    }
}
