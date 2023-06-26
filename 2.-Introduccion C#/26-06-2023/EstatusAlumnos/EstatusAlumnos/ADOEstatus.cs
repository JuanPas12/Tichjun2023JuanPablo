﻿using System;
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

        //Cargar lista Usando SqlReader
        public List<Estatus> Consultar()
        {
            List<Estatus> _lstEstatus = new List<Estatus>();
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

        //1. Consultar Todos

    }
}
