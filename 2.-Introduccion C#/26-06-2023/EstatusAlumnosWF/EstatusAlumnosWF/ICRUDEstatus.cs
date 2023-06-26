﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EstatusAlumnosWF
{
    public interface ICRUDEstatus
    {
        List<Estatus> Consultar();
        Estatus Consultar(int id);
        int Agregar(Estatus estatus);
        void Actualizar(Estatus estatus);
        void Eliminar(int id);
    }
}
