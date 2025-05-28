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
	
	public String agregarOferta(int cat,  double precioOferta) {
		String sentencia="UPDATE tb_producto SET estado = 1, valor = "+precioOferta+" WHERE id_cat = "+cat;
		Conexion con=new Conexion();
		String rs=null;

		rs=con.Ejecutar(sentencia);
		return rs;
	}
	
	public String eliminarOferta(int cat) {
		String sentencia="UPDATE tb_producto SET estado = 0 WHERE id_cat = "+cat;
		Conexion con=new Conexion();
		String rs=null;

		rs=con.Ejecutar(sentencia);
		return rs;
	}
	
	public String consultarOfertas()
	{
		String sql="SELECT * FROM tb_producto WHERE estado = 1 ORDER BY id_pr";
		Conexion con=new Conexion();
		String tabla="<table class=\"tabla\"><th>ID</th><th>Producto</th><th>Cantidad</th><th>Precio</th><th>Precio Oferta</th>";
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
							+ "<td>"+rs.getDouble(8)+"</td>"
							+ "</tr>";
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
	
	public String consultarSinOfertas(String linkModificar)
	{
		String sql="SELECT * FROM tb_producto WHERE estado = 0 ORDER BY id_pr";
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
							+ "<td><a href="+linkModificar+"?id="+rs.getInt(1)+">Agregar Oferta</a></td>"
							+ "</tr>";
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
	
	// Método para insertar imagen en un producto
    public String insertarImagenProducto(int idProducto, String rutaImagen) {
        String sql = "UPDATE public.tb_producto SET foto_pr = pg_read_binary_file('" + rutaImagen + "')::bytea WHERE id_pr = " + idProducto + ";";
        Conexion con = new Conexion();
        String resultado = con.Ejecutar(sql);
        return resultado;
    }
    
    // Método para obtener la imagen de un producto en base64 para HTML
    public String obtenerImagenProducto(int idProducto) {
        String sql = "SELECT CONCAT('data:image/png;base64,', encode(foto_pr, 'base64')) AS foto_base64 FROM public.tb_producto WHERE id_pr = " + idProducto + ";";
        Conexion con = new Conexion();
        ResultSet rs = null;
        String imagenBase64 = "";
        rs = con.Consulta(sql);
        try {
            if (rs != null && rs.next()) {
                imagenBase64 = rs.getString("foto_base64");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        return imagenBase64;
    }

	// Método para imprimir una galería de productos seleccionable usando obtenerImagenProducto y con efecto hover
    public String galeriaProductos(String linkVista) {
        String sql = "SELECT id_pr, nombre_pr, precio_pr, estado, valor FROM public.tb_producto ORDER BY id_pr";
        Conexion con = new Conexion();
        ResultSet rs = null;
        StringBuilder galeria = new StringBuilder();
        galeria.append("<div class='galeria-productos'>");
        rs = con.Consulta(sql);
        try {
            while (rs != null && rs.next()) {
                int id = rs.getInt("id_pr");
                String nombre = rs.getString("nombre_pr");
                double precio = rs.getDouble("precio_pr");
                int estado = rs.getInt("estado");
                double valorOferta = rs.getDouble("valor");
                // Usar el método obtenerImagenProducto
                String imgBase64 = obtenerImagenProducto(id);
                if (imgBase64 == null || imgBase64.isEmpty()) {
                    imgBase64 = "images/choropatin-logo.jpg"; // Imagen por defecto si no hay foto
                }
                galeria.append("<a href='" + linkVista + "?id=" + id + "' style='text-decoration:none;color:inherit;'>");
                galeria.append("<div class='producto-card'>");
                galeria.append("<img src='" + imgBase64 + "' alt='" + nombre + "' style='width:100%;height:150px;object-fit:cover;'>");
                galeria.append("<div style='padding:10px;'>");
                galeria.append("<h3>" + nombre + "</h3>");
                if (estado == 1) {
                    galeria.append("<span class='oferta-badge'>Oferta</span><br>");
                    galeria.append("<span class='precio-tachado'>$" + precio + "</span> ");
                    galeria.append("<span class='precio-oferta'>$" + valorOferta + "</span>");
                } else {
                    galeria.append("<span class='precio-normal'>$" + precio + "</span>");
                }
                galeria.append("</div></div></a>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        galeria.append("</div>");
        return galeria.toString();
    }

	// Método para consultar un producto por su id
    public ResultSet consultar(int idProducto) {
        String sql = "SELECT * FROM tb_producto WHERE id_pr = " + idProducto;
        Conexion con = new Conexion();
        return con.Consulta(sql);
    }
	
}
