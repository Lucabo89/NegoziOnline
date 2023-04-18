package sessione;
import blogics.Utente;
import blogics.GestioneUtente;
import db.DataBase;
import java.sql.SQLException;
import java.util.Vector;
import javax.servlet.http.Cookie;

public class Sessione {
  public Sessione() {}
  
  //METODO RICHIAMATO IN GestioneLogin.Login(String mail, String psw) 
  public static Cookie[] createCookie(String usrMail) throws SQLException, ClassNotFoundException{
    //Crea un record cookie dove andrò a salvare il nome e la mail dell'utente
    Cookie[] cookies = new Cookie[2];
    
    System.out.println("Metodo Cookies[] createCookie(String MMMail)");
    System.out.println("creato cookies = new Cookie[2];");
    System.out.println("creato user= ...getUtente_bymail(MMMail)  ");
    Utente user = GestioneUtente.getUtente_byMail(usrMail);
         
    System.out.println("Creo un oggetto cookie con salvata l'email e lo mettorò"
            + "come primo record dell'array cookies[?], come secondo campo ");
    System.out.println("ci salverò un cookie=new Cookie(\"userNome\",user.getNome(),)");
    
    System.out.println("cookie0= new Cookie(utenteMail, user.getEmail()");
    System.out.println("cookies[0] = cookie0");
    
    Cookie cookie0=new Cookie("userMail", user.getEmail());
    cookies[0]=cookie0;
    
    Cookie cookie1=new Cookie("userNome",user.getNome()+" "+user.getCognome());
    cookies[1]=cookie1;
    
    for (int i=0; i<cookies.length; i++) {
      cookies[i].setPath("/");}
    
    return cookies;
  }
  
  public static String getValue(Cookie cookies[], String name, int position){
    int i;
    boolean found=false;
    String value=null;
    
    for (i=0;   i<cookies.length && !found;   i++)
      if (cookies[i].getName().equals(name)){
          
        Vector oV = util.Conversion.tokenizeString(cookies[i].getValue(),"#");
        value=(String)oV.elementAt(position);
        found=true;
       }
    return value;
  }
  
  public static String getUserMail(Cookie[] cookies) {
    return getValue(cookies, "userMail", 0);
  }
  
  public static String getUserName(Cookie[] cookies) {
    return getValue(cookies, "userNome", 0);
  }
      
  public static Cookie[] deleteCookie(Cookie[] cookies) {
    for (int i=0; i<cookies.length; i++) {
      cookies[i].setMaxAge(0);
      cookies[i].setPath("/");
    }
    return cookies;
  }  
  
  public static void showCookies(Cookie[] cookies){
    System.out.println("Cookie presenti:" + cookies.length);
        int i;
        for (i=0;i< cookies.length; i++)
            System.out.println("Nome: " + cookies[i].getName() + " Valore:" +cookies[i].getValue());}
    }

/*
import blogics.GestioneUtente;
import blogics.Utente;
import db.DataBase;
import java.sql.SQLException;
import java.util.Vector;
import javax.servlet.http.Cookie;

public class Sessione {
public Sessione(){}
    
public static Cookie[] createCookie(DataBase database, String mail, String type)throws SQLException, ClassNotFoundException{
       
     Cookie[] cookies=new Cookie[3];
     Cookie cookie;     
        switch (type) {
            case "0":
                Utente utente = GestioneUtente.getUtente(mail);
                cookie=new Cookie("UserMail",utente.getEmail());
                cookies[0]=cookie;
                cookie= new Cookie("UserNome",utente.getNome()+"#"+utente.getCognome());
                cookies[1]=cookie;
                cookie= new Cookie("UserTipo","Cliente");
                cookies[2]=cookie;
                for (int i=0; i<cookies.length; i++) {
                    cookies[i].setPath("/");
                }
                break;
            case "1":
                Utente utenteAdmin = GestioneUtente.getUtente(mail);
                cookie=new Cookie("UserMail",utenteAdmin.getEmail());
                cookies[0]=cookie;
                cookie= new Cookie("UserName",utenteAdmin.getNome()+"#"+utenteAdmin.getCognome());
                cookies[1]=cookie;
                cookie= new Cookie("tipo","Admin");
                cookies[2]=cookie;
                  for (int i=0; i<cookies.length; i++) {
                    cookies[i].setPath("/");
                }
                break;
        }
     return cookies;
    }
    
public static String getValue(Cookie cookies[], String name, int position){
    int i;
    boolean found=false;
    String value=null;
    
    for (i=0;i<cookies.length && !found;i++)
      if (cookies[i].getName().equals(name)) 
      {
        Vector oV = util.Conversion.tokenizeString(cookies[i].getValue(),"#");
        value=(String)oV.elementAt(position);
        found=true;
      }
    return value;
}

// getUserCode va a prendere il campo usercode del cookie, corrispondente all'USERNAME dell'utente
public static String getUserCode(Cookie[] cookies){
        return getValue(cookies,"userCode",0);}
    
public static String getUserFirstname(Cookie[] cookies) {  // va a prendere il campo 0 dell'USERNAME, ovvero il NOME
    return getValue(cookies, "userName", 0);}
  
public static String getUserSurname(Cookie[] cookies) {  //PRENDE IL CAMPO 1 DELL'USERNAME, COGNOME
    return getValue(cookies, "userName", 1);} 
  
public static String getType(Cookie[] cookies){     //RITORNA IL VALORE DEL CAMPO "TIPO"  DEL COOKIE
    return getValue(cookies,"tipo",0);}

public static Cookie[] deleteCookie(Cookie[] cookies) {
    for (int i=0; i<cookies.length; i++) {
      cookies[i].setMaxAge(0);
      cookies[i].setPath("/");}
    return cookies;}

public static void showCookies(Cookie[] cookies){    
   System.out.println("Cookie presenti:" + cookies.length);
    int i;
    for (i=0;i< cookies.length;i++)
      System.out.println("Nome:" + cookies[i].getName() + " Valore:" +cookies[i].getValue());}

}
    
    */