package db;
import java.io.*;
import java.sql.*;
//import services.databaseservice.exception.*;

public class DataBase
{   //VARIABILI
    private Connection connection;
    private Statement statement;
    //COSTRUTTORE 
    public DataBase(Connection connection)
    {
        try{
            this.connection=connection;
            if (this.connection==null)
                {   System.out.println("DataBase: DataBase(): Impossibile Aprire la Connessione Logica");   }
            this.connection.setAutoCommit(false);
            statement=this.connection.createStatement();
        }catch(Exception ex){
            ByteArrayOutputStream stackTrace=new ByteArrayOutputStream();
            ex.printStackTrace(new PrintWriter(stackTrace,true));
            System.out.println("DataBase: DataBase(): Impossibile Aprire la Connessione col DataBase: \n"+stackTrace);}
    }
    //METODO SELECT
    public ResultSet select(String sql) throws SQLException{
        ResultSet resultSet;
        resultSet = statement.executeQuery(sql);
        return resultSet;
    }
  
    public int modify(String sql) throws SQLException{
        int recordsNumber;
        recordsNumber=statement.executeUpdate(sql);        
        return recordsNumber;}
  
    public void commit(){
        try{
            connection.commit();
            statement.close();
            statement=connection.createStatement();
            System.out.println("Eseguita Commit del database");
        }catch(SQLException ex){System.out.println("DataBase: commit(): Impossibile eseguire la commit ");}}
  
    public void rollBack(){
        try{
            connection.rollback();
            statement.close();
            statement=connection.createStatement();
        }catch(SQLException ex){System.out.println("DataBase: rollback(): Impossibile eseguire il RollBack sul DB. Eccezione: "+ex);}}
  
    public void close(){
        try{
            connection.close();
            System.out.println("eseguita close");
        }catch (SQLException ex){System.out.println("DataBase: close(): Impossibile chiudere il DB. Eccezione: "+ex);}
         catch(IllegalStateException e){System.out.println(""+e.getMessage());}}
  
    @Override
    protected void finalize() throws Throwable{
        this.close();}
}
