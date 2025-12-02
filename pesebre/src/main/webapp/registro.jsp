<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Pesebre Navideño</title>
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/registro.css">
<script type="module"
    src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js"></script>

<style>
    .error-msg {
        color: red;
        font-size: 14px;
        margin-top: 4px;
    }
</style>

<script>
function validarFormulario() {

    let nombre = document.getElementById("nombre");
    let apellido = document.getElementById("apellido");
    let estado = document.getElementById("estado");
    let email = document.getElementById("email");
    let clave = document.getElementById("clave");

    let valido = true;

    // Limpiar errores previos
    document.querySelectorAll(".error-msg").forEach(e => e.remove());

    function mostrarError(campo, mensaje) {
        let div = document.createElement("div");
        div.className = "error-msg";
        div.textContent = mensaje;
        campo.parentNode.appendChild(div);
        valido = false;
    }

    // Validar nombre (solo letras)
    if (nombre.value.trim() === "") {
        mostrarError(nombre, "Ingrese su nombre.");
    } else if (!/^[A-Za-zÁÉÍÓÚáéíóúñÑ ]+$/.test(nombre.value)) {
        mostrarError(nombre, "El nombre solo debe contener letras.");
    }

    // Validar apellido
    if (apellido.value.trim() === "") {
        mostrarError(apellido, "Ingrese su apellido.");
    } else if (!/^[A-Za-zÁÉÍÓÚáéíóúñÑ ]+$/.test(apellido.value)) {
        mostrarError(apellido, "El apellido solo debe contener letras.");
    }

    // Validar estado civil
    if (estado.value === "") {
        mostrarError(estado, "Seleccione un estado civil.");
    }

    // Validar email
    let expEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (email.value.trim() === "") {
        mostrarError(email, "Ingrese su correo electrónico.");
    } else if (!expEmail.test(email.value)) {
        mostrarError(email, "Ingrese un correo válido.");
    }

    // Validar contraseña
    if (clave.value.trim() === "") {
        mostrarError(clave, "Ingrese una contraseña.");
    } else if (clave.value.length < 6) {
        mostrarError(clave, "La contraseña debe tener al menos 6 caracteres.");
    }

    return valido;
}
</script>

</head>

<jsp:include page="head&foot/head.jsp" />

<h1 class="ms-3">Registro de nuevo Usuario</h1>

<form action="nuevoCliente.jsp" method="post" id="formCliente" onsubmit="return validarFormulario()">

    <table border="1">
        <thead>
            <tr>
                <th colspan="2">Complete sus datos</th>
            </tr>
        </thead>
        <tbody>

            <!-- Nombre -->
            <tr>
                <td>Nombre</td>
                <td>
                    <input type="text" id="nombre" name="txtNombre" required />
                    <span class="req">*</span>
                </td>
            </tr>

            <!-- Apellido -->
            <tr>
                <td>Apellido</td>
                <td>
                    <input type="text" id="apellido" name="txtApellido" required />
                    <span class="req">*</span>
                </td>
            </tr>

            <!-- Estado Civil -->
            <tr>
                <td>Estado Civil</td>
                <td>
                    <select name="cmbEstado" id="estado" required>
                        <option value="">-- Seleccione --</option>
                        <option>Soltero</option>
                        <option>Casado</option>
                        <option>Viudo</option>
                    </select>
                    <span class="req">*</span>
                </td>
            </tr>

            <!-- Correo -->
            <tr>
                <td>Correo electrónico</td>
                <td>
                    <input type="email" id="email" name="txtEmail" placeholder="usuario@proveedor.dominio" required />
                    <span class="req">*</span>
                </td>
            </tr>

            <!-- Clave -->
            <tr>
                <td>Clave</td>
                <td>
                    <input type="password" id="clave" name="txtClave" required />
                    <span class="req">*</span>
                </td>
            </tr>

            <!-- Acciones -->
            <tr>
                <td>Acciones</td>
                <td>
                    <input type="submit" value="Enviar" class="btn btn-primary" />
                    <input type="reset" value="Limpiar" class="btn btn-secondary ms-2" />
                </td>
            </tr>

        </tbody>
    </table>
</form>

<jsp:include page="head&foot/footer.jsp" />
</html>
