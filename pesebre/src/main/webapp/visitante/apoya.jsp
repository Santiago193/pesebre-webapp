<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, javax.servlet.http.*, java.sql.*, com.pesebre.datos.*" session="true"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Apoya tu Pesebre Favorito</title>

<link rel="stylesheet" href="../css2/menuu.css">
<link rel="stylesheet" href="../css2/apoya.css">

</head>

<body class="menu-body">
<% response.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/head&foot/menuu.jsp" />

<div class="container my-5">

<h2 class="text-center text-dark mb-4">🎁 APOYA TU PESEBRE FAVORITO</h2>

<%
    // ===========================================
    // 1. Traer los pesebres
    // ===========================================
    Conexion con = new Conexion();
    ResultSet rs = con.Consulta(
        "SELECT id_galeria, carrera, descripcion, imagen FROM tb_galeria"
    );

    // ===========================================
    // 2. Traer recaudación TOTAL por cada pesebre
    // ===========================================
    Map<Integer, Double> recaudado = new HashMap<>();

    ResultSet rs2 = con.Consulta(
        "SELECT id_galeria, SUM(monto) AS total FROM tb_apoyos GROUP BY id_galeria"
    );

    while (rs2.next()) {
        recaudado.put(
            rs2.getInt("id_galeria"),
            rs2.getDouble("total")
        );
    }

    // ===========================================
    // 3. Carrito de sesión
    // ===========================================
    HttpSession sesion = request.getSession();
    List<Map<String,Object>> carrito =
        (List<Map<String,Object>>) sesion.getAttribute("carrito_apoyo");

    if (carrito == null) {
        carrito = new ArrayList<>();
        sesion.setAttribute("carrito_apoyo", carrito);
    }

    // ===========================================
    // 4. Acciones
    // ===========================================
    String mensaje = "";
    String accion = request.getParameter("accion");

    if ("agregar".equals(accion)) {

        String idGal = request.getParameter("id");
        String monto = request.getParameter("monto");

        if (idGal != null && monto != null) {

            Map<String,Object> item = new HashMap<>();

            item.put("id_galeria", Integer.parseInt(idGal));
            item.put("carrera", request.getParameter("carrera"));
            item.put("monto", Double.parseDouble(monto));

            carrito.add(item);
            sesion.setAttribute("carrito_apoyo", carrito);

            mensaje = "✔ Apoyo agregado correctamente.";
        }
    }

    if ("eliminar".equals(accion)) {

        String idx = request.getParameter("index");

        if (idx != null) {
            int i = Integer.parseInt(idx);
            if (i >= 0 && i < carrito.size()) {
                carrito.remove(i);
                sesion.setAttribute("carrito_apoyo", carrito);
                mensaje = "🗑 Apoyo eliminado.";
            }
        }
    }

    // ===========================================
    // TOTAL EN EL CARRITO
    // ===========================================
    double total = 0;
    for (Map<String,Object> ap : carrito)
        total += (Double) ap.get("monto");
%>

<!-- Mensaje arriba -->
<% if (!mensaje.isEmpty()) { %>
<div class="alert alert-info text-center"><%= mensaje %></div>
<% } %>

<!-- ========================= -->
<!-- TARJETAS DE PESEBRES -->
<!-- ========================= -->

<div class="seccion-productos mb-5">
    <h3 class="text-success text-center mb-4">Pesebres Disponibles</h3>

    <div class="productos-grid">

        <% while (rs.next()) { %>

        <div class="producto">

            <img src="../<%= rs.getString("imagen") %>" class="img-fluid" alt="Pesebre">

            <h5 class="mt-3"><%= rs.getString("carrera") %></h5>

            <p class="text-muted"><%= rs.getString("descripcion") %></p>

            <!-- MONTO RECAUDADO -->
            <p class="fw-bold text-primary">
                Recaudado: $
                <%= String.format("%.2f",
                        recaudado.getOrDefault(rs.getInt("id_galeria"), 0.0)) %>
            </p>

            <form method="post">
                <input type="hidden" name="accion" value="agregar">
                <input type="hidden" name="id" value="<%= rs.getInt("id_galeria") %>">
                <input type="hidden" name="carrera" value="<%= rs.getString("carrera") %>">

                <label>Monto a apoyar ($):</label>
                <input type="number" name="monto" min="1" step="0.50"
                       class="form-control mb-2" required>

                <button type="submit" class="btn btn-success btn-sm px-3">
                    💚 Apoyar
                </button>

            </form>

        </div>

        <% } %>
    </div>

</div>


<!-- ========================= -->
<!--  CARRITO DE APOYOS -->
<!-- ========================= -->

<section class="carrito mt-5">
    <h3 class="text-success mb-3">💵 Carrito de Apoyos</h3>

    <% if (carrito.isEmpty()) { %>

        <p class="text-muted text-center">No has agregado apoyos todavía.</p>

    <% } else { %>

        <table class="table table-bordered text-center align-middle">
            <thead class="table-success">
                <tr>
                    <th>Pesebre</th>
                    <th>Monto ($)</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>

                <% for (int i = 0; i < carrito.size(); i++) {
                       Map<String,Object> ap = carrito.get(i); %>

                <tr>
                    <td><%= ap.get("carrera") %></td>
                    <td>$<%= String.format("%.2f", ap.get("monto")) %></td>
                    <td>
                        <form method="post">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="index" value="<%= i %>">
                            <button class="btn btn-danger btn-sm">🗑 Quitar</button>
                        </form>
                    </td>
                </tr>

                <% } %>

            </tbody>
        </table>

        <h4 class="text-end mt-3">Total: $<%= String.format("%.2f", total) %></h4>

        <form method="get" action="pagoApoyo.jsp" class="text-end mt-3">
            <button type="submit" class="btn btn-primary">Proceder al Pago</button>
        </form>

    <% } %>

</section>

</div>
</body>
</html>
