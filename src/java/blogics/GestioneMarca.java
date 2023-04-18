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
public class GestioneMarca {
    public GestioneMarca(){}
    
    public static Vector getMarcheTab() throws SQLException, ClassNotFoundException
    {
        System.out.println("Metodo : getMarcTabella");

        DataBase db = DBService.getDataBase();
        System.out.println("getMarcTabella --> dopo DBService.getDatabase()");

        Marca m;
        Vector<Marca> marche = new Vector<>();
        String sql=" SELECT  marc_id, marc_brand FROM marca";
        ResultSet resultSet = db.select(sql);
        
        try{
            while (resultSet.next()){
                m = new Marca(resultSet);
                marche.add( m );
            }
            
            resultSet.close();
            System.out.println("Eseguita getCategorieTabella");
            
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getCategorieTabella");}
        
        return marche;
    }

}
