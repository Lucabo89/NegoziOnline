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
// CREO OGGETTO ORDINE DA DARE AL METODO aggiungiOrdine( ornine ) 
    String id     = "null";
    String nome   = request.getParameter("nome_art");
    String prezzo = request.getParameter("prezzo_art");
    String marca  = request.getParameter("marc");
    String categoria   = request.getParameter("cat");
    String descrizione = request.getParameter("desc_art");
            
    System.out.println("-------------->Stampo dettagli Nuovo articolo");
    System.out.println(nome);   System.out.println(prezzo);  System.out.println(marca);    
    System.out.println(categoria);       System.out.println(descrizione);
    
//------------ CREO L'articolo E LO AGGIUNGO AL DB
    Articolo a = new Articolo(id, nome, prezzo, descrizione, marca, categoria );
    System.out.println(a.getArt_nome()); 
    
    
    int res = GestioneArticolo.aggiungiArticolo( a );
    System.out.println("risultato="+res);
    if(res>0){System.out.println( "creato oggetto ordine ed aggiunto al database" );    }
    
    
    %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inserisci articolo</title>
        <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
    </head>

<body>
      <div class="container">	     
        <div class="header"><span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span></div>    
<!--------------------- BARRA ORIZZONTALE MARCHE ----------------------->
<div id="navigation">
 <span class="menu" >
<%
            Vector<Marca> elencoMarc = GestioneMarca.getMarcheTab();
            int g, h = elencoMarc.size();
                for( g=0; g<h; g++ )
                {    
%> 
    <span class="alt" >
        <a href="ricerca.jsp?tipoRicerca=marc&idRicerca=<%= elencoMarc.elementAt(g).getMarc_id()%> ">
                            <%=elencoMarc.elementAt(g).getMarc_brand()%></a>
    </span>      
<%              }             %> 
</span>
</div> 

 <div class="main_nav"> 
        <div class="sub_menu">
            <div>Gestione Database</div>
            <table>
                <TR><td><a href="viewPage.jsp?id=utenti">  Utenti</a></td></tr>
                <TR><td><a href="viewPage.jsp?id=ordini">  Ordini</a></td></TR>
                <tr><td><a href="viewPage.jsp?id=articoli">Articoli</a></td></TR>
                <TR><td><a href="viewPage.jsp?id=categorie">Categorie</a></td></TR>
                <TR><td><a href="viewPage.jsp?id=marche">Marche</a></td></TR>
            
            <td colspan="3">
                <form  name="logoutForm" action="index.jsp" method="post">
                <center>    <input type="hidden" name="status" value="logout"/>  </center>
                </form>
                 <a href="javascript:logoutForm.submit()">Logout</a>
            </td>
            </table>
        </div>
    </div>

<!------------------------------------------- CONTENUTO CENTRALE PAGINA--------------------------------------------------------->
   
    <div class="content">
        <br><br>     
<%  if( res>0 )    {%> 
    <table border="0" width="500px">
        <tr><td align="center"><h1>Articolo inserito con successo!</h1></td></tr><br>
    </table>
    </div>
<%      }   %>

    </div>
</div>
</body>