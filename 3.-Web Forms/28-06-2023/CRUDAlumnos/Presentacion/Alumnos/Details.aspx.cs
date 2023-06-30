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
        NAlumno nAlumno = new NAlumno();
        NEstado nEstado = new NEstado();
        NEstatusAlumnos nStatus = new NEstatusAlumnos();
        Alumno objAlumno = new Alumno();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            int idConsulta = Convert.ToInt32(Request.QueryString["id"]);
            objAlumno = nAlumno.Consultar(idConsulta);


            lblidR.Text = idConsulta.ToString();
            lblNombreR.Text = objAlumno.nombre;
            lblPAR.Text = objAlumno.primerApellido;
            lblSAR.Text = objAlumno.segundoaPellido;
            lblFechaN.Text = objAlumno.fechaNacimiento.ToString("yyyy-MM-dd");
            lblCURPR.Text = objAlumno.curp;
            lblCorreoR.Text = objAlumno.correo;
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

        protected void btnIMSS_Click(object sender, EventArgs e)
        {
            AportacionesIMSS objImss = nAlumno.CalcularIMSS((decimal)objAlumno.sueldo);
            lblEyM.Text = objImss.EnfermedadMaternidad.ToString("C");
            lblIyV.Text = objImss.InvalidezVida.ToString("C");
            lblRetiro.Text = objImss.Retiro.ToString("C");
            lblCesantia.Text = objImss.Cesantia.ToString("C");
            lblInfo.Text = objImss.Infonavit.ToString("C");
        }

        protected void btnISR_Click(object sender, EventArgs e)
        {
            decimal sueldoQunicenal = (decimal)(objAlumno.sueldo / 2);
            ItemTablaISR objISR = nAlumno.CalcularISR(sueldoQunicenal);
            lblLimInf.Text = objISR.LimiteInferior.ToString("C");
            lblLimSup.Text = objISR.LimiteSuperior.ToString("C");
            lblCuota.Text = objISR.CuotaFija.ToString("C");
            lblExcedente.Text = objISR.Excedente.ToString("C");
            lblSubsidio.Text = objISR.Subsidio.ToString("C");
            lblImpuesto.Text = objISR.ISR.ToString("C");
        }
    }
}