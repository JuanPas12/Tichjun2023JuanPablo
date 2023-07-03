using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class TablaIsr
    {
        public int Id { get; set; }
        public decimal? LimInf { get; set; }
        public decimal? LimSup { get; set; }
        public decimal? CuotaFija { get; set; }
        public decimal? ExedLimInf { get; set; }
        public decimal? Subsidio { get; set; }
    }
}
