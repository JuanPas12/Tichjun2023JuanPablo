using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Razor.Controllers
{
    public class RazorController : Controller
    {
        // GET: Razor
        public ActionResult Index()
        {
            return View();
        }

        /*3. Crear el Método y vista HolaMundo. Incluir en la vista, el código razor ( html 
            y c#) */
        public ActionResult HolaMundo()
        {
            return View();
        }

        /*Crear el Método y la Vista Ciclos. Incluir en la vista, el código razor ( html y 
            c#) */
        public ActionResult Ciclos()
        {
            return View();
        }
    }
}