package blogics;
import db.DataBase;
import db.DBService;
import java.sql.*;
import java.util.*;

public class GestioneOrdine{
    public GestioneOrdine(){}
    
     public static int modificaSpedizione(String ord, String newStato)throws SQLException, ClassNotFoundException{
         DataBase db=DBService.getDataBase();
        System.out.println("----------Siamo dentro a ModificaArticolo(String id, String nome, String desc, String prezzo, String marca, String cat)");
    
    String sql=(
            "UPDATE ordine"
                +" SET ord_stato="+"'"+newStato+"'"
                +" WHERE ord_id ="+ord);    
    System.out.println(sql);
    int i = db.modify(sql);
    System.out.println(i);
    if(i>0){
        db.commit();
        db.close();
        return i;
    }else{
        db.rollBack();
        System.out.println("Errore nella modifica, eseguita rollback..");
        return 0;
    }
}
     
    public static String getDate(){
        Calendar now = Calendar.getInstance();
        String data;
            
        int giorno = now.get(Calendar.DATE);
        int mese = now.get(Calendar.MONTH);
        int anno = now.get(Calendar.YEAR);
        data =  giorno+"/"+mese+"/"+anno;
        return data;
    }
   
    public static int aggiungiOrdine(Ordine ord)throws SQLException, ClassNotFoundException{
        DataBase database=DBService.getDataBase();
        System.out.println("GestionOrdine.aggiungiOrdine(Ordine o)");
        int count=0;
        String data = getDate();
        Utente u = GestioneUtente.getUtente_byMail(ord.getOrd_utetnte());
        String utente_id = u.getId();
        String citta  = ord.getOrd_citta();
        String via    = ord.getOrd_via();
        String civico = ord.getOrd_civico();
        String pagamento  = ord.getOrd_pagamento();
        String stato  = ord.getOrd_stato();
        
        String sql = "INSERT INTO `negozionline`.`ordine` "
                + "(`ord_id`, `ord_data`, `ord_utente`, `ord_citta`, `ord_via`, `ord_civico`, `ord_pagamento`, `ord_stato`) "
                + "VALUES "
                + "(NULL, '"+data+"', '"+utente_id+"', '"+citta+"', '"+via+"', '"+civico+"', '"+pagamento+"', '"+stato+"')";

        System.out.println("GestionOrdine.aggiungiOrdine() -> provo ad eseguire la query: ");
        System.out.println(""+sql);
        int i = database.modify(sql);
        System.out.println("GestioneOrdine: aggiungiOrdine() -> i = database.modify(sql)= "+i );

        if(i>0){ 
                database.commit();
                database.close();
                return i;
        }else{
            database.rollBack();
            System.out.println("Errore nella modifica, eseguita rollback..");
            return 0;
        }
    }
 
    public static String lastOrdId() throws SQLException, ClassNotFoundException{
         DataBase database=DBService.getDataBase();
         String sql = "SELECT * FROM ordine WHERE ord_id = (SELECT MAX(ord_id) FROM ordine)";
         System.out.println("   dentro ad----------> lastOrdId");
         ResultSet resultSet = database.select(sql);
         resultSet.next();
         Ordine o = new Ordine(resultSet);
         String new_ord_id = o.getOrd_id();
         System.out.println("Nuovo OrdineId: "+new_ord_id);
         resultSet.close();
         return new_ord_id;
    }
    
    public static int aggiungiDettaglio(Item item)throws SQLException, ClassNotFoundException{
        DataBase database=DBService.getDataBase();
        System.out.println("----------------------- Dentro aggiungiDettagli(Itemn item )");
        
//TROVO IL NUOVO CODICE D'ORDINE NEL DATABASE E VADO AD INSERIRE TUTTI GLI ITEM SOTTO QUEL CODICE
        String new_ord_id = lastOrdId();
        System.out.println("nuovo Ord_id: "+new_ord_id);
        
        String art_id = item.getItem_id();
        String art_prezzo= item.getItem_prezzo();
        String art_qty= item.getItem_qty();
            
            String sql = "INSERT INTO `negozionline`.`dettagli` "
                + "(`dett_articolo`, `dett_ordine`, `dett_qty`, `dett_prezzo`) "
                + "VALUES "
                + "( '"+art_id+"', '"+new_ord_id+"', '"+art_qty+"', '"+art_prezzo+"')";

            System.out.println("Sto per effettuare la seguente query: "+sql);
            int j = 0;
            j = database.modify(sql);
            System.out.println("DOPO LA MODIFY AL DATABASE, j="+j);
             
            if(j>0){ 
                database.commit();
                database.close();
                return j;
            }else{
                database.rollBack();
                System.out.println("Errore nella modifica, eseguita rollback..");
                return 0;}
    }
       
