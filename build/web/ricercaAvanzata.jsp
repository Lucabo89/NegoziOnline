<%-- 
    Document   : ricercaAvanzata
    Created on : Jan 10, 2017, 11:26:24 AM
    Author     : bonny
--%>
<%@ page info="Home Page" %>
<%@ page contentType="text/html" %>
<%@ page buffer="30kb" %>
<%@ page session="false" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="sessione.Sessione" %>
<%@ page import="blogics.*" %>
<%@ page import="db.*" %>
<%@ page import="java.util.Vector" %>

<%
        String art  = request.getParameter("art");
        String cat  = request.getParameter("cat");
        String marc = request.getParameter("marc");
    
        System.out.println(art);
        
        String sql = "select from articolo where ";

%>



<!DOCTYPE html>
<html>
    <head>
        <link href=" template.css" rel="stylesheet" type="text/css" media="screen">
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ricerca Avanzata</title>
    </head>

    <body>
        <div  id="container">
        <h1>Hello World!</h1>
        <br>
        I parametri della ricerca sono: <%= art  %>, <%= marc  %>, <%= cat  %>  
<%
        
//        PRENDO I PARAMETRI DELL'INDEX, FACCIO LA QUERY E 
//        METTO I RISULTATI IN UNA PAGINA UGUALE ALL'INDEX
        
        System.out.println("--------Stampo Risultati Ricerca Avanzata");                    
        
        Vector<Articolo> articoli = GestioneArticolo.RicercaAvanzata(art, cat, marc);
        
        int numArt = articoli.size();
        int i;
%>
       <table border="1">
<%
        for( i=0; i<numArt; i++ ){                    
%>
 
        <tr>
            <td><%= articoli.elementAt(i).getArt_nome() %></td>
            <td><%= articoli.elementAt(i).getArt_desc() %></td>
            <td><%= articoli.elementAt(i).getArt_prezzo() %></td>
        </tr>  
     
     <% } %>           
        
        </table>

        </div>

    </body>
</html>
