using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PuntoVenta
{
    public class ItemDescuento : ItemBase
    {

        public int _descuento { get; set; }
        public decimal _impDescuento { get { return (SubTotal() /100) * _descuento; } }

        public ItemDescuento(Articulo art, int cantidad) : base(art, cantidad)
        {
        }

        public override decimal Total()
        {
            return _precio * _cantidad - _impDescuento; 
        }

        public override string Imprimir()
        {
            return $"{_id} {_nombre} Precio: {_precio} Cantidad: {_cantidad} Subtotal: {SubTotal().ToString("C")} \n" +
                $"Descuento: {_impDescuento} ({_descuento})\n" +
                $"Total: {Total().ToString("C")}";
        }
    }
}
