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
    System.out.println("-------------------Pagina modifyExec.jsp");
    
    String newNome    = request.getParameter("nuovoNome");
    String newCognome = request.getParameter("nuovoCognome");
    String newEmail   = request.getParameter("nuovoEmail");
    String stessoID   = request.getParameter("utente_id");
    
        System.out.println(stessoID);
    System.out.println(newNome);
        System.out.println(newCognome);
        System.out.println(newEmail);
    
      int i = GestioneUtente.Modifica_Utente(stessoID, newNome, newCognome, newEmail);
    
      if(i>0)
          out.println("Modifica Effettuata correttamente");
    

%>

<html>
    <body>
        <a href="elencoUtenti.jsp">Torna al Gestionale</a>
    </body>
    
</html>