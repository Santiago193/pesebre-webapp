<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,com.pesebre.datos.*,com.pesebre.seguridad.*" session="true"%>

<%
    HttpSession ses = request.getSession();
    Integer perfil = (Integer) ses.getAttribute("perfil");

    if (perfil == null || perfil != 1) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Conexion con = new Conexion();

    String action = request.getParameter("action");

    if ("registrar".equals(action)) {
        con.Ejecutar("INSERT INTO tb_galeria (carrera, descripcion, imagen) VALUES (" +
            "'" + request.getParameter("carrera") + "'," +
            "'" + request.getParameter("descripcion") + "'," +
            "'" + request.getParameter("imagen") + "')"
        );
    }

    if ("editar".equals(action)) {
        con.Ejecutar("UPDATE tb_galeria SET " +
            "carrera='" + request.getParameter("carrera") + "'," +
            "descripcion='" + request.getParameter("descripcion") + "'," +
            "imagen='" + request.getParameter("imagen") + "'" +
            " WHERE id_galeria=" + request.getParameter("id")
        );
    }

    if ("eliminar".equals(action)) {
        con.Ejecutar("DELETE FROM tb_galeria WHERE id_galeria="+request.getParameter("id"));
    }

    String buscar = request.getParameter("buscar");
    String filtro = " WHERE 1=1 ";

    if (buscar != null && !buscar.trim().equals("")) {
        filtro += " AND (LOWER(carrera) LIKE LOWER('%" + buscar + "%') OR " +
                  "LOWER(descripcion) LIKE LOWER('%" + buscar + "%')) ";
    }

    ResultSet rs = con.Consulta(
        "SELECT * FROM tb_galeria " + filtro + " ORDER BY id_galeria ASC"
    );
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestion de Pesebres</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/menuu.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/adminPesebres.css">

</head>

<body class="menu-body">

<jsp:include page="../head&foot/menuu.jsp" />

<div class="admin-container">

    <h1 class="admin-title">Gestion de Pesebres del Campus</h1>

    <div class="card">
        <h2>Buscar Pesebres</h2>

        <form method="GET">
            <div class="fila">
                <input type="text" name="buscar"
                       placeholder="Buscar por carrera o descripcion"
                       value="<%= buscar != null ? buscar : "" %>">
            </div>
            <button class="btn-buscar">Buscar</button>
        </form>
    </div>

    <div class="card">
        <h2>Registrar Pesebre</h2>

        <form method="post">
            <input type="hidden" name="action" value="registrar">

            <div class="fila">
                <input type="text" name="carrera" placeholder="Carrera" required>
            </div>

            <div class="fila">
                <textarea name="descripcion" placeholder="Descripcion" required></textarea>
            </div>

            <div class="fila">
                <input type="text" name="imagen" placeholder="Ruta de imagen (ej: images/pesebre.png)" required>
            </div>

            <button class="btn-guardar">Guardar Pesebre</button>
        </form>
    </div>

    <div class="card">
        <h2>Lista de Pesebres</h2>

        <table class="tabla">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Carrera</th>
                    <th>Descripcion</th>
                    <th>Imagen</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <form method="post">
                        <input type="hidden" name="action" value="editar">
                        <input type="hidden" name="id" value="<%= rs.getInt("id_galeria") %>">

                        <td><%= rs.getInt("id_galeria") %></td>

                        <td>
                            <input type="text" name="carrera" value="<%= rs.getString("carrera") %>">
                        </td>

                        <td>
                            <textarea name="descripcion"><%= rs.getString("descripcion") %></textarea>
                        </td>

                        <td>
                            <input type="text" name="imagen" value="<%= rs.getString("imagen") %>">
                            <img src="<%=request.getContextPath()%>/<%= rs.getString("imagen") %>" class="preview">
                        </td>

                        <td>
                            <button class="btn-editar">Guardar</button>

                            <form method="post" style="display:inline;"
                                  onsubmit="return confirm('Eliminar pesebre?')">
                                <input type="hidden" name="action" value="eliminar">
                                <input type="hidden" name="id" value="<%= rs.getInt("id_galeria") %>">
                                <button class="btn-eliminar">Eliminar</button>
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
