using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PuntoVenta
{
    public abstract class ItemBase
    {
        public ItemBase() { }
        public ItemBase(Articulo art, int cantidad) { 
        
            _id = art.id;
            _nombre = art.nombre;
            _precio = art.precio;
            _cantidad = cantidad;
        }
        public static int _id {  get; set; }
        public static string _nombre { get; set; }
        public static decimal _precio { get; set; }
        public static int _cantidad { get; set; }

        public virtual decimal SubTotal()
        {
            return _precio * _cantidad;
        }

        public virtual decimal Total()
        {
            return _precio * _cantidad;
        }

        public abstract string Imprimir();
    }
}
