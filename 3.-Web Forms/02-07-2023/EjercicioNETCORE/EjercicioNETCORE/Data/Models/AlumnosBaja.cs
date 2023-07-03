using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class AlumnosBaja
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string PrimerApellido { get; set; } = null!;
        public string? SegundoApellido { get; set; }
        public DateTime FechaBaja { get; set; }
    }
}
