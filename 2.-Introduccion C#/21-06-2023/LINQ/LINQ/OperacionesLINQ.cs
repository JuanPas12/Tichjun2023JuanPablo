using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

//7. Crear la Clase OperacionesLINQ:
namespace LINQ
{
    internal class OperacionesLINQ
    {
        //7.1. Dentro de esta clase crear el método CargarLists, realizando lo siguiente:
        /*7.1.1. Crear una lista de cada uno de las clases, cargándolos desde los 
            archivos json anexos (Alumnos.json, Estados.json, Estatus.json) 
        7.1.2. Crear una lista llamada TablaISR con elementos ItemISR, 
            cargándolos desde el archivo TablaISR.cvs */

        public static List<Alumnos> _lstAlumno = new List<Alumnos>();
        public static List<Estados> _lstEstado = new List<Estados>();
        public static List<Estatus> _lstEstatus = new List<Estatus>();
        public static List<ItemISR> _lstItemISR = new List<ItemISR>();
        internal static void CargarList()
        {
            //Alumnos
            string strRutaAlumnos = File.ReadAllText(@"C:\Users\juanp\Desktop\TICH\Intro_CSharp\21-06-2023\Resources\Alumnos.json");
            _lstAlumno = JsonConvert.DeserializeObject<List<Alumnos>>(strRutaAlumnos);

            //Estados
            string strRutaEstados = File.ReadAllText(@"C:\Users\juanp\Desktop\TICH\Intro_CSharp\21-06-2023\Resources\Estados.json");
            _lstEstado = JsonConvert.DeserializeObject<List<Estados>>(strRutaEstados);

            //Estatus
            string strRutaEstatus = File.ReadAllText(@"C:\Users\juanp\Desktop\TICH\Intro_CSharp\21-06-2023\Resources\Estatus.json");
            _lstEstatus = JsonConvert.DeserializeObject<List<Estatus>>(strRutaEstatus);

            //TablaISR
            string strRutaTablaISR = @"C:\Users\juanp\Desktop\TICH\Intro_CSharp\21-06-2023\Resources\ISR.csv";
            StreamReader sr = new StreamReader(strRutaTablaISR);
            ItemISR isr = new ItemISR();
            string strTemp = "";
            string[] arrayS;
            while (strTemp != null)
            {
                strTemp = "";
                strTemp = sr.ReadLine();
                if (strTemp != null)
                {
                    arrayS = strTemp.Split(',');
                    isr.decLimInf = Convert.ToDecimal(arrayS[0]);
                    isr.decLimSup = Convert.ToDecimal(arrayS[1]);
                    isr.decCuotaFija = Convert.ToDecimal(arrayS[2]);
                    isr.decPorExed = Convert.ToDecimal(arrayS[3]);
                    isr.decSubsidio = Convert.ToDecimal(arrayS[4]);
                    _lstItemISR.Add(isr);
                    isr = new ItemISR();
                }
            }

        }

