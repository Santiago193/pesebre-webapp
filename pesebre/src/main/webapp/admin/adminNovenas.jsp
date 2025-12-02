<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,com.pesebre.datos.*,com.pesebre.seguridad.*" session="true"%>

<%
    // ================== VALIDAR ADMIN ==================
    HttpSession ses = request.getSession();
    Integer perfil = (Integer) ses.getAttribute("perfil");

    if (perfil == null || perfil != 1) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Conexion con = new Conexion();

    // ================== CRUD ==================
    String action = request.getParameter("action");

    if ("registrar".equals(action)) {
        con.Ejecutar("INSERT INTO tb_novenas (dia, fecha, organiza, lugar, descripcion) VALUES (" +
            request.getParameter("dia") + "," +
            "'" + request.getParameter("fecha") + "'," +
            "'" + request.getParameter("organiza") + "'," +
            "'" + request.getParameter("lugar") + "'," +
            "'" + request.getParameter("descripcion") + "')"
        );
    }

    if ("editar".equals(action)) {
        con.Ejecutar("UPDATE tb_novenas SET " +
            "dia=" + request.getParameter("dia") + "," +
            "fecha='" + request.getParameter("fecha") + "'," +
            "organiza='" + request.getParameter("organiza") + "'," +
            "lugar='" + request.getParameter("lugar") + "'," +
            "descripcion='" + request.getParameter("descripcion") + "'" +
            " WHERE id_novena=" + request.getParameter("id")
        );
    }

    if ("eliminar".equals(action)) {
        con.Ejecutar("DELETE FROM tb_novenas WHERE id_novena=" + request.getParameter("id"));
    }

    // ================== FILTROS ==================
    String buscar = request.getParameter("buscar");
    String filtro = " WHERE 1=1 ";

    if (buscar != null && !buscar.trim().equals("")) {
        filtro += " AND (LOWER(organiza) LIKE LOWER('%" + buscar + "%') OR " +
                  "LOWER(lugar) LIKE LOWER('%" + buscar + "%') OR " +
                  "LOWER(descripcion) LIKE LOWER('%" + buscar + "%')) ";
    }

    // ================== CONSULTA ==================
    ResultSet rs = con.Consulta(
        "SELECT * FROM tb_novenas " + filtro + " ORDER BY dia ASC"
    );
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestión de Novenas</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/menuu.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/adminNovenas.css">

</head>

<body class="menu-body">

<jsp:include page="../head&foot/menuu.jsp" />

<div class="admin-container">

    <h1 class="admin-title">📅 Gestión de Novenas UPS</h1>

    <!-- ============================= -->
    <!-- BUSCADOR -->
    <!-- ============================= -->
    <div class="card">
        <h2>🔎 Buscar Novenas</h2>

        <form method="GET">
            <input type="text" name="buscar" class="input-full"
                   placeholder="Buscar por organizador, lugar o descripción"
                   value="<%= buscar != null ? buscar : "" %>">

            <button class="btn-buscar">Buscar</button>
        </form>
    </div>

<!--     ============================= -->
<!--     REGISTRO -->
<!--     ============================= -->
<!--     <div class="card"> -->
<!--         <h2>➕ Registrar Novena</h2> -->

<!--         <form method="POST"> -->
<!--             <input type="hidden" name="action" value="registrar"> -->

<!--             <div class="fila"> -->
<!--                 <input type="number" name="dia" placeholder="Día (1-9)" required> -->
<!--                 <input type="date" name="fecha" required> -->
<!--             </div> -->

<!--             <div class="fila"> -->
<!--                 <input type="text" name="organiza" placeholder="Organiza" required> -->
<!--                 <input type="text" name="lugar" placeholder="Lugar" required> -->
<!--             </div> -->

<!--             <textarea name="descripcion" placeholder="Descripción de la novena..." required></textarea> -->

<!--             <button class="btn-guardar">Guardar Novena</button> -->
<!--         </form> -->
<!--     </div> -->

    <!-- ============================= -->
    <!-- LISTA DE NOVENAS -->
    <!-- ============================= -->
    <div class="card">
        <h2>📋 Lista de Novenas</h2>

        <table class="tabla">
            <thead>
                <tr>
                    <th>Día</th>
                    <th>Fecha</th>
                    <th>Organiza</th>
                    <th>Lugar</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <form method="post">
                        <input type="hidden" name="action" value="editar">
                        <input type="hidden" name="id" value="<%= rs.getInt("id_novena") %>">

                        <td><input type="number" name="dia" value="<%= rs.getInt("dia") %>"></td>

                        <td><input type="date" name="fecha" value="<%= rs.getString("fecha") %>"></td>

                        <td><input type="text" name="organiza" value="<%= rs.getString("organiza") %>"></td>

                        <td><input type="text" name="lugar" value="<%= rs.getString("lugar") %>"></td>

                        <td>
                            <textarea name="descripcion"><%= rs.getString("descripcion") %></textarea>
                        </td>

                        <td class="acciones">
                            <button class="btn-editar">💾</button>

                            <form method="post" style="display:inline;"
                                  onsubmit="return confirm('¿Eliminar esta novena?')">
                                <input type="hidden" name="action" value="eliminar">
                                <input type="hidden" name="id" value="<%= rs.getInt("id_novena") %>">
                            </form>
                        </td>
                    </form>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
