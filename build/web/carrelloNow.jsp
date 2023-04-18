<%-- 
    Document   : managePage
    Created on : Jan 18, 2017, 10:34:00 PM
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<jsp:useBean id="GestioneLogin" scope="request" class="bflows.GestioneLogin" />
<jsp:setProperty name="GestioneLogin" property="*" />

<%
  Cookie[] cookies = request.getCookies();
  boolean loggato=false;
  try{
      String mailLoggato = cookies[1].getValue();
      if (mailLoggato!=null){
          loggato = true;}
  }catch(Exception e){
      System.out.println("Catchata l'eccezione! Vuol dire che c'è il cookies JSESSION ma non è loggato nessuno!!");
      loggato = false;}
  
  int i;
  String status=null;
  String mail;
  Boolean admin=false;
  status = request.getParameter("status");

  if (status==null){
      status="view";
      System.out.println("---------------------------------------Siamo dello status: "+status);
      if(loggato){
        System.out.println("dentro all'if loggato status "+ status);
        mail = cookies[1].getValue();
        System.out.println("La mail è "+mail);
        Utente u = GestioneUtente.getUtente_byMail(mail);
        if(u.getType().equals("1")){
              admin=true;}
      }
  }
  if (status.equals("login")){
      System.out.println("---------------------------------------Siamo dello status: "+status);
      
      mail = request.getParameter("mail");
      String pass = request.getParameter("password");
      System.out.println("Parametri login:");
      System.out.println(mail);
      System.out.println(pass);

      GestioneLogin.Login(mail, pass);
      if(GestioneLogin.getCookies()!=null)
      {
          for(i=0; i<GestioneLogin.getCookies().length; i++){
              System.out.println("response.addCookie(GestLog.getCookies("+i+" )");
//Aggiunge alla RESPONSE tutti i cookie relativi 
//all'utente che si ? appena loggato!!
              response.addCookie(GestioneLogin.getCookies(i));
              System.out.println(i);
              System.out.println(GestioneLogin.getCookies(i).getValue());
          }
      cookies=GestioneLogin.getCookies();
      System.out.println("Fuori ciclio for prima di loggato=true");
//GUARDO SE SI è LOGGATO UN AMMINISTRATORE CHE NEL CASO CAMBIA 
      Utente u = GestioneUtente.getUtente_byMail(mail);
      if(u.getType().equals("1")){
          admin=true;}
      loggato=true;
    }
  }
    
  if (status.equals("logout")){
    if (loggato){
        GestioneLogin.setCookies(cookies);
        GestioneLogin.Logout();
        for(i=0; i<GestioneLogin.getCookies().length; i++)
            response.addCookie( GestioneLogin.getCookies(i) );
        loggato=false;
    }
  }
 
//  AGGIUNGI AL CARRELLO
    String art_id = request.getParameter("art_id");
    Articolo a = GestioneArticolo.getArticolo_byId(art_id);
    
    Carrello cart = (Carrello) session.getAttribute("cart");
    Item[] items = cart.getItems();

    
//    if (status.equals("add")){   
//        String artId  = request.getParameter("art_id");
//        String art_qty = request.getParameter("qty");
//        String art_prezzo = GestioneArticolo.getArticolo_byId(art_id).getArt_prezzo();
//        Item it = new Item(artId, art_prezzo, art_qty  );
//        cart.addItem(it);        
//    }
    
//    if(status.equals("delete")){
//        String indice  = request.getParameter("index");
//        cart.deleteItem(Integer.parseInt(indice));
//    }
    
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aggiungi al Carrello</title>
        <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
    </head>
    
    
    <body>
        <div class="container">			    
            <div class="header">
               <span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span>
            </div>		
<!------------------------------------------------------- BARRA ORIZZONTALE MARCHE -------------------------------------------------------------------->
<div id="navigation">
 <span  class="menu"></span>   
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
 </div>
<!------------------------ MENU LATERALE SINISTRO --------------------------------------------------------->
<div class="main_nav">
<div class="sub_menu"><!-------------------  CHECK LOGIN ------------------->
        <div>Effettua Login</div>
<%        if(loggato && !admin){                   %>
<form name="logoutForm" action="index.jsp" method="post">
        Bentornato <%= Sessione.getUserName(cookies)%>
        <a href="areaPersonale.jsp">Carrello</a>
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
</div>
        <br>
        <br>
    <%      if(!loggato){                             %>
<div class="sub_menu">
    <table>
        <tr><td colspan="2"><a href="registrazioneUtente.jsp">Registrati</a></td></tr>
    </table>
</div>        <%}%>
<!---------------  ELENCO CATEGORIE ----------------------->
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






<!-------------------------  CONTENT CENTRALE  ------------------------------->
<div class="content">             
<!-------------- ELENCO CARRELLO ---------------------->
        <table width="650px" border="0">   
            <tr><td colspan="6"><h2>Articoli nel carrello: </h2></td></tr>
<%      if(items.length==0){%>   <tr><td>Carrello Vuoto </td></tr>  <%}%>
<%



        int totale=0;

        for(int j=0; j<items.length; j++) {
            Articolo ar = GestioneArticolo.getArticolo_byId( items[j].getItem_id() );
            String desc = ar.getArt_desc();
            String nome = ar.getArt_nome();
            int prezzo = Integer.parseInt(items[j].getItem_prezzo());
            int qty = Integer.parseInt(items[j].getItem_qty());  
            
            
%>
<tr>
<td width="10px" align="right">
    <% out.print(items[j].getItem_qty()); %></td>  
    <td width="15px" >x</td>    
    <td align="center"><% out.print(nome); %></td>
    <td><% out.print(desc); %></td> 
    <td><% out.print(items[j].getItem_prezzo()); %> €</td>      
<%  
    
    
        totale = totale + (qty*prezzo);
        
        
        
        
        } %>
</tr>
<tr><td colspan="5">------------------------------------------------------------------------------------------------------------------------</td></tr>
        <tr><td colspan="2"><h1>Totale: </h1></td><td><h1><%= totale%> €</h1></td></tr>
</table>
<!---------------  fine ELENCO ARTICOLI NEL CARRELLO  -------->

<br><br>
     <br><br>
   

<table border="0" width="300px">
    <tr><td>
        <table>
            <tr><td><a href="index.jsp"><img align="center" src="images/icona-home-page2.jpg" width="90px" height="90px"></td></tr>                
            <tr><td><a href="index.jsp">Torna alla home</a></td></tr>
        </table>
    </td>
    <td>
        <table>
            <tr><td><a href="ordine.jsp"><img align="center" src="images/icona-carrello-458px.png" width="70px" height="70px"></td></tr>
           <tr><td><a href="ordine.jsp">Vai alla Cassa</a></td></tr>
        </table>
    </td></tr>

</table>
        </div>
        
        
        
        </div>
    </body>
</html>
