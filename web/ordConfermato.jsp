<%-- 
    Document   : c
    Created on : Jan 10, 2017, 11:21:36 AM
    Author     : bonny
--%>

<%@ page info="Home Page" %>
<%@ page contentType="text/html" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="sessione.*" %>
<%@ page import="blogics.*" %>
<%@ page import="db.*" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Date" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- <meta http-equiv="refresh" content="4; URL=http://localhost:8080/NegoziOnline/index.jsp"> -->
        <meta http-equiv="refresh" content="4; URL=http://localhost:38998/NegoziOnline/index.jsp">
        <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
        <title>Ordine Confermato</title>
    </head>    
<body>           
<% 
    Cookie[] cookies = request.getCookies();
    Date d = new Date();
    String art_id = request.getParameter("art_id");
    Articolo a = GestioneArticolo.getArticolo_byId(art_id);
    System.out.println(a.getArt_nome());
    Carrello cart = (Carrello) session.getAttribute("cart");
    Item[] items = cart.getItems();
    
// CREO OGGETTO ORDINE DA DARE AL METODO aggiungiOrdine( ornine ) 
    String ord_id = "null"; 
    String data = GestioneOrdine.getDate() ;
    String utente_id = cookies[1].getValue();
    String citta  = request.getParameter("city");
    String via    = request.getParameter("via");
    String civico = request.getParameter("civico");
    String pagamento  = request.getParameter("pagamento");
    String stato  = "Fermo";
    System.out.println("-------------->Stampo articoli nel carrello:");
    System.out.println(ord_id);    System.out.println(data);   System.out.println(utente_id);  System.out.println(citta);    
    System.out.println(via);       System.out.println(civico); System.out.println(pagamento);  System.out.println(stato);
    int res2= 0;    
    
//------------ CREO L ORDINE E LO AGGIUNGO AL DB
    Ordine o = new Ordine(ord_id, data, utente_id, citta, via, civico, pagamento, stato);
    int res = GestioneOrdine.aggiungiOrdine( o );
    if(res>0){System.out.println( "ordConfermato: creato oggetto ordine ed aggiunto al database" );}
    
//    ADESSO CICLO FOR PER INSERIRE TUTTI I DETTAGLI IN TABELLA
    System.out.println( "ordConfermato: -------------------> Devo inserire tutti i dettagli adesso ---------" );
    int num = items.length;
    System.out.println( "ordConfermato: Devo inserire n. "+num+"righe in tabella" );
    System.out.println( "-------------------------------------------" );    
    System.out.println( "-------------------------------------------" );    

    for(int k=0; k<num; k++){
        res2 = GestioneOrdine.aggiungiDettaglio( items[k] );
        if(res2 >0){
            System.out.println( "Inserita riga n."+k  );
            System.out.println( "ArtId:  "+items[k].getItem_id() );
            System.out.println( "Prezzo= "+items[k].getItem_prezzo())  ;
            System.out.println( "QTY=    "+items[k].getItem_qty());
        
        }
        if(res2<0){ System.out.println( "FALLITO INSERIMENTO RIGA n."+k); break; }
    }
    
    System.out.println( "Inseriti tutti i dettagli!" );
    
    if(res>0 && res2>0){
        out.println("DEVI SVUOTARE IL CARRELLO!!!");
        cart.svuotaCarrello();         
    }
    
    %>

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
    </div>
</div>
    
    
    
    <div class="content">
    <table border="0" width="700">
        <tr><td align="center"><h1>Ordine effettuato con successo!</h1></td></tr><br>
    <tr><td align="center"><h2>Verrai reinidrezzato alla Home fra pochi istanti</h2></td></tr><br><br>
        <tr><td align="center"><h1>Grazie e Arrivederci!</h1></td></tr>
    </table>
    </div>
    
    </div>
    </body>
</html>
