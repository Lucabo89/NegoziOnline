<%@ page info="Home Page" %> 
<%@ page contentType="text/html" %>
<%@ page buffer="30kb" %>
<%@ page session="true" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="sessione.*" %>
<%@ page import="blogics.*" %>
<%@ page import="db.*" %>
<%@ page import="java.util.Vector" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">


<jsp:useBean id="GestioneLogin" scope="request" class="bflows.GestioneLogin" />
<jsp:setProperty name="GestioneLogin" property="*" />

<jsp:useBean id="cart" scope= "session" class="sessione.Carrello" />
<jsp:setProperty name="cart" property="*" />
    


<%
  Cookie[] cookies = request.getCookies();
  boolean loggato=false;
  int i;
  String status=null;
  String mail;
  Boolean admin = false;
  status = request.getParameter("status");
  
  try{
      String mailLoggato = cookies[1].getValue();
      if (mailLoggato!=null){
          loggato = true;}
  }catch(Exception e){
      loggato = false;}
  
  if (status==null){
      status="view";
      System.out.println("------------------------Siamo dello status: "+status);
      System.out.println("prima di  if(loggato)");

      if(loggato){
        System.out.println("MAIL = cookies[l].getValue()");
        System.out.println("dentro all'if loggato status "+ status);
        mail = cookies[1].getValue();
        System.out.println("La mail è "+mail);
        Utente u = GestioneUtente.getUtente_byMail(mail); 
        if(u.getType().equals("1")){
              admin=true;}
      }      
      System.out.println("dopo  if(loggato)");      
  }

  if (status.equals("login")){
      System.out.println("------------------------Siamo dello status: "+status);
      
      mail = request.getParameter("mail");
      String pass = request.getParameter("password");
      System.out.println("Parametri login:");
            System.out.println("STAMPO PARAMETRI");
      System.out.println(mail);
      System.out.println(pass);
      GestioneLogin.Login(mail, pass);
      if(GestioneLogin.getCookies()!=null)
      {
          for(i=0; i<GestioneLogin.getCookies().length; i++){
              System.out.println("response.addCookie(GestLog.getCookies("+i+" )");
              response.addCookie(GestioneLogin.getCookies(i));
              System.out.println(i);
              System.out.println(GestioneLogin.getCookies(i).getValue());}
          
      cookies=GestioneLogin.getCookies();
      System.out.println("Fuori ciclio for prima di loggato=true");
//GUARDO SE SI è LOGGATO UN AMMINISTRATORE CHE NEL CASO CAMBIA 
      Utente u = GestioneUtente.getUtente_byMail(mail);
      if(u.getType().equals("1")){
          admin=true;}
      loggato=true; 
    }
  }
    
  if (status.equals("logout")){
    if (loggato){
        GestioneLogin.setCookies(cookies);
        GestioneLogin.Logout();
        for(i=0; i<GestioneLogin.getCookies().length; i++)
            response.addCookie( GestioneLogin.getCookies(i) );
        loggato=false;
        cart.svuotaCarrello();
    } 
  }
  
%>



<html>
    <head><title>NegoziOnline</title><!------------- INIZIO HEAD ----------------------->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
    <script language="JavaScript">     
            function submitLogin()            
            {
                if (isEmpty(loginForm.mail.value)){
                    alert("Inserisci la tua e-mail."); 
                    return false;}  
                if (isEmpty(loginForm.password.value)){
                    alert("Inserire una password valida: almeno 6 caratteri.");
                    return false;}      
                loginForm.submit();
            }
            function isEmpty(value){
                if (value === null || value.length === 0) return true;
                for (var count = 0; count < value.length; count++) {
                    if (value.charAt(count) !== " ") return false;}
            return true;}
    </script>
  </head>
  
  
  
  
<body>
  <div class="container">	     
<!------------------------------- Begin Header --------------------------------->
<div class="header">
    <span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span>
</div>		
        
        
        
<!------------------------- BARRA ORIZZONTALE MARCHE ----------------------->
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


