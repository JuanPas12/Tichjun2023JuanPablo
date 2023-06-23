using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDEstados
{
    internal class CRUD
    {
        internal static Dictionary<int, Estado> _DicEstados = new Dictionary<int, Estado>();

        internal static Estado ConsultarUno(int id)
        {
            Estado def;
            def = _DicEstados[id];
            return def;
        }

        internal static Dictionary<int, Estado> ConsultarTodo()
        {
            return _DicEstados;
        }

        internal static void Agregar(Estado estado)
        {
            _DicEstados.Add(estado.id, estado);
        }

        internal static void Actualizar(int id, Estado estado)
        {
            _DicEstados[id] = estado;
        } 

        internal static void Eliminar(int id)
        {
            _DicEstados.Remove(id);
        }
    }
}
