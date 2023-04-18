<%-- 
    Document   : editUtente
    Created on : Jan 10, 2017, 12:05:37 PM
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


<html>
    <head>
        <title>Elenco Ordini </title>
    </head>
   
    <body>
        <h1>Elenco Dettagli</h1>
        <table border="1">
            <tr  >    <td>Art.Id</td> <td>Descrizione</td> <td>Prezzo euro/cad</td><td>Quantità</td> <td>Parziali   </td></tr>
<%
//--------------------SECONDO CICLIO FOR CHE, PER OGNI ORDINE, MI VISUALIZZA TUTII I DETTAGLI  
                    String ord_id=request.getParameter("cod_ord");
                    
                    System.out.println("Codice ordine: "+ord_id);
                    Vector<Item> dettagli = GestioneOrdine.getDettagliTab_byOrdId(ord_id);
                    int numDett = dettagli.size();
                    int d, totale=0;               
                    for( d=0; d<numDett; d++){
                        System.out.println("---------ciclio for dettagliXordine");
                        int prezzo = Integer.parseInt(dettagli.elementAt(d).getItem_prezzo());
                        int qty    = Integer.parseInt(dettagli.elementAt(d).getItem_qty() );
                        
                        Articolo a = GestioneArticolo.getArticolo_byId(dettagli.elementAt(d).getItem_id());
%>
                    
                    <tr>
                    <td><%= dettagli.elementAt(d).getItem_id() %></td>
                    <td><%= a.getArt_nome() %></td>
                    <td><%= dettagli.elementAt(d).getItem_prezzo() %></td>
                    <td><%= dettagli.elementAt(d).getItem_qty() %></td>
                    <td><%= prezzo*qty %></td>
                    </tr>    
                <%       totale = totale+(prezzo*qty);  
                    
    }   %>
                <tr><td colspan="4">Totale ordine: </td><td><%= totale %></td></tr>
        </table>
    </body>
</html>
