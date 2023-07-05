using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace Entidades
{
    [MetadataType(typeof(AlumnosDataAnnotations))]
    public partial class Alumnos
    {

    }
    public class AlumnosDataAnnotations
    {
        //=======================================================
        public int id { get; set; }
        //=======================================================
        [DisplayName("Nombre")]
        [RegularExpression("^[A-Za-zñÑ\\s]+$", ErrorMessage = "El campo {0} solo puede contener letras y espacios.")]
        [Required(ErrorMessage = "El campo {0} es obligatorio.")]
        public string nombre { get; set; }
        //=======================================================
        [DisplayName("Primer Apellido")]
        [RegularExpression("^[A-Za-zñÑ\\s]+$", ErrorMessage = "El campo {0} solo puede contener letras y espacios.")]
        [Required(ErrorMessage = "El  campo {0} es obligatorio.")]
        public string primerApellido { get; set; }
        //=======================================================
        [DisplayName("Segundo Apellido")]
        [RegularExpression("^[A-Za-zñÑ\\s]+$", ErrorMessage = "El campo {0} solo puede contener letras y espacios.")]
        public string segundoaPellido { get; set; }
        //=======================================================
        [DisplayName("Correo")]
        [EmailAddress(ErrorMessage = "Formato incorrecto, el formato es x@x.x.")]
        [Required(ErrorMessage = "El campo {0} es obligatorio.")]
        public string correo { get; set; }
        //=======================================================
        public string telefono { get; set; }
        //=======================================================
        [DisplayName("Fecha de Nacimiento")]
        [Required(ErrorMessage = "El campo {0} es obligatorio.")]
        [DataType(DataType.Date)]
        [RangeData("1990-01-01", "2000-12-31", ErrorMessage = "El campo {0} debe estar entre {1} y {2}.")]
        public System.DateTime fechaNacimiento { get; set; }
        //=======================================================
        [DisplayName("CURP")]
        [Required(ErrorMessage = "El campo {0} es obligatorio.")]
        [RegularExpression("^[A-Z]{4}[\\d]{6}[HM]{1}[A-Z]{5}[A-Z\\d]{2}$", ErrorMessage ="Los valores proporcionados en el campo {0} no tienen el formato correcto.")]
        public string curp { get; set; }
        //=======================================================
        [DisplayName("Sueldo")]
        [Range(10000, 40000, ErrorMessage = "El {0} debe ser entre ${1} y ${2} pesos.")]
        public Nullable<decimal> sueldo { get; set; }
        //=======================================================
        public int idEstadoOrigen { get; set; }
        //=======================================================
        public short idEstatus { get; set; }
        //=======================================================
    }
}
