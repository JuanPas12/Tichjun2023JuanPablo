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
        NAlumno nAlumno = new NAlumno();
        NEstado nEstado = new NEstado();
        NEstatusAlumnos nStatus = new NEstatusAlumnos();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlEstado.DataSource = nEstado.Consultar();
                ddlEstado.DataTextField = "nombre";
                ddlEstado.DataValueField = "id";
                ddlEstado.DataBind();
                ddlEstatus.DataSource = nStatus.Consultar();
                ddlEstatus.DataTextField = "nombre";
                ddlEstatus.DataValueField = "id";
                ddlEstatus.DataBind();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Alumno alum = new Alumno()
            {
                nombre = txtNombre.Text,
                primerApellido = txtPA.Text,
                segundoaPellido = txtSA.Text,
                correo = txtCorreo.Text,
                telefono = txtTel.Text,
                fechaNacimiento = Convert.ToDateTime(txtFN.Text),
                curp = txtCURP.Text,
                sueldo = Convert.ToDecimal(txtSueldo.Text),
                idEstadoOrigen = Convert.ToInt32(ddlEstado.SelectedValue),
                idEstatus = Convert.ToInt32(ddlEstatus.SelectedValue),
            };
            nAlumno.Agregar(alum);
            Response.Redirect("Index.aspx");
        }
    }
}