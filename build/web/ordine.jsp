
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : managePage
    Created on : Jan 18, 2017, 10:34:00 PM
    Author     : bonny
--%>

<%@ page contentType="text/html" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="sessione.*" %>
<%@ page import="blogics.*" %>
<%@ page import="db.*" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="GestioneLogin" scope="request" class="bflows.GestioneLogin" />
<jsp:setProperty name="GestioneLogin" property="*" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

   
<%
  String status = request.getParameter("canc");
  Cookie[] cookies = request.getCookies();
  boolean loggato=false;
  String mail;
  Boolean admin=false;
  
  try{
      String mailLoggato = cookies[1].getValue();      
      if (mailLoggato!=null){
          loggato = true;}
  }catch(Exception e){
        loggato = false;}
  
  if(loggato){
        mail = cookies[1].getValue();
        Utente u = GestioneUtente.getUtente_byMail(mail);
        if(u.getType().equals("1")){
              admin=true;}}
  
    System.out.println("siamo dentro a ordine!!");
      
    Carrello cart = (Carrello) session.getAttribute("cart");
    
    String art_id  = request.getParameter("art_id");
    String art_qty = request.getParameter("qty");
    String art_prezzo = GestioneArticolo.getArticolo_byId(art_id).getArt_prezzo();
    System.out.println(" art id: "+art_id+" prezzo: "+art_prezzo+", quantità: "+art_qty);
    
    
    if(!art_id.equals("null"))
    {
//      CREO L ITEM E LO AGGIUNGO AL CARRELLO!!
        Item it = new Item(art_id, art_prezzo, art_qty  );    
        cart.addItem(it);
    }
    else
        if(status.equals("delete")){
            System.out.println("siamo dentro a status = delete");
            String indice  = request.getParameter("index");
            cart.deleteItem(Integer.parseInt(indice));
         }
    
    
    Item[]  items = cart.getItems();
    
%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Effettua ordine</title>
        <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
    </head>
    
    
    
    
    
<body>
    <div class="container">	
        <div class="header">
            <span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span>
        </div>		

        
<!----------------------------------- BARRA ORIZZONTALE MARCHE ---------------->
<div id="navigation">
 <span  class="menu">   
<%
            Vector<Marca> elencoMarc = GestioneMarca.getMarcheTab();
            int g, h = elencoMarc.size();
                for( g=0; g<h; g++ )
                {    
%> 
    <span class="alt"><a href="ricerca.jsp?tipoRicerca=marc&idRicerca=<%= elencoMarc.elementAt(g).getMarc_id()%> ">
                            <%=elencoMarc.elementAt(g).getMarc_brand()%></a>
    </span> 
<%              }             %> 
 </span>       
</div>
    


<!------------------------------------ MENU LATERALE SINISTRO ----------------->
<div class="main_nav">
<div class="sub_menu"><!-------------------  CHECK LOGIN ------------------->
        <div>Effettua Login</div>
<%        if(loggato && !admin){                   %>
<form name="logoutForm" action="index.jsp" method="post">

        Bentornato <%= Sessione.getUserName(cookies)%>
        <a href="areaPersonale.jsp">Ordini effettuati</a>
            <input type="hidden" name="status" value="logout"/>        
        <a href="javascript:logoutForm.submit()">Logout</a>
</form>
<%}%>
<%     if(loggato && admin ){                   %>
        <table border="0">
            <tr><td colspan="3">Bentornato Admin </td></tr>
            <tr><td colspan="3"><%= Sessione.getUserName(cookies)%> </td> </tr>
            <tr>
                <td><a href="viewPage.jsp?id=utenti"> GESTIONALE </a></td>
            </tr>
            <tr>
            <td colspan="3">
                <form  name="logoutForm" action="index.jsp" method="post">
                <center>    <input type="hidden" name="status" value="logout"/>  </center>
                </form>
             <a href="javascript:logoutForm.submit()">Logout</a>
            </td>
            </tr>    
        </table> 
        <%}%>
<%      if(!loggato){                             %>
        <form name="loginForm" action="index.jsp" method="get">
            <table border="0">
                <tr><td><input type="text" name="mail" placeholder="Mail" ></td></tr>
                <tr><td><input type="password" name="password" placeholder="Password" /></td></tr>
                
            </table>
           <input type="hidden" name="status" value="login"/>     
           <input type="submit" value="Entra"  onclick="submitLogin()"/>
        </form>
        <%}%>
