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
			Registro de usuarios (
			<%
		out.println(usuario);
		%>
			)
		</h1>
		<form action="validarRegistro.jsp" method="post" class="card">
			<table border="0" cellpadding="5" cellspacing="5">
				<!-- organizacion columna fila -->
				<!-- input nombre -->
				<tr>
					<td><label for="nombre">Nombre:</label></td>
					<td><input type="text" id="nombre" name="nombre" required>
					</td>
				</tr>
				<!-- input cedula -->
				<tr>
					<td><label for="cedula">Cedula:</label></td>
					<td><input type="text" id="cedula" name="cedula" required>
					</td>
				</tr>
				<!-- input perfil -->
				<tr>
					<td><label for="perfil">Perfil:</label></td>
					<td><select id="perfil" name="perfil">
							<%
						Perfil per = new Perfil();
						out.print(per.mostrarPerfil());
						%>
					</select></td>
				</tr>
				<!-- input estado civil -->
				<tr>
					<td><label for="estado_civil">Estado Civil:</label></td>
					<td><select id="estado_civil" name="estado_civil">
							<%
						EstadoCivil estc = new EstadoCivil();
						out.print(estc.mostrarEstadoCivil());
						%>
					</select></td>
				</tr>
				<!-- input correo -->
				<tr>
					<td><label for="correo">Correo:</label></td>
					<td><input type="email" id="correo" name="correo" required>
					</td>
				</tr>
				<!-- input contraseña -->
				<tr>
					<td><label for="contrasena">Contraseña:</label></td>
					<td><label for="contrasena-default">654321</label></td>
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
					<td><input type="submit" value="Registrar"></td>
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