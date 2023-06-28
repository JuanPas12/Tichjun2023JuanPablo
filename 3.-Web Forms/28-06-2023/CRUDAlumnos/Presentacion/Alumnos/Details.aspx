<%@ Page Title="Detalles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Presentacion.Alumnos.Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Datos del Alumno</h1>
    <div CssClass="container">
        <div CssClass ="col align-content-end ">
            <strong><asp:Label ID="lblId" runat="server" Text="ID"></asp:Label></strong>
            <strong><asp:Label ID="lblNombre" runat="server" Text="Nombre"></asp:Label></strong>
            <strong><asp:Label ID="lblPA" runat="server" Text="Primer Apellido"></asp:Label></strong>
            <strong><asp:Label ID="lblSA" runat="server" Text="Segundo Apellido"></asp:Label></strong>
            <strong><asp:Label ID="lblFN" runat="server" Text="Label">Fecha Nacimiento</asp:Label></strong>
            <strong><asp:Label ID="lblCURP" runat="server" Text="Label">CURP</asp:Label></strong>
            <strong><asp:Label ID="lblCorreo" runat="server" Text="Label">Correo</asp:Label></strong>
            <strong><asp:Label ID="lblTel" runat="server" Text="Label">Telefono</asp:Label></strong>
            <strong><asp:Label ID="lblSM" runat="server" Text="Label">Sueldo Mensual</asp:Label></strong>
            <strong><asp:Label ID="lblEstado" runat="server" Text="Label">Estado</asp:Label></strong>
            <strong><asp:Label ID="lblEstatus" runat="server" Text="Label">Estatus</asp:Label></strong>

        </div>
        <div CssClass ="container">
            <asp:Label ID="lblidR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblNombreR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblPAR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblSAR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblFNR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblCURPR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblCorreoR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblTelR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblSMR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblEstadoR" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblEstatusR" runat="server" Text=""></asp:Label>
        </div>
        <br />
        <asp:Button ID="btnIMSS" runat="server" Text="CalcularIMSS" />
        <asp:Button ID="btnISR" runat="server" Text="CalcularISR" />
        <br />
        <a href ="Index.aspx">Regresar a Lista</a>
    </div>
</asp:Content>
