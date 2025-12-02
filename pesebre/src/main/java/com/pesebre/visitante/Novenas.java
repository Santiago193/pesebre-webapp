package com.pesebre.visitante;

import com.pesebre.datos.Conexion;
import java.sql.*;
import java.util.ArrayList;

public class Novenas {

    // Clase interna para representar una novena
    public static class Item {
        public int dia;
        public Date fecha;
        public String organiza;
        public String lugar;
        public String descripcion;
    }

    // Método para obtener las novenas
    public ArrayList<Item> getNovenas() {
        ArrayList<Item> lista = new ArrayList<>();

        try {
            Conexion con = new Conexion();
            String sql = "SELECT dia, fecha, organiza, lugar, descripcion FROM tb_novenas ORDER BY dia ASC";
            ResultSet rs = con.Consulta(sql);

            while (rs.next()) {
                Item i = new Item();
                i.dia = rs.getInt("dia");
                i.fecha = rs.getDate("fecha");
                i.organiza = rs.getString("organiza");
                i.lugar = rs.getString("lugar");
                i.descripcion = rs.getString("descripcion");
                lista.add(i);
            }

        } catch (Exception e) {
            System.out.println("Error cargando novenas: " + e.getMessage());
        }

        return lista;
    }
}
