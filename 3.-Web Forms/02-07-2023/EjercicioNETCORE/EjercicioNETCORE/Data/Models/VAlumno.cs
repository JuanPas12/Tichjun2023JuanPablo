using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class VAlumno
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string PrimerApellido { get; set; } = null!;
        public string? SegundoaPellido { get; set; }
        public string Correo { get; set; } = null!;
        public string Telefono { get; set; } = null!;
        public string Curp { get; set; } = null!;
        public string? Estado { get; set; }
        public string Estatus { get; set; } = null!;
    }
}
