<%-- 
    Document   : aggiungiAlCarrello
    Created on : Jan 9, 2017, 10:16:58 AM
    Author     : bonny
--%>
<%@ page info="Home Page" %>
<%@ page contentType="text/html" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="sessione.*" %>
<%@ page import="blogics.*" %>
<%@ page import="db.*" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
   
            
    Cookie[] cookies = request.getCookies(); 
    Boolean loggato  = (cookies!=null);
    int i;
    String art_id = request.getParameter("art_id");
    String prezzo = request.getParameter("art_prezzo");
    String conferma = request.getParameter("conferma");
    
    System.out.println("ID articolo e prezzo");
    System.out.println(art_id);
    System.out.println(prezzo);
    
    Articolo art = GestioneArticolo.getArticolo_byId(art_id);

    Sessione.showCookies(cookies);
     
    Carrello cart = (Carrello) session.getAttribute("cart");
    
    cart.setItem("diocane");
    
    if(cart==null){
        System.out.println("Sto creando un nuovo carrello");
        request.setAttribute("Carrello", cart);
        
        
    }
    
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <h1>Aggiungi al carrello</h1>
        <h1>Ciao <%= Sessione.getUserName(cookies) %></h1>
                 
<ol>
<% 
	String[] items = cart.getItems();
            
        for (int a=0; a<items.length; a++) {
%>
       
        <li><% out.print(items[a]); %> 
        
        <%}%>
</ol>
        
        <form name="formConferma"  action="aggiungiExec.jsp" method="get" >
              <table border="1">
                 <tr><td>Nome</td><td>Descrizione</td><td colspan="2">Quatità</td></tr>
                 <tr>
                     <td><%= art.getArt_nome() %></td>
                     <td><%= art.getArt_desc() %></td>
                     <td><input type="text" size="5" name="art_qty"></td>
                    <td><input type="submit" value="Add"  onclick="submit()"/></td>
                </tr>
                </table>
                <input type="hidden" name="art_id"     value=<%= art.getArt_id()%> />
                <input type="hidden" name="art_prezzo" value=<%= art.getArt_prezzo()%> />
                
        </form>
    </body>
</html>
