<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"
    import="com.pesebre.visitante.Votar,java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Pesebre Navideño</title>

<link rel="stylesheet" href="/pesebre/css2/menuu.css">
<link rel="stylesheet" href="/pesebre/css2/votar.css">
</head>

<body class="menu-body">

<jsp:include page="/head&foot/menuu.jsp" />

<%
    // ============================================
    //     TOMAR EL NOMBRE GUARDADO EN SESIÓN
    // ============================================
    String nombreSesion = (String) session.getAttribute("usuario");

    if (nombreSesion == null) {
%>
        <h2 class="error-msg">Debe iniciar sesión para votar</h2>
        </body></html>
<%
        return;
    }

    // ============================================
    //     USAR LA CLASE VOTAR.JAVA
    // ============================================
    Votar votar = new Votar();

    // Obtener el ID real del usuario desde BD
    int idUsuario = votar.obtenerIdUsuario(nombreSesion);

    if (idUsuario == -1) {
%>
        <h2 class="error-msg">Error: Usuario no encontrado en la base de datos.</h2>
        </body></html>
<%
        return;
    }

    // Verificar si ya votó
    boolean yaVoto = votar.yaVoto(idUsuario);

    // Procesar voto
    if (request.getParameter("id") != null && !yaVoto) {
        int idGaleria = Integer.parseInt(request.getParameter("id"));
        votar.registrarVoto(idUsuario, idGaleria);
        yaVoto = true;
    }
%>

<h1 class="titulo-votar">🎄 Votar por el Mejor Pesebre 🎄</h1>

<%
if (yaVoto) {
%>

    <div class="mensaje-votado">
        🎉 ¡Gracias por votar!  
        <br>No puedes votar más de una vez.
    </div>

<%
} else {
    ArrayList<Votar.Pesebre> lista = votar.obtenerPesebres();
%>

    <div class="contenedor-pesebres">

<%
    for (Votar.Pesebre p : lista) {
%>

        <div class="tarjeta-pesebre">
            <img src="/pesebre/<%= p.imagen %>" class="img-pesebre">
            <h2><%= p.carrera %></h2>

            <a href="votar.jsp?id=<%= p.id %>" class="btn-votar">Votar</a>
        </div>

<%
    }
%>

    </div>

<%
}
%>

<!-- ============================================
            RANKING (ahora desde Votar.java)
=============================================== -->
<h2 class="titulo-ranking">🏆 Ranking de Pesebres</h2>

<table class="tabla-ranking">
    <tr>
        <th>Pesebre</th>
        <th>Votos</th>
    </tr>

<%
    ArrayList<Votar.Ranking> rank = votar.obtenerRanking();

    for (Votar.Ranking r : rank) {
%>

    <tr>
        <td><%= r.carrera %></td>
        <td><%= r.votos %></td>
    </tr>

<%
    }
%>

</table>

</body>
</html>
