using System;
using System.Collections.Generic;

namespace WAPIEstados.Data.Models
{
    public partial class EstatusAlumno
    {
        public short Id { get; set; }
        public string Clave { get; set; } = null!;
        public string Nombre { get; set; } = null!;
    }
}
