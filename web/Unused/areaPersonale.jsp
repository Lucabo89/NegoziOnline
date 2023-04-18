<%-- 
    Document   : areaPersonale
    Created on : Jan 1, 2017, 10:54:02 AM
    Author     : bonny
--%>
<%@ page info="Home Page" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>  
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="sessione.Sessione" %>

<%@ page import="blogics.*" %>
<%@ page import="bflows.*" %>

<!DOCTYPE html>
<%
  Cookie[] cookies = request.getCookies(); 
  Boolean loggato  = (cookies!=null);
  String status=request.getParameter("status");
  int i;
  
  System.out.println("Cookie presenti:" + cookies.length);
  for (i=0;i< cookies.length;i++)
  System.out.println("Nome" + cookies[i].getName() + " Valore:" +cookies[i].getValue());
  
  String usermail =  cookies[0].getName();
  Utente ut = GestioneUtente.getUtente_byMail(usermail);
  
  
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <h1>Elenco ordini di: <%= Sessione.getUserMail(cookies) %>  </h1>
        <h1>il Cliente ha effettuato: <%= GestioneOrdine.contaOrdini_byUtenteMail(Sessione.getUserMail(cookies)) %> ordini</h1>

        <table border="1">
                        
         <% 
           String[] arrayOrd = GestioneOrdine.getCodiciOrdini_byUtenteMail(Sessione.getUserMail(cookies));
           
           int numOrd = arrayOrd.length;
           int co=0;
           
           for(int k=0; k<numOrd; k++){
               String cod = arrayOrd[k];
                System.out.println("Cod. ordine n."+k+": "+cod);
                
                Ordine ord = GestioneOrdine.getOrdine_byId(cod); 
                
         %>
            <tr>
                <td>Ord.Id <%= ord.getOrd_id() %>    </td>
                <td>del    <%= ord.getOrd_data() %>  </td>
                <td>Stato: <%= ord.getOrd_stato() %> </td>            
            </tr>
            
            
            <% //ciclio for interno che mi stampa le righe dettagli di ogni ordine!!
               out.println("nome descrizione prezzo quantità");
               out.println("totale=   ");
                    
            %>
            
            <tr>
                <td colspan="3">qua in mezzo ci vogliono tutti i dettagli!!!</td>
            </tr>

                <% } %>
            <% }  %> 
            <tr>
                <td colspan="2">Totale: </td>
                <td>12345</td>
            </tr>
            </table>
            
            

    </body>
</html>
