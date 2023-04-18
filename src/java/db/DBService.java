package db;

import java.sql.*;

//import global.*;
//import services.databaseservice.exception.*;

public class DBService extends Object 
{
    public DBService(){}

    public static synchronized DataBase getDataBase() throws ClassNotFoundException, SQLException
    {
              
      //System.out.println("dentro getDatabase()");

      String url="jdbc:mysql://localhost/negozionline?user=root&password=";
            
      //System.out.println("dopo string url ");

      Class.forName("com.mysql.jdbc.Driver");
      
      //System.out.println("dopo getDatabase - Class.forName(com.mysql.jdbc..sdfasdf)");
      
      Connection  connection = DriverManager.getConnection(url);
      
      //System.out.println("dopo Class.forName(asdfasdf) - connection=driverManager.getConnection(url)");

      return new DataBase(connection);  
    }
}