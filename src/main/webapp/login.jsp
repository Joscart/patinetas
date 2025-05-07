<!DOCTYPE html>
<html lang="en">
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

	<!-- login de cliente correo y contraseña -->

	<h3>Iniciar Sesion</h3>
	<form action="validarLogin.jsp" method="post" class="card">
		<table border="0" cellpadding="5" cellspacing="5">
			<!-- input correo -->
			<tr>
				<td><label for="correo">Correo:</label></td>
				<td><input type="email" id="correo" name="correo" required></td>
			</tr>
			<!-- input contraseña -->
			<tr>
				<td><label for="contraseña">Contraseña:</label></td>
				<td><input type="password" id="contrasena" name="contrasena"
					required></td>
			</tr>
			<!-- input submit -->
			<tr>
				<td><label for="error"></label></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Iniciar Sesion"></td>
			</tr>
		</table>
	</form>

	<footer>
		<p>
			Uicons by <a href="https://www.flaticon.com/uicons">Flaticon</a>
		</p>
		<p>&copy; 2025 ChoroPatin. Todos los derechos reservados.</p>
	</footer>
	<script src="main.js"></script>
</body>
</html>