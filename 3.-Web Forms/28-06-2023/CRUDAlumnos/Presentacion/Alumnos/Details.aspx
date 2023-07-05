<%@ Page Title="Detalles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Presentacion.Alumnos.Details" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
    <asp:Label ID="lblHidden" runat="server" Text=""></asp:Label>
    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderISR" runat="server" TargetControlID="lblHidden" PopupControlID="modalISR" DropShadow="true">
        <Animations>
        <OnShown>
            <FadeIn Duration="0.5" />
        </OnShown>
        <OnHiding>
            <FadeOut Duration="0.5" />
        </OnHiding>
    </Animations>
    </ajaxToolkit:ModalPopupExtender>
    <div class="container d-flex flex-column w-50 position-relative m-0">
        <h1>Datos del Alumno</h1>
        <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblId" runat="server" Text="ID"></asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblidR" runat="server" Text=""></asp:Label></div>
        </div>
        <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblNombre" runat="server" Text="Nombre"></asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblNombreR" runat="server" Text=""></asp:Label></div>
        </div>
        <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblPA" runat="server" Text="Primer Apellido"></asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblPAR" runat="server" Text=""></asp:Label></div>
        </div>
        <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblSA" runat="server" Text="Segundo Apellido"></asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblSAR" runat="server" Text=""></asp:Label></div>
        </div>
        <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblFN" runat="server" Text="Label">Fecha Nacimiento</asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblFechaN" runat="server" Text=""></asp:Label></div>
        </div>
        <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblCURP" runat="server" Text="Label">CURP</asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblCURPR" runat="server" Text=""></asp:Label></div>
        </div>
        <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblCorreo" runat="server" Text="Label">Correo</asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblCorreoR" runat="server" Text=""></asp:Label></div>
        </div>
         <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblTel" runat="server" Text="Label">Telefono</asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblTelR" runat="server" Text=""></asp:Label></div>
        </div>
         <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblSM" runat="server" Text="Label">Sueldo Mensual</asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblSMR" runat="server" Text=""></asp:Label></div>
        </div>
         <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblEstado" runat="server" Text="Label">Estado</asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblEstadoR" runat="server" Text=""></asp:Label></div>
        </div>
         <div class ="row">
            <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblEstatus" runat="server" Text="Label">Estatus</asp:Label></strong></div>
            <div class="col-sm"><asp:Label ID="lblEstatusR" runat="server" Text=""></asp:Label></div>
        </div>
        <br />
        <div class ="row">
            <div class="col-sm"><a id="btnIMSS" runat="server" class="btn btn-primary">CalcularIMSS</a></div>
            <div class="col-sm"><asp:Button ID="btnISR" runat="server" Text="CalcularISR" class="btn btn-light" OnClick="btnISR_Click"/></div>
        </div>
        <br />
        <br />
    </div>
    <a href ="Index.aspx" class="btn text-decoration-none text-primary">Regresar a Lista</a>
    
        <div id="modalISR" runat="server" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdrop" aria-hidden="true" class="bg-white px-xxl-5 py-sm-2" style="width: 40rem; border: solid 0.05rem">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="margin-bottom: 2rem">
                <strong><h1 class="modal-title fs-5">Calculo del ISR</h1></strong>
                <asp:Button ID="Button2" runat="server" CssClass="btn btn-close"/>
                </div>
                <div class="modal-body">
                        <div class="row"><asp:Label ID="Label1" runat="server" Text="Limite Inferior" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblLimInf" runat="server" Text=""></asp:Label></div>
                        <div class="row"><asp:Label ID="Label3" runat="server" Text="Limite Superior" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblLimSup" runat="server" Text=""></asp:Label></div>
                        <div class="row"><asp:Label ID="Label5" runat="server" Text="Cuota Fija" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblCuota" runat="server" Text=""></asp:Label></div>
                        <div class="row"><asp:Label ID="Label7" runat="server" Text="Excedente Limite Inferior" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblExcedente" runat="server" Text="" ></asp:Label></div>
                        <div class="row"><asp:Label ID="Label9" runat="server" Text="Subsidio" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblSubsidio" runat="server" Text=""></asp:Label></div>
                        <div class="row"><asp:Label ID="Label11" runat="server" Text="Impuesto" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblImpuesto" runat="server" Text=""></asp:Label></div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="Button3" runat="server" Text="Cerrar" CssClass="btn btn-danger"/>
                    </div>
                </div>
            </div>
        </div>  
        <div class="modal" id="modalIMSS" tabindex="-1" aria-labelledby="modalIMSSlabel" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header" style="margin-bottom: 2rem">
                        <h1 class="modal-title fs-5">Calculo del IMSS</h1>
                        <asp:Button ID="btnCrerrarImms" runat="server" CssClass="btn btn-close"/>
                    </div>
                    <div class="modal-body">
                        <div class="row"><asp:Label ID="Label13" runat="server" Text="Enfermedades y Maternidad" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblEyM" runat="server" Text=""></asp:Label></div>
                        <div class="row"><asp:Label ID="Label15" runat="server" Text="Invalidez y Vida" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblIyV" runat="server" Text=""></asp:Label></div>
                        <div class="row"><asp:Label ID="Label17" runat="server" Text="Retiro" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblRetiro" runat="server" Text=""></asp:Label></div>
                        <div class="row"><asp:Label ID="Label19" runat="server" Text="Cesantia" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblCesantia" runat="server" Text=""></asp:Label></div>
                        <div class="row"><asp:Label ID="Label21" runat="server" Text="Infonavit" CssClass="fw-bold"></asp:Label></div>
                        <div class="row"><asp:Label ID="lblInfo" runat="server" Text=""></asp:Label></div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnCerrarIMSS" runat="server" Text="Cerrar" CssClass="btn btn-danger"/>
                        
                    </div>
                </div>
            </div>
        </div>
    <script>
        $(document).ready(function () {
            $("#modalIMSS").hide();
            var idAlm = $("#<%=lblidR.ClientID%>").text();
            var idAlm2 = parseInt(idAlm);
            var alumno = { id: idAlm2 };
            var param = JSON.stringify(alumno);

            $("#<%=btnIMSS.ClientID%>").click(function (e) { 
                $.ajax(
                    {
                        type: "POST",
                        url: 'http://localhost:49433/WSAlumnos.asmx/CalcularIMSS',
                        data: param,
                        contentType: "application/json; charset=utf8",
                        dataType: "json",
                        success: funcExito,
                        error: errorGen
                    }
                );
                $("#modalIMSS").show('show');
            });

            function funcExito(resultado, estatus, jqXHR){
                var res = resultado.d;
                try {
                    if (res != null) {
                            $("#<%=lblEyM.ClientID%>").text(res.EnfermedadMaternidad);
                            $("#<%=lblIyV.ClientID%>").text(res.InvalidezVida);
                            $("#<%=lblRetiro.ClientID%>").text(res.Retiro);
                            $("#<%=lblCesantia.ClientID%>").text(res.Cesantia);
                            $("#<%=lblInfo.ClientID%>").text(res.Infonavit);;
                        }
                    else {
                        alert("La respuesta recibida del Web Service es incorrecta" + resultado.d);
                    }
                } catch (e) {
                    alert("Error al recibir los datos")
                }
            } 
                function errorGen(jqXHR, estatus, error) {
                    var msg = '';
                    if (jqXHR.status === 0) {
                        msg = 'No está conectado, favor de verificar su conexión.';
                    }
                    else if (jqXHR.status === 404) {
                        msg = 'Página no encontrada [404]';
                    }
                    else if (jqXHR.status === 500) {
                        msg = 'Error no hay conexión al servidor [500]';
                    }
                    else if (jqXHR.status === 'parseerror') {
                        msg = 'El parseo del JSON es erróneo.';
                    }
                    else if (jqXHR.status === 'timeout') {
                        $('body').addClass('loaded');
                    }
                    else if (jqXHR.status === 'abort') {
                        msg = 'La petición Ajax fue abortada.';
                    }
                    else {
                        msg = 'Error no conocido. ';
                        console.log(exception);
                    }
                    alert(msg);
                }
                
        });
    </script>
</asp:Content>
