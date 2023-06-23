using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDEstados
{
    internal class Program
    {
        static void Main(string[] args)
        {
            byte op = 0;
            while (!(op == 6))
                {
                Console.WriteLine("Elige una opción: \n" +
                "1.- Consultar Todos \n" +
                "2.- Consultar Solo Uno \n" +
                "3.- Agregar \n" +
                "4.- Actualizar \n" +
                "5.- Eliminar \n" +
                "6.- Terminar");

                op = Convert.ToByte(Console.ReadLine());
                Console.Clear();
                switch (op)
                {
                    case 1:
                        Console.WriteLine("Todos los estados");
                        Dictionary<int, Estado> _DicEstados = CRUD.ConsultarTodo();
                        foreach (KeyValuePair<int, Estado> kvp in _DicEstados)
                        {
                            Console.WriteLine($"id = {kvp.Key}, Nombre = {kvp.Value.nombre}");
                        }
                        Console.ReadKey();
                        break;
                    case 2:
                        Console.Write("Ingrese el ID a buscar: ");
                        int idBusqueda = Convert.ToInt32(Console.ReadLine());
                        Console.WriteLine("Resultado de la busqueda");
                        Console.WriteLine(CRUD.ConsultarUno(idBusqueda).nombre);
                        Console.ReadKey();
                        break;
                    case 3:
                        Console.Write("Ingresa el ID: ");
                        int idAgregar = Convert.ToInt32(Console.ReadLine());
                        Console.Write("Ingrese el nombre de el estado: ");
                        string nombreAgregar = Console.ReadLine();

                        Estado estado = new Estado();
                        estado.id = idAgregar;
                        estado.nombre = nombreAgregar;

                        CRUD.Agregar(estado);
                        break;
                    case 4:
                        Console.Write("Ingresa el ID del estado que se desea actualizar: ");
                        int idActualizar = Convert.ToInt32(Console.ReadLine());
                        Console.Write("Ingrese el nombre nuevo de el estado: ");
                        string nombreActualizar = Console.ReadLine();

                        Estado estadoA = new Estado();
                        estadoA.id = idActualizar;
                        estadoA.nombre = nombreActualizar;

                        CRUD.Actualizar(idActualizar, estadoA);
                        break;
                    case 5:
                        Console.Write("Ingresa el id del estado a eliminar: ");
                        int idEliminar = Convert.ToInt32(Console.ReadLine());
                        CRUD.Eliminar(idEliminar);
                        break;
                    default:
                        Console.WriteLine("Opción invalida");
                        break;
                }
                Console.Clear();
            }
        }
    }
}
