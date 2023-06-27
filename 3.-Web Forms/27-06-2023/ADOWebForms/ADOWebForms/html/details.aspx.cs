using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ADOWebForms.html
{
    public partial class detalles : System.Web.UI.Page
    {
        ADOEstatus ado = new ADOEstatus();
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);
            lblId.Text = ado.Consultar(id).id.ToString();
            lblNombre.Text = ado.Consultar(id).nombre.ToString();
            lblClave.Text = ado.Consultar(id).clave.ToString();
        }
    }
}