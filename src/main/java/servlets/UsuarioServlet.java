package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import mantenimiento.MySQLUsuarioDAO;
import Models.UsuarioDTO;

import java.io.IOException;

import DAO.DAOFactory;
import DAO.UsuarioDAO;

/**
 * Servlet implementation class UsuarioServlet
 */

@WebServlet(name="usuario", urlPatterns = {"/usuario"})
public class UsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsuarioServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String opcion =request.getParameter("opcion");
		System.out.println(" opcion -->" +opcion);
		 
		switch (opcion) {
		case "log":  
					registrarUsurio(request,response); 
					break;
	 
		default:
			throw new IllegalArgumentException("Unexpected value: " + opcion);
		}
		 
	}

	private void registrarUsurio(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//variables
		String mensaje="";
		String url;
		
		//Entradas
		String nombre= request.getParameter("txtNombre");
		String apellido= request.getParameter("txtApellido");
		String correo= request.getParameter("txtCorreo");
		String contraseña= request.getParameter("txtContraseña");
		String pais= request.getParameter("pais");
		String ciudad= request.getParameter("ciudad");
		String genero= request.getParameter("genero");

		
		UsuarioDTO u = new UsuarioDTO(nombre,apellido,correo,contraseña,pais,ciudad,genero);
		
		
		//Obtenemos la fabrica DAO 
	    DAOFactory fabrica = DAOFactory.getDaoFactory(DAOFactory.MySQL);
		UsuarioDAO dao = fabrica.getUsuarioDAO();
				
		//Procesos 
		int ok=dao.registrar(u);
		
		if(ok==0) {
			mensaje+="Error al registrar los datos, revisar";
			url="usuario/registrar.jsp";
		}else {
			mensaje+=" <script> alert('"+"Registro del usuario <strong>"+nombre+"</strong> OK, ingrese al sistema" +"') </script>";
			url="/login.jsp";
		}
		
		request.setAttribute("mensaje", mensaje);
		request.getRequestDispatcher(url).forward(request, response);

	
	
		
		
		
		
		
			
		
		
	}

}
