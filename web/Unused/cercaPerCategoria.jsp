<%@ page info="Home Page" contentType="text/html" session="false" buffer="30kb" errorPage="/ErrorPage.jsp"%>
<%@ page import="blogics.*" %>
<%@ page import="db.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ricerca per Categoria</title>
    </head>
    

    <body>
        <form name="cercaCategoria" action="cercaPerCategoria.jsp" method="get">
        <table align="left">
            <tr><td colspan="3" align="center"><h1>Ricerca per categoria</h1></td></tr>
            <tr>
                <td>
                    
                <%
                String[] array = GestioneCategoria.getCodici();
                int k;
                int dim = array.length;
                for(k=0; k<dim; k++){
                String cod = array[k];
                Categoria cat = GestioneCategoria.getCategoria_byCod(cod);
                out.print("<tr>"
                        + "<td ><input type=radio value="+ cat.getCat_id()+ " name = category/>"+ cat.getCat_nome()+"<td>"
                        + "</tr>");}
                %> 
                    
                </td>
                
                <td><input type="text" name="prodotto"  size="20"></td>
                <td><input type="button" name="vai" value="Cerca"></td>
            </tr>
        </table>
                    <input type="hidden" name="status" value="ricerca">
        </form>

    </body>
</html>
