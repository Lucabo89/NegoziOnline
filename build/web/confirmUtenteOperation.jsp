<%-- 
    Document   : managePage
    Created on : Jan 18, 2017, 10:34:00 PM
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Area Amministatore</title>
        <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
    </head>
    
    <body>
        <div class="container">			   
<!-------------------------------- TESTATA ------------------------------------>
            <div class="header">
            <table><tr><td><span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span></td>
                <td width="10%"></td></tr>
            </table>
            </div>			
<!-------------------------------- TESTATA ------------------------------------>
    <div class="main_nav"> 
        <div class="sub_menu">
            <div>GESTISCI DATABASE</div>
            <table>
                <TR><td><a href="viewPage.jsp?id=utenti">  Utenti</a></td></tr>
                <TR><td><a href="viewPage.jsp?id=ordini">  Ordini</a></td></TR>
                <tr><td><a href="viewPage.jsp?id=articoli">Articoli</a></td></TR>
                <TR><td><a href="viewPage.jsp?id=articoli">Categorie</a></td></TR>
                <TR><td><a href="viewPage.jsp?id=articoli">Marche</a></td></TR>
            
 <td colspan="3">
                <form  name="logoutForm" action="index.jsp" method="post">
                <center>    <input type="hidden" name="status" value="logout"/>  </center>
                </form>
             <a href="javascript:logoutForm.submit()">Logout</a>
            </td>
            
            </table>
        </div>
    </div>
        





    <div class="content">
<%      
    String ut = request.getParameter("utente");
    String operazione = request.getParameter("operazione");
    Utente utToEdit = GestioneUtente.getUtente_byID(ut);
%>
    
    
    
<%  if(operazione.equals("cancella")){
    
    int result = GestioneUtente.Elimina_Utente(utToEdit);
    
    if(result>0){ %>
    
    <H1>Utente cancellato con successo</H1>
                   
<%  }  %> 

<%  if(result<0){
        System.out.println("UTENTE cancellato con successo");
        out.println("Utente NON cancellato!!");
        }
    }
%>
    
    

    </div>  
    
    
    </body>  
</html>
