<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.DAOFactory"%>

<%@page import="Models.UsuarioDTO"%>
<%@page import="Models.OrganizadorDTO"%>
<%@page import="Models.AsistenteDTO"%>
<%@page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>



<%@page import="Models.EventoDTO"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Menu Usuario</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Lexend&display=swap');

        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            font-family: 'Lexend', sans-serif;
        }

        .pag-container {
            display: flex;
            flex-direction: row;
            margin-top: 20px;
        }

        .pag-main {
            width: 80%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            margin-top: 50px;
        }

        .pag-subtitle-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .pag-subtitle {
            font-size: 2em;
            margin-right: 10px;
        }


        .pag-search-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .pag-search-input {
            width: 600px;
            height: 40px;
            padding: 5px;
            font-size: 1em;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .pag-search-button {
            width: 40px;
            height: 40px;
            margin-left: 10px;
            font-size: 1.5em;
            border-radius: 50%;
            border: none;
            flex-wrap:wrap;
            background-color: #00B4CC;
            color: white;
            cursor: pointer;
        }

        .pag-event-container {
            border: 1px solid #ccc;
            padding: 20px;
            font-size: 1.2em;
			display:flex;
			flex-wrap:wrap;
            width: 80%;
            margin-top: 20px;
        }
        
        .pec-1{
        
        	flex-wrap: nowrap;
        	flex-direction: column;
        }
        .item-evento{
        	display:flex;
        	flex-direction:row;
        	gap:5px;
        	justify-content:flex-start;
        	align-items:center;
        	width: 95%;
        	height: 200px;
        	background-color: #D9D9D9;
        	border-radius: 10px;
        	margin:10px 5px;
        	
        }
        
        .item-evento img{
       		height:100%;
        	width: 70%;
           	border-bottom-left-radius: 10px;
           	border-top-left-radius: 10px;
           	
    
        }



    
    #itemMenu{
    	background-color: rgb(158, 158, 158);
        color: #262525;
    
    }
</style>

</head>
<body>
<% String msg = (String) request.getAttribute("mensaje");
if (msg==null) msg="";

UsuarioDTO user = (UsuarioDTO) request.getSession().getAttribute("datousu");


int codigo = user.getIdUsuario();
System.out.print(user.getIdUsuario());
//aca es en general , pero solo debe de contar los eventos creados llamados desde la tabla Organizador
DAOFactory fabric = DAOFactory.getDaoFactory(DAOFactory.MySQL);

	
%>
<%=msg %>
<!-- Usted se ha identificado como: <strong> ${datosusu.nombre} ${datosusu.apellido} </strong> 
 -->
	<%@include file="../comun/header_Salir.jsp" %>

	<div class="pag-container">

	<%@include file="../comun/aside.html" %>


	    <div class="pag-main">
	        <div class="pag-subtitle-container">
	            <h2 class="pag-subtitle">Buscar Evento</h2>
	        </div>
	        <div class="pag-search-container">
	        
	        	<form action="evento" method="post">
	        	
		            <input type="text" class="pag-search-input"  name="usuario" style="display: none;" value=<%=codigo %>>
		            <input type="text" class="pag-search-input"  name="texto" placeholder="Buscar evento">
		            <button class="pag-search-button" name="opcion" value="buscador">&#128269;</button>
		        	
	        	</form>
	        </div>
	        <div class="pag-event-container pec-1" id="contenedor-eventos1">
	           

	            <% 
	            ArrayList<AsistenteDTO> listaAsistente = fabric.getAsistenteDAO().listarAsistenciasDeUsuario(codigo);
	           	if(listaAsistente != null){%>
	           		
	           		<%="<p align='center' style='font-weight: bold;' > Aqu� se mostrar�n tus eventos pendientes</p>"%>
	           		<%
	           		if(listaAsistente.size() == 0){%>
	           			<%="<br /><p align='center'> No tienes Eventos Pendientes</p>"%>
	           		<%
	           		}else{
	           			
		           		for(AsistenteDTO p : listaAsistente){
		           			
		           			OrganizadorDTO org = fabric.getOrganizadorDAO().buscarOrganizadorPorEvento(p.getIdEvento());
		           					
		           			EventoDTO eve = fabric.getEventoDAO().buscarEvento(p.getIdEvento());
		                    InputStream imagenInputStream = eve.getImagenEvento(); // Obtener el InputStream de la imagen del objeto EventoDTO
		                    String imagenBase64 = fabric.getEventoDAO().ConvertirIMG(imagenInputStream);
		                    int usuario = codigo;
		           	%>
		           	
		           		<a href="/EventosYa/evento?opcion=bus&org=<%=org.getIdOrganizador() %>&url=ver&usuario=<%=codigo %>" class="item-evento">
		           		
		    				<img src="<%= imagenBase64.toString() %>" alt="Imagen del evento">
							<h3><%=eve.getNombreEvento() %></h3>
		           	
		           		</a>

		           	<%
		           	}
	           			
	           		}
	           	}
	           	%>	
	        </div>
	        <div class="pag-event-container pec-2" id="contenedor-eventos ">
	          <p align="center" style="font-weight: bold;"> Aqu� se mostrar�n los eventos agregados recientemente</p>
	           
	          	<%//Llamamos a los organizador ya que ellos tienen los idEvento y IdUsuario %>
	        	<%ArrayList<OrganizadorDTO> listaOrganizador = fabric.getOrganizadorDAO().listarOrganizador();
		           	if(listaOrganizador != null){
		           		
		           		for(OrganizadorDTO p : listaOrganizador){
		           			
		           			EventoDTO eve = fabric.getEventoDAO().buscarEvento(p.getIdEvento());
		           			
		                    InputStream imagenInputStream = eve.getImagenEvento(); // Obtener el InputStream de la imagen del objeto EventoDTO
		                    
		                    String imagenBase64 = fabric.getEventoDAO().ConvertirIMG(imagenInputStream);   
		           	%>
		           	
		           		<a href="${pageContext.request.contextPath}/evento?opcion=bus&org=<%=p.getIdOrganizador() %>&url=ver&usuario=<%=codigo %>" class="item-evento">
		           		
		    				<img src="<%= imagenBase64.toString() %>" alt="Imagen del evento">
							<h3><%=eve.getNombreEvento() %></h3>
		           	
		           		</a>
	
		           	<%
		           			
		           		}
		           		
		           	}%>	
	        
	        </div>
	    </div>
	    
	</div>
    <%@include file="../comun/footer.jsp" %>
    
</body>
</html>
