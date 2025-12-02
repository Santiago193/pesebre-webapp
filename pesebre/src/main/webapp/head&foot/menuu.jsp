<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    session="true"
    import="com.pesebre.seguridad.*, java.time.*, java.time.format.*" %>

<%
    // ====== Validar sesión ======
    HttpSession sesion = request.getSession();

    if (sesion.getAttribute("usuario") == null) {
%>
    <jsp:forward page="../login.jsp">
        <jsp:param name="error" value="Debe iniciar sesión para continuar."/>
    </jsp:forward>
<%
    } else {

        String usuario = (String) sesion.getAttribute("usuario");
        Integer perfil = (Integer) sesion.getAttribute("perfil");

        if (perfil == null) perfil = 0;

        Pagina pag = new Pagina();
        String menu = pag.mostrarMenu(perfil);

        // Fecha y hora actual
        LocalDateTime ahora = LocalDateTime.now();
        DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("EEE, MMM dd yyyy");
        DateTimeFormatter formatoHora = DateTimeFormatter.ofPattern("HH:mm");

        String fecha = ahora.format(formatoFecha);
        String hora = ahora.format(formatoHora);

        request.setAttribute("fecha", fecha);
        request.setAttribute("hora", hora);
%>

<link rel="stylesheet" href="css/menuu.css">

<!-- 🎄 MENÚ NAVIDEÑO 🎄 -->
<div class="menu-container">

    <h1 class="titulo">🎄 Panel Privado – Pesebre Navideño UPS 🎁</h1>
    <h4 class="bienvenida">✨ Bienvenido, <%= usuario %> ✨</h4>

    <nav class="barra-menu">
        <%= menu %>
    </nav>

    <div class="fecha-hora">
        <span><b>📅 Fecha:</b> <%= fecha %></span>
        <span><b>⏰ Hora:</b> <%= hora %></span>
    </div>

</div>

<%
    } // fin else
%>
