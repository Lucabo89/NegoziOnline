/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blogics;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Categoria implements java.io.Serializable
{   //VARIABILI
    
    private String cat_id;
    private String cat_nome;
    
    public Categoria(){}
    
    public Categoria(String i, String n){
        this.cat_id=i;
        this.cat_nome=n;}
    
    public Categoria(ResultSet rs){
        try {cat_id= rs.getString("cat_id");}            catch (SQLException sqle) {}
        try {cat_nome=rs.getString("cat_nome");}         catch (SQLException sqle) {}}

    public String getCat_id(){return this.cat_id; }
    public String getCat_nome(){return this.cat_nome;}
    
    public void setCat_id(String i){this.cat_id=i; }
    public void setCat_nome(String n){this.cat_nome=n;}
   
}
