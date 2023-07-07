using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Entidades;
using Negocio;

namespace Presentacion.Controllers
{
    public class EstatusController : Controller
    {
        NEstatusAlumnos _estatus = new NEstatusAlumnos();
        // GET: Estatus
        public ActionResult Index()
        {
            return View(_estatus.Consultar());
        }

        // GET: Estatus/Details/5
        public ActionResult Details(int id)
        {
            return View(_estatus.Consultar(id));
        }

        // GET: Estatus/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Estatus/Create
        [HttpPost]
        public ActionResult Create(EstatusAlumnos est)
        {
            try
            {
                _estatus.Agregar(est);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Estatus/Edit/5
        public ActionResult Edit(int id)
        {
            return View(_estatus.Consultar(id));
        }

        // POST: Estatus/Edit/5
        [HttpPost]
        public ActionResult Edit(EstatusAlumnos est)
        {
            try
            {
                _estatus.Actualizar(est);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Estatus/Delete/5
        public ActionResult Delete(int id)
        {
            return View(_estatus.Consultar(id));
        }

        // POST: Estatus/Delete/5
        [HttpPost]
        public ActionResult Delete(EstatusAlumnos est)
        {
            try
            {
                _estatus.Eliminar(est.id);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
