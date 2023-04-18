package blogics;
import db.DBService;
import db.DataBase;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

/**
 *
 * @author bonny
 */
public class GestioneCategoria {
    public GestioneCategoria(){}
    
    public static Vector getCategorieTab() throws SQLException, ClassNotFoundException{
        
        DataBase db=DBService.getDataBase();
        System.out.println("dentro metodo getCategorieTabella");
        Categoria c;
        Vector<Categoria> categorie = new Vector<>();
        String sql=" SELECT  cat_id, cat_nome FROM categoria";
        ResultSet resultSet = db.select(sql);
        try{
            while (resultSet.next()){
                c = new Categoria(resultSet);
                categorie.add( c );
            }
            resultSet.close();
            System.out.println("Eseguita getCategorieTabella");
            
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getCategorieTabella");}
        
        return categorie;
    }

    
    
    
    public static String lastID() throws ClassNotFoundException, SQLException{
        DataBase db=DBService.getDataBase();
         String sql = "SELECT max(cat_id) as last FROM categoria";
        ResultSet rs = db.select(sql);
        rs.next(); 
        String last_id = (rs.getString("last"));
        db.commit();
        db.close();
        return last_id;
    }
    
  
public static int aggiungiCategoria(Categoria c) throws ClassNotFoundException, SQLException{
    DataBase db=DBService.getDataBase();
      System.out.println("---------------aggiungiCategoria() seguenti dati: "); 
      System.out.println(c.getCat_nome());
      String last = lastID();
      int newId = (Integer.parseInt(last) + 1);
      String nuovo = Integer.toString(newId);
      String sql=(
              "INSERT INTO `categoria`"+ 
              "( `cat_id`, `cat_nome` )"+
              "VALUES"+
              "( '"+util.Conversion.getDatabaseString(nuovo)+"'," 
                    +"'"+util.Conversion.getDatabaseString(c.getCat_nome())+"')");
      
      System.out.println(sql);
      int i = db.modify(sql);
      System.out.println("Valore i dopo la modify: "+i);

            if(i>0){ 
                db.commit();
                db.close();
                return i;
            }else{
                db.rollBack();
                System.out.println("Errore nell'inserimento, eseguita rollback..");
                return 0;}  
     }
    
    
    
    
    
    
}
