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
        /*5. Implementar lo indicado en el punto 1, invocando los métodos correspondientes de 
        la clase ADOEstatus */
        //Cadena de conexión
        string _cnnString = ConfigurationManager.ConnectionStrings["InstitutoConnection"].ConnectionString;
        string _query;
        SqlCommand _comando;
        List<Estatus> _lstEstatus = new List<Estatus>();

        //1. Consultar Todos
        public List<Estatus> Consultar()
        {
            _query = "SELECT * FROM EstatusAlumnos";
            using (SqlConnection con = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, con);
                _comando.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader reader = _comando.ExecuteReader();
                while (reader.Read())
                {
                    _lstEstatus.Add(
                        new Estatus()
                        {
                            id = Convert.ToInt32(reader["id"]),
                            clave = reader["clave"].ToString(),
                            nombre = reader["nombre"].ToString(),
                        }
                        );
                }
                con.Close();
            }

            return _lstEstatus;
        }

        //2. Consultar Solo uno 
        public Estatus Consultar(int id)
        {
            _query = $"SELECT * FROM EstatusAlumnos WHERE id = {id}";
            using (SqlConnection conn = new SqlConnection(_cnnString))
            {
                _comando= new SqlCommand(_query, conn);
                _comando.CommandType = CommandType.Text;
                conn.Open();
                SqlDataReader reader = _comando.ExecuteReader();
                reader.Read();
                Estatus busqueda = new Estatus();
                busqueda.id = Convert.ToInt32(reader["id"]);
                busqueda.clave = reader["clave"].ToString();
                busqueda.nombre = reader["nombre"].ToString();

                return busqueda;
            }
        }
        
        //3.- Agragar
        public int Agregar(Estatus estatus)
        {
            int id = 0;
            //Agregar un registro a la tabla EstatusAlumnos
            _query = "InsertarEstatusAlumnos";
            using (SqlConnection con = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, con);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("Clave", estatus.clave);
                _comando.Parameters.AddWithValue("Nombre", estatus.nombre);
                con.Open();
                id = (Int32)_comando.ExecuteScalar();
                con.Close();
            }

            return id;

        }

        public void Actualizar(Estatus estatus)
        {
            throw new NotImplementedException();
        }
        public void Eliminar(int id)
        {
            throw new NotImplementedException();
        }
    }
}
