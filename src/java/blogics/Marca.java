/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blogics;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Marca implements java.io.Serializable
{   //VARIABILI
    private String marc_id;
    private String marc_brand;
    //COSTRUTTORI
    public Marca(){}
 
    public Marca(ResultSet rs){
        try {marc_id    =  rs.getString("marc_id");}            catch (SQLException sqle) {}
        try {marc_brand = rs.getString("marc_brand");}         catch (SQLException sqle) {}}

    public String getMarc_id(){return this.marc_id; }
    public String getMarc_brand(){return this.marc_brand;}
    
    public void setMarc_id(String i){this.marc_id=i; }
    public void setMarc_brand(String n){this.marc_brand=n;}
      

}
