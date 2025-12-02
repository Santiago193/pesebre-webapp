<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pesebre.visitante.Novenas" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Pesebre Navideño</title>
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/novenas.css">
<script type="module"
    src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js">
</script>
</head>

<jsp:include page="head&foot/head.jsp" />

<h1 class="titulo-novenas">🎄 Calendario de Novenas – Campus Sur UPS 🎄</h1>
<p class="subtitulo">Novenario tradicional celebrado del 15 al 23 de diciembre.</p>

<table class="tabla-novenas">
    <thead>
        <tr>
            <th>Día</th>
            <th>Fecha</th>
            <th>Organiza</th>
            <th>Lugar</th>
            <th>Descripción</th>
        </tr>
    </thead>
    <tbody>

<%
    Novenas n = new Novenas();
    ArrayList<Novenas.Item> lista = n.getNovenas();

    for (Novenas.Item item : lista) {
%>

        <tr>
            <td><%= item.dia %></td>
            <td><%= new java.text.SimpleDateFormat("dd 'de' MMMM").format(item.fecha) %></td>
            <td><%= item.organiza %></td>
            <td><%= item.lugar %></td>
            <td><%= item.descripcion %></td>
        </tr>

<% } %>

    </tbody>
</table>

<jsp:include page="head&foot/footer.jsp" />

</html>