<!-------------------------- MENU LATERALE SINISTRO ---------------------------->
<div class="main_nav">
<div class="sub_menu"><!-------------------  CHECK LOGIN ------------------->
        <div>Effettua Login</div>
<%        if(loggato && !admin){                   %>
<form name="logoutForm" action="index.jsp" method="post">

         Bentornato <%= Sessione.getUserName(cookies)   %>
        
        <%
         
            String id = GestioneUtente.idFromMail( Sessione.getUserMail(cookies));
            System.out.println(id);
        
        %>
        
        <a href="carrelloNow.jsp?id=utente&utenteId=<%=id  %>.jsp">Carrello</a>
            <input type="hidden" name="status" value="logout"/>        
        <a href="javascript:logoutForm.submit()">Logout</a>
</form>
<%}%>
            
<%     if(loggato && admin ){                   %>
        <table border="0">
            <tr><td colspan="3">Bentornato Admin: </td></tr>
            <tr><td colspan="3"><%= Sessione.getUserName(cookies)%> </td> </tr>
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
</div>
    <br>
    <br>
    <%      if(!loggato){                             %>
<div class="sub_menu">
    <table>
        <tr><td colspan="2"><a href="registrazione.jsp">Registrati</a></td></tr>
    </table>
</div><%}%>
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










<!-------------- CONTENT --------------------------->
<div class="content">
<!------------- form ricerca avanzata  ------------>
<form action="ricerca.jsp" > 
<table border="0" align="" width="100px">
    <tr><td>        
            <select name="cat">
<%
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
                int d=0;  
                for( d=0; d<c; d++ ){ 
%>
                <option value=<%= marcList.elementAt(d).getMarc_id()%>> <%= marcList.elementAt(d).getMarc_brand()  %> </option>
            <%  }  %>                   
            </select>
        </td>
        <td><input type="text" name="artParola" placeholder="Search"></td>
        <td><input type="submit" class="button2" value="Ricerca Avanzata"></td>
    </tr> 
    </table>
    <input type="hidden" name="tipoRicerca" value="RicercaAvanzata"/>     
</form> 



<br><br><br><br>

    
    
    <table border="0"  width="700px"> 
 <% 
       String[] array = GestioneArticolo.getFirstTen();
        int k;
        for(k=0; k <5; k++){
                String cod = array[k];
                Articolo art = GestioneArticolo.getArticolo_byId(cod);
%>                      
            <tr>
                <td>
                    
                    
                    <table border="0" width="170px" height="140px"  >                         
                            <tr><td align=center><%=art.getArt_nome()%></td></tr>
                            <tr><td align=center width=50px height=50px>
                                <img  src="images/<%=art.getArt_categ()%>.jpg"> </td></tr> 
                            <tr><td align=center>Prezzo: <%=art.getArt_prezzo()%> e</td></tr>
                    </table>
                    
                    
<!--                    
                       + "<table border=0 width=170px height=140px>"
                            + "<tr><td align=center>"+artResult.elementAt(q).getArt_nome()+"</td></tr>"
                            + "<tr><td align=center width=50px height=50px><img src=images/"+artResult.elementAt(q).getArt_categ()+".jpg></td></tr>"
                            + "<tr><td align=center>Prezzo:   "+artResult.elementAt(q).getArt_prezzo()+" </td></tr>"
                        + "</table>"                              
                        -->
                    
                    
                    
                   </td>
<%              if(loggato){
                    //se uno è loggato, la Descrizione diventa un link per aggiungerlo al carrello!!
                out.println("<td><a href=articol.jsp?"
                        + "art_id="+art.getArt_id()
                        + "&art_prezzo="+art.getArt_prezzo()
                        + ">"+art.getArt_desc()+ "</a></td>"
                        + "</tr>" );
                }else{
                out.println("<td>"+art.getArt_desc()+"</td>");
                }
    }
%>


</table>
</div><!--content-->
</div>
</body>
</html>
