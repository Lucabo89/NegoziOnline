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
                <table>
            <tr>
                <td><span>Area Amministrativa</span></td>
                <td width="10%"></td>
            </tr>
            </table>
            </div>			
<!-------------------------------- TESTATA ------------------------------------>



<div class="main_nav"> 
        <div class="sub_menu">
            <div>Gestione Database</div>
            <table>
                <TR><td><a href="viewPage.jsp?id=utenti">  Utenti</a></td></tr>
                <TR><td><a href="viewPage.jsp?id=ordini">  Ordini</a></td></TR>
                <tr><td><a href="viewPage.jsp?id=articoli">Articoli</a></td></TR>
                <TR><td><a href="viewPage.jsp?id=categorie">Categorie</a></td></TR>
                <!--<TR><td><a href="viewPage.jsp?id=articoli">Marche</a></td></TR>-->
           
             <td colspan="3">
                <form  name="logoutForm" action="index.jsp" method="post">
                <center>    <input type="hidden" name="status" value="logout"/>  </center>
                </form>
             <a href="javascript:logoutForm.submit()">Logout</a>
            </td>
            
            
            </table>
        </div>
    </div>



<!---------------------- INTERCETTO L'AZIONE DA FARE ---------------------------->
<%    String edit = request.getParameter("id");%>
<!---------------------- INTERCETTO L'AZIONE DA FARE ---------------------------->



<!--CONTENITORE RISULTATI SINISTRO-->
<div class="content">

    
<!---------------------- SE L'AZIONE RIGUARDA L'UTENTE: ---------------------------->
<%  
    if(edit.equals("utente")){
        String ut_id= request.getParameter("utenteId");
        Utente u = GestioneUtente.getUtente_byID(ut_id);
        System.out.println("----------editPage---->areaUtente: "+u.getEmail());
%>        

<h2>Pagina personale di:  <%= u.getNome() %> <%= u.getCognome()%> </h2>

<!-------------------------- tabella dati personali ------------------------->
        <form action="confirmUtenteOperation.jsp" method="get">
            <table align="left" border="0" width="300px">
            <tr><td colspan="2"><h1>Dati Personali</h1></td></tr>
            <tr><td width="100px">Nome</td><td><%= u.getNome() %></td></tr>
            <tr><td width="100px">Cognome</td><td><%= u.getCognome() %></td></tr>
            <tr><td width="100px">Email</td><td><%= u.getEmail() %></td></tr>
            <tr>
                <td><input type="radio" name="operazione" value="cancella">Cancella</td>
                <!--<td><input type="radio" name="operazione" value="modifica">Modifica</td>-->
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Effettua operazione"></td></tr>
            </table>
            <input type="hidden" name="utente" value="<%=ut_id %>">
        </form>
<!------------------------- fine tabella dati personali---------------------->
<BR><BR>
<BR><BR>

<!----------------- tabella ordini utente ------------------------------------>
<table border=0 align="left" >
    <tr><td colspan="3" ><h1>Ordini effetuati:</h1></td></tr>
            <tr><td>Ord. ID</td><td>Effettuato il </td><td>Stato</td></tr>
            
<%          Vector<Ordine> ordini = GestioneOrdine.getOrdiniTab_byUtenteId( ut_id );
            int ordNum = ordini.size();
            int o;
//------------------PRIMO CICLIO FOR PER SCROLLARE TUTTI GLI ORDINI
            for( o=0; o<ordNum; o++ ){                    
%>
        <tr><td> <%=ordini.elementAt(o).getOrd_id()%> </td>
            <td> <%=ordini.elementAt(o).getOrd_data() %></td>
            <td> <%=ordini.elementAt(o).getOrd_stato() %></td></tr>    
<%          }%>
</table>
<!----------------- fine tabella ordini utente ----------------------->


    
            
            
<%  } //if(id.equals(edit articolo)
    if(edit.equals("articolo")){
        String artId= request.getParameter("artId");
        Articolo a = GestioneArticolo.getArticolo_byId(artId);
        System.out.println("----------editPage--->areaArticolo: "+a.getArt_nome());
%>
    <form action="confirmArtOperation.jsp" method="get">
        <table align="left" border="1">
            <tr><td>Nome</td><td><%=    a.getArt_nome()    %></td></tr>
            <tr><td>Descrizione</td><td><%= a.getArt_desc() %></td></tr>
            <tr><td>Prezzo</td><td><%=   a.getArt_prezzo() %></td></tr>
            <tr><td><input type="radio" name="operazione" value="cancella">Cancella</td>
                <td><input type="radio" name="operazione" value="modifica">Modifica</td></tr>
            <tr><td colspan="2"><input type="submit" value="Effettua operazione"></td></tr>
        </table>
            <input type="hidden" name="articolo" value="<%=artId %>">
    </form>
<% }  %>    

</div>

        </div>
    </body>
</html>
