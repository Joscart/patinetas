package com.productos.seguridad;

import java.sql.*;

import com.productos.datos.Conexion;

public class EstadoCivil {
	
	public String mostrarEstadoCivil()
	{
		String estadoCivil="";
		String sql="SELECT * FROM tb_estadocivil";
		Conexion con = new Conexion();
		ResultSet rs=null;
		try
		{
			rs=con.Consulta(sql);
			while(rs.next())
			{
				estadoCivil+="<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>";
			}
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		return estadoCivil;
		
	}
}
