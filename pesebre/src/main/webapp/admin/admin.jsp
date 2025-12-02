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

    // ======= MÉTRICAS DEL DASHBOARD =======
    ResultSet totalUsuarios = con.Consulta("SELECT COUNT(*) FROM tb_usuario");
    totalUsuarios.next();

    ResultSet totalAdmins = con.Consulta("SELECT COUNT(*) FROM tb_usuario WHERE id_perfil = 1");
    totalAdmins.next();

    ResultSet totalPesebres = con.Consulta("SELECT COUNT(*) FROM tb_galeria");
    totalPesebres.next();

    ResultSet totalEventos = con.Consulta("SELECT COUNT(*) FROM tb_novenas");
    totalEventos.next();

    ResultSet ultimosUsuarios = con.Consulta(
        "SELECT nombre, apellido, correo FROM tb_usuario ORDER BY id_usuario DESC LIMIT 5"
    );

    ResultSet ultimosPesebres = con.Consulta(
        "SELECT carrera, imagen FROM tb_galeria ORDER BY id_galeria DESC LIMIT 5"
    );

    ResultSet ultimosEventos = con.Consulta(
        "SELECT dia, organiza, lugar FROM tb_novenas ORDER BY id_novena DESC LIMIT 5"
    );
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Panel Administrador</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/menuu.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/admin.css">

</head>

<body class="menu-body">

<jsp:include page="../head&foot/menuu.jsp" />

<div class="admin-container">

    <h1 class="admin-title">🎛 Panel de Administración</h1>

    <!-- ============================= -->
    <!-- MÉTRICAS -->
    <!-- ============================= -->
    <div class="grid-metricas">

        <div class="card-metrica azul">
            <h3>👤 Usuarios Registrados</h3>
            <p class="numero"><%= totalUsuarios.getInt(1) %></p>
        </div>

        <div class="card-metrica rojo">
            <h3>🛡 Administradores</h3>
            <p class="numero"><%= totalAdmins.getInt(1) %></p>
        </div>

        <div class="card-metrica verde">
            <h3>🎄 Pesebres Registrados</h3>
            <p class="numero"><%= totalPesebres.getInt(1) %></p>
        </div>

        <div class="card-metrica dorado">
            <h3>📅 Eventos Navideños</h3>
            <p class="numero"><%= totalEventos.getInt(1) %></p>
        </div>

    </div>

    <!-- ============================= -->
    <!-- ACCESOS RÁPIDOS -->
    <!-- ============================= -->
    <h2 class="subtitulo">⚡ Accesos Rápidos</h2>

    <div class="grid-accesos">

        <a class="acceso" href="adminUsuarios.jsp">👥 Gestión de Usuarios</a>

        <a class="acceso" href="adminPesebres.jsp">🏠 Gestión de Pesebres</a>

        <a class="acceso" href="adminNovenas.jsp">📅 Gestión de Eventos</a>

        <a class="acceso" href="bitacora.jsp">📝 Bitácora del Sistema</a>

        <a class="acceso" href="../visitante/logout.jsp">🚪 Cerrar Sesión</a>

    </div>

    <!-- ============================= -->
    <!-- ÚLTIMOS REGISTROS -->
    <!-- ============================= -->
    <h2 class="subtitulo">🕒 Últimos Registros</h2>

    <div class="grid-ultimos">

        <!-- USUARIOS -->
        <div class="card-lista">
            <h3>👤 Últimos Usuarios</h3>
            <ul>
            <% while (ultimosUsuarios.next()) { %>
                <li><%=ultimosUsuarios.getString("nombre")%> <%=ultimosUsuarios.getString("apellido")%> — <%=ultimosUsuarios.getString("correo")%></li>
            <% } %>
            </ul>
        </div>

        <!-- PESEBRES -->
        <div class="card-lista">
            <h3>🎄 Últimos Pesebres</h3>
            <ul>
            <% while (ultimosPesebres.next()) { %>
                <li><%=ultimosPesebres.getString("carrera")%></li>
            <% } %>
            </ul>
        </div>

        <!-- EVENTOS -->
        <div class="card-lista">
            <h3>📅 Últimos Eventos</h3>
            <ul>
            <% while (ultimosEventos.next()) { %>
                <li>Día <%=ultimosEventos.getInt("dia")%> — <%=ultimosEventos.getString("organiza")%></li>
            <% } %>
            </ul>
        </div>

    </div>

</div>

</body>
</html>
