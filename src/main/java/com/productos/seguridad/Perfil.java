package com.productos.seguridad;

import java.sql.*;

import com.productos.datos.Conexion;

public class Perfil {
	
	public String mostrarPerfil()
	{
		String perfil="";
		String sql="SELECT * FROM tb_perfil";
		Conexion con = new Conexion();
		ResultSet rs=null;
		try
		{
			rs=con.Consulta(sql);
			while(rs.next())
			{
				perfil+="<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>";
			}
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		return perfil;
		
	}

}
