using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Entidades;

namespace Datos
{
    public class DRepositorio<T> : IRepositorioBase<T> where T : class
    {
        InstitutoTichEntities1 _contexto;
        public DRepositorio()
        {
            _contexto = new InstitutoTichEntities1();
        }

        public void Actualizar(T entity)
        {
            _contexto.Entry(entity).State = EntityState.Modified;
            _contexto.SaveChanges();
        }

        public List<T> Consultar()
        {
            return _contexto.Set<T>().ToList();
        }

        public List<T> Consultar(Expression<Func<T, bool>> predicado)
        {
            return _contexto.Set<T>().Where(predicado).ToList();
        }

        public T Consultas(int id)
        {
            return _contexto.Set<T>().Find(id);
        }

        public T Consultas(Expression<Func<T, bool>> predicado)
        {
            return _contexto.Set<T>().FirstOrDefault<T>(predicado);
        }

        public void Agregar(T entity)
        {
            _contexto.Set<T>().Add(entity);
            _contexto.SaveChanges();
        }

        public void Eliminar(int id)
        {
            var entity = _contexto.Set<T>().Find(id);
            if (entity != null)
            {
                _contexto.Set<T>().Remove(entity);
                _contexto.SaveChanges();
            }
        }

        public void Eliminar(T entity)
        {
            _contexto.Entry(entity).State = EntityState.Deleted;
            _contexto.SaveChanges();
        }

        public void Eliminar(Expression<Func<T, bool>> predicado)
        {
            var entities = _contexto.Set<T>().Where(predicado).ToList();
            entities.ForEach(x => _contexto.Entry(x).State = EntityState.Deleted);
            _contexto.SaveChanges();
        }
    }
}
