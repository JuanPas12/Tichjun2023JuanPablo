using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EstatusAlumnos
{
    internal class Program
    {
        static void Main(string[] args)
        {
            ADOEstatus ado = new ADOEstatus();
            int op = 0;
            while (op != 6)
            {
                Console.WriteLine("Elige una opción\n" +
                    "1.- Consultar Todos\n" +
                    "2.- Consultar Solo Uno\n" +
                    "3.- Agregar\n" +
                    "4.- Actualizar\n" +
                    "5.- Eliminar\n" +
                    "6.- Terminar\n");
                Console.Write("> ");
                op = Convert.ToInt32(Console.ReadLine());
                switch (op)
                {
                    //Consultar Todos
                    case 1:
                        Console.Clear();
                        Console.WriteLine("Opción: Consultar Todos\n");
                        foreach (var consulta in ado.Consultar())
                        {
                            Console.WriteLine($"ID: {consulta.id}        Clave: {consulta.clave} Nombre: {consulta.nombre}");
                        }
                        Console.ReadKey();
                        break;
                    //Consultar Solo Uno
                    case 2:
                        Console.Clear();
                        Console.WriteLine("Opción: Consultar Solo Uno\n");
                        Console.Write("Ingrese el ID del registro a consultar: ");
                        int idC = Convert.ToInt32(Console.ReadLine());
                        Console.WriteLine($"\nClave: {ado.Consultar(idC).clave} Nombre: {ado.Consultar(idC).nombre}");
                        Console.ReadKey();
                        break;
                    //Agregar
                    case 3:
                        Console.Clear();
                        Console.WriteLine("Opción: Agregar\n");
                        Console.Write("Ingrese la Clave del nuevo registro: ");
                        string claveA = Console.ReadLine();
                        Console.Write("Ingrese el Nombre del nuevo registro: ");
                        string nombreA = Console.ReadLine();
                        Estatus est = new Estatus();
                        est.clave = claveA;
                        est.nombre = nombreA;
                        try
                        {
                            ado.Agregar(est);
                            Console.WriteLine($"Registro agregado correctamente con Clave: {claveA} y Nombre: {nombreA}");
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine($"No se pudo agregar el registro: {e}");
                        }
                        Console.ReadKey();
                        break;
                    //Actualizar
                    case 4:
                        Console.Clear();
                        Console.WriteLine("Opción: Actualizar");
                        Console.Write("Ingrese el ID del registro que se desea actualizar: ");
                        int idU = Convert.ToInt32(Console.ReadLine());
                        Console.WriteLine($"\nClave: {ado.Consultar(idU).clave} Nombre: {ado.Consultar(idU).nombre}\n");
                        Console.Write("Ingrese el nuevo valor de Clave: ");
                        string claveU = Console.ReadLine();
                        Console.Write("Ingrese ek nuevo valor de Nombre: ");
                        string nombreU = Console.ReadLine();
                        Estatus estatusU = new Estatus();
                        estatusU.id = idU;
                        estatusU.clave = claveU;
                        estatusU.nombre = nombreU;
                        try
                        {
                            ado.Actualizar(estatusU);
                            Console.WriteLine("Registro actualizado correctamente");
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine($"Hubo un error al momento de actualizar: {e}");
                        }
                        Console.ReadKey();
                        break;
                    //Eliminar
                    case 5:
                        Console.Clear();
                        Console.WriteLine("Opción: Eliminar\n");
                        Console.Write("Ingrese el ID del registro que desea eliminar: ");
                        int idE = Convert.ToInt32(Console.ReadLine());
                        Console.WriteLine($"\nClave: {ado.Consultar(idE).clave} Nombre: {ado.Consultar(idE).nombre}\n");
                        Console.WriteLine("¿Esta seguro que desea eliminar el registro?\n" +
                            "1.- Si\n" +
                            "2.- No\n");
                        Console.Write("> ");
                        int res = Convert.ToInt32(Console.ReadLine());
                        if (res == 1)
                        {
                            try
                            {
                                ado.Eliminar(idE);
                                Console.WriteLine($"Registro {idE} eliminado correctamente");
                            }
                            catch (Exception e)
                            {
                                Console.WriteLine($"Hubo un error al momento de eliminar el registro: {e}");
                            }
                        }
                        Console.ReadKey();
                        break;
                }
                Console.Clear();
            }
        }
    }
}
