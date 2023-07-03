using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Entidades;
using Datos;
using Negocio;

namespace MVC_Razor_ADO.Controllers
{
    public class AlumnoController : Controller
    {
        // GET: Alumno
        NAlumno nAlumno = new NAlumno();
        List<Alumno> lstAlumnos = new List<Alumno>();
        List<Estado> lstEstados = new List<Estado>();
        NEstado nEstado = new NEstado();
        List<EstatusAlumnos> lstEstatus = new List<EstatusAlumnos>();
        NEstatusAlumnos nEstatus = new NEstatusAlumnos();
        
        public ActionResult Index()
        {
            lstAlumnos = nAlumno.Consultar();
            ViewBag.Estado = lstEstados;
            ViewBag.Estatus = lstEstatus;
            return View(lstAlumnos);
        }

        public ActionResult Details(int id)
        {
            Alumno alm = nAlumno.Consultar(id);
            ViewBag.Estado = lstEstados;
            ViewBag.Estatus = lstEstatus;
            return View(alm);
        }
        [HttpGet]
        public ActionResult Delete(int id)
        {
            Alumno alm = nAlumno.Consultar(id);
            ViewBag.Estado = lstEstados;
            ViewBag.Estatus = lstEstatus;
            return View(alm);
        }

        public ActionResult Create()
        {
            lstEstados = nEstado.Consultar();
            lstEstatus = nEstatus.Consultar();
            ViewBag.Estado = lstEstados;
            ViewBag.Estatus = lstEstatus;
            return View();
        }

        public ActionResult Edit(int id)
        {
            Alumno alm = nAlumno.Consultar(id);
            lstEstados = nEstado.Consultar();
            lstEstatus = nEstatus.Consultar();
            ViewBag.Estado = lstEstados;
            ViewBag.Estatus = lstEstatus;
            return View(alm);
        }

        //-------------------------------------------------------------------
        [HttpPost]
        public ActionResult Delete(Alumno alm)
        {
            nAlumno.Eliminar(alm.id);
            
            return RedirectToAction("Index");
        }
        [HttpPost]
        public ActionResult Create(Alumno alm)
        {
            nAlumno.Agregar(alm);
            return RedirectToAction("Index");
        }
        [HttpPost]
        public ActionResult Edit(Alumno alm)
        {
            nAlumno.Actualizar(alm);
            return RedirectToAction("Index");
        }
    }
}