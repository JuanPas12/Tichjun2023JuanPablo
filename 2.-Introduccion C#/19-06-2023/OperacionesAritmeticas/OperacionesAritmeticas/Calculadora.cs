using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OperacionesAritmeticas
{
    internal class Calculadora
    {
        /*Crear la clase Calculadora con los siguientes métodos estáticos, sumar, 
        restar, multiplicar, dividir y módulo, tomando como parámetros dos 
        decimales y regresar el resultado. */
        public static decimal Suma(decimal n1, decimal n2)
        {
            return n1 * n2;
        }

        public static decimal Resta(decimal n1, decimal n2)
        {
            return n1 - n2;
        }

        public static decimal Multiplicar(decimal n1, decimal n2)
        {
            return n1 * n2;
        }

        public static decimal Dividir(decimal n1, decimal n2)
        {
            return n1 / n2;
        }

        public static decimal Modulo(decimal n1, decimal n2)
        {
            return n1 % n2;
        }

        /*e) Crear el método Operación, en la clase Calculadora, el cual recibirá una 
        variable de tipo OperacionAritmetica y realizará la operación indicada 
        regresando el resultado correspondiente. */

        public static decimal Operacion(OperacionAritmetica operacion)
        {
            if (operacion.oper == tipoOperacion.suma)
            {
                return operacion.n1 + operacion.n2;
            }
            else if (operacion.oper == tipoOperacion.resta)
            {
                return operacion.n1 - operacion.n2;
            }
            else if (operacion.oper == tipoOperacion.multiplicacion)
            {
                return operacion.n1 * operacion.n2;
            }
            else if (operacion.oper == tipoOperacion.division)
            {
                return operacion.n1 / operacion.n2;
            }
            else if (operacion.oper == tipoOperacion.modulo)
            {
                return operacion.n1 % operacion.n2;
            }
            else
            {
                return 0;
            }

        }

        /*g) En la clase Calculadora crear el método estático llamado Simultaneas, 
        el cual recibirá como parámetros dos datos tipo decimal y regresará un 
        parámetro de tipo (Resultado), con cada uno de los valores resultantes 
        de haber realizado la operación correspondiente. */

        public static Resultado Simultaneas(decimal n1, decimal n2)
        {
            Resultado resultado = new Resultado();
            resultado.suma = Suma(n1, n2);
            resultado.resta = Resta(n1, n2);
            resultado.multiplicacion = Multiplicar(n1, n2);
            resultado.division = Dividir(n1, n2);
            resultado.modulo = Modulo(n1, n2);
            return resultado;
        }

        /*h) Crear el Método estático Presentacion, el cual solicitará al usuario los 
        operandos y la operación a realizar, para finalmente mostrar el 
        resultado. */

        public static void Presentacion()
        {
            decimal n1, n2; 
            byte operacion;
            Console.WriteLine("Operación a Realizar \n 1.- Sumar \n 2.- Restar \n 3.- Multiplicar \n 4.- Dividir \n 5.- Módulo \n 6.- Todas");
            operacion = Convert.ToByte(Console.ReadLine());
            Console.WriteLine("Proporciona el primer numero");
            n1 = Convert.ToDecimal(Console.ReadLine());
            Console.WriteLine("Proporciona el segundo operador");
            n2 = Convert.ToDecimal(Console.ReadLine());
            //Creamos nuestro objeto y le asignamos sus valores
            OperacionAritmetica operacionAritmetica = new OperacionAritmetica();
            operacionAritmetica.n1 = n1;
            operacionAritmetica.n2 = n2;
            operacionAritmetica.oper = (tipoOperacion)operacion;
            /*------------------------------------------------------------------------*/
            //Console.WriteLine($"El resultado es: {Operacion(operacionAritmetica)}");
            switch (operacion)
            {
                case 1:
                    Console.WriteLine($"La suma es: {Operacion(operacionAritmetica)}");
                    break;
                case 2:
                    Console.WriteLine($"La resta es: {Operacion(operacionAritmetica)}");
                    break;
                case 3:
                    Console.WriteLine($"La multiplicación es: {Operacion(operacionAritmetica)}");
                    break;
                case 4:
                    Console.WriteLine($"La división es: {Operacion(operacionAritmetica)}");
                    break;
                case 5:
                    Console.WriteLine($"El modulo es: {Operacion(operacionAritmetica)}");
                    break;
                case 6:
                    Resultado res = new Resultado();
                    res = Simultaneas(n1, n2);
                    Console.WriteLine($"La suma es: {res.suma} \n La resta es: {res.resta} \n La multiplicación es: {res.multiplicacion} \n" +
                        $"La división es: {res.division} \n El modulo es: {res.modulo}");
                    break;
                default:
                    Console.WriteLine("Opción invalida");
                    break;
            }
        }
    }
}
