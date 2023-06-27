<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="delete.aspx.cs" Inherits="ADOWebForms.html.delete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div CssClass ="container">
        <h1>Eliminar</h1>
        <strong><asp:Label ID="lblIdTitulo" runat="server" Text="Id"></asp:Label></strong>
        <asp:Label ID="lblId" runat="server" Text=""></asp:Label>
        <br />
         <strong><asp:Label ID="lblNombreTitulo" runat="server" Text="Nombre "></asp:Label></strong>
        <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label>
        <br />
         <strong><asp:Label ID="lblClaveTitulo" runat="server" Text="Clave "></asp:Label></strong>
        <asp:Label ID="lblClave" runat="server" Text=""></asp:Label>
        <br />
        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click" />
        <br />
        <a href="../index.aspx">Regresar a la Lista</a>
    </div>
</asp:Content>
