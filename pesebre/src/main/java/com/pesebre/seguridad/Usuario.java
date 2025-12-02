package com.pesebre.seguridad;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import com.pesebre.datos.Conexion;

public class Usuario {

	// ============================
	// ATRIBUTOS (coinciden con la BD)
	// ============================
	private int id_usuario;
	private String nombre;
	private String apellido;
	private String correo;
	private String contrasena;
	private int id_estadocivil;
	private int id_perfil;
	private boolean bloqueado;

	// ============================
	// CONSTRUCTOR
	// ============================
	public Usuario() {
	}

	// ============================
	// GETTERS Y SETTERS
	// ============================
	public boolean isBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(boolean bloqueado) {
		this.bloqueado = bloqueado;
	}

	public int getId_usuario() {
		return id_usuario;
	}

	public void setId_usuario(int id_usuario) {
		this.id_usuario = id_usuario;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

	public String getContrasena() {
		return contrasena;
	}

	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}

	public int getId_estadocivil() {
		return id_estadocivil;
	}

	public void setId_estadocivil(int id_estadocivil) {
		this.id_estadocivil = id_estadocivil;
	}

	public int getId_perfil() {
		return id_perfil;
	}

	public void setId_perfil(int id_perfil) {
		this.id_perfil = id_perfil;
	}

	// ===================================================
	// MÉTODO: Insertar usuario (REGISTRO PÚBLICO)
	// ===================================================
	public String registrar() {
		String sql = "INSERT INTO tb_usuario (nombre, apellido, correo, contrasena, id_estadocivil, id_perfil) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		Conexion con = new Conexion();

		try (Connection cn = con.getConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {

			ps.setString(1, this.nombre);
			ps.setString(2, this.apellido);
			ps.setString(3, this.correo);
			ps.setString(4, this.contrasena);
			ps.setInt(5, this.id_estadocivil);
			ps.setInt(6, this.id_perfil); // siempre VISITANTE = 2

			ps.executeUpdate();
			return "OK";

		} catch (Exception e) {
			return e.getMessage();
		}
	}

	// ===================================================
	// MÉTODO: VALIDAR LOGIN
	// ===================================================
	public static Usuario login(String correo, String clave) {
		String sql = "SELECT * FROM tb_usuario WHERE correo = ? AND contrasena = ?";
		Conexion con = new Conexion();

		try (Connection cn = con.getConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {

			ps.setString(1, correo);
			ps.setString(2, clave);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				Usuario u = new Usuario();
				u.setId_usuario(rs.getInt("id_usuario"));
				u.setNombre(rs.getString("nombre"));
				u.setApellido(rs.getString("apellido"));
				u.setCorreo(rs.getString("correo"));
				u.setContrasena(rs.getString("contrasena"));
				u.setId_estadocivil(rs.getInt("id_estadocivil"));
				u.setId_perfil(rs.getInt("id_perfil"));
				return u;
			}

		} catch (Exception e) {
			System.out.println("Error en login: " + e.getMessage());
		}
		return null;
	}

	public boolean verificarUsuario(String correo, String clave) {

	    String sql = "SELECT * FROM tb_usuario WHERE correo = ? AND contrasena = ?";
	    Conexion con = new Conexion();

	    try (Connection cn = con.getConexion();
	         PreparedStatement ps = cn.prepareStatement(sql)) {

	        ps.setString(1, correo);
	        ps.setString(2, clave);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {

	            // Verificar si está bloqueado
	            this.bloqueado = rs.getBoolean("bloqueado");
	            if (this.bloqueado) {
	                return false; // login fallará pero sabremos que está bloqueado
	            }

	            // Si NO está bloqueado, cargar datos
	            this.id_usuario     = rs.getInt("id_usuario");
	            this.nombre         = rs.getString("nombre");
	            this.apellido       = rs.getString("apellido");
	            this.correo         = rs.getString("correo");
	            this.contrasena     = rs.getString("contrasena");
	            this.id_estadocivil = rs.getInt("id_estadocivil");
	            this.id_perfil      = rs.getInt("id_perfil");

	            return true;
	        }

	    } catch (Exception e) {
	        System.out.println("Error verificarUsuario: " + e.getMessage());
	    }

	    return false;
	}

}
