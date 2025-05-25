<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.productos.negocio.* , com.productos.seguridad.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1" name="viewport" />
<title>Choro Patin - Registro</title>
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
		<h3 class="text-center text-3xl font-bold text-indigo-700">Registro nuevo cliente</h3>
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
						accept=".pdf" ></td>
				</tr>
				<!-- input foto -->
				<tr>
					<td><label for="foto">Foto:</label></td>
					<td><input type="file" id="foto" name="foto" accept="image/*"
						></td>
				</tr>
				<!-- input fecha de nacimiento -->
				<tr>
					<td><label for="fecha_nacimiento">Fecha de Nacimiento:</label></td>
					<td><input type="date" id="fecha_nacimiento"
						name="fecha_nacimiento"></td>
				</tr>
				<!-- input color favorito -->
				<tr>
					<td><label for="color_favorito">Color Favorito:</label></td>
					<td><input type="text" id="color_favorito"
						name="color_favorito"></td>
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
	                	String estado = (String) request.getAttribute("estado");
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