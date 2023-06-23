using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HolaMundo
{
    internal class Saludo
    {
        //Metodo no estatico
        public string Saludar(string Nom)
        {
            return "Hola, " + Nom + " este es un metodo no estatico";
        }

        //Metodo estatico
        public static string SaludarEstatico(string Nom)
        {
            return "Hola, " + Nom + " este es un metodo estatico";
        }

    }
}
