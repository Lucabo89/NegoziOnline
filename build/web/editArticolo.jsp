<%-- 
    Document   : editUtente
    Created on : Jan 10, 2017, 12:05:37 PM
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

<!DOCTYPE html>

<%
    String artid= request.getParameter("articoloID");
    Articolo a = GestioneArticolo.getArticolo_byId(artid);
    
    System.out.println("----------Pagina editArticolo.jsp di: "+a.getArt_nome());

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Articolo</title>
    </head>
    <body>
        <h1>Dati Articolo:  <%= a.getArt_nome() %> </h1>
       
        
        <form action="confirmArtOperation.jsp" method="get">
        <table align="left" border="1">
            <tr><td>Nome</td><td><%=    a.getArt_nome()    %></td></tr>
            <tr><td>Descrizione</td><td><%= a.getArt_desc() %></td></tr>
            <tr><td>Prezzo</td><td><%=   a.getArt_prezzo() %></td></tr>
            <tr>
                <td><input type="radio" name="operazione" value="cancella">Cancella</td>
                <td><input type="radio" name="operazione" value="modifica">Modifica</td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Effettua operazione"></td></tr>
        </table>
            <input type="hidden" name="articolo" value="<%= artid %>">
        </form>
    </body>
</html>
