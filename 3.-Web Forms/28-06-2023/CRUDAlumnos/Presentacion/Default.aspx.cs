using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Entidades;

namespace Presentacion
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NAlumno estatus = new NAlumno();
            Alumnos al = new Alumnos()
            {
                id = 30,
                nombre = "30",
                primerApellido = "30",
                segundoaPellido = "30",
                correo = "30",
                telefono = "30",
                fechaNacimiento = DateTime.Now,
                curp = "1",
                sueldo = 100,
                idEstadoOrigen = 1,
                idEstatus = 1,
            };
            estatus.Actualizar(al);
        }
    }
}