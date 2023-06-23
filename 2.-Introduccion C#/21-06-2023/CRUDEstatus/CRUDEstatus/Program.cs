using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDEstatus
{
    internal class Program
    {
        static void Main(string[] args)
        {
            byte op = 0;
            while (!(op == 6))
            {
                Console.ForegroundColor = ConsoleColor.DarkMagenta;
                Console.WriteLine("Menu Listas CRUD\n");
                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine(
                "1.- Consultar Todos \n" +
                "2.- Consultar Solo Uno \n" +
                "3.- Agregar \n" +
                "4.- Actualizar \n" +
                "5.- Eliminar \n" +
                "6.- Terminar");
                Console.ForegroundColor = ConsoleColor.DarkGray;
                Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                Console.ForegroundColor = ConsoleColor.White;
                op = Convert.ToByte(Console.ReadLine());
                Console.Clear();
                switch (op)
                {
                    case 1:
                        Console.ForegroundColor = ConsoleColor.DarkMagenta;
                        Console.WriteLine("Datos de la lista");
                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        List<EstatusAlumnos> listaEstatusAlumnos = CRUD.ConsultarTodo();
                        foreach (var estatus in listaEstatusAlumnos)
                        {
                            Console.ForegroundColor = ConsoleColor.White;
                            Console.WriteLine($"ID: {estatus.id}, Clave: {estatus.clave}, Nombre: {estatus.nombre}");
                            Console.ForegroundColor = ConsoleColor.DarkGray;
                            Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        }

                        Console.ForegroundColor = ConsoleColor.Green;
                        Console.WriteLine("\nPresiona cualquier tecla para salir");
                        Console.ReadKey();
                        break;
                    case 2:
                        Console.ForegroundColor = ConsoleColor.DarkMagenta;
                        Console.WriteLine("Buscar un registro");
                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.Write("Ingrese el ID a buscar: ");
                        int idB = Convert.ToInt32(Console.ReadLine());
                        EstatusAlumnos res = CRUD.ConsultarUno(idB);
                        Console.WriteLine($"\nResultado de la busqueda:\nClave: {res.clave}\nNombre: {res.nombre}");

                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        Console.ForegroundColor = ConsoleColor.Green;
                        Console.WriteLine("\nPresiona cualquier tecla para salir");
                        Console.ReadKey();
                        break;
                    case 3:
                        Console.ForegroundColor = ConsoleColor.DarkMagenta;
                        EstatusAlumnos estatusA = new EstatusAlumnos();
                        Console.WriteLine("Agregar un valor");
                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.Write("Ingrese el ID: ");
                        estatusA.id = Convert.ToInt32(Console.ReadLine());
                        Console.Write("Ingrese la Clave: ");
                        estatusA.clave = Console.ReadLine();
                        Console.Write("Ingrese el Nombre: ");
                        estatusA.nombre = Console.ReadLine();

                        CRUD.Agregar(estatusA);

                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        Console.ForegroundColor = ConsoleColor.Green;
                        Console.WriteLine("\nDatos guardados correctamente resiona cualquier tecla para salir");
                        Console.ReadKey();
                        break;
                    case 4:
                        Console.ForegroundColor = ConsoleColor.DarkMagenta;
                        EstatusAlumnos estatusAActua = new EstatusAlumnos();
                        Console.WriteLine("Actualizar datos");
                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.Write("Ingrese ek ID del elemento que desea actualizar: ");
                        estatusAActua.id = Convert.ToInt32(Console.ReadLine());
                        Console.WriteLine("¿Que datos desea actualizar? \n" +
                            "1.- Clave \n" +
                            "2.- Nombre \n" +
                            "3.- Todos");
                        int o = Convert.ToInt32(Console.ReadLine());
                        switch (o)
                        {
                            case 1:
                                Console.Write("Ingrese ek nuevo valor de Clave: ");
                                estatusAActua.clave = Console.ReadLine();
                                break;
                            case 2:
                                Console.Write("Ingrese el nuevo valor de Nombre: ");
                                estatusAActua.nombre = Console.ReadLine();
                                break;
                            case 3:
                                Console.Write("Ingrese ek nuevo valor de Clave: ");
                                estatusAActua.clave = Console.ReadLine();
                                Console.Write("Ingrese el nuevo valor de Nombre: ");
                                estatusAActua.nombre = Console.ReadLine();
                                break;
                            default:
                                Console.WriteLine("Opción invalida");
                                break;
                        }

                        CRUD.Actualizar(estatusAActua.id, estatusAActua, o);

                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        Console.ForegroundColor = ConsoleColor.Green;
                        Console.WriteLine("\nDatos actualizados correctamente resiona cualquier tecla para salir");
                        Console.ReadKey();
                        break;
                    case 5:
                        Console.ForegroundColor = ConsoleColor.DarkMagenta;
                        Console.WriteLine("Eliminar un registro");
                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.Write("Ingresa el ID de el registro a eliminar: ");
                        int idE = Convert.ToInt32(Console.ReadLine());

                        CRUD.Eliminar(idE);

                        Console.ForegroundColor = ConsoleColor.DarkGray;
                        Console.WriteLine("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_");
                        Console.ForegroundColor = ConsoleColor.Green;
                        Console.WriteLine("\nDatos eliminados correctamente resiona cualquier tecla para salir");
                        Console.ReadKey();
                        break;
                    default:
                        Console.ForegroundColor = ConsoleColor.Red;
                        Console.WriteLine("Opción invalida");
                        Console.ReadKey();
                        break;
                }
                Console.Clear();
            }
        }
    }
}
