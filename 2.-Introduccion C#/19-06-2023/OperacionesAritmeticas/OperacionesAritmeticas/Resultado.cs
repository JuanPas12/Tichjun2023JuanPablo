using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*Crear la estructura llamada Resultado con 5 propiedades de tipo 
(decimal) llamadas suma, resta, multiplicación, división y modulo. */
namespace OperacionesAritmeticas
{
    public struct Resultado
    { 
        public Resultado(decimal suma, decimal resta, decimal multiplicacion, decimal division, decimal modulo)
        {
            this.suma = suma;
            this.resta = resta;
            this.multiplicacion = multiplicacion;
            this.division = division;
            this.modulo = modulo;
        }

        public decimal suma { get; set; }
        public decimal resta { get; set; }
        public decimal multiplicacion { get; set; }
        public decimal division { get; set; }  
        public decimal modulo { get; set; } 
    }
}
