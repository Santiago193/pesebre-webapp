<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true" %>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Curiosidades Navideñas</title>

<link rel="stylesheet" href="../css2/menuu.css">
<link rel="stylesheet" href="../css2/curiosidades.css">

</head>

<body class="menu-body">

    <jsp:include page="/head&foot/menuu.jsp" />

    <div class="hero">
        <h1>🎅 Curiosidades Navideñas 🎄</h1>
        <p>Descubre datos sorprendentes, tradiciones antiguas y secretos mágicos de la Navidad</p>
    </div>

    <!-- TABLA PRINCIPAL DECORADA -->
    <div class="tabla-container">
        <h2 class="subtitulo">🎁 Resumen de Curiosidades</h2>
        <table class="tabla-navidad">
            <thead>
                <tr>
                    <th>Elemento</th>
                    <th>Significado</th>
                    <th>Origen</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>🎄 Árbol de Navidad</td>
                    <td>Símbolo de vida y esperanza</td>
                    <td>Tradiciones nórdicas</td>
                </tr>
                <tr>
                    <td>⭐ Estrella</td>
                    <td>Guía espiritual</td>
                    <td>Los Reyes Magos</td>
                </tr>
                <tr>
                    <td>🕯 Velas</td>
                    <td>Luz en la oscuridad</td>
                    <td>Ritos europeos</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- TARJETAS DINÁMICAS -->
    <div class="contenedor-tarjetas">
        <div class="card">
            <img src="../images/nav_curiosidad1.png" alt="Curiosidad 1">
            <h3>El Árbol de Navidad</h3>
            <p>Se originó en países nórdicos como símbolo de vida eterna durante el invierno.</p>
        </div>

        <div class="card">
            <img src="../images/nav_curiosidad2.png" alt="Curiosidad 2">
            <h3>La Estrella</h3>
            <p>Representa la estrella de Belén que guió a los Reyes Magos hasta el pesebre.</p>
        </div>

        <div class="card">
            <img src="../images/nav_curiosidad3.png" alt="Curiosidad 3">
            <h3>Los Pesebres</h3>
            <p>San Francisco de Asís hizo el primer pesebre viviente en 1223.</p>
        </div>

        <div class="card">
            <img src="../images/nav_curiosidad4.png" alt="Curiosidad 4">
            <h3>El Color Rojo</h3>
            <p>Se hizo popular por campañas de Coca-Cola en los años 30.</p>
        </div>

        <div class="card">
            <img src="../images/nav_curiosidad5.png" alt="Curiosidad 5">
            <h3>Muérdago</h3>
            <p>Los vikingos lo consideraban un símbolo de paz, por eso se dan besos debajo.</p>
        </div>

        <div class="card">
            <img src="../images/nav_curiosidad6.png" alt="Curiosidad 6">
            <h3>Santa Claus</h3>
            <p>Basado en San Nicolás, protector de niños y marineros.</p>
        </div>
    </div>


</body>
</html>
