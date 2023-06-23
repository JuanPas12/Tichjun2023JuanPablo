using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*d) Crear la estructura llamada OperacionAritmetica la cual deberá 
contener dos propiedades para los operandos de tipo (decimal) y una 
propiedad para la operación a realizar de tipo (tipoOperacion). */
namespace OperacionesAritmeticas
{
    public struct OperacionAritmetica
    { 
        public OperacionAritmetica(decimal n1, decimal n2, tipoOperacion oper)
        {
            this.n1 = n1;
            this.n2 = n2;
            this.oper = oper;
        }

        public decimal n1 { get; set; }
        public decimal n2 { get; set; }
        public tipoOperacion oper { get; set; }
    }
}
