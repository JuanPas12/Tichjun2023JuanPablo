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
    public partial class Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int idConsulta = Convert.ToInt32(Request.QueryString["id"]);
            NAlumno nAlumno = new NAlumno();
            NEstado nEstado = new NEstado();
            NEstatusAlumnos nStatus = new NEstatusAlumnos();
            Alumno objAlumno = new Alumno();
            objAlumno = nAlumno.Consultar(idConsulta);

            lblidR.Text = idConsulta.ToString();
            lblNombreR.Text = objAlumno.nombre;
            lblPAR.Text = objAlumno.primerApellido;
            lblSAR.Text = objAlumno.segundoaPellido;
            lblFNR.Text = objAlumno.fechaNacimiento.ToString();
            lblCorreoR.Text = objAlumno.correo;
            lblFNR.Text = objAlumno.curp;
            lblTelR.Text = objAlumno.telefono;
            lblSMR.Text = objAlumno.sueldo.ToString();
            /*var estadoA =
                from alumno in nAlumno.Consultar()
                join estado in nEstado.Consultar() on alumno.idEstadoOrigen equals estado.id
                where alumno.id == idConsulta
                select estado.nombre;*/
            lblEstadoR.Text = nEstado.Consultar(objAlumno.idEstadoOrigen).nombre;
            /*var estatusA =
                from alumno in nAlumno.Consultar()
                join estatus in nStatus.Consultar() on alumno.idEstatus equals estatus.id
                where alumno.id == idConsulta
                select estatus.nombre;*/
            lblEstatusR.Text = nStatus.Consultar(objAlumno.idEstatus).nombre;
        }
    }
}