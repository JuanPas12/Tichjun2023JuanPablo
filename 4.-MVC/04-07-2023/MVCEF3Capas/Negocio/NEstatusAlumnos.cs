using Entidades;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class NEstatusAlumnos
    {
        List<EstatusAlumnos> _lstEstatus = new List<EstatusAlumnos>();
        EstatusAlumnos _Estatus = new EstatusAlumnos();
        const string urlWebAPI = "http://localhost:5098/api/Estatus";

        public List<EstatusAlumnos> Consultar()
        {
            try
            {
                using (var cliente = new HttpClient())
                {
                    Task<HttpResponseMessage> responseTask = cliente.GetAsync(urlWebAPI);
                    responseTask.Wait();
                    HttpResponseMessage result = responseTask.Result;
                    if (result.IsSuccessStatusCode)
                    {
                        Task<String> readTask = result.Content.ReadAsStringAsync();
                        readTask.Wait();
                        string json = readTask.Result;

                        _lstEstatus = JsonConvert.DeserializeObject<List<EstatusAlumnos>>(json);
                    }
                    else
                    {
                        throw new Exception($"WebAPI. Respondio con el error: {result.StatusCode}");
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception($"WebAPI. Respondio con el error: {ex.Message}");
            }
            return _lstEstatus;
        }

        public EstatusAlumnos Consultar(int id)
        {
            try
            {
                using (var cliente = new HttpClient())
                {
                    Task<HttpResponseMessage> responseTask = cliente.GetAsync(urlWebAPI + $"/{id}");
                    responseTask.Wait();
                    HttpResponseMessage result = responseTask.Result;
                    if (result.IsSuccessStatusCode)
                    {
                        Task<String> readTask = result.Content.ReadAsStringAsync();
                        readTask.Wait();
                        string json = readTask.Result;

                        _Estatus = JsonConvert.DeserializeObject<EstatusAlumnos>(json);
                    }
                    else
                    {
                        throw new Exception($"WebAPI. Respondio con el error: {result.StatusCode}");
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception($"WebAPI. Respondio con el error: {ex.Message}");
            }
            return _Estatus;
        }

        public void Agregar(EstatusAlumnos est)
        {
            try
            {
                using (var cliente = new HttpClient())
                {
                    string json = JsonConvert.SerializeObject(est);
                    StringContent content = new StringContent(json, Encoding.UTF8, "application/json");
                    Task<HttpResponseMessage> responseTask = cliente.PostAsync(urlWebAPI, content);
                    responseTask.Wait();
                    HttpResponseMessage result = responseTask.Result;
                    if (!(result.IsSuccessStatusCode))
                    {
                        throw new Exception($"WebAPI. Respondio con el error: {result.StatusCode}");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"WebAPI. Respondio con el error: {ex.Message}");
            }
        }

        public void Actualizar(EstatusAlumnos est)
        {
            try
            {
                using (var cliente = new HttpClient())
                {
                    string json = JsonConvert.SerializeObject(est);
                    StringContent content = new StringContent(json, Encoding.UTF8, "application/json");
                    Task<HttpResponseMessage> responseTask = cliente.PutAsync(urlWebAPI + $"/{est.id}", content);
                    responseTask.Wait();
                    HttpResponseMessage result = responseTask.Result;
                    if (!(result.IsSuccessStatusCode))
                    {
                        throw new Exception($"WebAPI. Respondio con el error: {result.StatusCode}");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"WebAPI. Respondio con el error: {ex.Message}");
            }
        }

        public void Eliminar(int id)
        {
            try
            {
                using (var cliente = new HttpClient())
                {
                    Task<HttpResponseMessage> responseTask = cliente.DeleteAsync(urlWebAPI + $"/{id}");
                    responseTask.Wait();
                    HttpResponseMessage result = responseTask.Result;
                    if (!(result.IsSuccessStatusCode))
                    {
                        throw new Exception($"WebAPI. Respondio con el error: {result.StatusCode}");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"WebAPI. Respondio con el error: {ex.Message}");
            }
        }
    }
}
