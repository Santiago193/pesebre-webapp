<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, com.pesebre.datos.Conexion" session="true"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Bitácora del Sistema</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/menuu.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css2/bitacora.css">

</head>

<body class="menu-body">

<jsp:include page="/head&foot/menuu.jsp" />

<div class="container mt-4">

    <h2 class="mb-4">📑 Bitácora del Sistema</h2>

    <!-- ============================= -->
    <!-- FORMULARIO DE FILTROS -->
    <!-- ============================= -->
    <form method="GET" class="row g-3 mb-4">

        <div class="col-md-3">
            <label>Fecha Desde:</label>
            <input type="date" name="desde" class="form-control"
                   value="<%= request.getParameter("desde") != null ? request.getParameter("desde") : "" %>">
        </div>

        <div class="col-md-3">
            <label>Fecha Hasta:</label>
            <input type="date" name="hasta" class="form-control"
                   value="<%= request.getParameter("hasta") != null ? request.getParameter("hasta") : "" %>">
        </div>

        <div class="col-md-3">
            <label>Operación:</label>
            <select name="op" class="form-control">
                <option value="">Todas</option>
                <option value="INSERT" <%= "INSERT".equals(request.getParameter("op"))?"selected":"" %>>INSERT</option>
                <option value="UPDATE" <%= "UPDATE".equals(request.getParameter("op"))?"selected":"" %>>UPDATE</option>
                <option value="DELETE" <%= "DELETE".equals(request.getParameter("op"))?"selected":"" %>>DELETE</option>
            </select>
        </div>

        <div class="col-md-3">
            <label>Tabla:</label>
            <select name="tabla" class="form-control">
                <option value="">Todas</option>
                <option value="tb_usuario">Usuarios</option>
                <option value="tb_estadocivil">Estado Civil</option>
                <option value="tb_perfil">Perfiles</option>
                <option value="tb_pagina">Páginas</option>
                <option value="tb_perfilpagina">Perfil-Página</option>
                <option value="tb_galeria">Galería</option>
                <option value="tb_novenas">Novenas</option>
                <option value="tb_producto">Producto</option>
            </select>
        </div>

        <div class="col-md-12 text-end">
            <button class="btn btn-primary mt-3">Buscar</button>
        </div>

    </form>

    <!-- ============================= -->
    <!-- TABLA RESULTADOS -->
    <!-- ============================= -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Fecha</th>
                    <th>Tabla</th>
                    <th>Operación</th>
                    <th>Usuario</th>
                    <th>IP</th>
                    <th>Página</th>
                    <th>Antes</th>
                    <th>Después</th>
                </tr>
            </thead>
            <tbody>
            <%
                String desde = request.getParameter("desde");
                String hasta = request.getParameter("hasta");
                String tabla = request.getParameter("tabla");
                String op = request.getParameter("op");

                String sql = "SELECT id_aud, fecha_aud, tabla_aud, operacion_aud, usuario_aud, ip_aud, pagina_aud, old_data, new_data " +
                             "FROM tb_auditoria WHERE 1=1 ";

                if (desde != null && !desde.isEmpty()) sql += " AND fecha_aud >= '" + desde + " 00:00:00' ";
                if (hasta != null && !hasta.isEmpty()) sql += " AND fecha_aud <= '" + hasta + " 23:59:59' ";

                if (tabla != null && !tabla.isEmpty()) {
                    sql += " AND tabla_aud = '" + tabla + "' ";
                }

                if (op != null && !op.isEmpty()) {
                    sql += " AND operacion_aud = '" + op + "' ";
                }

                sql += " ORDER BY fecha_aud DESC, id_aud DESC";

                try {
                    Conexion cn = new Conexion();
                    Connection c = cn.getConexion();
                    Statement st = c.createStatement();
                    ResultSet rs = st.executeQuery(sql);

                    while (rs.next()) {
            %>

            <tr>
                <td><%= rs.getInt("id_aud") %></td>
                <td><%= rs.getTimestamp("fecha_aud") %></td>
                <td><%= rs.getString("tabla_aud") %></td>
                <td><%= rs.getString("operacion_aud") %></td>
                <td><%= rs.getString("usuario_aud") %></td>
                <td><%= rs.getString("ip_aud") %></td>
                <td><%= rs.getString("pagina_aud") %></td>

                <td style="max-width:260px;"><pre><%= rs.getString("old_data") %></pre></td>
                <td style="max-width:260px;"><pre><%= rs.getString("new_data") %></pre></td>
            </tr>

            <%
                    }

                } catch (Exception e) {
                    out.println("<tr><td colspan='9'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
