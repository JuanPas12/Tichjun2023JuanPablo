<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="create.aspx.cs" Inherits="ADOWebForms.html.create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class = "container">
        <form class ="form-control">
            <strong><asp:Label ID="lblId" runat="server" Text="Id" AssociatedControlID ="txtId"></asp:Label></strong>
            <asp:TextBox ID="txtId" runat="server" CssClass="input-group-text"></asp:TextBox>

            <strong><asp:Label ID="lblNombre" runat="server" Text="Nombre" AssociatedControlID ="txtNombre"></asp:Label></strong>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="input-group-text"></asp:TextBox>

            <strong><asp:Label ID="lblClave" runat="server" Text="Clave" AssociatedControlID ="txtClave"></asp:Label></strong>
            <asp:TextBox ID="txtClave" runat="server" CssClass="input-group-text"></asp:TextBox>

            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click"/>
            <br />
            <a href ="../index.aspx">Regresar a la Lista</a>
        </form>
    </div>
</asp:Content>
