package com.productos.negocio;
import com.productos.datos.Conexion;
import java.sql.*;

public class Producto {

	public String consultarTodo()
	{
		String sql="SELECT * FROM tb_producto ORDER BY id_pr";
		Conexion con=new Conexion();
		String tabla="<table class=\"tabla\"><th>ID</th><th>Producto</th><th>Cantidad</th><th>Precio</th>";
		ResultSet rs=null;
		rs=con.Consulta(sql);
		try {
			if(rs!=null) {
				while(rs.next())
				{
					tabla+="<tr><td>"+rs.getInt(1)+"</td>"
							+ "<td>"+rs.getString(3)+"</td>"
							+ "<td>"+rs.getInt(4)+"</td>"
							+ "<td>"+rs.getDouble(5)+"</td>"
							+ "</td></tr>";
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		tabla+="</table>";
		return tabla;
	}
	
	public String reporte()
	{
		String sql="SELECT id_pr, nombre_pr, descripcion_cat, cantidad_pr, precio_pr FROM tb_producto, tb_categoria WHERE tb_producto.id_cat=tb_categoria.id_cat ORDER BY id_pr";
		Conexion con=new Conexion();
		String tabla="<table class=\"tabla\"><th>ID</th><th>Producto</th><th>Categoria</th><th>Cantidad</th><th>Precio</th>";
		ResultSet rs=null;
		rs=con.Consulta(sql);
		try {
			if(rs!=null) {
				while(rs.next())
				{
					tabla+="<tr><td>"+rs.getInt(1)+"</td>"
							+ "<td>"+rs.getString(2)+"</td>"
							+ "<td>"+rs.getString(3)+"</td>"
							+ "<td>"+rs.getInt(4)+"</td>"
							+ "<td>"+rs.getDouble(5)+"</td>"
							+ "</td></tr>";
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		tabla+="</table>";
		return tabla;
		
	}
	
	public String reporte(String link_eliminar,String link_modificar)
	{
		String sql="SELECT id_pr, nombre_pr, descripcion_cat, cantidad_pr, precio_pr FROM tb_producto, tb_categoria WHERE tb_producto.id_cat=tb_categoria.id_cat ORDER BY id_pr";
		Conexion con=new Conexion();
		String tabla="<table class=\"tabla\"><th>ID</th><th>Producto</th><th>Categoria</th><th>Cantidad</th><th>Precio</th>";
		ResultSet rs=null;
		rs=con.Consulta(sql);
		try {
			if(rs!=null) {
				while(rs.next())
				{
					tabla+="<tr><td>"+rs.getInt(1)+"</td>"
							+ "<td>"+rs.getString(2)+"</td>"
							+ "<td>"+rs.getString(3)+"</td>"
							+ "<td>"+rs.getInt(4)+"</td>"
							+ "<td>"+rs.getDouble(5)+"</td>"
							+ "<td><a href="+link_modificar+"?id="+rs.getInt(1)+">Modificar</a></td>"
							+ "<td><a href="+link_eliminar+"?id="+rs.getInt(1)+">Eliminar</a></td>"
							+ "</td></tr>";
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		tabla+="</table>";
		return tabla;
		
	}
	
	public Boolean insertarProducto( String nombre, int cantidad, double precio, int cat)
	{
		String sql="INSERT INTO tb_producto ( nombre_pr, cantidad_pr, precio_pr, id_cat) VALUES ('"+nombre+"',"+cantidad+","+precio+","+cat+")";
		Conexion con=new Conexion();
		boolean resultado=false;
		String error=con.Ejecutar(sql);
		if(error.equals(""))
		{
			resultado=true;
		}else{
			System.out.print("Error: "+error);
		}
		return resultado;
		
	}

	public String buscarProductoCategoria(int cat)
	{
		String sentencia="SELECT nombre_pr, precio_pr FROM tb_producto WHERE id_cat="+cat;
		Conexion con=new Conexion();
		ResultSet rs=null;
		String resultado="<table class=\"tabla\">";
		try
		{
			rs=con.Consulta(sentencia);
			while(rs.next())
			{
				resultado+="<tr><td>"+ rs.getString(1)+"</td>"
						+ "<td>"+rs.getDouble(2)+"</td></tr>";
			}
			resultado+="</table>";
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		System.out.print(resultado);
		return resultado;
	}

}
