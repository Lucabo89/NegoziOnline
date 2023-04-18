package blogics;
import db.DataBase;
import db.DBService;
import java.sql.*;
import java.util.Vector;

public class GestioneUtente{
    public GestioneUtente() {}

public static Utente getUtente_byID(String id) throws SQLException, ClassNotFoundException{
        DataBase database=DBService.getDataBase();
        Utente utente=null;
        String sql=" SELECT * " +
                "    FROM utente " +
                "    WHERE " +
                "    utente_id= " + id;
        ResultSet resultSet = database.select(sql);
        try{if (resultSet.next())
                utente=new Utente(resultSet);
            resultSet.close();
            database.commit();
            database.close();
        }catch(SQLException ex)
        {System.out.println("UserService: getUser():  ResultSetDBException: ");}
        return utente;
    }    
    
public static Utente getUtente_byMail(String email) throws SQLException, ClassNotFoundException{
        DataBase database=DBService.getDataBase();
        Utente utente=null;
        String sql=" SELECT * " +
                "    FROM utente " +
                "    WHERE " +
                "    utente_mail = '" + util.Conversion.getDatabaseString(email)+"'";
        ResultSet resultSet = database.select(sql);
        try{if (resultSet.next())
                utente=new Utente(resultSet);
            resultSet.close();
            database.commit();
            database.close();
        }catch(SQLException ex)
        {System.out.println("UserService: getUser():  ResultSetDBException: ");}
        return utente;
    }

public static String idFromMail(String email) throws SQLException, ClassNotFoundException{       
    DataBase database=DBService.getDataBase();
        System.out.println("----------Mail arrivata da index: "+email);
        String id=null;
        
        String sql=" SELECT utente_id" +
                "    FROM utente " +
                "    WHERE " +
                "    utente_mail = '"+email+"'";
         
                System.out.println(sql);
        ResultSet rs = database.select(sql);
        try{            
            if (rs.next()){
                id = rs.getString("utente_id");
        System.out.println("------------- ID UTENTE relativo alla mail: "+id);}
            rs.close();
            database.commit();
            database.close();
        }catch(SQLException ex)
        {System.out.println("UserService: getUser():  ResultSetDBException: ");}
    return id;
}

public static int Inserisci_Utente(Utente u) throws SQLException, ClassNotFoundException { /* FUNZIONA  */
        DataBase db=DBService.getDataBase();
        System.out.println("InserisciUtente(Utente u) coi seguenti dati: "); 
        System.out.println(u.getNome());
        System.out.println(u.getCognome());
        System.out.println(u.getEmail());
        System.out.println(u.getPassword());
        Utente utente = getUtente_byMail(u.getEmail());
        if(utente==null){
            String sql=(
                "INSERT INTO `utente`"+ 
                "(`utente_id`, `utente_nome`, `utente_cogno`, `utente_mail`, `utente_pass`, `utente_type`)"+
                "VALUES"+
                "( NULL, '"
                    +util.Conversion.getDatabaseString(u.getNome())+"',"
                    +"'"+util.Conversion.getDatabaseString(u.getCognome())+"',"
                    +"'"+util.Conversion.getDatabaseString(u.getEmail())+"',"
                    +"'"+util.Conversion.getDatabaseString(u.getPassword())+"',"
                    +"'"+util.Conversion.getDatabaseString(u.getType())+"')");
            
            System.out.println(sql);
            int i = db.modify(sql);
            if(i>0){ 
                db.commit();
                db.close();
                return i;
            }else{
                db.rollBack();
                System.out.println("Errore nell'inserimento, eseguita rollback..");
                return 0;}
         }else{
             System.out.println("Errore: utente con quell'username gia' presente");
             return -1;}
     }

public static int Modifica_Utente(String id, String nome, String cogno, String mail) throws SQLException, ClassNotFoundException {
         /*INSERT INTO `negozionline`.`utente`
          * (`Utente_id`, `Utente_nome`, `Utente_cogno`, `Utente_email`, `Utente_pass`, `Utente_admin`) 
          * VALUES ('a', 'a', 'j', 'j', 'j', 'j');*/
        DataBase db=DBService.getDataBase();
        System.out.println("----------Siamo dentro a ModificaUtente(String nome, String cogno, String mail) ");
        
        String sql=(
                "UPDATE utente "
                +" SET utente_nome="+"'"+util.Conversion.getDatabaseString(nome)+"'"
                +"     ,utente_cogno="+"'"+util.Conversion.getDatabaseString(cogno)+"'"
                +"     ,utente_mail="+"'"+util.Conversion.getDatabaseString(mail)+"'"
                +" WHERE utente_id ="+id);
        
            System.out.println(sql);
            
            int i = db.modify(sql);
            System.out.println(i);
            if(i>0){ 
                db.commit();
                db.close();
                return i;
            }else{
                db.rollBack();
                System.out.println("Errore nell'inserimento, eseguita rollback..");
                return 0;}
         
     }

public static int Elimina_Utente(Utente u) throws SQLException, ClassNotFoundException {  /*  FUNZIONA */
    try{
        DataBase db=DBService.getDataBase();
        Utente utente = GestioneUtente.getUtente_byMail(u.getEmail());

        if(utente!=null){
            String sql=("DELETE FROM utente WHERE utente_id="+u.getId());
            
            int i=db.modify(sql);
                if(i>0){ 
                    db.commit();
                    db.close();
                    return i;
                    
                }else{
                    db.rollBack();
                    db.close();
                    return 0;}
        }else{
            System.out.println("errore: utente non presente nel database");
            return 0;}
    }catch (NullPointerException e){
        System.out.println("Null Pointer Exception..");
        return 0;}
}

public boolean esiste(Utente u) throws SQLException, ClassNotFoundException{     
     Utente utente= getUtente_byMail(u.getEmail());
        return utente.getEmail() != null;
}

public static Vector getUtentiTab() throws SQLException, ClassNotFoundException{
        DataBase db=DBService.getDataBase();
        System.out.println("dentro metodo getUtentiTabella");
        
        Utente ut;
        Vector<Utente> utenti = new Vector<>();
        
        String sql=" SELECT  * FROM utente";
        ResultSet resultSet = db.select(sql);
        
        try{
            while (resultSet.next()){
                ut = new Utente(resultSet);
                utenti.add( ut );
            }
            
            resultSet.close();
            System.out.println("Eseguita getUtentiTabella");
            
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getUtentiTabella");}
        
        return utenti;
    }


}
