<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.*"%>
    
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
		<h1>Sitio Privado de Productos</h1>
		<h4>
			Bienvenido
			<%
		out.println(usuario);
		%>
		</h4>

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

<%
}
%>