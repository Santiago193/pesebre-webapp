<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Pesebre Navideño</title>
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/index.css">
<script type="module"
	src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js">
</script>
</head>

<jsp:include page="head&foot/head.jsp" />
<main class="contenido-index">


	<!-- ================================= -->
	<!--      SECCIÓN DE BIENVENIDA        -->
	<!-- ================================= -->
	<section class="intro">
		<h2 class="intro-titulo">Bienvenido al Pesebre Navideño UPS</h2>

		<p class="intro-texto">El Pesebre Navideño de la Universidad
			Politécnica Salesiana es un proyecto que refleja la tradición
			cristiana, el compromiso social y el trabajo colaborativo de
			estudiantes y docentes.</p>

		<p class="intro-texto">Explora imágenes, modelos 3D, información
			histórica y mucho más dentro de esta experiencia digital.</p>
	</section>



	<!-- ================================= -->
	<!--  SECCIÓN PESEBRE + MODELO 3D (GRID) -->
	<!-- ================================= -->
	<section class="contenedor-doble">

		<div class="bloque">
			<h2 class="titulo-seccion">Representación Tradicional del
				Pesebre</h2>
			<p class="texto-seccion">Esta ilustración muestra la escena
				clásica del nacimiento de Jesús.</p>
			<img src="images/pesebre.png" class="img-pesebre"
				alt="Pesebre tradicional">
		</div>

		<div class="bloque">
			<h2 class="titulo-seccion">Video Navideño</h2>
			<p class="texto-seccion">Disfruta un video especial relacionado
				con el espíritu navideño.</p>

			<video controls width="100%" class="video-navidad">
				<source src="images/video_navidad.mp4" type="video/mp4">
				Tu navegador no soporta la reproducción de video.
			</video>
		</div>

		<div class="bloque">
			<h2 class="titulo-seccion">Audio Navideño</h2>
			<p class="texto-seccion">Escucha un villancico navideño clásico
				para ambientar la experiencia.</p>

			<audio controls class="audio-navidad">
				<source src="images/villancico.mp3" type="audio/mpeg">
				Tu navegador no soporta la reproducción de audio.
			</audio>
		</div>

	</section>



	<!-- ================================= -->
	<!--         TARJETAS DE ACCESO        -->
	<!-- ================================= -->
	<section class="tarjetas">

		<div class="tarjeta">
			<h3>Galería de Pesebres</h3>
			<p>Observa las fotografías de los pesebres creados por la UPS a
				lo largo de los años.</p>
			<a href="galeria.jsp" class="btn-ir">Ver galería</a>
		</div>

		<div class="tarjeta">
			<h3>Calendario de Novenas</h3>
			<p>Revisa cada día de la novena con su oración y reflexión
				correspondiente.</p>
			<a href="novenas.jsp" class="btn-ir">Ver calendario</a>
		</div>

		<div class="tarjeta">
			<h3>Historia del Pesebre</h3>
			<p>Conoce el origen, evolución y simbolismo del pesebre navideño.</p>
			<a href="historia.jsp" class="btn-ir">Leer historia</a>
		</div>

	</section>

</main>

<jsp:include page="head&foot/footer.jsp" />