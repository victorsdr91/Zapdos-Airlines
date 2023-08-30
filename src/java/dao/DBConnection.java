/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.sql.*;

public class DBConnection {
    private static DBConnection UnicaConexion=null; 
    private Connection Conex;
    private DBConnection() throws ClassNotFoundException, SQLException{
                Class.forName("com.mysql.jdbc.Driver");
                String connectionUrl = "jdbc:mysql://localhost:3306/db_airlines";
                Conex = DriverManager.getConnection(connectionUrl,"root","root");
    }
    public synchronized static DBConnection GetConexion() throws ClassNotFoundException, SQLException{

       if(UnicaConexion == null){
           UnicaConexion = new DBConnection();
       }
       return UnicaConexion;
    }
    public Connection GetCon(){
           return Conex;
    }
    public void Destroy() throws SQLException{
           Conex.close();
    }
}