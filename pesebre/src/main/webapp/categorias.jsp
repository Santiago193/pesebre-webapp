<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.pesebre.datos.Conexion" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Categorías del Pesebre</title>
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/categorias.css">
</head>

<body>

<jsp:include page="head&foot/head.jsp" />

<section class="intro-categorias">
    <h2 class="titulo-principal">Categorías del Pesebre</h2>

    <p class="descripcion-principal">
        Las categorías del pesebre permiten organizar todo el contenido de manera clara, 
        guiando al visitante por diferentes aspectos de la tradición navideña.  
        Aquí encontrarás un resumen de cada área, acompañado de una breve explicación 
        que te ayudará a conocer mejor cómo se estructura nuestro proyecto.
    </p>
</section>

<div class="contenedor-categorias">

<%
    Conexion cn = new Conexion();
    Connection con = cn.getConexion();

    String sql = "SELECT * FROM tb_categoria ORDER BY id_categoria";
    PreparedStatement ps = con.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>

    <div class="tarjeta-cat">
        <h3 class="titulo-cat"><%= rs.getString("nombre") %></h3>
        <p class="texto-cat"><%= rs.getString("descripcion") %></p>
    </div>

<%
    }
    con.close();
%>

</div>

<jsp:include page="head&foot/footer.jsp" />

</body>
</html>
