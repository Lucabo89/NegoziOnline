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
    
  int i;
  Cookie[] cookies = request.getCookies();
  boolean loggato=false;
  String op = request.getParameter("op");
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
  
  String stato   = request.getParameter("stato"); 
  String ord = request.getParameter("ord"); 
  
  Ordine ordine = GestioneOrdine.getOrdine_byId(ord);
  
  
//  if(op.equals("modify")){
//      out.println("dioporco funziona!!!");
//  }

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
    
</div><!-------------------------------------------------------------- fine CHECK LOGIN -------------------------------------------------------------->
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
    </div><!------------------------------------------------- fine  ELENCO CATEGORIE --------------------------------------------------------->            

</div>


    
    
    
    
    
    
    

    
<!------------------------------------------- CONTENUTO CENTRALE PAGINA--------------------------------------------------------->
    <div class="content">
        
        
        <form action="spedizioneExec.jsp" method="get" >
            <table width="550px" border="0">
            <tr>
            <td><h2>Vuoi cambiare lo stato dell'ordine n.<%= ordine.getOrd_id()%> del <%= ordine.getOrd_data()%>?</h2></td>
            </tr>
            <tr>
                    <td>Stato attuale</td>            
                    <td><%= ordine.getOrd_stato()%></td>
            </tr>

            <tr>
            <td>Modifica Stato ordine in: </td>
                
            <td>
                <select name="newStato">
                    <option>Fermo</option>
                   <option>Pagato</option>
                   <option>Spedito</option>
                </select>
            </td>            
                   
            </tr>

            <tr><td><input type="submit" class="button2" value="Modifica Stato"></td></tr>  
                 <input type="hidden" name="ord" value="<%= ordine.getOrd_id()%>">
    
        </table>
        </form>
    </div>


    </div>
</div>
</body>