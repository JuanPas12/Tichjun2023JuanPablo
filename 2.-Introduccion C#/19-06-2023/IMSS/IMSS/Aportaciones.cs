using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*c) Crear la estructura llamada Aportaciones con 5 propiedades de tipo 
(decimal), llamadas EnfermedadMaternidad, InvalidezVida, Retiro, 
Cesantia, Infonavit. */

namespace IMSS
{
    public struct Aportaciones
    {
        public Aportaciones(decimal EnfermedadMaternidad, decimal InvalidezVida, decimal Retiro, decimal Cesantia, decimal Infonavit)
        {
            this.EnfermedadMaternidad = EnfermedadMaternidad;
            this.InvalidezVida = InvalidezVida;
            this.Retiro = Retiro;
            this.Cesantia = Cesantia;
            this.Infonavit = Infonavit;
        }

        public decimal EnfermedadMaternidad { get; set; }
        public decimal InvalidezVida { get; set; }
        public decimal Retiro { get; set; }
        public decimal Cesantia { get; set;}
        public decimal Infonavit { get; set; }
    }
}
