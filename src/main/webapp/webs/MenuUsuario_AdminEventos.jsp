<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Menu Usuario </title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lexend&display=swap');
    *{
        padding: 0;
        margin: 0;
        box-sizing: border-box;
        font-family: 'Lexend', sans-serif;
    }


    #itemAdminEventos{
    	background-color: rgb(158, 158, 158);
        color: #262525;
    }

    .aside-item-active {
      background-color: rgb(158, 158, 158);
      color: #262525;
    }
    
    

    
    
    /* Estilo: AdminEvento */

    .contenido{
    
    	display: flex;
    	width: 100%;

    }
    
    .container-main{
    	width: 80vw;
    	display: flex;
    	flex-direction:column;
    	align-items: center;
    	
    	height:auto;
    	
    }
    
    .section{
    	width: 100%;
    	height: 100%;
    }
    
    .organize-section {
      background-color: #3D4CD2;
      padding: 20px;
      color: white;
	  text-align: left;      
      height: 30% !important;
    }

    .organize-section h2 {
      color: white;
    }

    .create-event {
      display: flex;
      justify-content: flex-end;
      padding: 10px;
    }

    .create-event a {
      background-color: #5B72EF;
      color: white;
      border: none;
      border-radius: 5px;
      padding: 10px 20px;
      text-decoration: none;
    }
	.create-event a:hover {
       	cursor: pointer;   
       	opacity: .4;
       	transition:.4s all;
    }
    
    

    .registration-section {
      background-color: white;
      padding: 20px;
      height: 60% !important;
    }

    .registration-header {
      display: flex;
      justify-content: space-around;
      margin-bottom:20px; 
    }

    .registration-header img {
      width: 100px;

    }

    .registration-header p {
      font-size: 1.2em;

    }
    
    .registration-header span{
          font-size: 2em;
          font-weight: bold;
          text-align: right;
    	
    }

    .event-list-section {
		color:white;
    }


    .event-list-header{
       background-color: #3D4CD2;
       display: flex;
       justify-content: space-between;
       gap:10px;
       padding: 5px 20px;
       align-items: center;
    }
     .event-list-header a {
      background-color: #5B72EF;
      color: white;
      border: none;
      border-radius: 5px;
      padding: 10px 20px;
    }
	.event-list-header a:hover {
       	cursor: pointer;   
       	opacity: .4;
       	transition:.4s all;
    }
    

    .event-list {
      list-style: none;
      padding: 0;
      background-color: white;
      color:black;
      width: 100%;
      margin-top: 10px;
      font-size: 1.1em;
    }
    


  </style>
</head>
<body>
<% String msg = (String) request.getAttribute("mensaje");
if (msg==null) msg="";
%>
<%=msg %>

	<%@include file="../comun/header_Salir.jsp" %>

	<div class="contenido">
	
		<%@include file="../comun/aside.html" %> 
		<main class="container-main">
	
	
	    <div class="organize-section section">
	      <h2>Organizar Evento</h2>
	      <br>
	      <p>En esta secci�n puede ver la lista de eventos registrados en la base de datos</p>

	    </div>
	
	    <div class="registration-section section">
	      <div class="create-event">
	       <a href="${pageContext.request.contextPath}/webs/FormCrearEvento.jsp">Crear Evento</a>
	      </div>
	      
	      <div class="registration-header">
	        <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Icono">
		    <p>N�mero de registros: <br> <span id="numero-registros">0</span></p>
	      </div>
	      <hr>
	      <br />
	      <p>N�mero de eventos registrados actualmente en la base de datos</p>
	    
	    
	    </div>
	
	    <div class="event-list-section section">
    		<div class="event-list-header">
	      		<h3>Lista de Eventos</h3>
    			<a>Ver Evento</a>
    		</div>
	      <table class="event-list">
		      <tbody>
				<tr >
					<th>ID</th>
					<th>Nombre</th>
				</tr>
				<!-- 	Aca se haria un foreach -->	

	
		      </tbody>
	      </table>
	    </div>
	  </main>

	
	
	</div>

</body>
</html>