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
        NAlumno nAlumno = new NAlumno();
        NEstado nEstado = new NEstado();
        NEstatusAlumnos nStatus = new NEstatusAlumnos();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int idConsulta = Convert.ToInt32(Request.QueryString["id"]);

                ddlEstado.DataSource = nEstado.Consultar();
                ddlEstado.DataTextField = "nombre";
                ddlEstado.DataValueField = "id";
                ddlEstado.DataBind();
                ddlEstatus.DataSource = nStatus.Consultar();
                ddlEstatus.DataTextField = "nombre";
                ddlEstatus.DataValueField = "id";
                ddlEstatus.DataBind();
                
                NAlumno nAlumno = new NAlumno();
                Alumno objAlumno = new Alumno();
                objAlumno = nAlumno.Consultar(idConsulta);
                txtId.Text = idConsulta.ToString();
                txtNombre.Text = objAlumno.nombre;
                txtPA.Text = objAlumno.primerApellido;
                txtSA.Text = objAlumno.segundoaPellido;
                txtFN.Text = objAlumno.fechaNacimiento.ToString("yyyy-MM-dd");
                txtCorreo.Text = objAlumno.correo;
                txtCURP.Text = objAlumno.curp;
                txtTel.Text = objAlumno.telefono;
                txtSueldo.Text = objAlumno.sueldo.ToString();
                ddlEstado.SelectedValue = objAlumno.idEstadoOrigen.ToString();
                ddlEstatus.SelectedValue = objAlumno.idEstatus.ToString();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Alumno alum = new Alumno()
            {
                id = Convert.ToInt32(txtId.Text),
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
            nAlumno.Actualizar(alum);
            Response.Redirect("Index.aspx");
        }
    }
}