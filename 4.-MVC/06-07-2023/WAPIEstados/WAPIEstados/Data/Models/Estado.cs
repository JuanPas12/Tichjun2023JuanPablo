using System;
using System.Collections.Generic;

namespace WAPIEstados.Data.Models
{
    public partial class Estado
    {
        public int Id { get; set; }
        public string? Nombre { get; set; }
        public string? Curp { get; set; }
    }
}
