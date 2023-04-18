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
  
  String ord   = request.getParameter("cod_ord");
  
%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visualizza Dettagli</title>
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
        <table>
            <tr>
            <td><h2>Ordine n.<%=ord %> </h2></td>
            </tr>
        </table>
            <br><br>
        <table width="500px">
            <tr><td>Art.ID</td><td>Quantità</td><td>Prezzo</td></tr>
        <tr><td></td><td></td><td></td><td></td></tr>
        <% 
        int totale=0;
        int qty=0;
        int prezzo=0;
        
            Vector<Item> dettagli = GestioneOrdine.getDettagliTab_byOrdId(ord);
            System.out.println(dettagli.size());
            for(int l=0; l< dettagli.size(); l++)
            {
                Articolo a = GestioneArticolo.getArticolo_byId(dettagli.elementAt(l).getItem_id());
                String nome = a.getArt_nome();
                qty= Integer.parseInt(dettagli.elementAt(l).getItem_qty());
                prezzo= Integer.parseInt(dettagli.elementAt(l).getItem_prezzo());
                
                System.out.println("Nome: "+nome+"Qty="+qty+"  Prezzo="+prezzo);        
        %>
            
            <tr>
                <td><%=dettagli.elementAt(l).getItem_id()%></td>
                <td><%= nome %></td>
                <td><%=dettagli.elementAt(l).getItem_qty() %></td>
                <td><%=dettagli.elementAt(l).getItem_prezzo()%></td>
            </tr>

<%          
            totale = totale+( qty*prezzo );
                            System.out.println(totale);

            }  
            
            
%>
        
    <tr><td colspan="4">--------------------------------------------------------------------------------------------</td></tr>
<tr><td><h2>Totale: </h2></td><td> <h2><%= totale %> euro </h2> </td></tr>
        </table>
    </div>


    </div>
</div>
</body>