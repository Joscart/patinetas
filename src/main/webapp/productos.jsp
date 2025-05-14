<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.*, com.productos.negocio.*"%>
    
<%
String usuario;
HttpSession sesion = request.getSession();
if (sesion.getAttribute("usuario") == null) //Se verifica si existe la variable
{
%>
<jsp:forward page="login.jsp">
	<jsp:param name="error" value="Debe registrarse en el sistema." />
</jsp:forward>
<%
} else {
%>

<%
usuario = (String) sesion.getAttribute("usuario"); //Se devuelve los valores de atributos
int perfil = (Integer) sesion.getAttribute("perfil");
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Choro Patin</title>

<!-- Custom Styles -->
<link rel="stylesheet" href="style.css">
<link rel='stylesheet'
	href='https://cdn-uicons.flaticon.com/2.6.0/uicons-brands/css/uicons-brands.css'>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>

<body>
	<header>
		<a href="index.jsp"> <img id="logo"
			src="images/choropatin-logo.jpg" alt="Logo de Choro Patin"
			class="logo">
		</a>
		<h1>Choro Patin</h1>
		<p>Tu pati-tienda de confianza</p>
	</header>

	<nav>
		<ul>
			<li><a href="products.jsp">Productos</a></li>
			<li><a href="categories.jsp">Categorias</a></li>
		</ul>
		<aside>
			<ul>
				<%
				Pagina pag = new Pagina();
				String menu = pag.mostrarMenu(perfil);
				out.print(menu);
				%>
			</ul>
		</aside>
	</nav>

	<section id="menu">
		<!-- FORMULARIO para agregar productos  -->
		<h2>Agregar Productos</h2>
		<form action="productos.jsp" method="post">
			<table>
				<tr>
					<td><label for="nombre">Nombre:</label></td>
					<td><input type="text" id="nombre" name="nombre" required></td>
				</tr>
				<tr>
					<td><label for="precio">Precio:</label></td>
					<td><input type="number" id="precio" name="precio" required></td>
				</tr>
				<tr>
					<td><label for="categoria">Categoria:</label></td>
					<td>
					<%
					Categoria c = new Categoria();
					out.print(c.mostrarCategoria());
					%>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="Agregar Producto"></td>
				</tr>
			</table>
		</form>
		<%
		// Obtener los datos del formulario
		String nombre = request.getParameter("nombre");
		String precio = request.getParameter("precio");
		String categoria = request.getParameter("cmbCategoria");
		if (nombre != null && precio != null && categoria != null) {
            // Crear un nuevo objeto Producto
            Producto p = new Producto();
            
            try {
                // Convertir el precio a double y la categoria a int
                Double.parseDouble(precio);
                Integer.parseInt(categoria);
            } catch (NumberFormatException e) {
                out.println("<p>Error: Precio o Categoria no válidos.</p>");
            }
            Boolean resultado = p.insertarProducto(nombre, 0,Double.parseDouble(precio), Integer.parseInt(categoria));
            
            // Llamar al método para agregar el producto
            if (resultado) {
                out.println("<p>Producto agregado exitosamente.</p>");
            } else {
                out.println("<p>Error al agregar el producto.</p>");
            }
        }
		%>
	</section>
	<section id="productos">
		<h2>Lista de Productos</h2>
		<%
		Producto p = new Producto();
		out.print(p.reporte("", ""));
		%>
	</section>

	<footer>
		<p>
			Uicons by <a href="https://www.flaticon.com/uicons">Flaticon</a>
		</p>
		<p>&copy; 2025 ChoroPatin. Todos los derechos reservados.</p>
	</footer>
	<script src="main.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
</body>
</html>

<%
}
%>