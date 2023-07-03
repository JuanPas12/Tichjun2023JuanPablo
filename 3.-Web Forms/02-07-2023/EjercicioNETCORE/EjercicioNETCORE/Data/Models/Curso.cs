using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class Curso
    {
        public Curso()
        {
            CursosAlumnos = new HashSet<CursosAlumno>();
            CursosInstructores = new HashSet<CursosInstructore>();
        }

        public short Id { get; set; }
        public short? IdCatCurso { get; set; }
        public DateTime? FechaInicio { get; set; }
        public DateTime? FechaTermino { get; set; }
        public bool? Activo { get; set; }

        public virtual CatCurso? IdCatCursoNavigation { get; set; }
        public virtual ICollection<CursosAlumno> CursosAlumnos { get; set; }
        public virtual ICollection<CursosInstructore> CursosInstructores { get; set; }
    }
}
