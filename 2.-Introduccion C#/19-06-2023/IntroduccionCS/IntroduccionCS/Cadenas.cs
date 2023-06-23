using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IntroduccionCS
{
    internal class Cadenas
    {

        /*c) Crear el método estático HolaMundo el cual deberá tener la siguiente 
        Interacción con el usuario*/
        public static string HolaMundo(string nombre, string ap, string am, byte edad)
        {
            string cadenaConcatenacion = "Hola " + nombre + " " + ap + " " + am;
            string cadenaCompuesta = String.Format("{0} {1} {2} tiene {3} años.", nombre, ap, am, edad);
            string cadenaInterpolacionMayusculas = $"Gusto en conocerte {nombre.ToUpper()} {ap.ToUpper()} {am.ToUpper()}!!!";
            string cadenaRuta = "El archivo fue almacenado en \n C:\\Users\\juanp\\Desktop\\TICH\\Intro_CSharp";
            string cadenaRes = cadenaConcatenacion + "\n" + cadenaCompuesta + "\n" + cadenaInterpolacionMayusculas + "\n" + cadenaRuta;
            return cadenaRes.Trim();
        }
    }
}
