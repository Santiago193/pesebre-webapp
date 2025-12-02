package com.pesebre.seguridad;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.pesebre.datos.Conexion;

public class Pagina {

	public String mostrarMenu(Integer nperfil) {

		String menu = "<nav class=\"navbar navbar-expand-lg bg-body-tertiary\">\r\n"
		        + "  <div class=\"container-fluid\">\r\n"
		        + "    <a class=\"navbar-brand\" href=\"/pesebre/menu.jsp\">Menú</a>\r\n"
		        + "    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" "
		        + "data-bs-target=\"#navbarNav\" aria-controls=\"navbarNav\" aria-expanded=\"false\" "
		        + "aria-label=\"Toggle navigation\">\r\n"
		        + "      <span class=\"navbar-toggler-icon\"></span>\r\n"
		        + "    </button>\r\n"
		        + "    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\r\n"
		        + "      <ul class=\"navbar-nav\">\r\n";


	    String sql = "SELECT pag.id_pagina, pag.nombre, pag.url "
	            + "FROM tb_pagina pag "
	            + "JOIN tb_perfilpagina pper ON pag.id_pagina = pper.id_pagina "
	            + "WHERE pper.id_perfil = ?";

	    Conexion con = new Conexion();
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        ps = con.getConexion().prepareStatement(sql);
	        ps.setInt(1, nperfil);
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            int idPag = rs.getInt("id_pagina");
	            String nombrePag = rs.getString("nombre");
	            String urlPag = rs.getString("url");

	            menu += "        <li class=\"nav-item\">\r\n"
	                    + "          <a class=\"nav-link\" href=\"" + urlPag
	                    + "?accesskey=" + idPag + "\">"
	                    + nombrePag + "</a>\r\n"
	                    + "        </li>\r\n";
	        }

	    } catch (SQLException e) {
	        System.out.println("❌ Error al generar menú: " + e.getMessage());
	    }

	    menu += "      </ul>\r\n"
	            + "    </div>\r\n"
	            + "  </div>\r\n"
	            + "</nav>\r\n";

	    return menu;
	}

}
