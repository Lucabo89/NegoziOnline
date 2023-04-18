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
            <div class="header">
                <span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span><br>
                <table>
                    <tr><td><span>Area Amministrativa</span></td><td width="10%"></td></tr>
                </table>
            </div>			
                     
<!------------adesso leggo l'id arrivato dalla Request e vedo che operazione devo fare---------->
<%
        String id = request.getParameter("id");
        System.out.println("Id arrivato:"+id);
%>
    <div class="main_nav"> 
        <div class="sub_menu">
            <div>Gestione Database</div>
            <table>
                <TR><td><a href="viewPage.jsp?id=utenti">  Utenti</a></td></tr>
                <TR><td><a href="viewPage.jsp?id=ordini">  Ordini</a></td></TR>
                <tr><td><a href="viewPage.jsp?id=articoli">Articoli</a></td></TR>
                <TR><td><a href="viewPage.jsp?id=categorie">Categorie</a></td></TR>
<!--                <TR><td><a href="viewPage.jsp?id=marche">Marche</a></td></TR>-->
            
             <td colspan="3">
                <form  name="logoutForm" action="index.jsp" method="post">
                <center>    <input type="hidden" name="status" value="logout"/>  </center>
                </form>
                 <a href="javascript:logoutForm.submit()">Logout</a>
            </td>
            </table>
        </div>
    </div>
    
    
    
    


<div class="content">
    <!----------------------- IF ID = UTENTI: VISUALIZZO TUTTI GLI UTENTI -------------------->
<%      if(id.equals("utenti")){        %>
        <table  border=0 width=600px  align="left">
            <tr><td colspan="3" align="left">
                <div><h2>Elenco Utenti</h2></div>
                </td>
            </tr>
 <%   
                    System.out.println("Stampo Elenco utenti");
                    Vector<Utente> utentiList = GestioneUtente.getUtentiTab();
                    int uNum = utentiList.size();
                    int primiCinque=0; 
                    
                    for(int d=0; d<uNum; d++ ){ 
%>

            <td><a href="editPage.jsp?id=utente&utenteId=<%=utentiList.elementAt(d).getId()%>" >
                     <%=utentiList.elementAt(d).getEmail()%></a></td></tr>

<%                  }%>
        </table>
<%}                  %>   
<!---------------- FINE   IF ID = UTENTI: VISUALIZZO TUTTI GLI UTENTI------------------>

        





        
<!---------------- IF ID = ORDINI: VISUALIZZO TUTTI GLI ORDINI------------------>
<%      if(id.equals("ordini")){        %>        
        <table border="0" width=600px  align="left">
             <tr><td colspan="3" align="left">
                 <div><h2>Elenco Ordini</h2></div>
                </td>
            </tr>
            <tr><td >Ord. ID:</td><td>del </td><td>Effettuato da: </td><td>Stato</td></tr>
<%              System.out.println("--------Stampo Elenco Ordini");                    
                Vector<Ordine> ordini = GestioneOrdine.getOrdiniTab();
                int ordNum = ordini.size();
                int o;
//------------------PRIMO CICLIO FOR PER SCROLLARE TUTTI GLI ORDINI
          for( o=0; o<ordNum; o++ ){
%>
            <tr>
            <td align="center">
                <a href="visualizzaDettagli.jsp?cod_ord=<%=ordini.elementAt(o).getOrd_id() %>"><%=ordini.elementAt(o).getOrd_id() %></a>
            </td>
            <td><%= ordini.elementAt(o).getOrd_data() %></td>
            <td><%= GestioneUtente.getUtente_byID(ordini.elementAt(o).getOrd_utetnte()).getEmail() %></td>
            
            <td><a href="spedizione.jsp?stato=<%=ordini.elementAt(o).getOrd_stato() %>&ord=<%=ordini.elementAt(o).getOrd_id() %>"> <%=ordini.elementAt(o).getOrd_stato() %> </a></td>
             </tr>    
<%          }    }    %>
        </table>
