package com.productos.seguridad;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.productos.datos.Conexion;

public class Pagina {

	public String mostrarMenu(Integer nperfil)
	{
		String menu="";
		String sql="SELECT * FROM tb_pagina pag, tb_perfil per, "
				+ "tb_perfilpagina pper " +
				"WHERE pag.id_pag=pper.id_pag AND pper.id_per=per.id_per "
				+ "AND pper.id_per= "+nperfil;
		Conexion con = new Conexion();
		ResultSet rs=null;
		try
		{
			rs=con.Consulta(sql);
			while(rs.next())
			{
				menu+="<li><a href="+rs.getString(3)+" >"+rs.getString(2)+"</a></li>";
			}
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		return menu;
	}

}
