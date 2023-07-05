using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;

namespace Datos
{
    public class DEstatusAlumno
    {
        string _cnnString = ConfigurationManager.ConnectionStrings["InstitutoConnection"].ConnectionString;
        string _query;
        SqlCommand _comando;
        List<EstatusAlumnos> _lstEstatus = new List<EstatusAlumnos>();
        EstatusAlumnos es = new EstatusAlumnos();

        public List<EstatusAlumnos> Consultar()
        {
            _query = "sp_consultarEstatusAlumnosTodos";
            using (SqlConnection conn = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand(_query, conn);
                _comando.CommandType = CommandType.StoredProcedure;
                conn.Open();
                SqlDataReader reader = _comando.ExecuteReader();
                while (reader.Read())
                {
                    _lstEstatus.Add(
                        new EstatusAlumnos()
                        {
                            id = Convert.ToInt32(reader["id"]),
                            nombre = reader["nombre"].ToString(),
                            clave = reader["clave"].ToString()
                        }
                        );
                }
            }
            return _lstEstatus;
        }

        public EstatusAlumnos Consultar(int id)
        {
            _query = "sp_consultarEstatusAlumnos";
            using (SqlConnection con = new SqlConnection(_cnnString))
            {
                _comando = new SqlCommand( _query, con);
                _comando.CommandType = CommandType.StoredProcedure;
                _comando.Parameters.AddWithValue("IDEA", id);
                con.Open();
                SqlDataReader reader = _comando.ExecuteReader();
                reader.Read();
                es = new EstatusAlumnos()
                {
                    id = Convert.ToInt32(reader["id"]),
                    nombre = reader["nombre"].ToString(),
                    clave = reader["clave"].ToString()
                };
            }
            return es;
        }
    }
}
