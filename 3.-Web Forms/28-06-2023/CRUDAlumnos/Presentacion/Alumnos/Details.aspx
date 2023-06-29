<%@ Page Title="Detalles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Presentacion.Alumnos.Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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
            <div class="col-sm"><asp:Button ID="btnIMSS" runat="server" Text="CalcularIMSS" class="btn btn-primary"/></div>
            <div class="col-sm"><asp:Button ID="btnISR" runat="server" Text="CalcularISR" class="btn btn-light"/></div>
        </div>
        <br />
        <br />
    </div>
    <a href ="Index.aspx" class="btn text-decoration-none text-primary">Regresar a Lista</a>
</asp:Content>
