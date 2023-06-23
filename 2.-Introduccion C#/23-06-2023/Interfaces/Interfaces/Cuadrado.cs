using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//3. Crear la clase Cuadrado que implemente la interfaz IFigura 
namespace Interfaces
{
    internal class Cuadrado : IFigura
    {
        public Cuadrado() { }
        public Cuadrado(string nombre, decimal lado)
        {
            this.nombre = nombre;
            this.lado = lado;
        }
        public string nombre { get; set; }
        public decimal lado { get; set; }

        public decimal Area()
        {
            return Convert.ToDecimal(Math.Pow((double)lado, 2));
        }

        public decimal Perimetro()
        {
            return lado * 4;
        }
    }
}
