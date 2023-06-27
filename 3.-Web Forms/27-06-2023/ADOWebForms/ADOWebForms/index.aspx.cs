using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADOWebForms
{
    public partial class index : System.Web.UI.Page
    {
        ADOEstatus ado = new ADOEstatus();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlEstatus.DataSource = ado.Consultar();
                ddlEstatus.DataTextField = "nombre";
                ddlEstatus.DataValueField = "id";
                ddlEstatus.DataBind();
            }
            
        }

        protected void btnDetalles_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(ddlEstatus.SelectedValue);
            Response.Redirect($"html/details.aspx?id={id}");
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("html/create.aspx");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(ddlEstatus.SelectedValue);
            Response.Redirect($"html/delete.aspx?id={id}");
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(ddlEstatus.SelectedValue);
            Response.Redirect($"html/edit.aspx?id={id}");
        }
    }
}