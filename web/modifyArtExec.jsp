<%-- 
    Document   : deleteUtente
    Created on : Jan 10, 2017, 11:26:56 AM
    Author     : bonny
--%>

<%@ page contentType="text/html" %>
<%@ page buffer="30kb" %>
<%@ page session="false" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="sessione.Sessione" %>
<%@ page import="blogics.*" %>
<%@ page import="db.*" %>
<%@ page import="java.util.Vector" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    System.out.println("-------------------Pagina modifyArtExeci.jsp");
    
    String art_id   =  request.getParameter("art_id");
    String newNome    = request.getParameter("nuovoNome");
    String newDesc = request.getParameter("nuovoDesc");
    String newPrezzo   = request.getParameter("nuovoPrezzo");
    String newMarca  = request.getParameter("nuovoMarca");
    String newCategoria  = request.getParameter("nuovoCategoria");
    
    System.out.println("Nuovi parametri da modificare");
        System.out.println(newNome);
        System.out.println(newDesc);
        System.out.println(newPrezzo);
        System.out.println(newCategoria);
        System.out.println(newMarca);
    
      int i = GestioneArticolo.Modifica_Articolo(art_id, newNome, newDesc, newPrezzo, newMarca, newCategoria);
    
      if(i>0){
          out.println("Modifica Effettuata correttamente");
      }

%>

<html>
    <body>
        <a href="http://localhost:8080/NegoziOnline/viewPage.jsp?id=articoli.jsp">Torna al Gestionale</a>
        
    
    </body>
    
</html>