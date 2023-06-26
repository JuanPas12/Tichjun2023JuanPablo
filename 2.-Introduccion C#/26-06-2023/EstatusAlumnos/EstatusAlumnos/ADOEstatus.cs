using System;
using System.Collections.Generic;
//Acceso a base de datos
using System.Data.SqlClient;
using System.Data;
//Conexión
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//4. Crear la clase ADOEstatus que implemente la interfaz ICRUD usando ADO .Net 
namespace EstatusAlumnos
{
    public class ADOEstatus : ICRUDEstatus
    {
        List<Estatus> _lstEstatus = new List<Estatus>();


    }
}
