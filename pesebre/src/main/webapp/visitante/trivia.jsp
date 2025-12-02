<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true" import="com.pesebre.seguridad.*"%>

<%
    // ===========================
    //      PREGUNTAS / OPCIONES
    // ===========================

    String[] preguntas = {
        "¿En qué país se originó la tradición del árbol de Navidad?",
        "¿Qué planta es típica de Navidad y se usa como adorno rojo?",
        "¿Cuál es el dulce de Navidad típico con frutas confitadas?",
        "¿Quién ayudaba a Santa en los cuentos tradicionales?",
        "¿Cuál es el nombre del reno más famoso de Santa?",
        "¿Qué celebración marca el inicio oficial de la Navidad?",
        "¿Qué se cuelga tradicionalmente en la chimenea para recibir regalos?",
        "¿Cómo se llaman las canciones típicas navideñas?",
        "¿Qué bebida es tradicional en Navidad en EE. UU.?",
        "¿Qué animales suelen aparecer junto al pesebre?"
    };

    String[][] opciones = {
        {"Estados Unidos", "Alemania", "México", "Francia"},
        {"Rosas", "Girasoles", "La Flor de Pascua", "Hortensias"},
        {"Turrón", "Chocolate amargo", "Panettone", "Flan"},
        {"Gnomos", "Hadas", "Elfos", "Dragones"},
        {"Donner", "Comet", "Vixen", "Rudolph"},
        {"Halloween", "Año Nuevo", "Adviento", "Día del Trabajo"},
        {"Bufandas", "Guantes", "Medias o calcetines", "Cinturones"},
        {"Baladas", "Villancicos", "Óperas", "Tangos"},
        {"Café expreso", "Eggnog (ponche de huevo)", "Limonada", "Té negro"},
        {"León y águila", "Buey y burro", "Perro y gato", "Cebra y camello"}
    };

    int[] correctas = {1, 2, 2, 2, 3, 2, 2, 1, 1, 1};

    // ===========================
    //     LÓGICA DE TRIVIA
    // ===========================

    int index = 0;
    if (request.getParameter("q") != null) {
        index = Integer.parseInt(request.getParameter("q"));
    }

    Integer puntaje = (Integer) session.getAttribute("puntaje");
    if (puntaje == null) puntaje = 0;

    if (request.getParameter("resp") != null) {

        int resp = Integer.parseInt(request.getParameter("resp"));
        int anterior = index - 1;

        if (anterior >= 0 && resp == correctas[anterior]) {
            puntaje++;
        }

        session.setAttribute("puntaje", puntaje);
    }

    boolean terminado = index >= preguntas.length;
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Trivia Navideña</title>

<link rel="stylesheet" href="/pesebre/css2/menuu.css">
<link rel="stylesheet" href="/pesebre/css2/trivia.css">

<style>
    .trivia-container { margin-top: 150px !important; }
    .lista-respuestas {
        text-align: left;
        margin-top: 20px;
        color: #ffd98d;
        font-size: 18px;
    }
    .lista-respuestas li { margin-bottom: 10px; }
</style>

</head>
<body class="menu-body">

<jsp:include page="/head&foot/menuu.jsp" />

<main class="trivia-container">

    <h1 class="titulo-trivia">🎄 Trivia Navideña – 10 Preguntas 🎁</h1>
    <p class="intro-trivia">Responde cada pregunta y presiona “Siguiente”.</p>

<% if (!terminado) { %>

    <!-- ========== PREGUNTA ========== -->
    <form method="post" class="pregunta-box">

        <h2><%= preguntas[index] %></h2>

        <div class="opciones">
            <% for (int i = 0; i < 4; i++) { %>
                <label>
                    <input type="radio" name="resp" value="<%= i %>" required>
                    <span><%= opciones[index][i] %></span>
                </label>
            <% } %>
        </div>

        <input type="hidden" name="q" value="<%= index + 1 %>">

        <button class="btn-comprobar">Siguiente</button>

    </form>

<% } else { %>

    <!-- ========== RESULTADO FINAL ========== -->
    <div class="pregunta-box">
        <h2 class="titulo-trivia">✨ ¡Trivia completada! ✨</h2>
        <p class="intro-trivia">
            Obtuviste <b><%= puntaje %></b> de <%= preguntas.length %> respuestas correctas.
        </p>

        <h3 class="titulo-trivia">📘 Respuestas correctas:</h3>

        <ol class="lista-respuestas">
            <% for (int i = 0; i < preguntas.length; i++) { %>
                <li>
                    <b><%= preguntas[i] %></b><br>
                    ✔ <span style="color:#a5ff8a;">
                        <%= opciones[i][correctas[i]] %>
                    </span>
                </li>
            <% } %>
        </ol>

        <a href="trivia.jsp" class="btn-comprobar">Reintentar</a>
    </div>

    <% session.removeAttribute("puntaje"); %>

<% } %>

</main>

</body>
</html>
