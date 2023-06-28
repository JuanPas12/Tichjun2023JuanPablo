<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Presentacion.Alumnos.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container d-flex flex-column w-50 position-relative m-0">
        <h1>Agregar Alumno</h1>
        <form class="form-control">
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblId" runat="server" Text="Id"></asp:Label></strong></div>
                <div class="col-sm"><asp:TextBox ID="txtId" runat="server" Enabled="False" CssClass="form-control w-75"></asp:TextBox></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"> <strong><asp:Label ID="lblNombre" runat="server" Text="Nombre"></asp:Label></strong></div>
                <div class="col-sm"><asp:TextBox ID="txtNombre" runat="server" CssClass="form-control w-75" ></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"> <strong><asp:Label ID="lblPA" runat="server" Text="Primer Apellido"></asp:Label></strong></div>
                <div class="col-sm"><asp:TextBox ID="txtPA" runat="server" CssClass="form-control w-75"></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblSA" runat="server" Text="Segundo Apellido"></asp:Label></strong></div>
                <div class="col-sm"> <asp:TextBox ID="txtSA" runat="server" CssClass="form-control w-75"></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblFN" runat="server" Text="Label">Fecha Nacimiento</asp:Label></strong></div>
                <div class="col-sm"><asp:TextBox ID="txtFN" runat="server" TextMode="Date" CssClass="form-control w-75"></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblCURP" runat="server" Text="Label">CURP</asp:Label></strong></div>
                <div class="col-sm"><asp:TextBox ID="txtCURP" runat="server" MaxLength=18 CssClass="form-control w-75"></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblCorreo" runat="server" Text="Label">Correo</asp:Label></strong></div>
                <div class="col-sm"><asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" CssClass="form-control w-75"></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblTel" runat="server" Text="Label">Telefono</asp:Label></strong></div>
                <div class="col-sm"><asp:TextBox ID="txtTel" runat="server" MaxLength= 10 TextMode="Phone" CssClass="form-control w-75"></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"> <strong><asp:Label ID="lblSM" runat="server" Text="Label">Sueldo Mensual</asp:Label></strong></div>
                <div class="col-sm"><asp:TextBox ID="txtSueldo" runat="server" TextMode="Number" CssClass="form-control w-75"></asp:TextBox></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblEstado" runat="server" Text="Label">Estado</asp:Label></strong></div>
                <div class="col-sm"><asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select w-75"></asp:DropDownList></div>
            </div>
            <div class ="row">
                <div class="col-sm d-flex justify-content-end"><strong><asp:Label ID="lblEstatus" runat="server" Text="Label">Estatus</asp:Label></strong></div>
                <div class="col-sm"><asp:DropDownList ID="ddlEstatus" runat="server" CssClass="form-select w-75"></asp:DropDownList></div>
            </div>
            <div class ="row">
                <div class="col-sm"><asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" class="btn btn-light"/></div>
            </div>
        </form>
    </div>
            <br />
            <a href ="Index.aspx">Regresar a Lista</a>
        </div>
</asp:Content>