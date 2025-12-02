a<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Pesebre Navideño</title>
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/login.css">
<script type="module"
	src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js">
</script>
</head>

<jsp:include page="head&foot/head.jsp" />

<main class="login-container">
    <section class="login-card">
        <h2 class="login-title">Ingreso al Sistema</h2>

        <% if (request.getParameter("error") != null) { %>
            <p class="login-error"><%= request.getParameter("error") %></p>
        <% } %>

        <form action="validarLogin.jsp" method="post" class="login-form">
            <div class="form-group">
                <label for="usuario">Usuario (correo)</label>
                <input type="text" id="usuario" name="usuario" required />
            </div>

            <div class="form-group">
                <label for="clave">Clave</label>
                <input type="password" id="clave" name="clave" required />
            </div>

            <div class="form-actions">
                <input type="submit" value="Ingresar" class="btn btn-primary">
                <input type="reset" value="Limpiar" class="btn btn-secondary">
            </div>
        </form>

        <!-- NUEVO ENLACE A REGISTRO -->
        <p class="register-text">
            ¿No tienes cuenta? 
            <a href="registro.jsp" class="register-link">Regístrate aquí</a>
        </p>
    </section>
</main>
<jsp:include page="head&foot/footer.jsp" />