</div><!------------------------------------------------------- fine CHECK LOGIN -------------------------------------------------------------->
     <br>
    <br>
    <%      if(!loggato){                             %>

<div class="sub_menu">
    <table>
        <tr><td colspan="2"><a href="registrazioneUtente.jsp">Registrati</a></td></tr>
    </table>
    
</div>        <%}%>
<!------------------------------------------------------------  ELENCO CATEGORIE --------------------------------------------------------->
    <div class="sub_menu">
        <div>Categorie</div>
<%          
            Vector<Categoria> elencoCat = GestioneCategoria.getCategorieTab();
            int e , f = elencoCat.size();
            for( e=0; e<f; e++ ){    
%>
            <a href="ricerca.jsp?tipoRicerca=cat&idRicerca=<%= elencoCat.elementAt(e).getCat_id()%>"><%=elencoCat.elementAt(e).getCat_nome()%>
            </a>
<%       }           %> 
    </div>
</div>


    <%      System.out.println("prima di inserire indirizzo spedizione");        %>
    
    
<!------------------------------------------- CONTENUTO CENTRALE PAGINA------------------------------------------>
<div class="content">
<form action="ordConfermato.jsp" method="get">
    <table border="0" height="140px">
    <h2>Completa Ordine: </h2>
    <tr><td><input type="text" name="city" placeholder="Città"></td>
    <td rowspan="5">   
        <table>
            <tr><td><a href="index.jsp"><img align="right" src="images/icona-home-page2.jpg" width="100px" height="100px"></a></td></tr>                
        <tr><td align="right"><a href="index.jsp"><h1>Continua Shopping</h1></a></td></tr>
        </table>
    </tr>
    <tr><td><input type="text" name="via" placeholder="Via/Piazza" ></td></tr>
    <tr><td><input type="text" name="civico" placeholder="Civico"></td></tr>
    <tr><td>
    <select name="pagamento">
        <option>Poste Pay</option>
        <option>Bonifico</option>
        <option>Carta di credito</option>
        <option>Pay Pal</option>
    </select>
    </td></tr>
    <tr><td><input type="text" placeholder="Dati Pagamento"></td></tr>
    <tr><td><input type="submit" value="Conferma Ordine"></td></tr>
    </table>
</form>
        <br><br><br><br><br><br>
        <br><br>
        
        
        
<table border="0" align=center width="300px">
    <tr><td>
       
        </td>
    </tr>
</table>
        
<br>
        
        
<%      System.out.println("Stampo elenco Carrello");       %> 
    <!---------------- ELENCO CARRELLO ---------------------->
        <table width="600px" border="0">   
            <tr><td colspan="5" align="center"><h2>Articoli nel carrello: </h2></td></tr>
<%      if(items.length==0){%>   <tr><td>Carrello Vuoto </td></tr>  <%}%>
        
<%

int totale =0;

        for(int z=0; z<items.length; z++) {
            
            Articolo ar = GestioneArticolo.getArticolo_byId( items[z].getItem_id() );
            String desc = ar.getArt_desc();
            String nome = ar.getArt_nome();
            
            int prezzo = Integer.parseInt(items[z].getItem_prezzo());
            int qty = Integer.parseInt(items[z].getItem_qty());  
            
           
            
%>
<tr>
    <td width="10px" align="right" ><% out.print(items[z].getItem_qty()); %></td>  
    <td width="15px" >x</td>    
    <td><% out.print(nome); %></td>
    <td><% out.print(desc); %></td> 
    <td><% out.print(items[z].getItem_prezzo()); %></td>   
    
<% 
    System.out.println("Item n.: "+z+", nome: "+nome+", prezzo: "+items[z].getItem_prezzo());
%>
    <td>
     <form action="ordine.jsp"  method="get">
<!--            <table border="0">
                <tr><td><input type="submit" value="Delete"></td></tr>        
            </table>-->
        <input type="hidden" name="index" value= <%= z %> >
        <!--<input type="hidden" name="canc" value="delete"/>-->     
     </form>        
    </td>
    
<%  
          totale = totale + (qty*prezzo);


        
        
        } %>
        </tr><br>
        <tr><td width="30px"><h2>Totale: </h2></td><td width="30px"><h3><%= totale %> €</h3></td></tr>
</table>
</div>


    </div>
</body>