using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MenuGeneral
{
    public struct PolizaResultado
    {
        public PolizaResultado(DateTime fechaTermino, decimal prima)
        {
            this.fechaTermino = fechaTermino;
            this.prima = prima;
        }

        public DateTime fechaTermino { get; set; }
        public decimal prima { get; set; }
    }
}
