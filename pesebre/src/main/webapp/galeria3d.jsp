<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Pesebre Navideño</title>
<link rel="stylesheet" href="css/general.css">
<link rel="stylesheet" href="css/galeria3d.css">
<script type="module"
	src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js">
</script>
</head>

<jsp:include page="head&foot/head.jsp" />


    <h1>Modelos 3D del Pesebre</h1>

    <div class="model-grid">

        <div class="model-card">
            <model-viewer src="3d/arbolnavidad.glb" alt="Árbol de Navidad" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Árbol de Navidad</div>
            <div class="model-desc">Un árbol decorado con luces y adornos navideños.</div>
        </div>

        <div class="model-card">
            <model-viewer src="3d/bastoncaramelo.glb" alt="Bastón de caramelo" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Bastón de caramelo</div>
            <div class="model-desc">Bastón navideño típico, dulce y decorativo.</div>
        </div>

        <div class="model-card">
            <model-viewer src="3d/escenanavidad.glb" alt="Escena de Navidad" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Escena de Navidad</div>
            <div class="model-desc">Una pequeña escena navideña con figuras típicas.</div>
        </div>

        <div class="model-card">
            <model-viewer src="3d/galletasnavidad.glb" alt="Galletas navideñas" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Galletas navideñas</div>
            <div class="model-desc">Galletas decoradas para celebrar la Navidad.</div>
        </div>

        <div class="model-card">
            <model-viewer src="3d/regalo.glb" alt="Regalo" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Regalo</div>
            <div class="model-desc">Caja de regalo con cinta, lista para entregar.</div>
        </div>

        <div class="model-card">
            <model-viewer src="3d/santaclaus.glb" alt="Santa Claus" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Santa Claus</div>
            <div class="model-desc">El famoso Papá Noel repartiendo alegría.</div>
        </div>

        <div class="model-card">
            <model-viewer src="3d/snowman.glb" alt="Muñeco de nieve" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Muñeco de nieve</div>
            <div class="model-desc">Un muñeco de nieve con bufanda y sombrero.</div>
        </div>

        <div class="model-card">
            <model-viewer src="3d/stag.glb" alt="Reno" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Reno</div>
            <div class="model-desc">Reno navideño que acompaña a Santa Claus.</div>
        </div>

        <div class="model-card">
            <model-viewer src="3d/star.glb" alt="Estrella navideña" auto-rotate camera-controls></model-viewer>
            <div class="model-title">Estrella navideña</div>
            <div class="model-desc">Estrella brillante que corona el árbol.</div>
        </div>

    </div>

<jsp:include page="head&foot/footer.jsp" />