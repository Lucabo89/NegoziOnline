package blogics;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Item implements java.io.Serializable
{   //VARIABILI
    private String item_id;
    private String item_prezzo;
    private String item_qty;
    
    //COSTRUTTORI
    public Item(){}
    
     public Item(String i, String p, String q ){
        this.item_id=i;
        this.item_prezzo=p;
        this.item_qty=q;
     }
     
    public Item(ResultSet rs){
        try {item_id    = rs.getString("art_id");}            catch (SQLException sqle) {}
        try {item_prezzo= rs.getString("dett_prezzo");}         catch (SQLException sqle) {}
        try {item_qty   = rs.getString("dett_qty");}         catch (SQLException sqle) {}
    }

    public String getItem_id(){return this.item_id; }
    public String getItem_prezzo(){return this.item_prezzo;}
    public String getItem_qty(){return this.item_qty;}
    
    public void setItem_id(String i){this.item_id=i; }
    public void setItem_prezzo(String n){this.item_prezzo=n;}
    public void setItem_qty(String n){this.item_qty=n;}
      
}