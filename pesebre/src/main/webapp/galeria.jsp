<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pesebre.visitante.Galeria" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Pesebre Navideño</title>
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/galeria.css">
</head>

<jsp:include page="head&foot/head.jsp" />

<h1 class="titulo-navidad">🎄 Galería de Pesebres – Campus Sur 🎄</h1>

<div class="galeria-carreras">

<%
    Galeria g = new Galeria();
    ArrayList<Galeria.Item> lista = g.getGaleria();

    for (Galeria.Item item : lista) {
%>

    <div class="carrera-item">
        <h2><%= item.carrera %></h2>
        <p><%= item.descripcion %></p>
        <img src="<%= item.imagen %>" alt="Pesebre <%= item.carrera %>">
    </div>

<%
    }
%>

</div>

<jsp:include page="head&foot/footer.jsp" />

</html>
