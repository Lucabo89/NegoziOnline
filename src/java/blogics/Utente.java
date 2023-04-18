package blogics;

import java.sql.*;
import java.util.*;

public class Utente implements java.io.Serializable {
    //VARIABILI 
    private String id;
    private String nome;
    private String cognome;
    private String email;
    private String password;
    private String type;
    
    //GET & SET VARIABILI
    public String getId(){return this.id;}
    public String getNome(){return this.nome;} 
    public String getCognome(){return this.cognome;}
    public String getPassword(){return this.password;}
    public String getEmail(){return this.email;}
    public String getType(){return this.type;}

    public void setId(String i){this.id=i;}
    public void setNome(String n){this.nome=n;}
    public void setCognome(String c){this.cognome=c;}
    public void setPassword(String p){this.password=p;}
    public void setEmail(String e){this.email=e;}
    public void setType(String a){this.type=a;}
    
//COSTUTTORE CON PARAMETRI
    public Utente(String nome,String cognome,String email,String password, String tipo){
        this.id = id;
        this.nome=nome;
        this.cognome=cognome;
        this.email=email;
        this.password=password;
        this.type=tipo;
    }
    //COSTRUTTORE DA QUERY
    public Utente(ResultSet resultSet){
        try {id=resultSet.getString("utente_id");}         catch (SQLException sqle) {}
        try {nome=resultSet.getString("utente_nome");}         catch (SQLException sqle) {}
        try {cognome=resultSet.getString("utente_cogno");}   catch (SQLException sqle) {}
        try {email=resultSet.getString("utente_mail");}       catch (SQLException sqle) {}
        try {password=resultSet.getString("utente_pass");} catch (SQLException sqle) {}
        try {type=resultSet.getString("utente_type");}       catch (SQLException sqle) {}
    }
}
        
   
    
    

