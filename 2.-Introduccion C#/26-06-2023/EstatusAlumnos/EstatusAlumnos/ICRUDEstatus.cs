using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//3. Crear una interface  ICRUDEstatus indicada en la figura anexa 
namespace EstatusAlumnos
{
    public interface ICRUDEstatus
    {
        List<Estatus> Consultar();
        Estatus Consultar(int id);
        int Agregar(Estatus estatus);
        void Actualizar(Estatus estatus);
        void Eliminar(int  id);
    }
}
