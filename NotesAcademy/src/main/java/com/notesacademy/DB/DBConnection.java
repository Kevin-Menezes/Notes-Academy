
package com.notesacademy.DB;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;

public class DBConnection 
{
    private static Connection con;
    
    public static Connection getConnection()
    {
        try {
            if(con==null)
            {
                Class.forName("com.mysql.jdbc.Driver");
                con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/notesacademydb","root","");
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        
        return con;
    }
    
    
}
