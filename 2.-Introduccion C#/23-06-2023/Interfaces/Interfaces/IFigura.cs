using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*2. Crear una interfaz IFigura la cual define dos métodos: Uno para que calcule el 
Area y otro para que calcule el Perímetro.*/
namespace Interfaces
{
    interface IFigura
    {
        string nombre { get; set; }

        decimal Area();
        decimal Perimetro();
    }
}
