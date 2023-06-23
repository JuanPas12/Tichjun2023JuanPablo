using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace PuntoVenta
{
    public class Operaciones
    {
        public static List<Articulo> _lstArticulos = new List<Articulo>();
        public static List<string> _lstCarrito = new List<string>();
        internal static void CargarArticulos()
        {
            string strRuta = File.ReadAllText(@"C:\Users\juanp\Desktop\TICH\Intro_CSharp\22-06-2023\Resources\Articulos.json");
            _lstArticulos = JsonConvert.DeserializeObject<List<Articulo>>(strRuta);
        }

        internal static void Presentacion()
        {
            CargarArticulos();
            decimal totalPagar = 0;
            string respuesta = "V";
            while (respuesta != "T" && respuesta != "t")
            {
                Console.Clear();
                Console.Write("Empresa ");
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine("TICH");
                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine("Iniciar una nueva venta (V) Terminar (T)");
                respuesta = Console.ReadLine();
                if (respuesta == "V" || respuesta == "v")
                {
                    Console.Write("Ingrese el ID del articulo: ");
                    int id = Convert.ToInt32(Console.ReadLine());
                    Console.Write("Ingrese la cantidad: ");
                    int cantidad = Convert.ToInt32(Console.ReadLine());
                    Articulo artBusqueda = _lstArticulos.Find(x => x.id == id);
                    switch (artBusqueda.tipo)
                    {
                        case 1:
                            Item item = new Item(artBusqueda, cantidad);
                            _lstCarrito.Add(item.Imprimir());
                            totalPagar = totalPagar + item.Total();
                            Console.WriteLine(item.Imprimir());
                            break;
                        case 2:
                            Console.WriteLine("¿Cuanto descuento se va a aplicar?");
                            int descuento = Convert.ToInt32(Console.ReadLine());
                            ItemDescuento itemDesc = new ItemDescuento(artBusqueda, cantidad);
                            itemDesc._descuento = descuento;
                            _lstCarrito.Add(itemDesc.Imprimir());
                            totalPagar = totalPagar + itemDesc.Total();
                            Console.WriteLine(itemDesc.Imprimir());
                            break;
                        case 3:
                            Console.Write("Ingrese el numero de telefono: ");
                            string telefono = Console.ReadLine();
                            Console.Write("Ingrese la compañia: ");
                            string compania = Console.ReadLine();
                            Console.Write("Ingrese la comision: ");
                            decimal comision = Convert.ToDecimal(Console.ReadLine());
                            ItemTA itemta = new ItemTA(artBusqueda, cantidad);
                            itemta._Telefono = telefono;
                            itemta._Compania = compania;
                            itemta._Comision = comision;
                            _lstCarrito.Add(itemta.Imprimir());
                            totalPagar = totalPagar + itemta.Total();
                            Console.WriteLine(itemta.Imprimir());
                            break;
                        default:
                            Console.WriteLine("No se encontro ningun articulo con ese ID");
                            break;
                    }

                    Console.WriteLine("Ingrese (TV) para terminar la venta");
                    string respuesta2 = Console.ReadLine();
                    if (respuesta2 == "TV" || respuesta2 == "tv")
                    {
                        Console.Clear();
                        Console.Write("Empresa ");
                        Console.ForegroundColor = ConsoleColor.Green;
                        Console.WriteLine("TICH");
                        Console.ForegroundColor = ConsoleColor.White;
                        foreach (var imp in _lstCarrito)
                        {
                            Console.WriteLine(imp);
                        }
                        Console.WriteLine($"\nTotal a pagar: {totalPagar.ToString("C")}");
                        Console.ReadKey();
                    }
                }
            }
        }
    }
}
