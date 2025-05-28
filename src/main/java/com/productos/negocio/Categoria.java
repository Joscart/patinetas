package com.productos.negocio;
import com.productos.datos.Conexion;
import java.sql.*;

public class Categoria {

	public String mostrarCategoria()
	{
		String combo="<select name=cmbCategoria>";
		String sql="SELECT * FROM tb_categoria";
		ResultSet rs=null;
		Conexion con=new Conexion();
		try
		{
			rs=con.Consulta(sql);
			while(rs.next())
			{
				combo+="<option value="+rs.getInt(1)+ ">"+rs.getString(2)+"</option>";
			}
			combo+="</select>";
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		return combo;
	}

	public String mostrarCategoria(int idSeleccionado) {
        String combo = "";
        String sql = "SELECT * FROM tb_categoria";
        ResultSet rs = null;
        Conexion con = new Conexion();
        try {
            rs = con.Consulta(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String nombre = rs.getString(2);
                if (id == idSeleccionado) {
                    combo += "<option value='" + id + "' selected>" + nombre + "</option>";
                } else {
                    combo += "<option value='" + id + "'>" + nombre + "</option>";
                }
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return combo;
    }

}
