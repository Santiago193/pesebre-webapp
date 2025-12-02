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

    // ===============================================================
    // PROCESAR ACCIONES CRUD + BLOQUEO / DESBLOQUEO
    // ===============================================================
    String action = request.getParameter("action");

    if ("registrar".equals(action)) {
        con.Ejecutar("INSERT INTO tb_usuario (nombre, apellido, correo, contrasena, id_estadocivil, id_perfil) VALUES ("+
            "'" + request.getParameter("nombre") + "'," +
            "'" + request.getParameter("apellido") + "'," +
            "'" + request.getParameter("correo") + "'," +
            "'" + request.getParameter("contrasena") + "'," +
            request.getParameter("estadocivil") + "," +
            request.getParameter("perfilNuevo") +
        ")");
    }

    if ("editar".equals(action)) {
        con.Ejecutar("UPDATE tb_usuario SET " +
            "nombre='" + request.getParameter("nombre") + "'," +
            "apellido='" + request.getParameter("apellido") + "'," +
            "correo='" + request.getParameter("correo") + "'," +
            "contrasena='" + request.getParameter("contrasena") + "'," +
            "id_estadocivil=" + request.getParameter("estadocivil") + "," +
            "id_perfil=" + request.getParameter("perfil") +
            " WHERE id_usuario=" + request.getParameter("id")
        );
    }

    if ("eliminar".equals(action)) {
        con.Ejecutar("DELETE FROM tb_usuario WHERE id_usuario="+request.getParameter("id"));
    }

    if ("bloquear".equals(action)) {
        con.Ejecutar("UPDATE tb_usuario SET bloqueado = TRUE WHERE id_usuario=" + request.getParameter("id"));
    }

    if ("desbloquear".equals(action)) {
        con.Ejecutar("UPDATE tb_usuario SET bloqueado = FALSE WHERE id_usuario=" + request.getParameter("id"));
    }

    // ===============================================================
    // CONSULTA USUARIOS
    // ===============================================================
    String buscar = request.getParameter("buscar");
    String perfilFiltro = request.getParameter("perfilFiltro");

    String filtro = " WHERE 1=1 ";

    if (buscar != null && !buscar.trim().equals("")) {
        filtro += " AND (LOWER(u.nombre) LIKE LOWER('%" + buscar + "%') " +
                  "OR LOWER(u.apellido) LIKE LOWER('%" + buscar + "%') " +
                  "OR LOWER(u.correo) LIKE LOWER('%" + buscar + "%')) ";
    }

    if (perfilFiltro != null && !"TODOS".equals(perfilFiltro)) {
        filtro += " AND u.id_perfil = " + perfilFiltro;
    }

    ResultSet rsUsuarios = con.Consulta(
        "SELECT u.id_usuario, u.nombre, u.apellido, u.correo, u.contrasena, " +
        "u.id_estadocivil, ec.descripcion AS estado, " +
        "u.id_perfil, p.nombre AS perfil_desc, u.bloqueado " +
        "FROM tb_usuario u " +
        "LEFT JOIN tb_estadocivil ec ON u.id_estadocivil = ec.id_estadocivil " +
        "LEFT JOIN tb_perfil p ON u.id_perfil = p.id_perfil " +
        filtro +
        " ORDER BY u.id_usuario ASC"
    );
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Administración de Usuarios</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/menuu.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/adminUsuarios.css">

</head>

<body class="menu-body">

<jsp:include page="../head&foot/menuu.jsp" />

<div class="admin-container">

    <h1 class="admin-title">👥 Administración de Usuarios</h1>

    <!-- ============================= -->
    <!-- FORMULARIO REGISTRO -->
    <!-- ============================= -->
    <div class="card">
        <h2>➕ Registrar Usuario</h2>

        <form method="post" class="formulario">
            <input type="hidden" name="action" value="registrar">

            <div class="fila">
                <input type="text" name="nombre" placeholder="Nombre" required>
                <input type="text" name="apellido" placeholder="Apellido" required>
            </div>

            <div class="fila">
                <input type="email" name="correo" placeholder="Correo" required>
                <input type="text" name="contrasena" placeholder="Contraseña" required>
            </div>

            <div class="fila">
                <select name="estadocivil">
                    <%
                        ResultSet ec = con.Consulta("SELECT * FROM tb_estadocivil");
                        while (ec.next()) { %>
                            <option value="<%=ec.getInt(1)%>"><%=ec.getString(2)%></option>
                    <% } %>
                </select>

                <select name="perfilNuevo">
                    <%
                        ResultSet per = con.Consulta("SELECT * FROM tb_perfil");
                        while (per.next()) { %>
                            <option value="<%=per.getInt(1)%>"><%=per.getString(2)%></option>
                    <% } %>
                </select>
            </div>

            <button class="btn-guardar">Guardar Usuario</button>
        </form>
    </div>

<!-- ============================= -->
<!-- BUSCADOR DE USUARIOS -->
<!-- ============================= -->

