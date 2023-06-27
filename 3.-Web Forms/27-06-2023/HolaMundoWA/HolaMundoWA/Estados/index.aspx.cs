using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HolaMundoWA.Estados
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Estado> _lstEstados = new List<Estado>
            {
                new Estado{id = 1, nombre = "Jose"},
                new Estado{id = 2, nombre = "Nesa York"}
            };
            ddlEstados.DataSource = _lstEstados;
            ddlEstados.DataTextField = "nombre";
            ddlEstados.DataValueField = "id";
            ddlEstados.DataBind();
        }
    }
}