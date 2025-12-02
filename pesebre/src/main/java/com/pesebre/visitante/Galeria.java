package com.pesebre.visitante;

import com.pesebre.datos.Conexion;
import java.sql.*;
import java.util.ArrayList;

public class Galeria {

    // Clase interna para representar un item
    public static class Item {
        public String carrera;
        public String descripcion;
        public String imagen;
    }

    // Método para obtener lista desde la BD
    public ArrayList<Item> getGaleria() {
        ArrayList<Item> lista = new ArrayList<>();

        try {
            Conexion con = new Conexion();
            String sql = "SELECT carrera, descripcion, imagen FROM tb_galeria ORDER BY id_galeria ASC";
            ResultSet rs = con.Consulta(sql);

            while (rs.next()) {
                Item i = new Item();
                i.carrera = rs.getString("carrera");
                i.descripcion = rs.getString("descripcion");
                i.imagen = rs.getString("imagen");
                lista.add(i);
            }

        } catch (Exception e) {
            System.out.println("Error cargando galería: " + e.getMessage());
        }

        return lista;
    }
}
