using System;
using System.Collections.Generic;

namespace WAPIEstatus.Models.Entities
{
    public partial class EstatusAlumno
    {
        public short Id { get; set; }
        public string Clave { get; set; } = null!;
        public string Nombre { get; set; } = null!;
    }
}