        /*7.2. Dentro de esta clase Crear el método Consultas dentro de la Clase 
            OperacionesLINQ, realizando lo siguiente: */
        /*7.2.1. Realizar los siguientes ejercicios utilizando LINQ y en todos los 
            casos mostrar los resultados en la consola: */
        internal static void Consultas()
        {
            CargarList();
            //7.2.1.1.De la lista de estados, obtener el estado que tiene el id = 5

            var linq7211 = _lstEstado.FindAll(x => x.id == 5);
            Console.WriteLine("7.2.1.1.De la lista de estados, obtener el estado que tiene el id = 5\n");
            foreach (var edo in linq7211)
            {
                Console.WriteLine(edo.nombre);
            }
            Console.ReadKey();

            /*7.2.1.2. De la lista de alumnos obtener a los alumnos cuyo idEstado 
                29 y 13, Ordenado por nombre */

            var linq7212 =
                from alumno in _lstAlumno
                where alumno.idEstado == 29
                orderby alumno.nombre
                select alumno;
            Console.WriteLine("\n7.2.1.2. De la lista de alumnos obtener a los alumnos cuyo idEstado 29 y 13, Ordenado por nombre\n");
            foreach (var alm in linq7212)
            {
                Console.WriteLine(alm.nombre);
            }
            Console.ReadKey();

            /*7.2.1.3. De la lista de alumnos obtener los alumnos que son IdEstado 
                19 y 20 y además de que estén en el estatus 4 o 5 */

            var linq7213 =
                from alumnos in _lstAlumno
                where (alumnos.idEstado == 19 || alumnos.idEstado == 20) && (alumnos.idEstatus == 4 || alumnos.idEstatus == 5)
                select alumnos;
            Console.WriteLine("\n7.2.1.3. De la lista de alumnos obtener los alumnos que son IdEstado \r\n19 y 20 y además de que estén en el estatus 4 o 5 \n");
            foreach (var alm in linq7213)
            {
                Console.WriteLine($"Nombre: {alm.nombre}, IdEstado: {alm.idEstado}, Estatus: {alm.id}");
            }
            Console.ReadKey();

            /*7.2.1.4. Obtener una lista de los alumnos que tienen calificación 
                aprobatoria, considerando esta como 6 o mayor, ordenado por calificación del mayor al menor */

            var linq7214 =
                from alumnos in _lstAlumno
                where alumnos.calificacion >= 6
                orderby alumnos.calificacion descending
                select alumnos;
            Console.WriteLine("\n7.2.1.4. Obtener una lista de los alumnos que tienen calificación \r\naprobatoria, considerando esta como 6 o mayor, ordenado por \r\ncalificación del mayor al menor \n");
            foreach (var alm in linq7214)
            {
                Console.WriteLine($"Calificación: {alm.calificacion}, Nombre: {alm.nombre}");
            }
            Console.ReadKey();

            //7.2.1.5. Obtener la calificación promedio de los alumnos 

            Console.WriteLine("\n7.2.1.5. Obtener la calificación promedio de los alumnos\n");
            var linq7215 = _lstAlumno.Average(x => x.calificacion);
            Console.WriteLine($"Calificación promedio: {linq7215}");
            Console.ReadKey();

            /*7.2.1.6. En caso de que ningún alumno tenga 10, sumarles un punto 
                de calificación, y en caso de que todos estén entre 6 y 7 sumarles dos puntos.  */

            Console.WriteLine("\n7.2.1.6. En caso de que ningún alumno tenga 10, sumarles un punto \r\nde calificación, y en caso de que todos estén entre 6 y 7 sumarles \r\ndos puntos.  \n");
            var alm10 = _lstAlumno.FindAll(x => x.calificacion == 10);
            if (!(alm10.Equals(0)))
            {
                foreach (var alm in alm10)
                {
                    Console.WriteLine($"Hay alumnos con 10: {alm.nombre}");
                }
            }
            else
            {
                foreach (var alm in _lstAlumno)
                {
                    if (alm.calificacion >= 6 && alm.calificacion <= 7)
                    {
                        alm.calificacion += 2;
                        Console.WriteLine("Se agregaron 2 puntos a todos por que tienen entre 6 y 7");
                    }
                    else
                    {
                        alm.calificacion += 1;
                        Console.WriteLine("Se agrego 1 punto a todos por que ningun alumno tiene 10");
                    }
                }
            }
            Console.ReadKey();

            /*7.2.1.7. Mostar en la consola los siguientes datos, de aquellos 
                alumnos que estén en estatus 3: 
                    • idAlumnos, 
                    • nombreAlumno, 
                    • nombre del Estado al que pertenece */

            var linq7217 =
                from alumnos in _lstAlumno
                join estados in _lstEstado on alumnos.idEstado equals estados.id
                where alumnos.idEstatus == 3
                select new { alumnos.id, nombreAlumno = alumnos.nombre, nombreEstado = estados.nombre };

            Console.WriteLine("\n7.2.1.7. Mostar en la consola los siguientes datos, de aquellos \r\nalumnos que estén en estatus 3: \r\n• idAlumnos, \r\n• nombreAlumno, \r\n• nombre del Estado al que pertenece \n");
            foreach(var alm in linq7217)
            {
                Console.WriteLine($"ID: {alm.id}\nNombre: {alm.nombreAlumno}\nEstado de Origen: {alm.nombreEstado}\n----------------------");
            }
            Console.ReadKey();

            /*7.2.1.8. Mostar en la consola los siguientes datos, de aquellos 
                alumnos que estén en estatus 2, ordenado por nombre del Alumno: 
                    • idAlumnos, 
                    • nombreAlumno, 
                    • nombre del Estatus en que se encuentran */

            var linq7218 =
                from alumnos in _lstAlumno
                join estatus in _lstEstatus on alumnos.idEstatus equals estatus.id
                where alumnos.idEstatus == 5
                orderby alumnos.nombre descending
                select new { alumnos.id, nombreAlm = alumnos.nombre, nombreEst = estatus.nombre };

            Console.WriteLine("\n7.2.1.8. Mostar en la consola los siguientes datos, de aquellos \r\nalumnos que estén en estatus 2, ordenado por nombre del Alumno: \r\n• idAlumnos, \r\n• nombreAlumno, \r\n• nombre del Estatus en que se encuentran \n");
            foreach(var alm in linq7218)
            {
                Console.WriteLine($"ID: {alm.id}\nNombre: {alm.nombreAlm}\nEstado de Origen: {alm.nombreEst}\n----------------------");
            }
            Console.ReadKey();

            /*7.2.1.9. Mostar en la consola los siguientes datos, de aquellos 
                alumnos cuyo estatus sea mayor a 2, ordenado por nombre del estatus: 
                    • idAlumnos, 
                    • nombreAlumno, 
                    • nombre del Estado al que pertenece 
                    • nombre del Estatus en que se encuentran */

            var linq7219 = 
                from alumnos in _lstAlumno
                join estado in _lstEstado on alumnos.idEstado equals estado.id
                join estatus in _lstEstatus on alumnos.idEstatus equals estatus.id
                where estatus.id > 2
                orderby estatus.nombre ascending
                select new { alumnos.id, nombreAlumno = alumnos.nombre, nombreEstado = estado.nombre, nombreEstatus = estatus.nombre};

            Console.WriteLine("\n7.2.1.9. Mostar en la consola los siguientes datos, de aquellos \r\nalumnos cuyo estatus sea mayor a 2, ordenado por nombre del \r\nestatus: \r\n• idAlumnos, \r\n• nombreAlumno, \r\n• nombre del Estado al que pertenece \r\n• nombre del Estatus en que se encuentran \n");
            foreach (var alm in linq7219)
            {
                Console.WriteLine($"ID: {alm.id}\nNombre Alumno: {alm.nombreAlumno}\nEstado Origen: {alm.nombreEstado}\nEstatus: {alm.nombreEstatus}\n----------------------");
            }
            Console.ReadKey();

            /*7.2.1.10. Calcular el impuesto para un sueldo mensual de 22,000, y mostrarlo en la consola: 
                • La búsqueda en la tablaISR de los parámetros 
                correspondientes para el cálculo del ISR deben de ser a través 
                de LINQ */

            decimal decSueldoMensual = 22000m;
            decimal decSueldoQuincenal = decSueldoMensual / 2;
            decimal decImpuesto;
            var linq72110 =
                from isr in _lstItemISR
                where (isr.decLimInf <= decSueldoQuincenal) && (isr.decLimSup >= decSueldoQuincenal)
                select isr;
            foreach (var isr in linq72110)
            {

                decImpuesto = decSueldoQuincenal - isr.decLimInf;
                decImpuesto *= (isr.decPorExed / 100);
                decImpuesto = (decImpuesto + isr.decCuotaFija) - isr.decSubsidio;
                Console.WriteLine($"Impuesto a pagar: {decImpuesto.ToString("C")}");
            }
            Console.ReadKey();

        }
    }
}
