<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Mascota / Juego Estrellas</title>

<link rel="stylesheet" href="../css2/menuu.css">
<link rel="stylesheet" href="../css2/juego.css">

</head>

<body class="menu-body">
    <jsp:include page="/head&foot/menuu.jsp" />

    <h1 class="titulo-juego">🎄 Atrapa las Estrellas Navideñas ⭐</h1>
    <p class="texto-juego">
        Mueve el regalo con ← y → 
    </p>

    <div id="juego">

        <!-- VIDAS DENTRO DEL JUEGO -->
        <div id="vidasHUD"></div>

        <!-- JUGADOR -->
        <div id="player"></div>

        <!-- GAME OVER -->
        <div id="gameover">
            <h2>GAME OVER</h2>
            <button id="btnReiniciar">Reiniciar</button>
        </div>

    </div>

    <!-- PANEL DE PUNTOS -->
    <div class="panel">
        <span>Puntos:</span> <span id="score">0</span>
        <span style="margin-left:20px;">Fallados:</span> <span id="fallos">0</span>
        <span style="margin-left:20px;">Vidas:</span> <span id="vidas">3</span>
    </div>

    <script src="../js/juego.js"></script>

</body>
</html>
