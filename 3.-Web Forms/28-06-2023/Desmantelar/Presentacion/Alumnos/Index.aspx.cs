using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Entidades;
using System.Net.NetworkInformation;

namespace Presentacion.Alumnos
{
    public partial class Index : System.Web.UI.Page
    {
        NAlumno nAlumno = new NAlumno();
        NEstado nEstado = new NEstado();
        NEstatusAlumnos nStatus = new NEstatusAlumnos();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPagina();
            }
        }

        protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAlumnos.PageIndex = e.NewPageIndex;
            CargarPagina();
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //Es necesario filtrar por que si no se entorpece el programa.
            if(!(e.CommandName == "Page")){
                int nRow = Convert.ToUInt16(e.CommandArgument);
                GridViewRow row = gvAlumnos.Rows[nRow];
                TableCell cell = row.Cells[0];
                int idGV = Convert.ToInt32(cell.Text);

                //Pasa como parametro el nombre del botón al que se le hizo click, entonces lo filtramos.
                switch (e.CommandName)
                {
                    case "btnDetalles":
                        Response.Redirect($"Details.aspx?id={idGV}");
                        break;
                    case "btnEditar":
                        Response.Redirect($"Edit.aspx?id={idGV}");
                        break;
                    case "btnEliminar":
                        Response.Redirect($"Delete.aspx?id={idGV}");
                        break;
                }
            }
        }

        private void CargarPagina()
        {
            //LINQ Para cargar nuestra lista.
            var alm =
                    from alumno in nAlumno.Consultar()
                    join estado in nEstado.Consultar() on alumno.idEstadoOrigen equals estado.id
                    join estatus in nStatus.Consultar() on alumno.idEstatus equals estatus.id
                    select new { idA = alumno.id, nombreA = alumno.nombre, alumno.primerApellido, alumno.segundoaPellido, alumno.correo, alumno.telefono, estadoA = estado.nombre, estatusA = estatus.nombre};
            
            //Asignación de la lista al GV
            gvAlumnos.DataSource = alm.ToList();
            gvAlumnos.DataBind();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Create.aspx");
        }

        protected void gvAlumnos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}