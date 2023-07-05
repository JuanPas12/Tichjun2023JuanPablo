using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace System.ComponentModel.DataAnnotations
{
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false)]
    //para heredar de la clase ValidationAttibute es necesario agregar este using
    //using System.ComponentModel.DataAnnotations;
    public class RangeDataAttribute : ValidationAttribute
    {
        public RangeDataAttribute(string min, string max)
        {
            Min = DateTime.Parse(min);
            Max = DateTime.Parse(max);
        }

        public DateTime Min { get; set; }
        public DateTime Max { get; set; }

        public override string FormatErrorMessage(string name)
        {
            return string.Format(ErrorMessage, name, Min.ToString("dd-MM-yyyy"), Max.ToString("dd-MM-yyyy"));
        }

        public override bool IsValid(object value)
        {
            DateTime date = (DateTime)value;
            if (date >= Min  && date <= Max)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}

// Resumen:
//     Determina si el valor especificado del objeto es válido.
//
//  Parámetros:
//   value:
//     Valor del objeto que se va a validar.
//
// Devuelve:
//     Es true si el valor especificado es válido; en caso contrario, es false.
