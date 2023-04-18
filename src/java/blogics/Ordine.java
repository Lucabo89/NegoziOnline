package blogics;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Ordine implements java.io.Serializable
{   //VARIABILI
    private String ord_id;
    private String ord_data;
    private String ord_utente;
    
    //indirizzo spedizione
    private String ord_citta;
    private String ord_via;
    private String ord_civico;
    private String ord_pagamento;
    private String ord_stato;    
    
    //COSTRUTTORI
    public Ordine(){}
    
    public Ordine(String i,String d, String u, String c, String v, String n, String p,String s ){
        
        System.out.println("public Ordine(parametri)");
        
        this.ord_id=i;        
        this.ord_data=d;
        this.ord_utente=u;
        this.ord_citta=c;
        this.ord_via=v;
        this.ord_civico=n;
        this.ord_pagamento=p;
        this.ord_stato=s;
    }
     
    public Ordine(ResultSet resultSet){
        System.out.println("ResultSetm rs");

        try {ord_id=resultSet.getString("ord_id");}             catch (SQLException sqle) {}
        try {ord_data=resultSet.getString("ord_data");}         catch (SQLException sqle) {}
        try {ord_utente=resultSet.getString("ord_utente");}     catch (SQLException sqle) {}
        try {ord_citta=resultSet.getString("ord_citta");}       catch (SQLException sqle) {}
        try {ord_via=resultSet.getString("ord_via");}           catch (SQLException sqle) {}
        try {ord_civico=resultSet.getString("ord_civico");}     catch (SQLException sqle) {}
        try {ord_pagamento=resultSet.getString("ord_pagamento");}       catch (SQLException sqle) {}
        try {ord_stato=resultSet.getString("ord_stato");}       catch (SQLException sqle) {}
    }


    //GET & SET METHOD
    public String getOrd_id(){return this.ord_id; }
    public String getOrd_data(){return this.ord_data;}
    public String getOrd_utetnte(){return this.ord_utente;}
    public String getOrd_citta(){return this.ord_citta;}
    public String getOrd_via(){return this.ord_via;}
    public String getOrd_civico(){return this.ord_civico;}
    public String getOrd_pagamento(){return this.ord_pagamento;}
    public String getOrd_stato(){return this.ord_stato;}
    
    
    public void setOrd_id(String i){this.ord_id=i; }
    public void setOrd_data(String n){this.ord_data=n;}
    public void setOrd_utente(String p){this.ord_utente=p;}
    public void setOrd_citta(String d){this.ord_citta= d;}
    public void setOrd_via(String m){this.ord_via=m;}
    public void setOrd_civico(String c){this.ord_pagamento=c;}
    public void setOrd_pagamento(String c){this.ord_stato=c;}
    public void setOrd_stato(String c){this.ord_stato=c;}

}