<div class="card">
    <h2>🔎 Buscar Usuarios</h2>

    <form method="GET">
        <div class="fila">
            <div class="campo">
                <input type="text" name="buscar"
                       placeholder="Buscar por nombre, apellido o correo"
                       value="<%= request.getParameter("buscar") != null ? request.getParameter("buscar") : "" %>">
            </div>

            <div class="campo">
                <select name="perfilFiltro">
                    <option value="TODOS">Todos</option>
                    <option value="1" <%= "1".equals(request.getParameter("perfilFiltro")) ? "selected" : "" %>>ADMIN</option>
                    <option value="2" <%= "2".equals(request.getParameter("perfilFiltro")) ? "selected" : "" %>>VISITANTE</option>
                </select>
            </div>

            <button class="btn-buscar" type="submit">Aplicar</button>
        </div>
    </form>
</div>

    <!-- ============================= -->
    <!-- TABLA USUARIOS -->
    <!-- ============================= -->
    <div class="card">
        <h2>📋 Lista de Usuarios</h2>

        <table class="tabla">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre completo</th>
                    <th>Correo</th>
                    <th>Contraseña</th>
                    <th>Estado civil</th>
                    <th>Perfil</th>
                    <th>Bloqueado</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>
                <% while (rsUsuarios.next()) { %>
                <tr>

                    <!-- ================================================== -->
                    <!-- CAMPOS EDITABLES (sin formularios anidados) -->
                    <!-- ================================================== -->

                    <td><%=rsUsuarios.getInt("id_usuario")%></td>

                    <td>
                        <input type="text" name="nombre" form="edit_<%=rsUsuarios.getInt("id_usuario")%>"
                               value="<%=rsUsuarios.getString("nombre")%>">
                        <input type="text" name="apellido" form="edit_<%=rsUsuarios.getInt("id_usuario")%>"
                               value="<%=rsUsuarios.getString("apellido")%>">
                    </td>

                    <td>
                        <input type="email" name="correo" form="edit_<%=rsUsuarios.getInt("id_usuario")%>"
                               value="<%=rsUsuarios.getString("correo")%>">
                    </td>

                    <td>
                        <input type="text" name="contrasena" form="edit_<%=rsUsuarios.getInt("id_usuario")%>"
                               value="<%=rsUsuarios.getString("contrasena")%>">
                    </td>

                    <td>
                        <select name="estadocivil" form="edit_<%=rsUsuarios.getInt("id_usuario")%>">
                            <%
                                ResultSet ec2 = con.Consulta("SELECT * FROM tb_estadocivil");
                                while (ec2.next()) {
                                    String sel = (ec2.getInt(1)==rsUsuarios.getInt("id_estadocivil")) ? "selected" : "";
                            %>
                                <option value="<%=ec2.getInt(1)%>" <%=sel%>><%=ec2.getString(2)%></option>
                            <% } %>
                        </select>
                    </td>

                    <td>
                        <select name="perfil" form="edit_<%=rsUsuarios.getInt("id_usuario")%>">
                            <%
                                ResultSet pf2 = con.Consulta("SELECT * FROM tb_perfil");
                                while (pf2.next()) {
                                    String sel = (pf2.getInt(1)==rsUsuarios.getInt("id_perfil")) ? "selected" : "";
                            %>
                                <option value="<%=pf2.getInt(1)%>" <%=sel%>><%=pf2.getString(2)%></option>
                            <% } %>
                        </select>
                    </td>

                    <td>
                        <% if (rsUsuarios.getBoolean("bloqueado")) { %>
                            🔒 BLOQUEADO
                        <% } else { %>
                            🔓 ACTIVO
                        <% } %>
                    </td>

                    <!-- ================================================== -->
                    <!-- ACCIONES (3 FORMULARIOS SEPARADOS) -->
                    <!-- ================================================== -->

                    <td>

                        <!-- FORM EDITAR -->
                        <form method="post" id="edit_<%=rsUsuarios.getInt("id_usuario")%>" style="display:inline;">
                            <input type="hidden" name="action" value="editar">
                            <input type="hidden" name="id" value="<%=rsUsuarios.getInt("id_usuario")%>">
                            <button class="btn-editar">💾</button>
                        </form>

                        <!-- FORM BLOQUEAR / DESBLOQUEAR -->
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%=rsUsuarios.getInt("id_usuario")%>">

                            <% if (rsUsuarios.getBoolean("bloqueado")) { %>
                                <input type="hidden" name="action" value="desbloquear">
                                <button class="btn-desbloquear" style="background:#28a745;" title="Desbloquear">
                                    🔓
                                </button>
                            <% } else { %>
                                <input type="hidden" name="action" value="bloquear">
                                <button class="btn-bloquear" style="background:#dc3545;" title="Bloquear">
                                    🔒
                                </button>
                            <% } %>
                        </form>

                        <!-- FORM ELIMINAR -->
                        <form method="post" style="display:inline;"
                            onsubmit="return confirm('¿Eliminar usuario?')">
                            <input type="hidden" name="action" value="eliminar">
                            <input type="hidden" name="id" value="<%=rsUsuarios.getInt("id_usuario")%>">
                            <button class="btn-eliminar">🗑</button>
                        </form>

                    </td>

                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
