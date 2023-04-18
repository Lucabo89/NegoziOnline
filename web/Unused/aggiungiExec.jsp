\<%-- 
    Document   : aggiungiExec
    Created on : Jan 9, 2017, 9:45:28 AM
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
    
    System.out.println("siamo dentro ad aggiungiExec ");

    String id     = request.getParameter("art_id");
    String prezzo = request.getParameter("art_prezzo");
    String qty    = request.getParameter("art_qty");
    Articolo art = GestioneArticolo.getArticolo_byId(id);
    String desc = art.getArt_desc();
        
    String nome = art.getArt_nome();
    
    System.out.println("Dettagli acquisto articolo");
    System.out.println("Art_id: "+id);
    System.out.println("Art_id: "+ nome);
    System.out.println("Art_prezzo: "+prezzo);
    System.out.println("Art_qty: "+qty);
    System.out.println("Art_desc: "+desc);
    
    System.out.println("Cerco di creare un nuovo item da inserire nel carrello");
    Item it = new Item(id, nome, desc, prezzo, qty);
   
    Carrello cart = (Carrello) session.getAttribute("cart");
            
    if(cart==null){
        System.out.println("Sto creando un nuovo carrello");
        System.out.println("adesso devo chiedere indirizzo spedizione e pagamento");
        System.out.println("oppure di tornare all'index e carcare altro");
    }    
%>
                 
il tuo carrello contiene già i seguenti elementi: 
<ol>
<% 
	String[] items = cart.getItems();
            
        for (int a=0; a<items.length; a++) {
%>
       
        <li><% out.print(items[a]); %> 
        
        <%}%>
</ol>
        