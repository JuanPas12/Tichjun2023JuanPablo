﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using Datos;
using Entidades;

namespace Negocio
{
    public class NAlumno
    {
        DAlumno a = new DAlumno();
        decimal UMA = Convert.ToDecimal(ConfigurationManager.AppSettings["UMA"]);
        public List<Alumno> Consultar()
        {
            return a.Consultar();
        }

        public Alumno Consultar(int id)
        {
            return a.Consutar(id);
        }

        public void Agregar(Alumno al)
        {
            a.Agregar(al);
        }

        public void Actualizar(Alumno al)
        {
            a.Actualizar(al);
        }

        public void Eliminar(int id)
        {
            a.Eliminar(id);
        }

        ItemTablaISR isrF = new ItemTablaISR();
        public ItemTablaISR CalcularISR(decimal sueldoQuincenal)
        {
            var linqISR =
               from isr in a.ConsultarTablaISR()
               where (isr.LimiteInferior <= sueldoQuincenal) && (isr.LimiteSuperior >= sueldoQuincenal)
               select isr;

            foreach (var isr in linqISR)
            {
                isrF.ISR = sueldoQuincenal - isr.LimiteInferior;
                isrF.ISR += (isr.Excedente / 100);
                isrF.ISR = (isrF.ISR + isr.CuotaFija) - isr.Subsidio;
                isrF.LimiteInferior = isr.LimiteInferior;
                isrF.LimiteSuperior = isr.LimiteSuperior;
                isrF.CuotaFija = isr.CuotaFija;
                isrF.Excedente = isr.Excedente;
                isrF.Subsidio = isr.Subsidio;
            }

            return isrF;
        }

        AportacionesIMSS imss = new AportacionesIMSS();
        public AportacionesIMSS CalcularIMSS(decimal SBC)
        {
            imss.EnfermedadMaternidad = ((SBC - (3 * UMA)) / 100) * 0.4m;
            imss.InvalidezVida = (SBC / 100) * 0.625m;
            imss.Retiro = 0;
            imss.Cesantia = (SBC / 100) * 1.125m;
            imss.Infonavit = 0;
            return imss;
        }
    }
}
