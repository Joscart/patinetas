<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.productos.negocio.* , com.productos.seguridad.*"%>
<%
String usuario;
HttpSession sesion = request.getSession();
if (sesion.getAttribute("usuario") == null) {
%>
<jsp:forward page="login.jsp">
	<jsp:param name="error" value="Debe registrarse en el sistema." />
</jsp:forward>
<%
} else {
	String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
    String accion = request.getParameter("accion");
	usuario = (String) sesion.getAttribute("usuario");
	int perfil = (Integer) sesion.getAttribute("perfil");
	String idUsuario = request.getParameter("idUsuario");
    if (accion != null && idUsuario != null) {
        Usuario usuarioObj = new Usuario();
        boolean resultado = usuarioObj.bloqueoUsuario(Integer.parseInt(idUsuario));
        if (resultado) {
            request.setAttribute("mensaje", "Acción realizada con éxito.");
        } else {
            request.setAttribute("error", "Error al realizar la acción.");
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1" name="viewport" />
<title>Choro Patin - Usuarios</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&amp;family=Roboto:wght@400;700&amp;display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="style.css" />
<style>
body {
	font-family: 'Montserrat', 'Roboto', sans-serif;
}
</style>
</head>
<body class="bg-white text-gray-900">
	<header class="w-full shadow-md fixed top-0 left-0 bg-white z-50">
		<div
			class="max-w-7xl mx-auto flex items-center justify-between px-4 py-3 md:py-4">
			<a class="flex items-center space-x-2" href="#"> <img
				alt="Guayakill Roller Shop logo, stylized text with roller skate icon"
				class="w-12 h-12 object-contain" height="48"
				src="images/ChoroPatin-logo.svg" width="48" /> <span
				class="text-2xl font-bold text-indigo-700"> Choro Patin </span>
			</a>
			<nav>
				<ul class="hidden md:flex space-x-8 font-semibold text-gray-700">
					<li><a class="hover:text-indigo-700 transition"
						href="index.jsp"> <span>Inicio</span>
					</a></li>
					<li><a class="hover:text-indigo-700 transition"
						href="products.jsp"> <span>Productos</span>
					</a></li>
					<li><a class="hover:text-indigo-700 transition"
						href="categories.jsp"> <span>Categorias</span>
					</a></li>
					<%
					Pagina pag_nav = new Pagina();
					HttpSession ses = request.getSession();
					Object usr = ses.getAttribute("usuario");
					boolean isLoggedIn = (usr != null);
					int per = isLoggedIn ? (int) ses.getAttribute("perfil") : 0;
					out.print(pag_nav.mostrarMenu(per, isLoggedIn));
					%>
				</ul>
				<button aria-label="Toggle menu"
					class="md:hidden text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-700"
					id="mobile-menu-button">
					<i class="fas fa-bars fa-lg"> </i>
				</button>
			</nav>
		</div>
		<div class="hidden md:hidden bg-white shadow-md" id="mobile-menu">
			<ul
				class="flex flex-col space-y-2 px-4 py-3 font-semibold text-gray-700">
				<li><a class="hover:text-indigo-700 transition"
					href="index.jsp"> <span>Inicio</span>
				</a></li>
				<li><a class="hover:text-indigo-700 transition"
					href="products.jsp"> <span>Productos</span>
				</a></li>
				<li><a class="hover:text-indigo-700 transition"
					href="categories.jsp"> <span>Categorias</span>
				</a></li>
				<%
				Pagina pag_nav_m = new Pagina();
				HttpSession ses_m = request.getSession();
				Object usr_m = ses_m.getAttribute("usuario");
				boolean isLoggedIn_m = (usr_m != null);
				int per_m = isLoggedIn ? (int) ses_m.getAttribute("perfil") : 0;
				out.print(pag_nav_m.mostrarMenu(per, isLoggedIn_m));
				%>
			</ul>
		</div>
	</header>

	<main class="pt-24">
		<section class="opcion">
			<h1>Registro de usuarios (<%= usuario %>)</h1>
			<% if (mensaje != null) { %>
				<div class="alert alert-success"><%= mensaje %></div>
			<% } %>
			<% if (error != null) { %>
				<div class="alert alert-danger"><%= error %></div>
			<% } %>
			<form action="validarRegistro.jsp" method="post" class="card">
				<table border="5" cellpadding="5" cellspacing="5">
					<tr>
						<td><label for="nombre">Nombre:</label></td>
						<td><input type="text" id="nombre" name="nombre" required></td>
					</tr>
					<tr>
						<td><label for="cedula">Cédula:</label></td>
						<td><input type="text" id="cedula" name="cedula" required></td>
					</tr>
					<tr>
						<td><label for="perfil">Perfil:</label></td>
						<td>
							<select id="sperfil" name="sperfil">
								<%
								Perfil perf = new Perfil();
								out.print(perf.mostrarPerfil());
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td><label for="estado_civil">Estado Civil:</label></td>
						<td>
							<select id="estado_civil" name="estadoCivil">
								<%
								EstadoCivil estc = new EstadoCivil();
								out.print(estc.mostrarEstadoCivil());
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td><label for="correo">Correo:</label></td>
						<td><input type="email" id="correo" name="correo" required></td>
					</tr>
					<tr>
						<td><label for="contrasena">Contraseña:</label></td>
						<td><input type="password" id="contrasena" name="contrasena" required></td>
					</tr>
					<tr>
						<td><label for="repetirContrasena">Repetir Contraseña:</label></td>
						<td><input type="password" id="repetirContrasena" name="repetirContrasena" required></td>
					</tr>
					<tr>
						<td><input type="reset" value="Cancelar"></td>
						<td><input type="submit" value="Registrar"></td>
					</tr>
				</table>
			</form>
			<%
    Usuario usuarioObj = new Usuario();
    String tablaUsuarios = usuarioObj.mostrarTablaUsuarios();
    if (tablaUsuarios == null || tablaUsuarios.isEmpty()) {
        out.println("<p>No se pudo cargar la tabla de usuarios. Verifique el método mostrarTablaUsuarios.</p>");
    }
%>
<table border="1" cellpadding="5" cellspacing="5">
    <%= tablaUsuarios %>
</table>
		</section>
	</main>

	<footer class="bg-indigo-700 text-indigo-100 py-8 mt-16">
		<div
			class="max-w-7xl mx-auto px-6 md:px-12 flex flex-col md:flex-row justify-between items-center">
			<p class="text-sm">&copy; 2024 Choro Patin. Todos los derechos
				reservados.</p>
			<div class="flex space-x-6 mt-4 md:mt-0">
				<a aria-label="Facebook" class="hover:text-white transition"
					href="#" rel="noopener noreferrer" target="_blank"> <i
					class="fab fa-facebook-f fa-lg"> </i>
				</a> <a aria-label="Instagram" class="hover:text-white transition"
					href="#" rel="noopener noreferrer" target="_blank"> <i
					class="fab fa-instagram fa-lg"> </i>
				</a> <a aria-label="Github" class="hover:text-white transition" href="#"
					rel="noopener noreferrer" target="_blank"> <i
					class="fab fa-github fa-lg"> </i>
				</a>
			</div>
		</div>
	</footer>
	<script>
		const menuButton = document.getElementById('mobile-menu-button');
		const mobileMenu = document.getElementById('mobile-menu');
		menuButton.addEventListener('click', () => {
			mobileMenu.classList.toggle('hidden');
		});
	</script>
</body>
</html>
<%
}
%>