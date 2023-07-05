using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Entidades;
using Negocio;
//Es importante hacer referencia de EntityFramework y entityFrameworkSqlServer para que todo funcione
namespace Presentacion.Controllers
{
    public class AlumnoController : Controller
    {
        NAlumno _oAlumno = new NAlumno();
        NEstado _oEstado = new NEstado();
        NEstatus _oEstatus = new NEstatus();
        // GET: Alumno
        public ActionResult Index()
        {
            return View(_oAlumno.Consultar());
        }

        // GET: Alumno/Details/5
        public ActionResult Details(int id)
        {
            return View(_oAlumno.Consultar(id));
        }

        // GET: Alumno/Create
        public ActionResult Create()
        {
            ViewBag.Estados = _oEstado.Consultar();
            ViewBag.Estatus = _oEstatus.Consultar();
            return View();
        }

        // POST: Alumno/Create
        [HttpPost]
        public ActionResult Create(Alumnos alm)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    _oAlumno.Agregar(alm);
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.Estados = _oEstado.Consultar();
                    ViewBag.Estatus = _oEstatus.Consultar();
                    return View("Create", alm);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, "Ocurrió un error al guardar el alumno: " + ex.Message);
                ViewBag.Estados = _oEstado.Consultar();
                ViewBag.Estatus = _oEstatus.Consultar();
                return View();
            }
        }

        // GET: Alumno/Edit/5
        public ActionResult Edit(int id)
        {
            ViewBag.Estados = _oEstado.Consultar();
            ViewBag.Estatus = _oEstatus.Consultar();
            return View(_oAlumno.Consultar(id));
        }

        // POST: Alumno/Edit/5
        [HttpPost]
        public ActionResult Edit(Alumnos alm)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    _oAlumno.Actualizar(alm);
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.Estados = _oEstado.Consultar();
                    ViewBag.Estatus = _oEstatus.Consultar();
                    return View("Edit", alm);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, "Ocurrió un error al guardar el alumno: " + ex.Message);
                ViewBag.Estados = _oEstado.Consultar();
                ViewBag.Estatus = _oEstatus.Consultar();
                return View();
            }
        }

        // GET: Alumno/Delete/5
        public ActionResult Delete(int id)
        {
            return View(_oAlumno.Consultar(id));
        }

        // POST: Alumno/Delete/5
        [HttpPost]
        public ActionResult Delete(Alumnos alm)
        {
            try
            {
                _oAlumno.Eliminar(alm.id);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
