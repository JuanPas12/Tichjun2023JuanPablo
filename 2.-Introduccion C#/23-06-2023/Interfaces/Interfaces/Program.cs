using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//1. Crear la aplicación de consola llamada Interfaces 
namespace Interfaces
{
    internal class Program
    {
        static void Main(string[] args)
        {
            /*5. En el método Main, de la clase program, cree un arreglo de longitud 2 con objetos 
                de tipo IFigura. */
            IFigura[] arregloFiguras = new IFigura[]
            {
                //6. Inicialicé el arreglo con un objeto de tipo Cuadrado y otro de tipo Triangulo;  
                new Triangulo("Triangulo", 2.89m, 9.54m), new Cuadrado("Cuadrado", 5.2m)
            };

            /*7. Usando un ciclo foreach calcule el área para los objetos contenidos en el arreglo, 
            mostrando los cálculos obtenidos en la consola. */
            foreach (var figuras in arregloFiguras)
            {
                Console.WriteLine($"Figura: {figuras.nombre}\n" +
                    $"Area: {figuras.Area()}\n" +
                    $"Perimetro: {figuras.Perimetro()}\n");
            }
        }
    }
}
