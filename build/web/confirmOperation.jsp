<%-- 
    Document   : deleteUtente
    Created on : Jan 10, 2017, 11:26:56 AM
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


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete User</title>
    </head>
    <body>    
<% 
    System.out.println("--------------Pagina confirmOperatin.jsp");
    String operazione = request.getParameter("operazione");
    //----------IN REALTà QUESTA PAGINA POTREBBE INGLOBARE TUTTTE LE OPERAZIONI 
    //POSSIBILI DA FARE SU UTENTI, ARTICOLI ECC ECC....
    //BASTA SOLO RICHIEDERE L'OPERAZIONE E, A SECONDA DI QUALE SIA, RISPONDERE COME SI DEVE 
%>
        
<%    
    String ut = request.getParameter("utente");
    Utente userToEdit= GestioneUtente.getUtente_byID(ut);        
       
    if(operazione.equals("cancella"))
    {
        System.out.println("---siamo dentro a if(operatione = cancella)");
        int result = GestioneUtente.Elimina_Utente(userToEdit);
        System.out.println("----siamo dopo query EliminaUtente");    
        if(result>0){
            System.out.println("Utente cancellato con successo");
        if(result<0){
            System.out.println("Utente cancellato con successo");}
    }

    if(operazione.equals("modifica")){ 
%>
    <form action="modifyExec.jsp" method="get">
        <table border="1">
            <tr><td colspan="2"> Modifica utente: </td></tr>
            <tr><td>Nome</td><td><input type="text" name="nuovoNome" value="<%=userToEdit.getNome()%>" ></td></tr>                   
            <tr><td>Cognome</td><td><input type="text" name="nuovoCognome" value="<%=userToEdit.getCognome()%>" ></td></tr>
            <tr><td>Email</td><td><input type="text" name="nuovoEmail" value="<%=userToEdit.getEmail()%>" ></td></tr>        
        </table>      

        <input type="submit" value="Conferma">
        <input type="hidden" name="utente_id" value="<%=userToEdit.getId()%>">
        
    </form>
<% } %>
    
    

         
    </body>
</html>
