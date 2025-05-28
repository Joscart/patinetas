<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.productos.negocio.* , com.productos.seguridad.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1" name="viewport" />
<title>Choro Patin - Carrito</title>
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
<%
// Obtener o crear el carrito en sesión
HttpSession sesion = request.getSession();
Carrito carrito = (Carrito) sesion.getAttribute("carrito");
if (carrito == null) {
    carrito = new Carrito();
    sesion.setAttribute("carrito", carrito);
}
// Si se envió un producto por POST, agregarlo al carrito
String idParam = request.getParameter("id");
String cantidadParam = request.getParameter("cantidad");
if (idParam != null && cantidadParam != null) {
    try {
        int idProducto = Integer.parseInt(idParam);
        int cantidad = Integer.parseInt(cantidadParam);
        Producto prod = new Producto();
        java.sql.ResultSet rs = prod.consultar(idProducto);
        if (rs != null && rs.next()) {
            int stock = rs.getInt("cantidad_pr");
            // Buscar si ya está en el carrito y sumar la cantidad
            int cantidadEnCarrito = 0;
            for (Carrito.Item item : carrito.getItems()) {
                if (item.getIdProducto() == idProducto) {
                    cantidadEnCarrito = item.getCantidad();
                    break;
                }
            }
            if (cantidad + cantidadEnCarrito > stock) {
                // Redireccionar a vistaProducto.jsp con mensaje de error
                response.sendRedirect("vistaProducto.jsp?id=" + idProducto + "&error=La cantidad solicitada supera el stock disponible");
                return;
            }
            String nombre = rs.getString("nombre_pr");
            double precio = rs.getDouble("precio_pr");
            int estado = rs.getInt("estado");
            double valorOferta = rs.getDouble("valor");
            boolean enOferta = (estado == 1);
            carrito.agregarProducto(idProducto, nombre, cantidad, precio, valorOferta, enOferta);
        }
    } catch (Exception ex) {
        // Manejo de error simple
    }
}
%>
<h1 class="text-center text-3xl font-bold text-indigo-700">Carrito</h1>
<%
if (carrito.getItems().isEmpty()) {
%>
    <p class="text-center text-gray-700 mt-4">Tu carrito está vacío.</p>
<%
} else {
%>
    <div class="max-w-4xl mx-auto mt-8">
        <table class="tabla">
            <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Subtotal</th>
                <th>Acción</th>
            </tr>
            <% for (Carrito.Item item : carrito.getItems()) { %>
            <tr>
                <td><%=item.getNombre()%></td>
                <td><%=item.getCantidad()%></td>
                <td>
                    <% if (item.isEnOferta()) { %>
                        <span class="text-pink-600 font-bold">$<%=item.getValorOferta()%></span>
                    <% } else { %>
                        <span>$<%=item.getPrecio()%></span>
                    <% } %>
                </td>
                <td>
                    <% if (item.isEnOferta()) { %>
                        $<%=item.getValorOferta() * item.getCantidad()%>
                    <% } else { %>
                        $<%=item.getPrecio() * item.getCantidad()%>
                    <% } %>
                </td>
                <td>
                    <form action="carrito.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="eliminar" value="<%=item.getIdProducto()%>" />
                        <button type="submit" class="bg-pink-600 hover:bg-pink-700 text-white font-bold px-3 py-1 rounded">Eliminar</button>
                    </form>
                </td>
            </tr>
            <% } %>
            <tr>
                <td colspan="3" class="text-right font-bold">Total:</td>
                <td colspan="2" class="font-bold text-indigo-700">$<%=carrito.getTotal()%></td>
            </tr>
        </table>
        <form action="carrito.jsp" method="post" class="mt-4 text-right">
            <input type="hidden" name="limpiar" value="1" />
            <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold px-6 py-2 rounded">Vaciar carrito</button>
        </form>
    </div>
<%
}
// Eliminar producto
String eliminar = request.getParameter("eliminar");
if (eliminar != null) {
    try {
        int idEliminar = Integer.parseInt(eliminar);
        carrito.eliminarProducto(idEliminar);
        response.sendRedirect("carrito.jsp");
        return;
    } catch (Exception ex) {}
}
// Limpiar carrito
if (request.getParameter("limpiar") != null) {
    carrito.limpiar();
    response.sendRedirect("carrito.jsp");
    return;
}
%>
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