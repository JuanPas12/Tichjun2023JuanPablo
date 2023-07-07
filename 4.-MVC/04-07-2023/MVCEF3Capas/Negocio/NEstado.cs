using Datos;
using Entidades;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using System.Runtime.InteropServices;

namespace Negocio
{
    public class NEstado
    {
        private InstitutoTichEntities1 _DbContext = new InstitutoTichEntities1();
        private DRepositorio<Estados> _rEstados = new DRepositorio<Estados>();
        private List<Estados> _lstEstado = new List<Estados>();
        private Estados _Estado = new Estados();

        //Consumir API ============================================================
        private static readonly HttpClient _httpClient = new HttpClient();
        const string urlWebAPI = "https://localhost:7160/api/Estados";

        public List<Estados> ConsultarAPI()
        {
            try
            {
                using(var cliente = new HttpClient())
                {
                    Task<HttpResponseMessage> responseTask = cliente.GetAsync(urlWebAPI); //Si se va aconsultar solo 1 seria (urlWebAPI + $"/{id}")
                    responseTask.Wait();
                    HttpResponseMessage result = responseTask.Result;
                    if (result.IsSuccessStatusCode)
                    {
                        Task<String> readTask = result.Content.ReadAsStringAsync();
                        readTask.Wait();
                        string json = readTask.Result;

                        _lstEstado = JsonConvert.DeserializeObject<List<Estados>>(json);
                    }
                    else
                    {
                        throw new Exception($"WebAPI. Respondio con el error: {result.StatusCode}");
                    }

                }
            }
            catch(Exception ex)
            {
                throw new Exception($"WebAPI. Respondio con el error: {ex.Message}");
            }

            return _lstEstado;
        }
        //=========================================================================

        public List<Estados> Consultar()
        {
            return _rEstados.Consultar();
        }

        //public List<Estados> Consultar()
        //{
        //    _lstEstado = _DbContext.Estados.ToList();
        //    return _lstEstado;
        //}

        public Estados Consultar(int id)
        {
            _Estado = _DbContext.Estados.Find(id);
            return _Estado;
        }

        public void Agregar(Estados est)
        {
            _DbContext.Estados.Add(est);
            _DbContext.SaveChanges();
        }

        public void Actualizar(Estados est)
        {
            _DbContext.Entry(est).State = EntityState.Modified;
            _DbContext.SaveChanges();
        }

        public void Eliminar(int id)
        {
            _DbContext.Entry(_DbContext.Estados.Find(id)).State = EntityState.Deleted;
            _DbContext.SaveChanges();
        }
    }
}
