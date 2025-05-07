<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.productos.seguridad.*"%>

<%
String usuario;
HttpSession sesion = request.getSession();
if (sesion.getAttribute("usuario") == null) //Se verifica si existe la variable
{
%>
<jsp:forward page="login.jsp">
	<jsp:param name="error" value="Debe registrarse en el sistema." />
</jsp:forward>
<%
} else {
%>

<%
usuario = (String) sesion.getAttribute("usuario"); //Se devuelve los valores de atributos
int perfil = (Integer) sesion.getAttribute("perfil");
%>

<%
Usuario usr= new Usuario();

if(usr.verificarClave(sesion.getAttribute("contrasena"))){
if(usr.coincidirClaves(sesion.getAttribute("nueva_contrasena"),sesion.getAttribute("confirmar_contrasena"))){
    usr.cambiarClave(sesion.getAttribute("nueva_contrasena"));
    sesion.setAttribute("contrasena", sesion.getAttribute("nueva_contrasena"));
    response.sendRedirect("cerrarsesion.jsp");
}
%>

<%
}
%>