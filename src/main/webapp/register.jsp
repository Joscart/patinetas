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

	<h3>Registro nuevo cliente</h3>
	<form>
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
			<!-- input estado civil -->
			<tr>
				<td><label for="estado_civil">Estado Civil:</label></td>
				<td><select id="estado_civil" name="estado_civil">
						<option value="soltero">Soltero</option>
						<option value="casado">Casado</option>
						<option value="divorciado">Divorciado</option>
						<option value="viudo">Viudo</option>
				</select></td>
			</tr>
			<!-- input lugar residencia -->
			<tr>
				<td><label for="lugar_residencia">Lugar de Residencia:</label></td>
				<td><input type="radio" id="lugar_residencia"
					name="lugar_residencia" value="Quito"> Norte <input
					type="radio" id="lugar_residencia" name="lugar_residencia"
					value="Guayaquil"> Centro <input type="radio"
					id="lugar_residencia" name="lugar_residencia" value="Cuenca">
					Sur</td>
			</tr>
			<!-- input hoja de vida -->
			<tr>
				<td><label for="hoja_vida">Hoja de Vida:</label></td>
				<td><input type="file" id="hoja_vida" name="hoja_vida"
					accept=".pdf" required></td>
			</tr>
			<!-- input foto -->
			<tr>
				<td><label for="foto">Foto:</label></td>
				<td><input type="file" id="foto" name="foto" accept="image/*"
					required></td>
			</tr>
			<!-- input fecha de nacimiento -->
			<tr>
				<td><label for="fecha_nacimiento">Fecha de Nacimiento:</label></td>
				<td><input type="date" id="fecha_nacimiento"
					name="fecha_nacimiento" required></td>
			</tr>
			<!-- input color favorito -->
			<tr>
				<td><label for="color_favorito">Color Favorito:</label></td>
				<td><input type="text" id="color_favorito"
					name="color_favorito" required></td>
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
				<td><input type="password" id="contrasena" name="contrasena"
					required></td>
			</tr>
			<!-- input confirmar contrasena -->
			<tr>
				<td><label for="confirmar_contrasena">Confirmar
						Contraseña:</label></td>
				<td><input type="password" id="confirmar_contrasena"
					name="confirmar_contrasena" required></td>
			</tr>
			<!-- label estado -->
			<tr>
                <td><label for="estado">
                <%
                
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

	<footer>
		<p>
			Uicons by <a href="https://www.flaticon.com/uicons">Flaticon</a>
		</p>
		<p>&copy; 2025 ChoroPatin. Todos los derechos reservados.</p>
	</footer>
	<script src="main.js"></script>
</body>
</html>