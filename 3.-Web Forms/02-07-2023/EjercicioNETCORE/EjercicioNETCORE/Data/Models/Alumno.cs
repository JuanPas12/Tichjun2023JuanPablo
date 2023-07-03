using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class Alumno
    {
        public Alumno()
        {
            CursosAlumnos = new HashSet<CursosAlumno>();
        }

        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string PrimerApellido { get; set; } = null!;
        public string? SegundoaPellido { get; set; }
        public string Correo { get; set; } = null!;
        public string Telefono { get; set; } = null!;
        public DateTime FechaNacimiento { get; set; }
        public string Curp { get; set; } = null!;
        public decimal? Sueldo { get; set; }
        public int IdEstadoOrigen { get; set; }
        public short IdEstatus { get; set; }

        public virtual Estado IdEstadoOrigenNavigation { get; set; } = null!;
        public virtual EstatusAlumno IdEstatusNavigation { get; set; } = null!;
        public virtual ICollection<CursosAlumno> CursosAlumnos { get; set; }
    }
}
