<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"
	import="com.productos.seguridad.Usuario"%>

<%
Usuario usuario = new Usuario();
HttpSession ses = request.getSession();
String correo = (String) ses.getAttribute("correo");
String claveActual = request.getParameter("claveActual");
String nuevaClave = request.getParameter("nuevaClave");
String repetirClave = request.getParameter("repetirClave");

usuario.setCorreo(correo);
if (!usuario.cambiarClave(claveActual, nuevaClave, repetirClave)) {
	request.setAttribute("error", "No se pudo cambiar la contraseña. Verifique los datos ingresados.");
	request.getRequestDispatcher("cambioClave.jsp").forward(request, response);
} else {
	request.setAttribute("mensaje", "Contraseña actualizada correctamente.");
	request.getRequestDispatcher("menu.jsp").forward(request, response);
}
%>
