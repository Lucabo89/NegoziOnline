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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Area Amministatore</title>
        <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
    </head>
    
    <body>
        <div class="container">			   
<!-------------------------------- TESTATA ------------------------------------>
            <div class="header">
            <table><tr>
                <td>    
                    <span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span>
                </td>
                <td width="10%"></td></tr>
            </table>
            </div>			
<!-------------------------------- TESTATA ------------------------------------>
    <div class="main_nav"> 
        <div class="sub_menu">
            <div>GESTISCI DATABASE</div>
            <table>
                <TR><td><a href="viewPage.jsp?id=utenti">  Utenti</a></td></tr>
                <TR><td><a href="viewPage.jsp?id=ordini">  Ordini</a></td></TR>
                <tr><td><a href="viewPage.jsp?id=articoli">Articoli</a></td></TR>
                <TR><td><a href="viewPage.jsp?id=articoli">Categorie</a></td></TR>
                <TR><td><a href="viewPage.jsp?id=articoli">Marche</a></td></TR>
            </table>
        </div>
    </div>
        





    <div class="content">
<%  System.out.println("--------------Pagina confirmArtOperatin.jsp");
    
    String ut = request.getParameter("articolo");
    Articolo artToEdit = GestioneArticolo.getArticolo_byId(ut);
    
    String operazione = request.getParameter("operazione");
    
    if(operazione.equals("cancella")){

        int result = GestioneArticolo.Elimina_Articolo(ut );
        
        if(result>0){
            System.out.println("Articolo cancellato con successo");
            out.println("Articolo cancellato con successo");}
        if(result<0){
            System.out.println("Articolo cancellato con successo");
            out.println("Articolo cancellato con successo");
        }
    }
%>
    
    
    
<%  
    if(operazione.equals("modifica")){ 
%>
    <form action="modifyArtExec.jsp" method="get">
        <table border="0">
            <tr><td colspan="2"> <h2>Modifica articolo </h2></td></tr>
            <tr><td>Nome        </td><td><input type="text" name="nuovoNome" value="<%=artToEdit.getArt_nome()%>" ></td></tr>                   
            <tr><td>Descrizione </td><td><input type="text" size="70" name="nuovoDesc" value="<%=artToEdit.getArt_desc()%>" ></td></tr>
            <tr><td>Prezzo      </td><td><input type="text" name="nuovoPrezzo" value="<%= artToEdit.getArt_prezzo() %>" ></td></tr>        
            <tr><td>Marca       </td><td><input type="text" name="nuovoMarca"    value="<%= artToEdit.getArt_marca() %>" ></td></tr>        
            <tr><td>Categoria   </td><td><input type="text" name="nuovoCategoria" value="<%= artToEdit.getArt_categ() %>" ></td></tr>        
        </table>      

        <input type="submit" value="Conferma">
        <input type="hidden" name="art_id" value="<%= artToEdit.getArt_id() %>">
    </form>
<% } %> 
    </div>  
    </body>  
</html>
