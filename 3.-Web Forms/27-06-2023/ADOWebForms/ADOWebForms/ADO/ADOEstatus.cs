using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.NetworkInformation;

namespace ADOWebForms
{
    public class ADOEstatus : ICRUDEstatus
    {
        //Cadena de conexión
        string _cnnString = ConfigurationManager.ConnectionStrings["InstitutoConnection"].ConnectionString;
        string _query;
        SqlCommand _comando;
        List<Estatus> _lstEstatus;

        //1. Consultar Todos
        public List<Estatus> Consultar()
        {
            _lstEstatus = new List<Estatus>();
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
                _comando = new SqlCommand(_query, conn);
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
            _query = "InsertarEstatusAlumnosC";
            using (SqlConnection con = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, con);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("ID", estatus.id);
                _comando.Parameters.AddWithValue("Clave", estatus.clave);
                _comando.Parameters.AddWithValue("Nombre", estatus.nombre);
                con.Open();
                _comando.ExecuteNonQuery();
                //id = (Int32)_comando.ExecuteScalar();
                con.Close();
            }

            return id;

        }

        //4.- Actualizar
        public void Actualizar(Estatus estatus)
        {
            _query = $"UPDATE EstatusAlumnos SET clave = '{estatus.clave}' WHERE id = {estatus.id};" +
                $"UPDATE EstatusAlumnos SET nombre = '{estatus.nombre}' WHERE id = {estatus.id};";
            using (SqlConnection con = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, con);
                _comando.CommandType = CommandType.Text;
                con.Open();
                //ExecuteNonQuery() = Ejecuta el query que se le pasa pero no retorna ningun valor
                _comando.ExecuteNonQuery();
                con.Close();
            }
        }

        //5.- Eliminar
        public void Eliminar(int id)
        {
            _query = $"DELETE EstatusAlumnos WHERE id = {id}";
            using (SqlConnection con = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, con);
                _comando.CommandType = CommandType.Text;
                con.Open();
                //ExecuteNonQuery() = Ejecuta el query que se le pasa pero no retorna ningun valor
                _comando.ExecuteNonQuery();
                con.Close();
            }
        }
    }
}