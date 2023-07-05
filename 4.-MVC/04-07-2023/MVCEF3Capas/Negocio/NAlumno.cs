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
    public class NAlumno
    {
        private InstitutoTichEntities1 _DbContext = new InstitutoTichEntities1();
        private List<Alumnos> _lstAlumnos = new List<Alumnos>();
        private Alumnos _Alumno = new Alumnos();

        public List<Alumnos> Consultar()
        {
            _lstAlumnos = _DbContext.Alumnos.ToList();
            return _lstAlumnos;
        }

        public Alumnos Consultar(int id)
        {
            _Alumno = _DbContext.Alumnos.Find(id);
            return _Alumno;
        }

        public void Agregar(Alumnos alm)
        {
            _DbContext.Alumnos.Add(alm);
            _DbContext.SaveChanges();
        }

        public void Actualizar(Alumnos alm)
        {
            _DbContext.Entry(alm).State = EntityState.Modified;
            _DbContext.SaveChanges();
        }

        public void Eliminar(int id)
        {
            _DbContext.Entry(_DbContext.Alumnos.Find(id)).State = EntityState.Deleted;
            _DbContext.SaveChanges();
        }
    }
}
