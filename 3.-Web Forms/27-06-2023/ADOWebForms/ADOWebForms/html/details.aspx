<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="details.aspx.cs" Inherits="ADOWebForms.html.detalles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class ="container">
        <h1>Detalles</h1>
        <strong><asp:Label ID="lblIdTitulo" runat="server" Text="Id"></asp:Label></strong>
        <asp:Label ID="lblId" runat="server" Text=""></asp:Label>
        <br />
         <strong><asp:Label ID="lblNombreTitulo" runat="server" Text="Nombre "></asp:Label></strong>
        <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label>
        <br />
         <strong><asp:Label ID="lblClaveTitulo" runat="server" Text="Clave "></asp:Label></strong>
        <asp:Label ID="lblClave" runat="server" Text=""></asp:Label>
        <br />
        <a href="../index.aspx">Regresar a la Lista</a>
    </div>
</asp:Content>
