<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
<jsp:useBean id="GestioneLogin" scope="request" class="bflows.GestioneLogin" />
<jsp:setProperty name="GestioneLogin" property="*" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

   
<%
  Cookie[] cookies = request.getCookies();
  boolean loggato=false;
  String mail;
  Boolean admin=false;
  //Non basta che cin siamo cookie per dire che uno è loggato, ma deve esserci cookies[1]=! null!
  //perchè se c'è, contiene proprio la mail dell utente loggato
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
  
  String artId   = request.getParameter("art_id"); 
  String prezzo  = request.getParameter("art_prezzo"); 

  Articolo a = GestioneArticolo.getArticolo_byId(artId);

%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ricerca articoli</title>
        <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
    </head>
    
    
    
    
    
<body>
    <div class="container">	
        <div class="header">
            <span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span>
        </div>		
 
            
<!-------------------------------------------------------------BARRA ORIZZONTALE MARCHE -------------------------------------------------------------------->
<div id="navigation">
<!--<div class="menu">-->
<!--barra ricerca piccola che qua non serve-->
<!--        <span class="search">
            <input type="text"  name="search" /> 
            <input type="submit" class="button" value="Search" />
        </span>-->



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
    
    
    
 
    


<!-------------------------------------------------------- MENU LATERALE SINISTRO --------------------------------------------------------->
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
            <!--<tr><td colspan="3">Accedi Area Amministrativa:</td></tr>-->
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
    

<div class="sub_menu"><!---------------  ELENCO CATEGORIE ----------------------->

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


    
    
    

    
<!------------------------------------------- CONTENUTO CENTRALE PAGINA--------------------------------------------------------->
    <div class="content">
        <%
        String nome = a.getArt_nome();
        String articolo = a.getArt_id();
        %>
        <form>
        <table width="500px" border="0">
            <tr><td colspan="2"><h2><%= nome %></h2></td></tr>
            <tr><td align="center">
                <!--<img src="images/41Huy05eJiL._AC_SY200_.jpg" width="300px"  height="200px">--> 
                
                <img src="images/<%=a.getArt_categ()%>.jpg" ></td></tr>
        

                
            </td>
            <td>    
            </td>
        </tr>
        <tr><td><br><br></td></tr>
        <tr><td><h3>Prezzo: <%= prezzo %> €</h3></td></tr>
        <tr><td> <%= a.getArt_desc() %> </td>
        <% if(loggato){ %>
        <td rowspan="2">
            <a href="carrello.jsp?art_id=<%= articolo%>" >
                <img src="images/icona-carrello-458px.png"  valign=center width="100px"  height="100px">
            </a>
            <br><br>
            <a href="carrello.jsp?art_id=<%= articolo%>"> Aggiungi al Carrello</a>
        </td>   
        </tr>
        <% }%>
        <% if(!loggato){ %>
        <td rowspan="2">
            <a href="registratione.jsp">
                <img src="images/icona-carrello-458px.png"  valign=center width="100px"  height="100px">
            </a>
            <br><br>
            <a href="carrello.jsp">Aggiungi al Carrello</a>
        </td>   
        </tr>
        <% }%>
        </table>
        </form>
    </div>


 </div>
</body>