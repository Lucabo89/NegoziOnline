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

//  PARAMETRI RICERCA
  String id   = request.getParameter("idRicerca"); 
  String tipo = request.getParameter("tipoRicerca");
  System.out.println("Ricerca: "+tipo+" "+id) ;  

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




 
<!---------------------- MENU LATERALE SINISTRO ---------------------------->
<div class="main_nav">
<div class="sub_menu">
<!---------------------------  CHECK LOGIN ------------------------------->
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
            <tr><td><a href="viewPage.jsp?id=utenti"> GESTIONALE </a></td></tr>
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
        <tr><td colspan="2"><a href="registrazione.jsp">Registrati</a></td></tr>
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


    
    
    
    
    
    
<div class="content">
<!------------- form ricerca avanzata  ------------>
<form action="ricerca.jsp" > 
<table border="0" align="" width="100px">
    <tr><td>
            <select name="cat">
<%
                out.print("<option>Categorie</option>");
                Vector<Categoria> catList = GestioneCategoria.getCategorieTab();
                int a ;
                int b = catList.size();;
                for( a=0; a<b; a++ ){ 
%>
                <option value= <%=catList.elementAt(a).getCat_id()%>> <%= catList.elementAt(a).getCat_nome()%> </option>
                <%  }  %>
            </select>
        </td>
        <td>
            <select name="marc">
<%
                out.print("<option>Marche</option>");                  
                Vector<Marca> marcList = GestioneMarca.getMarcheTab();
                int c = marcList.size();
                int d=0;  
                for( d=0; d<c; d++ ){ 
%>
                <option value=<%= marcList.elementAt(d).getMarc_id()%>> <%= marcList.elementAt(d).getMarc_brand()  %> </option>
            <%  }  %>                   
            </select>
        </td>
        <td><input type="text" name="artParola" placeholder="Search"></td>
        <td><input type="submit" class="button2" value="Ricerca Avanzata"></td>
    </tr> 
    </table>
    <input type="hidden" name="tipoRicerca" value="RicercaAvanzata"/>     
</form> 
<br><br><br><br>
<% 
    if(tipo.equals("RicercaAvanzata")){  
      String parola = request.getParameter("artParola");
      String cat    = request.getParameter("cat");
      String marca  = request.getParameter("marc");
      
      System.out.println("Parametri ricerca: "+parola+", "+marca+ ", "+cat+"");
     
      Vector<Articolo> artResult = GestioneArticolo.RicercaAvanzata(parola, cat, marca);
      int q, numArt = artResult.size();
        for(q=0; q<numArt; q++){
                out.println("<table border=0 width=700px>"
                        + "<tr>"
                        + "<td width=150px >"
            
                        + "<table border=0 width=170px height=140px>"
                            + "<tr><td align=center>"+artResult.elementAt(q).getArt_nome()+"</td></tr>"
                            + "<tr><td align=center width=50px height=50px><img src=images/"+artResult.elementAt(q).getArt_categ()+".jpg></td></tr>"
                            + "<tr><td align=center>Prezzo:   "+artResult.elementAt(q).getArt_prezzo()+" </td></tr>"
                        + "</table>"                        
                        
                        + "</td>");
                
            System.out.println("<img src=images/"+artResult.elementAt(q).getArt_categ()+".jpg>");
                
                if(loggato){
                    //se uno è loggato, la Descrizione diventa un link per aggiungerlo al carrello!!
                out.println("<td width=700px><a href=carrello.jsp?"
                        + "art_id="+artResult.elementAt(q).getArt_id()
                        + "&art_prezzo="+artResult.elementAt(q).getArt_prezzo()
                        + ">"+artResult.elementAt(q).getArt_desc()+ "</a></td>"
                        + "</tr>" );
                }else{
                out.println("<td width=700px>"+artResult.elementAt(q).getArt_desc()+"</td>");
                }
                out.println("</table>");
        }
  }        
%>

<%  
    if(tipo.equals("marc")){
      System.out.println("Ricerca per marca");
      
      Vector<Articolo> artResult = GestioneArticolo.RicercaMarca( id );
      int q, numArt = artResult.size();
        for(q=0; q<numArt; q++){
                out.println("<table border=0 width=700px>"
                        + "<tr>"
                        + "<td width=150px >"
            
                          + "<table border=0 width=170px height=140px>"
                            + "<tr><td align=center>"+artResult.elementAt(q).getArt_nome()+"</td></tr>"
                            + "<tr><td align=center width=50px height=50px><img src=images/"+artResult.elementAt(q).getArt_categ()+".jpg></td></tr>"
                            + "<tr><td align=center>Prezzo:   "+artResult.elementAt(q).getArt_prezzo()+" </td></tr>"
                        + "</table>"                           
                        
                        + "</td>");
                
                if(loggato){
                    //se uno è loggato, la Descrizione diventa un link per aggiungerlo al carrello!!
                out.println("<td width=700px><a href=carrello.jsp?"
                        + "art_id="+artResult.elementAt(q).getArt_id()
                        + "&art_prezzo="+artResult.elementAt(q).getArt_prezzo()
                        + ">"+artResult.elementAt(q).getArt_desc()+ "</a></td>"
                        + "</tr>" );
                }else{
                out.println("<td width=700px>"+artResult.elementAt(q).getArt_desc()+"</td>");
                }
                out.println("</table>");
        }
  
  }
%>
   
<%  
    if(tipo.equals("cat")){
      System.out.println("Ricerca per categoria");  
      Vector<Articolo> artResult = GestioneArticolo.RicercaCategoria( id );
      int q, numArt = artResult.size();
        for(q=0; q<numArt; q++){
                out.println("<table border=0 width=700px>"
                        + "<tr>"
                        + "<td width=150px >"
            
                       + "<table border=0 width=170px height=140px>"
                            + "<tr><td align=center>"+artResult.elementAt(q).getArt_nome()+"</td></tr>"
                            + "<tr><td align=center width=50px height=50px><img src=images/"+artResult.elementAt(q).getArt_categ()+".jpg></td></tr>"
                            + "<tr><td align=center>Prezzo:   "+artResult.elementAt(q).getArt_prezzo()+" </td></tr>"
                        + "</table>"                              
                        
                        + "</td>");
                if(loggato){
                    //se uno è loggato, la Descrizione diventa un link per aggiungerlo al carrello!!
                out.println("<td width=700px><a href=carrello.jsp?"
                        + "art_id="+artResult.elementAt(q).getArt_id()
                        + "&art_prezzo="+artResult.elementAt(q).getArt_prezzo()
                        + ">"+artResult.elementAt(q).getArt_desc()+ "</a></td>"
                        + "</tr>" );
                }else{
                out.println("<td width=700px>"+artResult.elementAt(q).getArt_desc()+"</td>");
                }
                out.println("</table>");
        }
  
  }
%>
   
</div><!------- content ----------> 

</div><!--container-->       
</body>