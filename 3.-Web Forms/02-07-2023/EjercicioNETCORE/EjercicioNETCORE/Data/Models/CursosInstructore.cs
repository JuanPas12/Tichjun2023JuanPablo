using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class CursosInstructore
    {
        public int Id { get; set; }
        public short IdCurso { get; set; }
        public short IdInstructor { get; set; }
        public DateTime? FechaContratacion { get; set; }

        public virtual Curso IdCursoNavigation { get; set; } = null!;
        public virtual Instructore IdInstructorNavigation { get; set; } = null!;
    }
}
