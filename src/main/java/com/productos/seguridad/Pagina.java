package com.productos.seguridad;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

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
			if (rs != null) {
				while(rs.next())
				{
					menu+="<li><a href="+rs.getString(3)+" >"+rs.getString(2)+"</a></li>";
				}
			}
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		return menu;
	}

	public String mostrarMenu(Integer perfil, boolean isLoggedIn) {
		String menu = "";

		if (isLoggedIn) {
			// User is logged in
			String sql = "SELECT * FROM tb_pagina pag, tb_perfil per, "
					+ "tb_perfilpagina pper " +
					"WHERE pag.id_pag=pper.id_pag AND pper.id_per=per.id_per "
					+ "AND pper.id_per= " + perfil;
			Conexion con = new Conexion();
			ResultSet rs = null;
			try {
				rs = con.Consulta(sql);
				if (rs != null) {
					while (rs.next()) {
						menu += "<li><a class=\"hover:text-indigo-700 transition\" href=" + rs.getString(3) + ">"
								+ "<span>" + rs.getString(2) + "</span>"
								+ "</a></li>";
					}
				}
			} catch (SQLException e) {
				System.out.print(e.getMessage());
			}
		} else {
			// User is not logged in
			menu += "<li><a class=\"hover:text-indigo-700 transition\" href=\"login.jsp\">"
					+ "<span> Iniciar Sesion </span>"
					+ "</a></li>";
			menu += "<li><a class=\"hover:text-indigo-700 transition\" href=\"register.jsp\">"
					+ "<span> Registrarse </span>"
					+ "</a></li>";
		}

		return menu;
	}

}
