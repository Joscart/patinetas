<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1" session="true" import="com.productos.seguridad.*" %>
 
<%
Usuario usuario= new Usuario();
String nlogin=request.getParameter("correo");
String nclave=request.getParameter("contrasena");
HttpSession sesion=request.getSession(); //Se crea la variable de sesión
boolean respuesta=usuario.verificarUsuario(nlogin,nclave);
if (respuesta)
{
sesion.setAttribute("usuario", usuario.getNombre()); //Se añade atributo usuario
sesion.setAttribute("perfil", usuario.getPerfil()); //Se añade atributo perfil
response.sendRedirect("menu.jsp"); //Se redirecciona a una página específica
}
else
{
	
%>
<jsp:forward page="login.jsp">
<jsp:param name="error" value="Datos incorrectos.<br/>Vuelva a intentarlo."/>
</jsp:forward>
<%
}
%>