<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Presentacion.Alumnos.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid d-flex flex-column w-75 position-relative m-0 xl-12"">
        <h1>Editar Alumno</h1>
        <form class="form-control">

            <!-- Id -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"><strong><asp:Label ID="lblId" runat="server" Text="Id"></asp:Label></strong></div>
                <div class="col-sm-3"><asp:TextBox ID="txtId" runat="server" Enabled="False" CssClass="form-control w-75"></asp:TextBox></asp:TextBox></div>
            </div>
            <!-- Nombre -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"> <strong><asp:Label ID="lblNombre" runat="server" Text="Nombre"></asp:Label></strong></div>
                <div class="col-sm-3"><asp:TextBox ID="txtNombre" runat="server" CssClass="form-control w-100"></asp:TextBox></div>
                <div class="col-sm-6">
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ErrorMessage="El campo Nombre es requerido." CssClass="text-danger position-absolute fw-bold" ControlToValidate="txtNombre"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revNombre" runat="server" ErrorMessage="Formato incorrecto, compruebe que no incluya caracteres especiales o numeros." CssClass="text-danger position-absolute fw-bold"
                    ControlToValidate="txtNombre" ValidationExpression="^[A-Za-zñÑ\s]+$"></asp:RegularExpressionValidator>
                </div>
            </div>

            <!-- Primer Apellido -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"> <strong><asp:Label ID="lblPA" runat="server" Text="Primer Apellido"></asp:Label></strong></div>
                <div class="col-sm-3"><asp:TextBox ID="txtPA" runat="server" CssClass="form-control w-100"></asp:TextBox></div>
                <div class="col-sm-6">
                    <asp:RequiredFieldValidator ID="rfPA" runat="server" ErrorMessage="El campo Primer Apellido es requerido." CssClass="text-danger position-absolute fw-bold" ControlToValidate="txtPA"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPA" runat="server" ErrorMessage="Formato incorrecto, compruebe que no incluya caracteres especiales o numeros." CssClass="text-danger position-absolute fw-bold"
                    ControlToValidate="txtPA" ValidationExpression="^[A-Za-zñÑ\s]+$"></asp:RegularExpressionValidator>
                </div>
            </div>

            <!-- Segundo Apellido -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"><strong><asp:Label ID="lblSA" runat="server" Text="Segundo Apellido"></asp:Label></strong></div>
                <div class="col-sm-3"> <asp:TextBox ID="txtSA" runat="server" CssClass="form-control w-75"></asp:TextBox></div>
                <div class="col-sm">
                    <asp:RegularExpressionValidator ID="revSA" runat="server" ErrorMessage="Formato incorrecto, compruebe que no incluya caracteres especiales o numeros." CssClass="text-danger position-absolute fw-bold"
                    ControlToValidate="txtSA" ValidationExpression="^[A-Za-zñÑ\s]+$"></asp:RegularExpressionValidator>
                </div>
            </div>
            <!-- Fecha de Nacimiento -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"><strong><asp:Label ID="lblFN" runat="server" Text="Label">Fecha Nacimiento</asp:Label></strong></div>
                <div class="col-sm-3"><asp:TextBox ID="txtFN" runat="server" TextMode="Date" CssClass="form-control w-100"></asp:TextBox></div>
                <div class="col-sm-6">
                    <asp:RequiredFieldValidator ID="rfvFechaN" runat="server" ErrorMessage="El campo Fecha Nacimiento es requerido." CssClass="text-danger position-absolute fw-bold" ControlToValidate="txtFN"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="rvFechaNacimiento" runat="server" ErrorMessage="El campo Fecha Nacimiento debe de estar entre 01-ene-1990 y 31-dic-2000." CssClass="text-danger fw-bold position-absolute" ControlToValidate="txtFN" 
                    Type="Date" MinimumValue="1990-01-01" MaximumValue="31-12-2000"></asp:RangeValidator>
                </div>
            </div>

            <!-- CURP -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"><strong><asp:Label ID="lblCURP" runat="server" Text="Label">CURP</asp:Label></strong></div>
                <div class="col-sm-3"><asp:TextBox ID="txtCURP" runat="server" MaxLength=18 CssClass="form-control w-100"></asp:TextBox></div>
                <div class="col-sm">
                    <asp:RequiredFieldValidator ID="rfvCURP" runat="server" ErrorMessage="El campo CURP es requerido." CssClass="text-danger position-absolute fw-bold" ControlToValidate="txtCURP"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvServerCURPvFN" runat="server" ErrorMessage="La fecha de nacimiento del CURP no coincide con la seleccionada anteriormente."
                    CssClass="text-danger position-absolute fw-bold" ControlToValidate="txtCURP" OnServerValidate="cvServerCURPvFN_ServerValidate"></asp:CustomValidator>
                    <asp:CustomValidator ID="cvCurpFormato" runat="server" ErrorMessage="El CURP proporcionado no cumple con el formato correcto." CssClass="text-danger position-absolute fw-bold"
                        ControlToValidate="txtCURP" ClientValidationFunction="CurpFormato"></asp:CustomValidator>
                </div>
            </div>

            <!-- Correo -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"><strong><asp:Label ID="lblCorreo" runat="server" Text="Label">Correo</asp:Label></strong></div>
                <div class="col-sm-3"><asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" CssClass="form-control w-100"></asp:TextBox></div>
                <div class="col-sm">
                    <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ErrorMessage="El Correo es requerido." CssClass="text-danger position-absolute fw-bold" ControlToValidate="txtCorreo"></asp:RequiredFieldValidator>
                </div>
            </div>

            <!-- Telefono -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"><strong><asp:Label ID="lblTel" runat="server" Text="Label">Telefono</asp:Label></strong></div>
                <div class="col-sm-5"><asp:TextBox ID="txtTel" runat="server" MaxLength= 10 TextMode="Phone" CssClass="form-control w-100"></asp:TextBox></div>
            </div>

            <!-- Sueldo Mensual -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"> <strong><asp:Label ID="lblSM" runat="server" Text="Label">Sueldo Mensual</asp:Label></strong></div>
                <div class="col-sm-3"><asp:TextBox ID="txtSueldo" runat="server" TextMode="Number" CssClass="form-control w-100"></asp:TextBox></div>
                <div class="col-sm">
                    <asp:RangeValidator ID="rvSueldo" runat="server" ErrorMessage="El campo Sueldo Mensual debe de estar entre 10,000 y 40,000." CssClass="text-danger fw-bold position-absolute" ControlToValidate="txtSueldo" 
                    Type="Double" MinimumValue="10000" MaximumValue="40000"></asp:RangeValidator>
                </div>
            </div>

            <!-- Estado -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"><strong><asp:Label ID="lblEstado" runat="server" Text="Label">Estado</asp:Label></strong></div>
                <div class="col-sm-3"><asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select w-100"></asp:DropDownList></div>
            </div>
            <!-- Estatus -->
            <div class ="row">
                <div class="col-sm-3 d-flex justify-content-end"><strong><asp:Label ID="lblEstatus" runat="server" Text="Label">Estatus</asp:Label></strong></div>
                <div class="col-sm-3"><asp:DropDownList ID="ddlEstatus" runat="server" CssClass="form-select w-100"></asp:DropDownList></div>
            </div>
            <div class ="row">
                <div class="col-sm"><asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" class="btn btn-light"/></div>
            </div>
        </form>
    </div>
            <br />
            <a href ="Index.aspx" class="btn text-decoration-none text-primary">Regresar a Lista</a>
    <script type="text/javascript">
            function CurpFormato(source, args) {
                let patronCURP = /^[A-Z]{4}[\d]{6}[HM]{1}[A-Z]{5}[A-Z\d]{2}$/;
                let curp = args.Value;
                args.IsValid = patronCURP.test(curp);
            }
    </script>
</asp:Content>

