using Datos;
using Entidades;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class NEstado
    {
        private InstitutoTichEntities1 _DbContext = new InstitutoTichEntities1();
        private List<Estados> _lstEstado = new List<Estados>();
        private Estados _Estado = new Estados();

        public List<Estados> Consultar()
        {
            _lstEstado = _DbContext.Estados.ToList();
            return _lstEstado;
        }

        public Estados Consultar(int id)
        {
            _Estado = _DbContext.Estados.Find(id);
            return _Estado;
        }

        public void Agregar(Estados est)
        {
            _DbContext.Estados.Add(est);
            _DbContext.SaveChanges();
        }

        public void Actualizar(Estados est)
        {
            _DbContext.Entry(est).State = EntityState.Modified;
            _DbContext.SaveChanges();
        }

        public void Eliminar(int id)
        {
            _DbContext.Entry(_DbContext.Estados.Find(id)).State = EntityState.Deleted;
            _DbContext.SaveChanges();
        }
    }
}
