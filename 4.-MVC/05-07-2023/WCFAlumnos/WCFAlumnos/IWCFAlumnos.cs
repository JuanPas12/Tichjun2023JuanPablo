using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace WCFAlumnos
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IWCFAlumnos" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IWCFAlumnos
    {
        [OperationContract]
        AportacionesIMSS CalcularIMSS(int id);

        [OperationContract]
        ItemTablaISR CalcularISR(int id);
    }
}
