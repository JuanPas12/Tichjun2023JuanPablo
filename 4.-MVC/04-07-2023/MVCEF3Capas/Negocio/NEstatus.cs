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
    public class NEstatus
    {
        private InstitutoTichEntities1 _DbContext = new InstitutoTichEntities1();
        private List<EstatusAlumnos> _lstEstatus = new List<EstatusAlumnos>();
        private EstatusAlumnos _Estatus = new EstatusAlumnos();

        public List<EstatusAlumnos> Consultar()
        {
            _lstEstatus = _DbContext.EstatusAlumnos.ToList();
            return _lstEstatus;
        }

        public EstatusAlumnos Consultar(int id)
        {
            _Estatus = _DbContext.EstatusAlumnos.Find(id);
            return _Estatus;
        }

        public void Agregar(EstatusAlumnos ea)
        {
            _DbContext.EstatusAlumnos.Add(ea);
            _DbContext.SaveChanges();
        }

        public void Actualizar(EstatusAlumnos ea)
        {
            _DbContext.Entry(ea).State = EntityState.Modified;
            _DbContext.SaveChanges();
        }

        public void Eliminar(int id)
        {
            _DbContext.Entry(_DbContext.EstatusAlumnos.Find(id)).State = EntityState.Deleted;
            _DbContext.SaveChanges();
        }
    }
}
