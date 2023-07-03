using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MVCHolaMundo.Controllers
{
    public class EstadoController : Controller
    {
        // GET: Estado
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(int num){
            return View();
        }
    }
}