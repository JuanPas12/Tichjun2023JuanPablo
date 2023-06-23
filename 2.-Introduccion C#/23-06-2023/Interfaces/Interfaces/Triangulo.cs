using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*4. Crear  la clase Triangulo que implemente la interfaz IFigura. Se considerará que la 
clase corresponde a un triangulo isóceles. */
namespace Interfaces
{
    public class Triangulo : IFigura
    {
        public Triangulo() { }
        public Triangulo(string nombre, decimal baseF, decimal lado) {
            this .nombre = nombre;
            this .baseF = baseF;
            this .lado = lado;
        }
        public string nombre { get; set; }
        public decimal baseF { get; set; }
        public decimal lado { get; set; }
        public decimal altura { get { return Convert.ToDecimal(Math.Sqrt(Math.Pow((double)lado, 2) - (Math.Pow((double)baseF, 2) / 4))); } }
        public decimal Area()
        {
            return (baseF * altura) / 2;
        }
        public decimal Perimetro()
        {
            return (lado * 2) + baseF;
        }
    }
}
