<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" session="true" import="com.productos.seguridad.Usuario" %>
 
<%
Usuario usuario = new Usuario();
String nlogin = request.getParameter("correo");
String nclave = request.getParameter("contrasena");
HttpSession sesion = request.getSession(); // Se crea la variable de sesión

// Verificar credenciales del usuario
boolean respuesta = usuario.verificarUsuario(nlogin, nclave);
if (respuesta) {
    // Establecer atributos de sesión
    sesion.setAttribute("usuario", usuario.getNombre());
    sesion.setAttribute("perfil", usuario.getPerfil());
    sesion.setAttribute("correo", nlogin);
    response.sendRedirect("menu.jsp"); // Redirigir al menú principal
} else {
%>
<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Datos incorrectos. Vuelva a intentarlo." />
</jsp:forward>
<%
}
%>