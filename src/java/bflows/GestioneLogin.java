package bflows;
import blogics.GestioneUtente;
import blogics.Utente;
import db.DBService;
import db.DataBase;
import java.sql.SQLException;
import javax.servlet.http.Cookie;
import sessione.*;

public class GestioneLogin {
//VARIABILI CLASS GESTIONE-LOGIN
private String errore;
private int result;
//CARATTERISTICHE FONDAMENTALI DI OGNI UTENTE
private String email;
private String password;
//L'ARRAY cookies verrà usato per metteri dentro tutto quello che mi serve per un utente!
//(quindi potrei pensare di metterci dentro anche tutti gli articoli che si sta comprando)
private Cookie[] cookies;
public GestioneLogin() {}

public String getUserMail() {return this.email;}
public void   setUserMail(String mail){this.email=mail;}
public String getPassword() {return this.password;}
public void   setPassword(String pass) {this.password = pass;}

public void Login(String mail, String psw) throws SQLException, ClassNotFoundException{
    System.out.println("GestioneLogin.Login(String mail, String psw)");
    DataBase db  = DBService.getDataBase();
    //Devo ricercare l'utente dalla mail che ha inserito nel form, ma prima
    //SETTO mail e password di questo Bean "GestioneLogin"
    this.setUserMail(mail);
    this.setPassword(psw);

    System.out.println("Mail e Pass arrivate dall'index login:");
    System.out.println(mail);
    System.out.println(psw);

    //CREO UN UTENTE TEMPORANEO (SE ESISTE) COI DATI DELLA MAIL INSERITA 
    //NELLA FORM DELL'INDEX
    
    Utente ut = GestioneUtente.getUtente_byMail(mail);
   
    try{//SE L'UTENTE INSERITO NEL LOGIN DELL'INDEX NON ESISTE.....
        if(ut.getEmail()==null || !ut.getPassword().equals(psw)){            
            cookies=null;
            System.out.println("Errore: password e/o username errati..");
        }else{   //SE è PRESENTE NEL DB L'UTENTE CHE SI STA LOGGANDO:
            //creo il cookie dell'utente comune appena loggato passandogli 
            //come parametri: il Database, la sua Mail ed il tipo di utente
          System.out.println("Utente != null ---> quindi creazione cookies (=Sessione.createCookie(db, ut.getEmail())");
          //<<<<<<<<<<<<<<<<<<<<<<<<<<<------------>>>>>>>>>>>>>>>>>>>>>>>>>
          cookies = Sessione.createCookie(ut.getEmail());
          //<<<<<<<<<<<<<<<<<<<<<<<<<<<------------>>>>>>>>>>>>>>>>>>>>>>>>>>
        }
        }catch(Exception e){System.out.println("errore: "+e.getMessage());}
        db.commit();
        db.close();
    }

public void Logout(){ cookies=Sessione.deleteCookie(cookies); }

//METODI PER L'UTILIZZO DEI COOKIE DELL UTENTE
public Cookie getCookies(int index){ 
    return this.cookies[index];}

public void   setCookies(int index, Cookie cookies){
    this.cookies[index]=cookies;}

public Cookie[] getCookies() {
    return this.cookies;}

public void setCookies(Cookie[] cookies){
    this.cookies = cookies;}

public String getErrorMessage() {return errore;}
public void   setErrorMessage(String errore){this.errore=errore;}

public int getResult() {return this.result;}
public void setResult(int result){this.result=result;}
}