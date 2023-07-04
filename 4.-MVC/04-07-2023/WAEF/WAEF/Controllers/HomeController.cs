using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WAEF.Models;

namespace WAEF.Controllers
{
    public class HomeController : Controller
    {
        private InstitutoTichEntities _dbcontext = new InstitutoTichEntities();
        private List<Cursos> _lstCursos = new List<Cursos>();
        Cursos _cursos;
        CatCursos _cursosCursos;

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ConsultarLista()
        {
            _dbcontext.Configuration.LazyLoadingEnabled = false;
            _lstCursos = _dbcontext.Cursos.ToList();
            return View(_lstCursos);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}