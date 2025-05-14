<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.* , com.productos.seguridad.*"%>
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
<%
String usuario;
HttpSession sesion = request.getSession();
if (sesion.getAttribute("usuario") == null) //Se verifica si existe la variable
{
usuario = (String) sesion.getAttribute("usuario"); //Se devuelve los valores de atributos
}
%>
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
				if (sesion.getAttribute("usuario") != null) {
					Pagina pag = new Pagina();
					int perfil = (Integer) sesion.getAttribute("perfil");
					String menu = pag.mostrarMenu(perfil);
					out.print(menu);
				} else {
				%>
				<li><a href="login.jsp">Iniciar Sesion</a></li>
				<li><a href="register.jsp">Registrarse</a></li>
				<%
				}
				%>
			</ul>
		</aside>
	</nav>

	<section id="mision">
		<h2>mision</h2>
		<p>Ser la tienda de patines mas confiable y accesible del Ecuador, ofreciendo
            un servicio de calidad y productos de alta gama.</p>
	</section>

	<section id="vision">
		<h2>vision</h2>
		<p>Ser la tienda de patines mas confiable y accesible del Ecuador,
			ofreciendo un servicio de calidad y productos de alta gama.</p>
	</section>

	<section id="location">
		<h2>Ubicacion</h2>
		<iframe id="mapa"
			src="https://www.google.com/maps/d/embed?mid=1C050dfAawal2mlOydNunYhsAenyG_kc&ehbc=2E312F&noprof=1"></iframe>
	</section>

	<section id="contact">
		<h2>Contactanos</h2>
		<a href="https://www.instagram.com/joscar_tinicio"><i class="fi fi-brands-instagram"></i> joscar_tinicio</a><br>
		<a href="https://github.com/Joscart"><i class="fi fi-brands-github"></i> Joscart</a><br>
		<a href="#"><i class="fi fi-brands-whatsapp"></i> +593 98 795 5837</a>
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