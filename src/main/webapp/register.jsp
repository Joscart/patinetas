<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Choro Patin</title>

<!-- Custom Styles -->
<link rel="stylesheet" href="style.css">
</head>

<body>
	<header>
		<a href="index.jsp"> <img id="logo" src="images/choropatin-logo.jpg"
			alt="Logo de Choro Patin" class="logo">
		</a>
		<h1>Choro Patin</h1>
		<p>Tu pati-tienda de confianza</p>
	</header>

	<nav>
		<ul>
			<li><a href="underconstruction.jsp">Productos</a></li>
			<li><a href="underconstruction.jsp">Como llegar</a></li>
			<li><a href="underconstruction.jsp">Contacto</a></li>
		</ul>
		<aside>
			<ul>
				<li><a href="login.jsp">Iniciar Sesion</a></li>
				<li><a href="register.jsp">Registrarse</a></li>
			</ul>
		</aside>
	</nav>

	<h3>Registro nuevo cliente</h3>
	<form>
		<table border="0" cellpadding="5" cellspacing="5">
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
			<!-- input correo -->
			<tr>
				<td><label for="correo">Correo:</label></td>
				<td><input type="email" id="correo" name="correo" required>
				</td>
			</tr>
			<!-- input contrasena -->
			<tr>
				<td><label for="contrasena">Contraseña:</label></td>
				<td><input type="password" id="contrasena" name="contrasena" required></td>
			</tr>
			<!-- input confirmar contrasena -->
			<tr>
				<td><label for="confirmar_contrasena">Confirmar Contraseña:</label></td>
				<td><input type="password" id="confirmar_contrasena" name="confirmar_contrasena" required></td>
			</tr>

			<!-- Boton de registro -->
			<tr>
				<td colspan="2"><input type="submit" value="Registrar"></td>
			</tr>
			<!-- Boton de cancelar -->
			<tr>
				<td colspan="2"><input type="reset" value="Cancelar"></td>
			</tr>


		</table>
	</form>

	<footer>
		<p>&copy; 2025 ChoroPatin. Todos los derechos reservados.</p>
	</footer>
	<script src="main.js"></script>
</body>
</html>