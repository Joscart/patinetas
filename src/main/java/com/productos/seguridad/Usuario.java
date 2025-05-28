package com.productos.seguridad;

import com.productos.datos.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Usuario {

    private int id;
    private int perfil;
    private int estadoCivil;
    private String cedula;
    private String nombre;
    private String correo;
    private String clave;
    private String mensajeError = null;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPerfil() {
        return perfil;
    }

    public void setPerfil(int perfil) {
        this.perfil = perfil;
    }

    public int getEstadoCivil() {
        return estadoCivil;
    }

    public void setEstadoCivil(int estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getMensajeError() {
        return mensajeError;
    }

    public void setMensajeError(String mensajeError) {
        this.mensajeError = mensajeError;
    }

    public boolean verificarUsuario(String correo, String clave) {
        String query = "SELECT * FROM tb_usuario WHERE correo_us = ? AND clave_us = ? AND bloqueo = 0";
        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(query);
            ps.setString(1, correo);
            ps.setString(2, clave);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs == null) {
                    this.mensajeError = "No se ha podido iniciar sesión. Error interno al consultar la base de datos.";
                    return false;
                }
                if (rs.next()) {
                    this.correo = correo;
                    this.clave = clave;
                    this.perfil = rs.getInt("id_per");
                    this.nombre = rs.getString("nombre_us");
                    this.mensajeError = null;
                    return true;
                } else {
                    this.mensajeError = "No se ha podido iniciar sesion. Usuario o clave incorrectos.";
                }
            }
        } catch (SQLException e) {
            this.mensajeError = "Error al verificar usuario: " + e.getMessage();
        }
        return false;
    }

    public boolean bloqueoUsuario(int id) {
        String query = "SELECT bloqueo FROM tb_usuario WHERE id_us = ?";
        try {
            Conexion con = new Conexion();
            PreparedStatement ps = con.getConexion().prepareStatement(query);
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    if (rs.getInt("bloqueo") == 0) {
                        String updateQuery = "UPDATE tb_usuario SET bloqueo = 1 WHERE id_us = ?";
                        PreparedStatement psUpdate = con.getConexion().prepareStatement(updateQuery);
                        psUpdate.setInt(1, id);
                        psUpdate.executeUpdate();
                    } else {
                        String updateQuery = "UPDATE tb_usuario SET bloqueo = 0 WHERE id_us = ?";
                        PreparedStatement psUpdate = con.getConexion().prepareStatement(updateQuery);
                        psUpdate.setInt(1, id);
                        psUpdate.executeUpdate();
                    }
                    return true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al verificar bloqueo de usuario: " + e.getMessage());
        }
        return false;
    }

    public String ingresarCliente() {
        String query = "INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            Conexion conexion = new Conexion();
            PreparedStatement ps = conexion.getConexion().prepareStatement(query);
            ps.setInt(1, 2); // Default profile for clients
            ps.setInt(2, this.estadoCivil);
            ps.setString(3, this.nombre);
            ps.setString(4, this.cedula);
            ps.setString(5, this.correo);
            ps.setString(6, this.clave);
            ps.executeUpdate();
            return "Inserción correcta";
        } catch (SQLException e) {
            return "Error en inserción: " + e.getMessage();
        }
    }

    public Boolean ingresarUsuario() {
        String result = "";
        Boolean respuesta = false;
        Conexion con = new Conexion();
        PreparedStatement pr = null;
        String sql = "INSERT INTO tb_usuario (id_per, id_est, nombre_us," +
                "cedula_us,correo_us,clave_us) " +
                "VALUES(?,?,?,?,?,?)";
        try {
            pr = con.getConexion().prepareStatement(sql);
            pr.setInt(1, this.getPerfil());
            pr.setInt(2, this.getEstadoCivil());
            pr.setString(3, this.getNombre());
            pr.setString(4, this.getCedula());
            pr.setString(5, this.getCorreo());
            pr.setString(6, this.getClave());
            if (pr.executeUpdate() == 1) {
                result = "Insercion correcta";
                respuesta = true;
            } else {
                result = "Error en insercion";
            }
        } catch (Exception ex) {
            result = ex.getMessage();
            System.out.print(result);
        } finally {
            try {
                pr.close();
                con.getConexion().close();
            } catch (Exception ex) {
                System.out.print(ex.getMessage());
            }
        }
        return respuesta;
    }

    public Boolean ingresarEmpleado(Integer nperfil, int nestado, String ncedula, String nnombre, String ncorreo, String nclave) {
        String result = "";
        Boolean respuesta = false;
        Conexion con = new Conexion();
        PreparedStatement pr = null;
        String sql = "INSERT INTO tb_usuario (id_per, id_est, nombre_us," +
                "cedula_us,correo_us,clave_us) " +
                "VALUES(?,?,?,?,?,?)";
        try {
            pr = con.getConexion().prepareStatement(sql);
            pr.setInt(1, nperfil);
            pr.setInt(2, nestado);
            pr.setString(3, nnombre);
            pr.setString(4, ncedula);
            pr.setString(5, ncorreo);
            pr.setString(6, nclave);
            if (pr.executeUpdate() == 1) {
                result = "Insercion correcta";
                respuesta = true;
            } else {
                result = "Error en insercion";
            }
        } catch (Exception ex) {
            result = ex.getMessage();
            System.out.print(result);
        } finally {
            try {
                pr.close();
                con.getConexion().close();
            } catch (Exception ex) {
                System.out.print(ex.getMessage());
            }
        }
        return respuesta;
    }

    public Boolean validarClave(String aclave) {
        String regex = "^.{8,}$"; // At least 8 characters
        return aclave.matches(regex);
    }

    public Boolean verificarClave(String aclave) {
        boolean respuesta = false;
        String sentencia = "SELECT clave_us FROM tb_usuario WHERE correo_us = ?";
        try {
            Conexion clsCon = new Conexion();
            PreparedStatement ps = clsCon.getConexion().prepareStatement(sentencia);
            ps.setString(1, this.getCorreo());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String claveBD = rs.getString("clave_us");
                respuesta = claveBD.equals(aclave);
            }
            rs.close();
            ps.close();
            clsCon.getConexion().close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return respuesta;
    }

    public Boolean coincidirClaves(String nclave, String nrepetir) {
        boolean respuesta;
        if (nclave.equals(nrepetir)) {
            respuesta = true;
            this.setClave(nclave);
        } else {
            respuesta = false;
        }
        return respuesta;
    }

    public Boolean cambiarClave(String claveActual, String nuevaClave, String repetirClave) {
        if (!this.verificarClave(claveActual)) {
            System.out.println("La clave actual no coincide con la registrada en la base de datos.");
            return false;
        }
        if (!this.coincidirClaves(nuevaClave, repetirClave)) {
            System.out.println("La nueva clave y la repetición no coinciden.");
            return false;
        }
        if (!this.validarClave(nuevaClave)) {
            System.out.println("La nueva clave no cumple con los requisitos de seguridad.");
            return false;
        }
        return this.actualizarClave(nuevaClave);
    }

    private Boolean actualizarClave(String nuevaClave) {
        boolean respuesta = false;
        String sentencia = "UPDATE tb_usuario SET clave_us = ? WHERE correo_us = ?";
        try {
            Conexion clsCon = new Conexion();
            PreparedStatement ps = clsCon.getConexion().prepareStatement(sentencia);
            ps.setString(1, nuevaClave);
            ps.setString(2, this.getCorreo());
            if (ps.executeUpdate() == 1) {
                respuesta = true;
                this.setClave(nuevaClave);
            }
            ps.close();
            clsCon.getConexion().close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return respuesta;
    }

    public String mostrarTablaUsuarios() {
        String tabla = "";
        String sql = "SELECT u.id_us, p.descripcion_per, e.descripcion_est, u.cedula_us, u.nombre_us, u.correo_us, u.bloqueo " +
                     "FROM tb_usuario u, tb_perfil p, tb_estadocivil e " +
                     "WHERE u.id_per = p.id_per AND u.id_est = e.id_est " +
                     "ORDER BY u.id_us";
        Conexion con = new Conexion();
        ResultSet rs = null;
        tabla += "<tr>"
                + "<th>Id</th>"
                + "<th>Perfil</th>"
                + "<th>Estado Civil</th>"
                + "<th>Cedula</th>"
                + "<th>Nombre</th>"
                + "<th>Correo</th>"
                + "<th>Estado</th>"
                + "<th>Bloqueo</th>"
                + "</tr>";
        try {
            rs = con.Consulta(sql);
            while (rs != null && rs.next()) {
                int id = rs.getInt(1);
                int bloqueo = rs.getInt(7);
                tabla += "<tr>"
                        + "<td>" + id + "</td>"
                        + "<td>" + rs.getString(2) + "</td>"
                        + "<td>" + rs.getString(3) + "</td>"
                        + "<td>" + rs.getString(4) + "</td>"
                        + "<td>" + rs.getString(5) + "</td>"
                        + "<td>" + rs.getString(6) + "</td>"
                        + "<td>" + (bloqueo == 0 ? "Desbloqueado" : "Bloqueado") + "</td>"
                        + "<td>"
                        + "<form action='usuarios.jsp' method='post'>"
                        + "<input type='hidden' name='idUsuario' value='" + id + "'/>"
                        + "<input type='submit' name='accion' value='" + (bloqueo == 0 ? "Bloquear" : "Desbloquear") + "'/>"
                        + "</form>"
                        + "</td>"
                        + "</tr>";
            }
        } catch (SQLException e) {
            System.out.print("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                con.getConexion().close();
            } catch (SQLException e) {
                System.out.print("Error al cerrar recursos: " + e.getMessage());
            }
        }
        if (tabla.isEmpty()) {
            System.out.println("La tabla generada está vacía.");
        }
        return tabla;
    }
}
