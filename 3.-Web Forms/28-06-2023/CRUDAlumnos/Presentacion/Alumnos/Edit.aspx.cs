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
    public partial class Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int idConsulta  = Convert.ToInt32(Request.QueryString["id"]);
            NAlumno nAlumno = new NAlumno();
            nAlumno.Consultar(idConsulta);
            Entidades.Alumnos alm = new Entidades.Alumnos()
            {
                id = idConsulta,
                nombre = "Jose",
            };
            nAlumno.Actualizar(alm);
        }
    }
}