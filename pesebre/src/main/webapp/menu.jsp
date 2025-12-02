	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8" session="true" import="com.pesebre.seguridad.*"%>
	
	<!DOCTYPE html>
	<html lang="es">
	<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>Pesebre Navideño</title>
	
	<link rel="stylesheet" href="css2/menu.css">
	<link rel="stylesheet" href="css2/menuu.css">
	</head>
	
<body class="menu-body">

    <!-- Menú reutilizable -->
    <jsp:include page="head&foot/menuu.jsp" />

    <!-- =============================== -->
    <!-- HERO PRINCIPAL -->
    <!-- =============================== -->
    <section class="hero-navidad">
        <div class="hero-texto">
            <h1>✨ Navidad UPS – Vive la Magia ✨</h1>
            <p>Explora las actividades, participa en juegos navideños, vota por el mejor pesebre y descubre la experiencia.</p>
        </div>
        <img src="images/hero.png" class="hero-img">
    </section>

    <!-- =============================== -->
    <!-- SECCIÓN DE TARJETAS  -->
    <!-- =============================== -->
    <section class="seccion-tarjetas">
        
        <div class="tarjeta">
            <img src="images/arbol.png">
            <h3>Pesebres</h3>
            <p>Observa los hermosos pesebres y vota por tu favorito.</p>
        </div>

        <div class="tarjeta">
            <img src="images/regalo.png">
            <h3>Trivia Navideña</h3>
            <p>Pon a prueba tu conocimiento sobre la Navidad.</p>
        </div>

        <div class="tarjeta">
            <img src="images/estrella.png">
            <h3>Mascota Virtual</h3>
            <p>Cuida una mascota navideña especial.</p>
        </div>

    </section>

    <!-- =============================== -->
    <!-- SECCIÓN ACERCA DEL PESEBRE UPS -->
    <!-- =============================== -->
    <section class="seccion-info">
        <h2>🎄 Acerca del Pesebre Navideño UPS 🎄</h2>
        <p>
            Cada año, estudiantes de la Universidad Politécnica Salesiana construyen un mágico pesebre
            lleno de creatividad, tradición y espíritu navideño. Este portal te permite vivir la experiencia,
            explorar actividades interactivas y compartir tus votos y logros.
        </p>
    </section>

    <!-- =============================== -->
    <!-- FOOTER -->
    <!-- =============================== -->
    <footer class="footer-navidad">
        <p>✨ Proyecto Pesebre Navideño UPS • 2025 ✨</p>
    </footer>

</body>


	</html>
