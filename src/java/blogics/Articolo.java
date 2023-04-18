package blogics;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Articolo implements java.io.Serializable
{   //VARIABILI
    private String art_id;
    private String art_nome;
    private String art_prezzo;
    private String art_desc;
    private String art_marca;
    private String art_categoria;
    
    //COSTRUTTORI
    public Articolo(){}
    
    public Articolo(String i,String n, String p, String d, String m, String c){
        this.art_id=i;        
        this.art_nome=n;
        this.art_prezzo=p;
        this.art_desc=d;
        this.art_marca=m;
        this.art_categoria=c;}
     
    public Articolo(ResultSet resultSet){
        try {art_id=resultSet.getString("art_id");}             catch (SQLException sqle) {}
        try {art_nome=resultSet.getString("art_nome");}         catch (SQLException sqle) {}
        try {art_prezzo=resultSet.getString("art_prezzo");}     catch (SQLException sqle) {}
        try {art_desc=resultSet.getString("art_desc");}         catch (SQLException sqle) {}
        try {art_marca=resultSet.getString("art_marca");}       catch (SQLException sqle) {}
        try {art_categoria=resultSet.getString("art_categoria");}       catch (SQLException sqle) {}}
    
    //GET & SET METHOD
    public String getArt_id(){return this.art_id; }
    public String getArt_nome(){return this.art_nome;}
    public String getArt_prezzo(){return this.art_prezzo;}
    public String getArt_desc(){return this.art_desc;}
    public String getArt_marca(){return this.art_marca;}
    public String getArt_categ(){return this.art_categoria;}
    
    public void setArt_id(String i){this.art_id=i; }
    public void setArt_nome(String n){this.art_nome=n;}
    public void setArt_prezzo(String p){this.art_prezzo=p;}
    public void setArt_desc(String d){this.art_desc= d;}
    public void setArt_marca(String m){this.art_marca=m;}
    public void setArt_categ(String c){this.art_categoria=c;}
}
