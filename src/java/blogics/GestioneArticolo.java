package blogics;
import db.DBService;
import db.DataBase;
import java.sql.*;
import java.util.Vector;

public class GestioneArticolo {
    public GestioneArticolo(){}
    
    
    public static String lastID() throws ClassNotFoundException, SQLException{
        DataBase db=DBService.getDataBase();
         String sql = "SELECT max(art_id) as last FROM articolo";
        ResultSet rs = db.select(sql);
        rs.next(); 
        String last_id = (rs.getString("last"));
        db.commit();
        db.close();
        return last_id;
    }
    
    
public static int aggiungiArticolo(Articolo art) throws ClassNotFoundException, SQLException{
    DataBase db=DBService.getDataBase();
      System.out.println("---------------aggiungiArticolo() seguenti dati: "); 
      System.out.println(art.getArt_nome());
      System.out.println(art.getArt_prezzo());
      System.out.println(art.getArt_desc());
      System.out.println(art.getArt_marca());
      System.out.println(art.getArt_categ());
      String last = lastID();
      int newId = (Integer.parseInt(last) + 1);
      String nuovo = Integer.toString(newId);
      String sql=(
              "INSERT INTO `articolo`"+ 
              "(`art_id`, `art_nome`, `art_prezzo`, `art_desc`, `art_marca`, `art_categoria`)"+
              "VALUES"+
              "( '"+nuovo+"'," 
                    +"'"+util.Conversion.getDatabaseString(art.getArt_nome())+"',"
                    +"'"+util.Conversion.getDatabaseString(art.getArt_prezzo())+"',"
                    +"'"+util.Conversion.getDatabaseString(art.getArt_desc())+"',"
                    +"'"+util.Conversion.getDatabaseString(art.getArt_marca())+"',"
                    +"'"+util.Conversion.getDatabaseString(art.getArt_categ())+"')");
      
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
    
    
public static Articolo getArticolo_byId(String cod) throws ClassNotFoundException, SQLException{
        System.out.println("getArticolo_byID");
        DataBase db = DBService.getDataBase();
        String sql = "SELECT * FROM articolo WHERE art_id="+cod ;//cod va bene anche senza virgolette perchè è un int
        ResultSet rs = db.select(sql);
        rs.next();
        Articolo art = new Articolo(rs);
        db.commit();
        db.close();
        return art;
    }

public static int getRimanenze_byId(String cod) throws ClassNotFoundException, SQLException{
        System.out.println("getRimanenze_byID");
        DataBase db = DBService.getDataBase();
        String sql = "SELECT rimanenze FROM magazzino WHERE cod_art="+cod ;//cod va bene anche senza virgolette perchè è un int
        ResultSet rs = db.select(sql);
            rs.next();
            String result = rs.getString("rimanenze");
        db.commit();
        db.close();
        return Integer.parseInt(result);
    }

public static Vector getArticoliTab() throws SQLException, ClassNotFoundException{
        DataBase db=DBService.getDataBase();
        System.out.println("dentro metodo getArticoliTab");
        Articolo ut;
        Vector<Articolo> articoli = new Vector<>();
        String sql=" SELECT  * FROM articolo";
        ResultSet resultSet = db.select(sql);
        try{
            while (resultSet.next()){
                ut = new Articolo(resultSet);
                articoli.add( ut );
            }
            resultSet.close();
            System.out.println("Eseguita getArticoliTab");
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getArticoliTab");}
        return articoli;
    }

public static String[] getFirstTen() throws SQLException, ClassNotFoundException{
    System.out.println("getFirsTen");
    DataBase db = DBService.getDataBase();
    String[] array = new String[10];
    int i =0;
    String sql = "SELECT art_id FROM articolo";
    ResultSet rs = db.select(sql);
    System.out.println("Eseguita getFirstTen ()");
    while(rs.next() && i<10){
        array[i] = rs.getString("art_id");
        i++;}
    db.commit();
    db.close();
    return array;
}

public static Vector RicercaMarca(  String marc )throws SQLException, ClassNotFoundException{
    System.out.println("----------Siamo dentro a RicercaCategoria( String cat ");
    System.out.println("----------Categoria arrivata: "+marc);
    DataBase db=DBService.getDataBase();
    Articolo a;
    String sql="";
    Vector<Articolo> articoli = new Vector<>();
    sql=("SELECT art_id, art_nome, art_desc, art_prezzo, art_marca, art_categoria "
                + " FROM articolo"
                + " WHERE art_marca="+marc);
    System.out.println(sql);
    ResultSet resultSet = db.select(sql);
        try{
            while (resultSet.next()){
                a = new Articolo(resultSet);
                articoli.add( a );
            }            
            resultSet.close();
            System.out.println("Eseguita RicercaMarca");
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore RicercaMarca");}
        return articoli;
}

public static Vector RicercaCategoria(  String cat )throws SQLException, ClassNotFoundException{
    System.out.println("----------Siamo dentro a RicercaCategoria( String cat ");
    System.out.println("----------Categoria arrivata: "+cat);
    DataBase db=DBService.getDataBase();
    Articolo a;
    String sql="";
    Vector<Articolo> articoli = new Vector<>();
    sql=("SELECT art_id, art_nome, art_desc, art_prezzo, art_marca, art_categoria "
                + " FROM articolo"
                + " WHERE art_categoria="+cat);
    System.out.println(sql);
    ResultSet resultSet = db.select(sql);
        try{
            while (resultSet.next()){
                a = new Articolo(resultSet);
                articoli.add( a );
            }            
            resultSet.close();
            System.out.println("Eseguita getUtentiTabella");
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getUtentiTabella");}
        return articoli;
}

public static Vector RicercaAvanzata(String keyword,  String cat, String marc)throws SQLException, ClassNotFoundException{
    System.out.println("----------Siamo dentro a ricercaAvnazata(String keyword, String cat, String marc");
    System.out.println("----------Parametri arrivati al metodo---->  KeyWord: "+keyword+" CatID: "+cat+" MarcID: "+marc);    
    DataBase db=DBService.getDataBase();
    Articolo a;
    String sql="";
    Vector<Articolo> articoli = new Vector<>();

//NELLE IF CHE FACCIO ADESSO DEVO SOLO SCRIVERE LA QUERY, PERCHè LA VADO A FARE DOPO FUORI DAI CONTROLLI
    if(cat.equals("Categorie") && marc.equals("Marche")){//FUNZIONA
        System.out.println("---------non ha scelto nè marca nè categoria quindi query solo con LIKE in art_nome e art_desc");    
        sql=("SELECT art_id, art_nome, art_desc, art_prezzo, art_marca, art_categoria "
                + " FROM articolo"
                + " WHERE art_desc LIKE '%"+keyword+"%' OR art_nome LIKE '%"+keyword+"%'");
        System.out.println(sql);}
    
    if( cat.equals("Categorie") && !marc.equals("Marche")){
        System.out.println("ha scelto la marca ma non la categoria");    
        sql=("SELECT art_id, art_nome, art_desc, art_prezzo, art_marca, art_categoria"
                + " FROM articolo, marca "
                + " WHERE (art_desc LIKE '%"+keyword+"%' OR art_nome LIKE '%"+keyword+"%') AND art_marca=marc_id"
                + " AND marc_id="+marc);
        System.out.println(sql);}
    
    
    if(!cat.equals("Categorie") &&  marc.equals("Marche")){
        System.out.println("ha scelto la categoria ma non la marca");
        sql=("SELECT art_id, art_nome, art_desc, art_prezzo, art_marca, art_categoria"
                + " FROM articolo, categoria"
                + " WHERE (art_desc LIKE '%"+keyword+"%' OR art_nome LIKE '%"+keyword+"%') AND art_categoria=cat_id"
                + " AND cat_id="+cat);
        System.out.println(sql);}
    
    
    if(!cat.equals("Categorie") && !marc.equals("Marche")){
        System.out.println("ha scelto sia categoria CHE marca");
        
        sql=("SELECT art_id, art_nome, art_desc, art_prezzo, art_marca, art_categoria"
                + " FROM articolo, marca, categoria"
                + " WHERE (art_desc LIKE '%"+keyword+"%' OR art_nome LIKE '%"+keyword+"%')"
                + " AND cat_id="+cat+" AND marc_id="+marc
                + " AND art_marca=marc_id AND art_categoria=cat_id");
        System.out.println(sql);}
    
//    ADESSO CHE HO FATTO TUTTE LE CASISTICHE DI QUERY POSSIBILI (CON O SENZA CATEGORIA E/O MARCA)
//    VADO A ESEGUIRE LA QUERY VERA E PROPRIA!!
    ResultSet resultSet = db.select(sql);
        try{
            while (resultSet.next()){
                a = new Articolo(resultSet);
                articoli.add( a );
            }            
            resultSet.close();
            System.out.println("Eseguita getUtentiTabella");
            db.commit();
            db.close();
        }catch (SQLException ex){
            System.out.println("Errore getUtentiTabella");}
        return articoli;
}

public static int Modifica_Articolo(String id, String nome, String desc, String prezzo, String marca, String cat) throws SQLException, ClassNotFoundException {    
    DataBase db=DBService.getDataBase();
    System.out.println("----------Siamo dentro a ModificaArticolo(String id, String nome, String desc, String prezzo, String marca, String cat)");
    
    String sql=(
            "UPDATE articolo"
                +" SET art_nome="+"'"+nome+"',"
                +" art_prezzo="+"'"+prezzo+"',"
                +" art_desc="+"'"+desc+"'"
//                +" art_marca="+"'"+marca+"',"
//                +" art_categoria="+"'"+cat+"'"
                +" WHERE art_id ="+id);    
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
    
public static int Numero_articoli() throws SQLException, ClassNotFoundException{
    System.out.println("numero_articoli");
        DataBase db=DBService.getDataBase();
        String sql=("SELECT COUNT(*) FROM articolo");
        ResultSet rs=db.select(sql);
        rs.next();
        int numero = rs.getInt("COUNT(*)");
        db.commit();
        db.close();
        return numero;
}

public static String[] getCodiciArt() throws SQLException, ClassNotFoundException {
    System.out.println("getCodiciArt");
    
    //effettuo il dimensionamento array dei codici con un metodo fatto ad arte
    String a[] = new String[GestioneArticolo.Numero_articoli()];
    DataBase db = DBService.getDataBase();
    int i =0;
            
    String sql = "SELECT art_id FROM articolo";
    ResultSet rs = db.select(sql);
    while(rs.next()){
        System.out.println("Eseguita getCodici()");
        a[i] = rs.getString(util.Conversion.getDatabaseString("art_id"));
        i++;
    }
    db.commit();
    db.close();
    return a;}

public static int Elimina_Articolo(String cod) throws SQLException, ClassNotFoundException {
    try{
        DataBase db=DBService.getDataBase();
        Articolo art=GestioneArticolo.getArticolo_byId(cod);
        if(art!=null){
            String sql=("DELETE FROM articolo WHERE art_id="+cod);
            System.out.println("-------Sto per fare questa query: DELETE FROM articolo WHERE art_id");
            
            int i=db.modify(sql);
            if(i>0){ 
                db.commit();
                return i;
            }else {
                db.rollBack();
                return 0;}
        }else{
            System.out.println("errore: Docente non presente nel database");
            return 0;}
    }catch (NullPointerException e){
        System.out.println("Null Pointer Exception..");
        return 0;}
}

}
