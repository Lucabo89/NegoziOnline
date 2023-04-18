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
     Cookie[] cookies = request.getCookies();
  boolean loggato=false;
  int i;
  String status=null;
  String mail;
  Boolean admin=false;
  status = request.getParameter("status");
  boolean inserito=false, giapresente=false, errore=false;
  
    Carrello cart = (Carrello) session.getAttribute("cart");
    Item[] items = cart.getItems();

  
  try{
      String mailLoggato = cookies[1].getValue();
      if (mailLoggato!=null){
          loggato = true;}
  }catch(Exception e){
      System.out.println("Catchata l'eccezione! Vuol dire che c'è il cookies JSESSION ma non è loggato nessuno!!");
      loggato = false;}
  
  if (status==null){
      status="view";
      System.out.println("---------------------------------------Siamo dello status: "+status);
      if(loggato){
        System.out.println("dentro all'if loggato status "+ status);
        mail = cookies[1].getValue();
        System.out.println("La mail è "+mail);
        Utente u = GestioneUtente.getUtente_byMail(mail);
        if(u.getType().equals("1")){
              admin=true;}
      }
  }

  if (status.equals("login")){
      System.out.println("---------------------------------------Siamo dello status: "+status);
      mail = request.getParameter("mail");
      String pass = request.getParameter("password");
      System.out.println("Parametri login:");
      System.out.println(mail);
      System.out.println(pass);
      GestioneLogin.Login(mail, pass);
      if(GestioneLogin.getCookies()!=null)
      {
          for(i=0; i<GestioneLogin.getCookies().length; i++){
              System.out.println("response.addCookie(GestLog.getCookies("+i+" )");
              response.addCookie(GestioneLogin.getCookies(i));
              System.out.println(i);
              System.out.println(GestioneLogin.getCookies(i).getValue());
          }
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
  
  if(status.equals("reg")){
    System.out.println("siamo nello status"+status);
    System.out.println("stampo parametri registrazione.jsp");
    
    String nome =    request.getParameter("nome");
    String cognome = request.getParameter("cognome");
    String email =   request.getParameter("email");
    String password= request.getParameter("password1");

    System.out.println(nome);
    System.out.println(cognome);
    System.out.println(email);
    
    Utente u = new Utente(nome,cognome,email,password,"0");
    
    int result = GestioneUtente.Inserisci_Utente(u);
    
    if(result>0)  {     System.out.println(result); inserito=true;  out.println("vai alla home"); }
    if(result==-1){     giapresente=true;}
    if(result==0) {     errore=true;     }
  }
%>



<html>
    <head>
            <link rel="stylesheet" type="text/css" media="screen" href="style.css" />
            <!--<meta http-equiv="refresh"  content="5;URL=index.jsp">-->

            
        <title>Registrazione</title>
         <script language="javascript">
                     function isEmpty(value) {
                            if (value == null || value.length == 0)
                            return true;
                            for (var count = 0; count < value.length; count++) {
                            if (value.charAt(count) != " ") return false;
                            }
                            return true;
                        }  
                    function isValidEmail(s) {
                             if (s.indexOf("@") > 0 && (s.indexOf("@") < (s.length - 1) ) ) return true;
                                 return false;
                        } 
                    function isNumber(n){
                             if ((isNaN(n)) ||(n == "undefined")){ return false;}
                                 else {return true;}
                            }
 
                    function registrazione() {
                             if (isEmpty(registrazione_form.nome.value)) {
                            alert("Inserire un nome.");
                            return false;
                            }     
                             if (isEmpty(registrazione_form.cognome.value)) {
                            alert("Inserire un cognome.");
                            return false;
                            }
                              if (isEmpty(registrazione_form.email.value)|| !isValidEmail(registrazione_form.email.value)) {
                            alert("Inserire una email valida.");
                            return false;
                            }
                              if (isEmpty(registrazione_form.password1.value)) {
                            alert("Inserire una password valida: almeno 6 caratteri.");
                            return false;
                            }
                              if (isEmpty(registrazione_form.password2.value)) {
                            alert("Inserire una password valida: almeno 6 caratteri.");
                            return false;
                            }
                            if(registrazione_form.password1.value!=registrazione_form.password2.value){
                                alert("Errore: le due password devono corrispondere");
                                return false}

                            registrazione_form.submit();
                        }
                       
         </script>
    </head>
    
    
    
    
    
<body>
    <div class="container">	
        <div class="header">
            <span><a href="index.jsp"><img src="images/BonnyShop.png"></a></span>
        </div>		          
<!-------------------------------------------------------------BARRA ORIZZONTALE MARCHE -------------------------------------------------------------------->
<div id="navigation">
 <span  class="menu">   
<%
            Vector<Marca> elencoMarc = GestioneMarca.getMarcheTab();
            int g, h = elencoMarc.size();
                for( g=0; g<h; g++ )
                {    
%> 
    <span class="alt"><a href="ricerca.jsp?tipoRicerca=marc&idRicerca=<%= elencoMarc.elementAt(g).getMarc_id()%> ">
                            <%=elencoMarc.elementAt(g).getMarc_brand()%></a>
    </span> 
<%              }             %> 
 </span>       
</div>
    
    
    
 

<!-------------------------------------------------------- MENU LATERALE SINISTRO --------------------------------------------------------->
<div class="main_nav">
<div class="sub_menu"><!-------------------  CHECK LOGIN ------------------->
        <div>Effettua Login</div>
<%        if(loggato && !admin){                   %>
<form name="logoutForm" action="index.jsp" method="post">

        Bentornato <%= Sessione.getUserName(cookies)%>
        <a href="areaPersonale.jsp">Ordini effettuati</a>
            <input type="hidden" name="status" value="logout"/>        
        <a href="javascript:logoutForm.submit()">Logout</a>
</form>
<%}%>
            
<%     if(loggato && admin ){                   %>
        <table border="0">
            <tr><td colspan="3">Bentornato Admin </td></tr>
            <tr><td colspan="3"><%= Sessione.getUserName(cookies)%> </td> </tr>
            <!--<tr><td colspan="3">Accedi Area Amministrativa:</td></tr>-->
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
</div><!-------------------------------------------------------------- fine CHECK LOGIN -------------------------------------------------------------->
     <br>
    <br>
    <%      if(!loggato){                             %>
<div class="sub_menu">
    <table>
        <tr><td colspan="2"><a href="registrazioneUtente.jsp">Registrati</a></td></tr>
    </table>
</div>        <%}%>
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
    </div><!------------------------------------------------- fine  ELENCO CATEGORIE --------------------------------------------------------->            
</div>







<% if(inserito==false)
{
    

    %>
<!------------------------------------------- CONTENUTO CENTRALE PAGINA--------------------------------------------------------->
<div class="content"><br>
        <form name="registrazione_form" action="registrazione.jsp" method="get" >
            <table border="0"  align="left">
                <tr><td colspan="2" align="center"><h2>Inserisci dati personali:</h2></td></tr>
                
                <tr><td width="100" align="center" > <input type="text" name="nome" size="20"  placeholder="Nome" maxlength="50"></td>
                <tr><td width="100" align="center"><input type="text" name="cognome" size="20" placeholder="Cognome" maxlength="50"></td>
                <tr><td width="100" align="center"><input type="text" name="email" size="20" placeholder="Email" maxlength="50"></td>
                <tr><td width="100" align="center"><input type="password" name="password1" placeholder="Password" size="20" maxlength="50"></td>
                <tr><td width="100" align="center"><input type="password" name="password2" placeholder="Ripeti Password" size="20" maxlength="50"></td>
                <tr><td><br></td></tr>
                
                <tr><td align="center"><input align="center" type="button" value="Registrati" onclick="registrazione()"></td></tr>  
                </table>
                    <input type="hidden" name="status" value="reg"/>
        </form>     
    </div>
<%  }      %>



<% if( inserito==true ){  %>
      <div class="content">
          <table align="left"><tr><td><h1>Registrazione avvenuta con successo!</h1></td></tr>
                 <tr><td>Loggati per effettuare acquisti!!</td></tr>
          </table>
          
      </div>
<%  }    %>


    </div>
</div>
</body>