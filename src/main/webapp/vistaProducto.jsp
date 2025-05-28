<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.productos.negocio.* , com.productos.seguridad.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1" name="viewport" />
<title>Choro Patin - Productos</title>
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
		<section id="producto">
			<%
			// Mostrar mensaje de error si existe
			String errorMsg = request.getParameter("error");
			if (errorMsg != null && !errorMsg.isEmpty()) {
			%>
				<div class="max-w-2xl mx-auto text-center text-red-600 font-bold text-xl mt-4 mb-4"><%=errorMsg%></div>
			<%
			}
			// Obtener el id del producto desde el parámetro de la URL
			String idParam = request.getParameter("id");
			if (idParam != null) {
				try {
					int idProducto = Integer.parseInt(idParam);
					Producto prod = new Producto();
					java.sql.ResultSet rs = prod.consultar(idProducto);
					if (rs != null && rs.next()) {
						String nombre = rs.getString("nombre_pr");
						int cantidad = rs.getInt("cantidad_pr");
						double precio = rs.getDouble("precio_pr");
						int estado = rs.getInt("estado");
						double valorOferta = rs.getDouble("valor");
						String imgBase64 = prod.obtenerImagenProducto(idProducto);
						if (imgBase64 == null || imgBase64.isEmpty()) {
							imgBase64 = "images/choropatin-logo.jpg";
						}
			%>
			<div class="max-w-3xl mx-auto bg-white rounded-lg shadow-lg p-8 flex flex-col md:flex-row gap-8 items-center">
				<img src="<%=imgBase64%>" alt="<%=nombre%>" class="w-64 h-64 object-cover rounded-lg border border-indigo-200" />
				<div class="flex-1">
					<h1 class="text-3xl font-bold text-indigo-700 mb-2"><%=nombre%></h1>
					<p class="text-lg text-gray-700 mb-2">Cantidad disponible: <span class="font-semibold"><%=cantidad%></span></p>
					<% if (estado == 1) { %>
						<span class="inline-block bg-indigo-600 text-white px-3 py-1 rounded mb-2">Oferta</span><br>
						<span class="text-gray-500 line-through text-lg">$<%=precio%></span>
						<span class="text-2xl text-pink-600 font-bold ml-2">$<%=valorOferta%></span>
					<% } else { %>
						<span class="text-2xl text-indigo-700 font-bold">$<%=precio%></span>
					<% } %>
					<form action="carrito.jsp" method="post" class="mt-6 flex gap-4 items-center">
						<input type="hidden" name="id" value="<%=idProducto%>" />
						<input type="number" name="cantidad" value="1" min="1" max="<%=cantidad%>" class="border border-indigo-200 rounded px-3 py-2 w-20" />
						<button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold px-6 py-2 rounded transition">Agregar al carrito</button>
					</form>
				</div>
			</div>
			<%
					} else {
			%>
				<div class="max-w-2xl mx-auto text-center text-red-600 font-bold text-xl mt-12">Producto no encontrado.</div>
			<%
					}
				} catch (Exception ex) {
			%>
				<div class="max-w-2xl mx-auto text-center text-red-600 font-bold text-xl mt-12">ID de producto inválido.</div>
			<%
				}
			} else {
			%>
				<div class="max-w-2xl mx-auto text-center text-red-600 font-bold text-xl mt-12">No se especificó producto.</div>
			<%
			}
			%>
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