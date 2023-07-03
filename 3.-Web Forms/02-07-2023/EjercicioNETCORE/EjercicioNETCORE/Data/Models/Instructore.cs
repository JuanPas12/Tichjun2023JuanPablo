using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class Instructore
    {
        public Instructore()
        {
            CursosInstructores = new HashSet<CursosInstructore>();
        }

        public short Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string PrimerApellido { get; set; } = null!;
        public string? SegundoApellido { get; set; }
        public string Correo { get; set; } = null!;
        public string Telefono { get; set; } = null!;
        public DateTime FechaNacimiento { get; set; }
        public string Rfc { get; set; } = null!;
        public string Curp { get; set; } = null!;
        public decimal CuotaHora { get; set; }
        public bool Activo { get; set; }

        public virtual ICollection<CursosInstructore> CursosInstructores { get; set; }
    }
}
