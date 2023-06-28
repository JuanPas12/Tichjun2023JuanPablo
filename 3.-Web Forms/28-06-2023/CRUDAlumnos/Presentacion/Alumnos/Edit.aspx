<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Presentacion.Alumnos.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class ="container">
        <div class ="col">
            <strong><asp:Label ID="lblId" runat="server" Text="Id"></asp:Label></strong>
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
        <div class ="col">
            <asp:TextBox ID="txtId" runat="server" Enabled="False"></asp:TextBox>
            <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtPA" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtSA" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtFN" runat="server" TextMode="Date"></asp:TextBox>
            <asp:TextBox ID="txtCURP" runat="server" MaxLength=18></asp:TextBox>
            <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email"></asp:TextBox>
            <asp:TextBox ID="txtTel" runat="server" MaxLength= 10 TextMode="Phone"></asp:TextBox>
            <asp:TextBox ID="txtSueldo" runat="server" TextMode="Number"></asp:TextBox>
            <asp:DropDownList ID="ddlEstado" runat="server"></asp:DropDownList>
            <asp:DropDownList ID="ddlEstatus" runat="server"></asp:DropDownList>
            <br />
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
            <br />
            <a href ="Index.aspx">Regresar a Lista</a>
</asp:Content>