    public static int contaOrdini_byUtenteMail(String utMail) throws SQLException, ClassNotFoundException{
        DataBase database=DBService.getDataBase();
        int count=0;
         String sql=" SELECT ord_id " +
                "     FROM ordine, utente " +
                "     WHERE ord_utente=utente_id AND " +
                "     utente_mail = '" +utMail+"'";
        ResultSet resultSet = database.select(sql);
        try{
            while(resultSet.next()){
                count++;
            }
            System.out.println("contaOrdini_byUtenteMail, totale: "+count);
            resultSet.close();
            database.commit();
            database.close();
        }catch(SQLException ex){System.out.println("UserService: getUser():  ResultSetDBException: ");}
        return count;
    }
    
    public static Vector getOrdiniTab() throws SQLException, ClassNotFoundException{
        DataBase db=DBService.getDataBase();
        System.out.println("---Dentro metodo getOrdiniTab");
        Ordine ord;
        Vector<Ordine> ordini = new Vector<>();
        String sql="SELECT * FROM ordine";
        ResultSet resultSet = db.select(sql);
        try{
            while (resultSet.next()){
                ord = new Ordine(resultSet);
                ordini.add( ord );
            }
            resultSet.close();
            System.out.println("Eseguita getOrdiniTab");
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getOrdiniTab");}
        return ordini;
    }
    
    public static Ordine getOrdine_byId(String cod) throws ClassNotFoundException, SQLException{
        System.out.println("getOrdine_byId");
        DataBase db = DBService.getDataBase();
        String sql = "SELECT * FROM ordine WHERE ord_id="+cod;
        ResultSet rs = db.select(sql);
        rs.next();
        Ordine ord = new Ordine(rs);
        db.commit();
        db.close();
        return ord;
    }
    
    public static int contaDettagli_byOrdId(String ordId) throws SQLException, ClassNotFoundException{
        DataBase database=DBService.getDataBase();
        int count=0;
        String sql=" SELECT dett_articolo " +
                "     FROM dettagli " +
                "     WHERE dett_ordine = '" +ordId+"'";
        ResultSet resultSet = database.select(sql);
        try{
            while(resultSet.next()){
                count++;
            }
            System.out.println("contaDettagli_byOrdIt, totale: "+count);
            resultSet.close();
            database.commit();
            database.close();
        }catch(SQLException ex){System.out.println("UserService: getUser():  ResultSetDBException: ");}
        return count;
    }
   
    public static Vector getDettagliTab_byOrdId(String ordID) throws SQLException, ClassNotFoundException{
        DataBase db=DBService.getDataBase();
        System.out.println("dentro metodo getDettagliTabbyOrdID: "+ordID);
//        SELECT art_id, art_nome, art_desc, dett_prezzo, dett_qty
//        FROM   articolo, dettagli
//        WHERE art_id=dett_articolo AND dett_ordine = 4
        Item it;
        Vector<Item> dettagli = new Vector<>();
        
        String sql="SELECT art_id, dett_prezzo, dett_qty"
                + " FROM articolo, dettagli"
                + " WHERE art_id=dett_articolo "
                + " AND dett_ordine ="+"'"+ordID+ "'";
        
        ResultSet resultSet = db.select(sql);
        try{
            while (resultSet.next()){
                it = new Item(resultSet);
                dettagli.add( it );
            }
            
            resultSet.close();
            System.out.println("Eseguita getDettagliTabella");
            
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getDettagliTab");}
        
        return dettagli;
    }

    public static Vector getOrdiniTab_byUtenteId(String utId) throws SQLException, ClassNotFoundException {
    System.out.println("---------------->getOrdiniTab_byUtenteId<------------------");
    DataBase db=DBService.getDataBase();
    Ordine ord;
    Vector<Ordine> ordini = new Vector<>();
    String sql="SELECT * FROM ordine WHERE ord_utente="+"'"+utId+ "'";
    ResultSet resultSet = db.select(sql);
    try{
        while (resultSet.next()){
            ord = new Ordine(resultSet);
            ordini.add( ord );
        }
            resultSet.close();
            System.out.println("Eseguita getOrdiniTab");
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getOrdiniTab");}
       
        return ordini;
    }
 
    public static int totaleOrdine(Item[] carrello) throws ClassNotFoundException, SQLException{
        System.out.println("DENTRO TOTALEORDINE");
        int i, totale=0;
        int numArticoli = carrello.length;
        
        for(i=0; i<numArticoli; i++){
            System.out.println("Articolo: "+carrello[i].getItem_id());
            System.out.println("Quantità: "+carrello[i].getItem_qty());
            System.out.println("Prezzo: "+carrello[i].getItem_prezzo());
            
            totale = totale + (Integer.parseInt(carrello[i].getItem_prezzo()) * Integer.parseInt(carrello[i].getItem_qty()));
        }
           System.out.println("Totale ordine: "+totale);
        
        return totale;
    }
}
