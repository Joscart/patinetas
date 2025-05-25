<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.productos.negocio.* , com.productos.seguridad.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1" name="viewport" />
<title>Choro Patin</title>
<script src="https://cdn.tailwindcss.com">
  </script>
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
	<!-- Header / Navbar -->
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
	<main>
		<!-- Hero Section -->
		<section
			aria-label="Hero section with roller skate image and shop introduction"
			class="pt-24 bg-gradient-to-r from-indigo-600 to-indigo-400 text-white">
			<div
				class="max-w-7xl mx-auto px-6 md:px-12 flex flex-col-reverse md:flex-row items-center md:space-x-12 py-16">
				<div class="md:w-1/2 text-center md:text-left">
					<h1 class="text-4xl md:text-5xl font-extrabold leading-tight mb-4">
						Bienvenido a Choro Patin</h1>
					<p class="text-lg md:text-xl mb-6">Descubre la calidad
						inigualable y la libertad de elegir entre nuestras patinetas
						premium. Pasea con confianza y expresa tu estilo único.</p>
					<a
						class="inline-block bg-white text-indigo-700 font-bold px-6 py-3 rounded-md shadow-md hover:bg-indigo-100 transition"
						href="products.jsp"> Comprar Ahora </a>
				</div>
				<div class="md:w-1/2 mb-10 md:mb-0">
					<img alt="" class="w-full rounded-lg shadow-lg object-cover"
						height="400" loading="lazy"
						src="https://storage.googleapis.com/a1aa/image/5252e38a-0d56-4f6d-c3e3-f23ea2a51b33.jpg"
						width="600" />
				</div>
			</div>
		</section>

		<!-- About Us Section -->
		<section aria-label="About Guayakill Roller Shop"
			class="bg-indigo-50 py-16 px-6 md:px-12" id="about">
			<div class="max-w-5xl mx-auto text-center">
				<h2 class="text-3xl font-extrabold text-indigo-700 mb-6">Sobre
					Nosotros</h2>
				<p class="text-gray-700 max-w-3xl mx-auto text-lg leading-relaxed">
					Choro Patin es tu destino para todo lo relacionado con el patinaje.
					Ofrecemos una amplia gama de patines, accesorios y equipo de
					protección para todos los niveles. Desde principiantes hasta
					profesionales, tenemos lo que necesitas para disfrutar del patinaje
					con seguridad y estilo.</p>
				<img
					alt="Happy customers skating in a sunny park wearing Guayakill roller skates and protective gear"
					class="mt-10 rounded-lg shadow-lg mx-auto max-w-full object-cover"
					height="400" loading="lazy"
					src="https://storage.googleapis.com/a1aa/image/ee84c35b-8398-4039-bad6-d36ae92991b0.jpg"
					width="800" />
				<h2 class="text-2xl font-bold text-indigo-700 mt-8">Nuestra
					Misión</h2>
				<p
					class="text-gray-700 max-w-2xl mx-auto text-lg leading-relaxed mt-4">
					Proporcionar productos de alta calidad y un servicio excepcional
					para que cada cliente disfrute de una experiencia de patinaje única
					y segura.</p>
				<h2 class="text-2xl font-bold text-indigo-700 mt-8">Nuestra
					Visión</h2>
				<p
					class="text-gray-700 max-w-2xl mx-auto text-lg leading-relaxed mt-4">
					Ser la tienda de patines más confiable y accesible del Ecuador,
					ofreciendo un servicio de calidad y productos de alta gama.</p>
				<h2 class="text-2xl font-bold text-indigo-700 mt-8">Nuestra
					Ubicación</h2>
				<iframe class="w-full h-64 rounded-lg border border-gray-300 mt-4"
					loading="lazy"
					src="https://www.google.com/maps/d/embed?mid=1C050dfAawal2mlOydNunYhsAenyG_kc&ehbc=2E312F&noprof=1"></iframe>
			</div>
		</section>
		<!-- Contact Section -->
		<section aria-label="Contact Guayakill Roller Shop"
			class="bg-indigo-50 py-16 px-6 md:px-12" id="contact">
			<div class="max-w-4xl mx-auto text-center">
				<h2 class="text-3xl font-extrabold text-indigo-700 mb-6">
					Contáctanos</h2>
				<p class="text-gray-700 mb-10 max-w-2xl mx-auto text-lg">Si
					tienes preguntas, comentarios o necesitas ayuda con tu pedido, no
					dudes en contactarnos. Estamos aquí para ayudarte a disfrutar al
					máximo de tu experiencia de patinaje.</p>
				<div
					class="mt-12 flex flex-col md:flex-row justify-center space-y-6 md:space-y-0 md:space-x-12 text-gray-700">
					<div class="flex items-center space-x-3">
						<i class="fas fa-phone-alt text-indigo-700 text-xl"> </i> <span>
							+593 98 795 5837 </span>
					</div>
					<div class="flex items-center space-x-3">
						<i class="fas fa-envelope text-indigo-700 text-xl"> </i> <span>
							jguallasaminc@est.ups.edu.ec </span>
					</div>
					<div class="flex items-center space-x-3">
						<i class="fab fa-linkedin text-indigo-700 text-xl"> </i> <span>
							<a href="https://www.linkedin.com/in/joscar-tinicio-123456789/"
							target="_blank" rel="noopener noreferrer">Joscar Tinicio</a>
						</span>
					</div>
				</div>
		</section>
	</main>
	<!-- Footer -->
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