<!----------------fine IF ID = ORDINI: VISUALIZZO TUTTI GLI ORDINI------------------>




        
        
<!---------------- IF ID = CATEGORIE------------------>
<%       if(id.equals("categorie")){     %>
         <br>
<form action="insertCateg.jsp" method="get"> 

    <table border="0" width="300px">
        <tr><td colspan="2" ><h2>Inserisci nuova Categoria</h2></td></tr>  
        <tr><td><input type="text" placeholder="Nome categoria" name="nome_cat"></td>
            <td><input type="submit" value="Inserisci"></td>
        </tr>  
    </table>            
</form>
<br><br>
<br><br>         

<table border="0" width=600px  align="left">
             <tr><td colspan="4" align="left">
                 <div><h2>Elenco Categorie</h2></div>
                </td>
            </tr>
<%
            System.out.println("Stampo Elenco categorie");
            Vector<Categoria> catList = GestioneCategoria.getCategorieTab();
            int cNum = catList.size();
            int b=0;
            
            for( b=0; b<cNum; b++ ){
%>
        <tr>
        <td><%= catList.elementAt(b).getCat_id() %></td>
        <td><%=  catList.elementAt(b).getCat_nome()  %></td>
                

<%          }           %>   
        </table>
<%          }   %>
<!----------------------------- FINE IF ID = CATEGORIE ------------------------------->







        
        
        
        
<!----------------------------- IF ID = ARTICOLI: VISUALIZZO TUTTI GLI ARTICOLI ------------------------------->
<%       if(id.equals("articoli")){     %>
         <br>

<form action="insertArticol.jsp" method="get"> 
<table border="0" width="600px">
    <tr><td colspan="5" ><h2>Inserisci nuovo articolo</h2></td></tr>  

<tr><td><input type="text" placeholder="Nome articolo" name="nome_art"></td>
    <td><input type="text" placeholder="Prezzo" name="prezzo_art"></td>
    <td>
        <select name="cat">
<%
    System.out.println("viewPage: id=ARTICOLI ");
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
                int e=0;  
                for( e=0; e<c; e++ ){ 
%>
                <option value=<%= marcList.elementAt(e).getMarc_id()%>> <%= marcList.elementAt(e).getMarc_brand()  %> </option>
            <%  }  %>                   
            </select>
        </td>
</tr>
<tr><td colspan="5">
        <textarea name="desc_art" placeholder="Inserisci descrizione" cols="45" rows="2"></textarea>
    </td>    
</tr>
    <tr><td><input type="submit" value="Inserisci"></td></tr>  
</table>            
</form>
<br><br>
<br><br>         
<br><br>         
<br><br>         

<table border="0" width=500px  align="left">
             <tr><td colspan="4" align="left">
                 <div><h2>Elenco Articoli</h2></div>
                </td>
            </tr>
            <tr><td>ID</td><td align="center">Nome articolo</td><td>Prezzo</td><td align="right" >Rimanenze</td></tr><br>
<%
            System.out.println("Stampo Elenco Articoli");
            Vector<Articolo> artList = GestioneArticolo.getArticoliTab();
            int aNum = artList.size();
            int d=0;
            
            for( d=0; d<aNum; d++ ){
%>
        <tr>
        <td><%= artList.elementAt(d).getArt_id() %></td>
        <td align="center"><a href="editPage.jsp?id=articolo&artId=<%=artList.elementAt(d).getArt_id()%>" >
                <%=artList.elementAt(d).getArt_nome()%></a></td>
                <td><%= artList.elementAt(d).getArt_prezzo() %></td>
                
                <td align="right"><%= GestioneArticolo.getRimanenze_byId(artList.elementAt(d).getArt_id()) %></td>

<%          }           %>   
        </table>
<%          }   %>
<!---------------- IF ID = ARTICOLI: VISUALIZZO TUTTI GLI ARTICOLI------------------>






</div><!---------------------- fine CONTENT ------------------------------->
</div><!--------------------- fine CONTAINER ----------------->
</body>

</html>
