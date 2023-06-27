var txtId = document.getElementById("txtId");
var txtNombre = document.getElementById("txtNombre");
var txtEdad = document.getElementById("txtEdad");
var cmbEstadoOrigen = document.getElementById("cmbEstadoOrigen");
var cbxEstatus = document.getElementById("cbxEstatus");
var btnEnviar = document.getElementById("btnEnviar");

btnEnviar.addEventListener("click", function () {
    if (!txtId.value) {
        alert("El campo de ID no puede estar vacio.");
    } else {
        txtNombre.value = "Juan Pablo";
        txtEdad.value = 22;
        cmbEstadoOrigen.value = 3;
        txtNombre.removeAttribute("disabled");
        txtEdad.removeAttribute("disabled");
        cmbEstadoOrigen.removeAttribute("disabled");
        cbxEstatus.removeAttribute("disabled");
        txtId.setAttribute("disabled", true);
        btnEnviar.value = "Guardar";

        btnEnviar.addEventListener("click", function () {
            alert("Registros guardados correctamente.");
            txtId.value = "";
            txtNombre.value = "";
            txtEdad.value = "";
            cmbEstadoOrigen.value = 1;
            txtNombre.setAttribute("disabled", true);
            txtEdad.setAttribute("disabled", true);
            cmbEstadoOrigen.setAttribute("disabled", true);
            cbxEstatus.setAttribute("disabled", true);
            txtId.removeAttribute("disabled");
            btnEnviar.value = "Consultar";
        });
    }
});
