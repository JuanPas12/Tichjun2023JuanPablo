using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Entidades;

namespace Presentacion.Alumnos
{
    public partial class Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NAlumno nAlumno = new NAlumno();
            Entidades.Alumnos alum = new Entidades.Alumnos()
            {
                id = 31,
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
            nAlumno.Agregar(alum);
        }
    }
}