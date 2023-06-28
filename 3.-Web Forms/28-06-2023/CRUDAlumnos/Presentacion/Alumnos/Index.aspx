<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Presentacion.Alumnos.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h1>Listado Alumnos</h1>
        <br />
        <asp:Button ID="btnAgregar" runat="server" Text="Agregar" class="btn btn-primary" OnClick="btnAgregar_Click"/>
        <asp:GridView ID="gvAlumnos" runat="server" 
            AllowPaging="True" 
            AutoGenerateColumns="False" 
            BorderStyle="None"
            CssClass="table"
            GridLines="Horizontal"
            OnPageIndexChanging="gv_PageIndexChanging"
            OnRowCommand="gv_RowCommand"
            PageSize="3">
                <Columns>
                    <asp:BoundField DataField ="idA" HeaderText="Id" />
                    <asp:BoundField DataField ="nombreA" HeaderText="Nombre" />
                    <asp:BoundField DataField ="primerApellido" HeaderText="Primer Apellido" />
                    <asp:BoundField DataField ="segundoaPellido" HeaderText="Segundo Apellido" />
                    <asp:BoundField DataField ="correo" HeaderText="Correo" />
                    <asp:BoundField DataField ="telefono" HeaderText="Telefono" />
                    <asp:BoundField DataField="estadoA" HeaderText="Estados" />
                    <asp:BoundField DataField="estatusA" HeaderText="Estatus" />
                    <asp:ButtonField Text="Detalles" CommandName="btnDetalles">
                    <ControlStyle CssClass="btn btn-warning btn-sm" />
                    </asp:ButtonField>
                    <asp:ButtonField Text="Editar" CommandName="btnEditar">
                    <ControlStyle CssClass="btn btn-success btn-sm" />
                    </asp:ButtonField>
                    <asp:ButtonField Text="Eliminar" CommandName="btnEliminar">
                    <ControlStyle CssClass="btn btn-danger btn-sm" />
                    </asp:ButtonField>
                </Columns>
        </asp:GridView>
    </div>
</asp:Content>
