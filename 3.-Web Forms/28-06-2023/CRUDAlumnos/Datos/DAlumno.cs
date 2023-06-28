using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;

namespace Datos
{
    public class DAlumno
    {
        string _cnnString = ConfigurationManager.ConnectionStrings["InstitutoConnection"].ConnectionString;
        string _query;
        SqlCommand _comando;
        List<Alumno> _lstEstatus = new List<Alumno>();
        Alumno a = new Alumno();

        public List<Alumno> Consultar()
        {
            _query = "sp_consultarAlumnosTodos";
            using (SqlConnection conn = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, conn);
                _comando.CommandType = CommandType.StoredProcedure;
                conn.Open();
                SqlDataReader reader = _comando.ExecuteReader();
                while (reader.Read())
                {
                    _lstEstatus.Add(new Alumno()
                    {
                        id = Convert.ToInt32(reader["id"]),
                        nombre = reader["nombre"].ToString(),
                        primerApellido = reader["primerApellido"].ToString(),
                        segundoaPellido = reader["segundoaPellido"].ToString(),
                        correo = reader["correo"].ToString(),
                        telefono = reader["telefono"].ToString(),
                        fechaNacimiento = Convert.ToDateTime(reader["fechaNacimiento"]),
                        curp = reader["curp"].ToString(),
                        sueldo = reader["sueldo"] == DBNull.Value ? 0 : Convert.ToDecimal(reader["sueldo"]),
                        idEstadoOrigen = Convert.ToInt32(reader["idEstadoOrigen"]),
                        idEstatus = Convert.ToInt32(reader["idEstatus"])
                    }
                    ) ;
                }
                conn.Close();
            }
            return _lstEstatus;
        }

        public Alumno Consutar(int id)
        {
            _query = "sp_consultarAlumnos";
            using (SqlConnection conn = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, conn);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("IDA", id);
                conn.Open();
                SqlDataReader reader = _comando.ExecuteReader();
                reader.Read();
                a = new Alumno()
                {
                    id = Convert.ToInt32(reader["id"]),
                    nombre = reader["nombre"].ToString(),
                    primerApellido = reader["primerApellido"].ToString(),
                    segundoaPellido = reader["segundoaPellido"].ToString(),
                    correo = reader["correo"].ToString(),
                    telefono = reader["telefono"].ToString(),
                    fechaNacimiento = Convert.ToDateTime(reader["fechaNacimiento"]),
                    curp = reader["curp"].ToString(),
                    sueldo = reader["sueldo"] == DBNull.Value ? 0 : Convert.ToDecimal(reader["sueldo"]),
                    idEstadoOrigen = Convert.ToInt32(reader["idEstadoOrigen"]),
                    idEstatus = Convert.ToInt32(reader["idEstatus"])
                };
                conn.Close();
            }
            return a;
        }

        public void Agregar (Alumno a)
        {
            _query = "sp_agregarAlumnos";
            using (SqlConnection conn = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, conn);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("Nombre", a.nombre);
                _comando.Parameters.AddWithValue("AP", a.primerApellido);
                _comando.Parameters.AddWithValue("AM", a.segundoaPellido);
                _comando.Parameters.AddWithValue("Correo", a.correo);
                _comando.Parameters.AddWithValue("Telefono", a.telefono);
                _comando.Parameters.AddWithValue("FN", a.fechaNacimiento);
                _comando.Parameters.AddWithValue("CURP", a.curp);
                _comando.Parameters.AddWithValue("Sueldo", a.sueldo);
                _comando.Parameters.AddWithValue("IEO", a.idEstadoOrigen);
                _comando.Parameters.AddWithValue("IE", a.idEstatus);
                conn.Open();
                _comando.ExecuteNonQuery();
                conn.Close();
            }
        }

        public void Actualizar(Alumno a)
        {
            _query = "sp_actualizarAlumno";
            using (SqlConnection conn = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, conn);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("ID", a.id);
                _comando.Parameters.AddWithValue("Nombre", a.nombre);
                _comando.Parameters.AddWithValue("AP", a.primerApellido);
                _comando.Parameters.AddWithValue("AM", a.segundoaPellido);
                _comando.Parameters.AddWithValue("Correo", a.correo);
                _comando.Parameters.AddWithValue("Telefono", a.telefono);
                _comando.Parameters.AddWithValue("FN", a.fechaNacimiento);
                _comando.Parameters.AddWithValue("CURP", a.curp);
                _comando.Parameters.AddWithValue("Sueldo", a.sueldo);
                _comando.Parameters.AddWithValue("IEO", a.idEstadoOrigen);
                _comando.Parameters.AddWithValue("IE", a.idEstatus);
                conn.Open();
                _comando.ExecuteNonQuery();
                conn.Close();
            }
        }

        public void Eliminar(int id)
        {
            _query = "sp_eliminarAlumno";
            using (SqlConnection conn = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, conn);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("ID", id);
                conn.Open();
                _comando.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}
