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
			// Obtener parámetros de acción y producto
			String idParam = request.getParameter("id");
			String accion = request.getParameter("accion");
			String confirm = request.getParameter("confirm");
			Producto prod = new Producto();
			if (idParam != null && accion != null) {
				int idProducto = Integer.parseInt(idParam);
				java.sql.ResultSet rs = prod.consultar(idProducto);
				if (rs != null && rs.next()) {
					String nombre = rs.getString("nombre_pr");
					int cantidad = rs.getInt("cantidad_pr");
					double precio = rs.getDouble("precio_pr");
					int idCat = rs.getInt("id_cat");
					int estado = rs.getInt("estado");
					double valor = rs.getDouble("valor");
					if ("eliminar".equals(accion)) {
				if ("2".equals(confirm)) {
					// Confirmación final para eliminar
					boolean eliminado = prod.eliminarProducto(idProducto);
					if (eliminado) {
						out.print(
								"<div class='max-w-xl mx-auto text-center text-green-600 font-bold text-xl mt-8'>Producto eliminado correctamente.</div>");
					} else {
						out.print(
								"<div class='max-w-xl mx-auto text-center text-red-600 font-bold text-xl mt-8'>Error al eliminar el producto.</div>");
					}
				} else if ("1".equals(confirm)) {
					// Primera confirmación
					out.print(
							"<div class='max-w-xl mx-auto text-center text-yellow-600 font-bold text-xl mt-8'>¿Está seguro que desea eliminar el producto <b>"
									+ nombre + "</b>? Esta acción no se puede deshacer.<br><br>");
					out.print("<a href='modProducto.jsp?id=" + idProducto
							+ "&accion=eliminar&confirm=2' class='bg-red-600 hover:bg-red-700 text-white font-bold px-6 py-2 rounded mx-2'>Sí, eliminar</a>");
					out.print(
							"<a href='productos.jsp' class='bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold px-6 py-2 rounded mx-2'>Cancelar</a></div>");
				} else {
					// Mostrar botón para confirmar
					out.print(
							"<div class='max-w-xl mx-auto text-center text-yellow-600 font-bold text-xl mt-8'>¿Desea eliminar el producto <b>"
									+ nombre + "</b>?<br><br>");
					out.print("<a href='modProducto.jsp?id=" + idProducto
							+ "&accion=eliminar&confirm=1' class='bg-red-600 hover:bg-red-700 text-white font-bold px-6 py-2 rounded mx-2'>Eliminar</a>");
					out.print(
							"<a href='productos.jsp' class='bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold px-6 py-2 rounded mx-2'>Cancelar</a></div>");
				}
					} else if ("modificar".equals(accion)) {
				if ("1".equals(confirm)) {
					// Procesar actualización
					String nuevoNombre = request.getParameter("nombre");
					int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
					double nuevoPrecio = Double.parseDouble(request.getParameter("precio"));
					int nuevoCat = Integer.parseInt(request.getParameter("categoria"));
					int nuevoEstado = Integer.parseInt(request.getParameter("estado"));
					double nuevoValor = Double.parseDouble(request.getParameter("valor"));
					boolean actualizado = prod.actualizarDatos(idProducto, nuevoCat, nuevoNombre, nuevaCantidad,
							nuevoPrecio, nuevoEstado, nuevoValor);
					if (actualizado) {
						out.print(
								"<div class='max-w-xl mx-auto text-center text-green-600 font-bold text-xl mt-8'>Producto actualizado correctamente.</div>");
					} else {
						out.print(
								"<div class='max-w-xl mx-auto text-center text-red-600 font-bold text-xl mt-8'>Error al actualizar el producto.</div>");
					}
				} else {
					// Mostrar formulario de edición
			%>
			<form action="modProducto.jsp" method="post"
				class="max-w-xl mx-auto bg-white rounded-lg shadow-lg p-8 mt-8">
				<input type="hidden" name="id" value="<%=idProducto%>" /> <input
					type="hidden" name="accion" value="modificar" /> <input
					type="hidden" name="confirm" value="1" />
				<div class="mb-4">
					<label class="block font-bold mb-2">Nombre:</label> <input
						type="text" name="nombre" value="<%=nombre%>"
						class="border border-indigo-200 rounded px-3 py-2 w-full" required />
				</div>
				<div class="mb-4">
					<label class="block font-bold mb-2">Cantidad:</label> <input
						type="number" name="cantidad" value="<%=cantidad%>" min="0"
						class="border border-indigo-200 rounded px-3 py-2 w-full" required />
				</div>
				<div class="mb-4">
					<label class="block font-bold mb-2">Precio:</label> <input
						type="number" name="precio" value="<%=precio%>" step="0.01"
						min="0" class="border border-indigo-200 rounded px-3 py-2 w-full"
						required />
				</div>
				<div class="mb-4">
					<label class="block font-bold mb-2">Categoría:</label> <select
						name="categoria"
						class="border border-indigo-200 rounded px-3 py-2 w-full" required>
						<%
						Categoria cat = new Categoria();
						out.print(cat.mostrarCategoria(idCat));
						%>
					</select>
				</div>
				<div class="mb-4">
					<label class="block font-bold mb-2">Estado:</label> <select
						name="estado"
						class="border border-indigo-200 rounded px-3 py-2 w-full" required>
						<option value="0" <%=estado == 0 ? "selected" : ""%>>Sin
							oferta</option>
						<option value="1" <%=estado == 1 ? "selected" : ""%>>Con
							oferta</option>
					</select>
				</div>
				<div class="mb-4">
					<label class="block font-bold mb-2">Valor oferta:</label> <input
						type="number" name="valor" value="<%=valor%>" step="0.01" min="0"
						class="border border-indigo-200 rounded px-3 py-2 w-full" />
				</div>
				<div class="flex justify-center gap-4">
					<button type="submit"
						class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold px-6 py-2 rounded">Confirmar
						cambios</button>
					<a href="productos.jsp"
						class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold px-6 py-2 rounded">Cancelar</a>
				</div>
			</form>
			<%
			if ("eliminar".equals(accion)) {
				if ("2".equals(confirm)) {
					// Procesar eliminación
					boolean eliminado = prod.eliminarProducto(idProducto);
					if (eliminado) {
				out.print(
						"<div class='max-w-xl mx-auto text-center text-green-600 font-bold text-xl mt-8'>Producto eliminado correctamente.</div>");
					} else {
				out.print(
						"<div class='max-w-xl mx-auto text-center text-red-600 font-bold text-xl mt-8'>Error al eliminar el producto.</div>");
					}
				} else {
					// Mostrar botón para confirmar
					out.print(
					"<div class='max-w-xl mx-auto text-center text-yellow-600 font-bold text-xl mt-8'>¿Desea eliminar el producto <b>"
							+ nombre + "</b>?<br><br>");
					out.print("<a href='modProducto.jsp?id=" + idProducto
					+ "&accion=eliminar&confirm=1' class='bg-red-600 hover:bg-red-700 text-white font-bold px-6 py-2 rounded mx-2'>Eliminar</a>");
					out.print(
					"<a href='productos.jsp' class='bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold px-6 py-2 rounded mx-2'>Cancelar</a></div>");
				}
			} else if ("modificar".equals(accion)) {
				if ("1".equals(confirm)) {
					// Procesar actualización
					String nuevoNombre = request.getParameter("nombre");
					int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
					double nuevoPrecio = Double.parseDouble(request.getParameter("precio"));
					int nuevoCat = Integer.parseInt(request.getParameter("categoria"));
					int nuevoEstado = Integer.parseInt(request.getParameter("estado"));
					double nuevoValor = Double.parseDouble(request.getParameter("valor"));
					boolean actualizado = prod.actualizarDatos(idProducto, nuevoCat, nuevoNombre, nuevaCantidad, nuevoPrecio,
					nuevoEstado, nuevoValor);
					if (actualizado) {
				out.print(
						"<div class='max-w-xl mx-auto text-center text-green-600 font-bold text-xl mt-8'>Producto actualizado correctamente.</div>");
					} else {
				out.print(
						"<div class='max-w-xl mx-auto text-center text-red-600 font-bold text-xl mt-8'>Error al actualizar el producto.</div>");
					}
				} else {
					// Mostrar formulario de edición
				}
			}
			}
			} // Cierre del else de modificar
			} // Cierre del if de accion
			} // Cierre del if de idParam y accion
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