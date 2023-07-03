using System;
using System.Collections.Generic;

namespace EjercicioNETCORE.Data.Models
{
    public partial class EstatusAlumno
    {
        public EstatusAlumno()
        {
            Alumnos = new HashSet<Alumno>();
        }

        public short Id { get; set; }
        public string Clave { get; set; } = null!;
        public string Nombre { get; set; } = null!;

        public virtual ICollection<Alumno> Alumnos { get; set; }
    }
}
