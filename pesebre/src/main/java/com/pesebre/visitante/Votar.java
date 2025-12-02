package com.pesebre.visitante;

import com.pesebre.datos.Conexion;
import java.sql.*;
import java.util.ArrayList;

public class Votar {

    // ========================================
    //  CLASE INTERNA PARA P E S E B R E S
    // ========================================
    public static class Pesebre {
        public int id;
        public String carrera;
        public String imagen;
    }

    // ========================================
    //  CLASE INTERNA PARA R A N K I N G
    // ========================================
    public static class Ranking {
        public String carrera;
        public int votos;
    }

    private Conexion con;

    public Votar() {
        con = new Conexion();
    }

    // ====================================================
    // OBTENER ID del usuario desde su NOMBRE DE SESIÓN
    // ====================================================
    public int obtenerIdUsuario(String nombreSesion) {
        int id = -1;

        try {
            String sql = "SELECT id_usuario FROM tb_usuario WHERE nombre = ?";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setString(1, nombreSesion);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id_usuario");
            }

        } catch (Exception e) {
            System.out.println("Error obtenerIdUsuario(): " + e.getMessage());
        }

        return id;
    }

    // ====================================================
    // TRAER LISTA DE PESEBRES
    // ====================================================
    public ArrayList<Pesebre> obtenerPesebres() {

        ArrayList<Pesebre> lista = new ArrayList<>();

        try {
            String sql = "SELECT id_galeria, carrera, imagen FROM tb_galeria ORDER BY carrera ASC";
            ResultSet rs = con.Consulta(sql);

            while (rs.next()) {
                Pesebre p = new Pesebre();
                p.id = rs.getInt("id_galeria");
                p.carrera = rs.getString("carrera");
                p.imagen = rs.getString("imagen");
                lista.add(p);
            }

        } catch (Exception e) {
            System.out.println("Error obtenerPesebres(): " + e.getMessage());
        }

        return lista;
    }

    // ====================================================
    // VERIFICAR SI EL USUARIO YA VOTÓ
    // ====================================================
    public boolean yaVoto(int idUsuario) {

        try {
            String sql = "SELECT COUNT(*) FROM tb_voto WHERE id_usuario = ?";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            System.out.println("Error yaVoto(): " + e.getMessage());
        }

        return false;
    }

    // ====================================================
    // REGISTRAR VOTO DEL USUARIO
    // ====================================================
    public boolean registrarVoto(int idUsuario, int idPesebre) {

        try {
            String sql = "INSERT INTO tb_voto(id_usuario, id_galeria) VALUES (?, ?)";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);
            ps.setInt(2, idPesebre);
            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            System.out.println("Error registrarVoto(): " + e.getMessage());
            return false;
        }
    }

    // ====================================================
    // OBTENER RANKING
    // ====================================================
    public ArrayList<Ranking> obtenerRanking() {

        ArrayList<Ranking> lista = new ArrayList<>();

        try {
            String sql =
                "SELECT g.carrera, COUNT(v.id_galeria) AS votos " +
                "FROM tb_galeria g " +
                "LEFT JOIN tb_voto v ON g.id_galeria = v.id_galeria " +
                "GROUP BY g.carrera " +
                "ORDER BY votos DESC";

            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ranking r = new Ranking();
                r.carrera = rs.getString("carrera");
                r.votos = rs.getInt("votos");
                lista.add(r);
            }

        } catch (Exception e) {
            System.out.println("Error obtenerRanking(): " + e.getMessage());
        }

        return lista;
    }
}
