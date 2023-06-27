using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADOWebForms.html
{
    public partial class create : System.Web.UI.Page
    {
        ADOEstatus ado = new ADOEstatus();
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Estatus estatus = new Estatus();
            estatus.id = Convert.ToInt32(txtId.Text);
            estatus.clave = txtClave.Text;
            estatus.nombre = txtNombre.Text;
            ado.Agregar(estatus);
            Response.Redirect("../index.aspx");
        }
    }
}