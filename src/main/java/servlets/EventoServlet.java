package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;

import DAO.DAOFactory;
import DAO.EventoDAO;
import Models.EventoDTO;

/**
 * Servlet implementation class EventoServlet
 */
@WebServlet(name="CRUD EVENTOS", urlPatterns = {"/evento"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // Tamaño máximo de la imagen (10 MB ) 

public class EventoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventoServlet() {
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
		case "reg":  
					registrarEvento(request,response); 
					break;
					
		case "sal":
				salir(request,response); 
				break;
	 

	 
		default:
			throw new IllegalArgumentException("Unexpected value: " + opcion);
		}
		
	}

	private void registrarEvento(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		//variables
		String mensaje="";
		String url;
	
		//Entradas
		String nombre= request.getParameter("txtNombre");
		String descripcion= request.getParameter("txtDescripcion");
		String ubicacion= request.getParameter("txtUbicaion");
		
		//Codigo especial para la imagen :D
		Part archivoImagen = request.getPart("txtImagen");
		InputStream imagen = archivoImagen.getInputStream(); //ruta de la imagen que se cargara a la BD
		
		
		String fechaIni= request.getParameter("txtFechaIni");
		String fechaFin= request.getParameter("txtFechaFin");
		int categoria= Integer.parseInt(request.getParameter("txtCategoria"));
				
		EventoDTO e = new EventoDTO(nombre,descripcion,ubicacion,imagen,fechaIni,fechaFin,categoria);
		
		//Obtenemos la fabrica DAO 
	    DAOFactory fabrica = DAOFactory.getDaoFactory(DAOFactory.MySQL);
		EventoDAO dao = fabrica.getEventoDAO();
		
		
		//Procesos 
		int ok=dao.registrar(e);
		
		if(ok==0) {
			mensaje+= "<script> alert('"+"Error al registrar el evento, revisar"+"')</script>";
			url="webs/MenuUsuario_AdminEventos.jsp";
		}else {
			mensaje+=" <script> alert('"+"Registro del evento <strong>"+ nombre +"</strong> OK " +"') </script>";
			url="webs/MenuUsuario_AdminEventos.jsp";
		}
		
		request.setAttribute("mensaje", mensaje);
		request.getRequestDispatcher(url).forward(request, response);
	}

	private void salir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "webs/MenuUsuario_AdminEventos.jsp";	
		
		request.getRequestDispatcher(url).forward(request, response);
		
		
		
	}

}