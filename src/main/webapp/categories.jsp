<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*"%>
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
				<li><a href="login.jsp">Iniciar Sesion</a></li>
				<li><a href="register.jsp">Registrarse</a></li>
			</ul>
		</aside>
	</nav>

	<section id="categorias">
		<form id="seleccionCat" method="post" action="categories.jsp">
			<%
			Categoria c = new Categoria();
			out.print(c.mostrarCategoria());
			%>
			<input type="submit" value="Verificar" />
		</form>
		
		<h3>Productos</h3>
		
		<%
		String idCat = request.getParameter("cmbCategoria");
		if (idCat != null) {
			Producto p = new Producto();
			try {
				int catId = Integer.parseInt(idCat);
				out.print(p.buscarProductoCategoria(catId));
			} catch (NumberFormatException e) {
				out.print(p.consultarTodo());
			}
		}
		%>

	</section>

	<footer>
		<p>
			Uicons by <a href="https://www.flaticon.com/uicons">Flaticon</a>
		</p>
		<p>&copy; 2025 ChoroPatin. Todos los derechos reservados.</p>
	</footer>
	<script src="main.js"></script>
</body>
</html>