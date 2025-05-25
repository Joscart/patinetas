package com.productos.seguridad;

import com.productos.datos.Conexion;
import java.sql.ResultSet;

public class Bitacora {

    public String mostrarAuditoria() {
        Conexion conexion = new Conexion();
        String query = "SELECT * FROM auditoria.tb_auditoria";
        String result = "<table border='1'><tr><th>ID</th><th>Tabla</th><th>Operación</th><th>Valor Anterior</th><th>Valor Nuevo</th><th>Fecha</th><th>Usuario</th><th>Esquema</th><th>Activar</th><th>Trigger</th></tr>";
        try {
            ResultSet resultSet = conexion.Consulta(query);
            if (!resultSet.isBeforeFirst()) { // Check if ResultSet is empty
                return "<p>No records found in tb_auditoria.</p>";
            }
            while (resultSet.next()) {
                result += "<tr>" +
                          "<td>" + resultSet.getInt("id_aud") + "</td>" +
                          "<td>" + resultSet.getString("tabla_aud") + "</td>" +
                          "<td>" + resultSet.getString("operacion_aud") + "</td>" +
                          "<td>" + resultSet.getString("valoranterior_aud") + "</td>" +
                          "<td>" + resultSet.getString("valornuevo_aud") + "</td>" +
                          "<td>" + resultSet.getDate("fecha_aud") + "</td>" +
                          "<td>" + resultSet.getString("usuario_aud") + "</td>" +
                          "<td>" + resultSet.getString("esquema_aud") + "</td>" +
                          "<td>" + resultSet.getBoolean("activar_aud") + "</td>" +
                          "<td>" + resultSet.getBoolean("trigger_aud") + "</td>" +
                          "</tr>";
            }
            result += "</table>";
        } catch (Exception e) {
            e.printStackTrace();
            return "<p>Error retrieving data: " + e.getMessage() + "</p>";
        }
        return result;
    }
}
