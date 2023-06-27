using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADOWebForms.html
{
    public partial class edit : System.Web.UI.Page
    {
        ADOEstatus ado = new ADOEstatus();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                txtId.Text = ado.Consultar(id).id.ToString();
                txtNombre.Text = ado.Consultar(id).nombre.ToString();
                txtClave.Text = ado.Consultar(id).clave.ToString();
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            Estatus estatus = new Estatus();
            estatus.id = Convert.ToInt32(txtId.Text);
            estatus.clave = txtClave.Text;
            estatus.nombre = txtNombre.Text;
            ado.Actualizar(estatus);
            Response.Redirect("../index.aspx");
        }
    }
}