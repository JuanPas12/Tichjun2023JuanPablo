using MVC_Razor_EF.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MVC_Razor_EF.Controllers
{
    public class AlumnosController : Controller
    {
        private InstitutoTichEntities _DbContext = new InstitutoTichEntities();
        private Alumnos _oAlumno;
        private List<Estados> _lstEsados = new List<Estados>();
        private List<EstatusAlumnos> _lstEstatus = new List<EstatusAlumnos>();
        // GET: Alumnos
        public ActionResult Index()
        {
            return View(_DbContext.Alumnos.ToList());
        }

        // GET: Alumnos/Details/5
        public ActionResult Details(int id)
        {

            return View(_DbContext.Alumnos.Find(id));
        }

        // GET: Alumnos/Create
        public ActionResult Create()
        {
            _lstEsados = _DbContext.Estados.ToList();
            _lstEstatus = _DbContext.EstatusAlumnos.ToList();
            ViewBag.Estados = _lstEsados;
            ViewBag.Estatus = _lstEstatus;
            return View();
        }

        // POST: Alumnos/Create
        [HttpPost]
        public ActionResult Create(Alumnos alm)
        {
            try
            {
                _DbContext.Alumnos.Add(alm);
                _DbContext.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Alumnos/Edit/5
        public ActionResult Edit(int id)
        {
            _lstEsados = _DbContext.Estados.ToList();
            _lstEstatus = _DbContext.EstatusAlumnos.ToList();
            ViewBag.Estados = _lstEsados;
            ViewBag.Estatus = _lstEstatus;
            _oAlumno = _DbContext.Alumnos.Find(id);
            return View(_oAlumno);
        }

        // POST: Alumnos/Edit/5
        [HttpPost]
        public ActionResult Edit(Alumnos alm)
        {
            try
            {
                _DbContext.Entry(alm).State = EntityState.Modified;
                _DbContext.SaveChanges();

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Alumnos/Delete/5
        public ActionResult Delete(int id)
        {
            return View(_DbContext.Alumnos.Find(id));
        }

        // POST: Alumnos/Delete/5
        [HttpPost]
        public ActionResult Delete(Alumnos alm)
        {
            try
            {
                _oAlumno = _DbContext.Alumnos.Find(alm.id);
                _DbContext.Entry(_oAlumno).State = EntityState.Deleted;
                _DbContext.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
