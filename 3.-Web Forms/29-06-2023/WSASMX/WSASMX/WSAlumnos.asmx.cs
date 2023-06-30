using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Entidades;
using Negocio;

namespace WSASMX
{
    /// <summary>
    /// Descripción breve de WSAlumnos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    [System.Web.Script.Services.ScriptService]
    public class WSAlumnos : System.Web.Services.WebService
    {
        NAlumno nAlumno = new NAlumno();
        AportacionesIMSS aIm = new AportacionesIMSS();
        [WebMethod]

        public AportacionesIMSS CalcularIMSS(int id)
        {
            Alumno a = nAlumno.Consultar(id);
            aIm = nAlumno.CalcularIMSS(Convert.ToDecimal(a.sueldo));
            return aIm;
        }

        [WebMethod]
        public ItemTablaISR CalcularISR(int id)
        {
            Alumno a = nAlumno.Consultar(id);
            ItemTablaISR isr = nAlumno.CalcularISR(Convert.ToDecimal(a.sueldo) / 2);
            return isr;
        }
        /*public string HelloWorld()
        {
            return "Hola a todos";
        }*/
    }
}
