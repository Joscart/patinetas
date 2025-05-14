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

	<section class="opcion">
		<h1>
			Cambio de clave (
			<%
		out.println(usuario);
		%>
			)
		</h1>
		<form action="validarCambioClave.jsp" method="post" class="card">
			<table border="0" cellpadding="5" cellspacing="5">
				<!-- organizacion columna fila -->
				<!-- input contraseña actual -->
				<tr>
					<td><label for="contrasena">Contraseña actual:</label></td>
					<td><input type="password" id="contrasena" name="contrasena"
						required></td>
				</tr>
				<!-- input nueva contraseña -->
				<tr>
					<td><label for="nueva_contrasena">Nueva Contraseña:</label></td>
					<td><input type="password" id="nueva_contrasena"
						name="nueva_contrasena" required></td>
				</tr>
				<!-- input confirmar contraseña -->
				<tr>
					<td><label for="confirmar_contrasena">Confirmar Nueva
							Contraseña:</label></td>
					<td><input type="password" id="confirmar_contrasena"
						name="confirmar_contrasena" required></td>
				</tr>

				<!-- label estado -->
				<tr>
					<td><label for="estado"> <%
                	String estado = (String) sesion.getAttribute("estado");
                		if (estado != null) {
                		out.println(estado);
                	}
                %>
					</label></td>
				</tr>

				<!-- Boton de registro -->
				<tr>
					<td><input type="reset" value="Cancelar"></td>
					<td><input type="submit" value="Cambio de Clave"></td>
				</tr>

			</table>
		</form>

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