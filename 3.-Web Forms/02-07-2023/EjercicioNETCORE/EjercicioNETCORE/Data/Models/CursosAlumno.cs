using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class CursosAlumno
    {
        public int Id { get; set; }
        public short IdCurso { get; set; }
        public int IdAlumnos { get; set; }
        public DateTime FechaInscripcion { get; set; }
        public DateTime? FechaBaja { get; set; }
        public byte? Calificacion { get; set; }

        public virtual Alumno IdAlumnosNavigation { get; set; } = null!;
        public virtual Curso IdCursoNavigation { get; set; } = null!;
    }
}
