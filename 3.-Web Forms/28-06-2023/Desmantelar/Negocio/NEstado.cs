using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Datos;
using Entidades;

namespace Negocio
{
    public class NEstado 
    {
        DEstado estado = new DEstado();
        public List<Estado> Consultar()
        {
            
            return estado.Consultar();
        }

        public Estado Consultar(int id)
        {

            return estado.Consultar(id);
        }
    }
}
