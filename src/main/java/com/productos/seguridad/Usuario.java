package com.productos.seguridad;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.productos.datos.Conexion;

public class Usuario {

	private int id;
	private int perfil;
	private int estadoCivil;
	private String cedula;
	private String Nombre;
	private String Correo;
	private String clave;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPerfil() {
		return perfil;
	}

	public void setPerfil(int perfil) {
		this.perfil = perfil;
	}

	public int getEstadoCivil() {
		return estadoCivil;
	}

	public void setEstadoCivil(int estadoCivil) {
		this.estadoCivil = estadoCivil;
	}

	public String getCedula() {
		return cedula;
	}

	public void setCedula(String cedula) {
		this.cedula = cedula;
	}

	public String getNombre() {
		return Nombre;
	}

	public void setNombre(String nombre) {
		Nombre = nombre;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public String getCorreo() {
		return Correo;
	}


	public void setCorreo(String correo) {
		Correo = correo;
	}

	public boolean verificarUsuario(String ncorreo, String nclave)
	{
		boolean respuesta=false;
		String sentencia= "Select * from tb_usuario where correo_us='"+ncorreo+
				"' and clave_us='"+nclave+"';";
		//System.out.print(sentencia);
		try
		{
			ResultSet rs;
			Conexion clsCon=new Conexion();
			rs=clsCon.Consulta(sentencia);
			if(rs.next())
			{
				respuesta=true;
				this.setCorreo(ncorreo);
				this.setClave(nclave);
				this.setPerfil(rs.getInt(2));
				this.setNombre(rs.getString(4));
			}
			else
			{
				respuesta=false;
				rs.close();
			}
		}
		catch(Exception ex)
		{
			System.out.println( ex.getMessage());
		}
		return respuesta;
	}

	public String ingresarCliente()
	{
		String result="";
		Conexion con=new Conexion();
		PreparedStatement pr=null;
		String sql="INSERT INTO tb_usuario (id_per, id_est, nombre_us,"
				+ "cedula_us,correo_us,clave_us) "
				+ "VALUES(?,?,?,?,?,?)";
		try{
			pr=con.getConexion().prepareStatement(sql);
			pr.setInt(1,2);
			pr.setInt(2, this.getEstadoCivil());
			pr.setString(3, this.getNombre());
			pr.setString(4, this.getCedula());
			pr.setString(5, this.getCorreo());
			pr.setString(6, this.getClave());
			if(pr.executeUpdate()==1)
			{
				result="Insercion correcta";
			}
			else
			{
				result="Error en insercion";
			}
		}
		catch(Exception ex)
		{
			result=ex.getMessage();
			System.out.print(result);
		}
		finally
		{
			try
			{
				pr.close();
				con.getConexion().close();
			}
			catch(Exception ex)
			{
				System.out.print(ex.getMessage());
			}
		}
		return result;
	}
	
	public Boolean ingresarUsuario()
	{
		String result="";
		Boolean respuesta=false;
		Conexion con=new Conexion();
		PreparedStatement pr=null;
		String sql="INSERT INTO tb_usuario (id_per, id_est, nombre_us,"
				+ "cedula_us,correo_us,clave_us) "
				+ "VALUES(?,?,?,?,?,?)";
		try{
			pr=con.getConexion().prepareStatement(sql);
			pr.setInt(1,this.getPerfil());
			pr.setInt(2, this.getEstadoCivil());
			pr.setString(3, this.getNombre());
			pr.setString(4, this.getCedula());
			pr.setString(5, this.getCorreo());
			pr.setString(6, this.getClave());
			if(pr.executeUpdate()==1)
			{
				result="Insercion correcta";
				respuesta=true;
			}
			else
			{
				result="Error en insercion";
			}
		}
		catch(Exception ex)
		{
			result=ex.getMessage();
			System.out.print(result);
		}
		finally
		{
			try
			{
				pr.close();
				con.getConexion().close();
			}
			catch(Exception ex)
			{
				System.out.print(ex.getMessage());
			}
		}
		return respuesta;
	}
	
	public Boolean ingresarEmpleado(Integer nperfil, int nestado, String ncedula, String nnombre, String ncorreo) {
		String result="";
		Boolean respuesta=false;
		Conexion con=new Conexion();
		PreparedStatement pr=null;
		String sql="INSERT INTO tb_usuario (id_per, id_est, nombre_us,"
				+ "cedula_us,correo_us,clave_us) "
				+ "VALUES(?,?,?,?,?,?)";
		try{
			pr=con.getConexion().prepareStatement(sql);
			pr.setInt(1,nperfil);
			pr.setInt(2, nestado);
			pr.setString(3, nnombre);
			pr.setString(4, ncedula);
			pr.setString(5, ncorreo);
			pr.setString(6, "654321");
			if(pr.executeUpdate()==1)
			{
				result="Insercion correcta";
				respuesta=true;
			}
			else
			{
				result="Error en insercion";
			}
		}
		catch(Exception ex)
		{
			result=ex.getMessage();
			System.out.print(result);
		}
		finally
		{
			try
			{
				pr.close();
				con.getConexion().close();
			}
			catch(Exception ex)
			{
				System.out.print(ex.getMessage());
			}
		}
		return respuesta;
	}
	
	public Boolean verificarClave(String aclave) {
		boolean respuesta=false;
		String sentencia= "Select * from tb_usuario where clave_us='"+aclave+
				"' and correo_us='"+this.getCorreo()+"';";
		//System.out.print(sentencia);
		try
		{
			ResultSet rs;
			Conexion clsCon=new Conexion();
			rs=clsCon.Consulta(sentencia);
			if(rs.next())
			{
				respuesta=true;
				this.setClave(aclave);
			}
			else
			{
				respuesta=false;
				rs.close();
			}
		}
		catch(Exception ex)
		{
			System.out.println( ex.getMessage());
		}
		return respuesta;
	}
	
	public Boolean coincidirClaves(String nclave, String nrepetir) {
		boolean respuesta;
		if(nclave.equals(nrepetir))
		{
			respuesta=true;
			this.setClave(nclave);
		}
		else
		{
			respuesta=false;
		}
		return respuesta;
	}
	
	public Boolean cambiarClave(String ncorreo, String nclave)
	{
		boolean respuesta=false;
		String sentencia= "UPDATE tb_usuario SET clave_us='"+nclave+
				"' WHERE correo_us='"+ncorreo+"';";
		//System.out.print(sentencia);
		try
		{
			ResultSet rs;
			Conexion clsCon=new Conexion();
			rs=clsCon.Consulta(sentencia);
			if(rs.next())
			{
				respuesta=true;
				this.setClave(nclave);
			}
			else
			{
				respuesta=false;
				rs.close();
			}
		}
		catch(Exception ex)
		{
			System.out.println( ex.getMessage());
		}
		return respuesta;
	}
}
