
package com.notesacademy.DAO;

import com.notesacademy.entities.UserDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO 
{
    private Connection con;
    
    public UserDAOImpl(Connection con)
    {
        super();
        this.con = con; // PUTTING THAT con IN THIS FILE KA con
    }

    @Override
    public boolean userSignup(UserDetails us) 
    {
        boolean f = false;
        
        try{
            String sql = "insert into user(userName,userPassword,userEmail,userProfession,userCollege) values(?,?,?,?,?)"; // INSERTING INTO THE DATABASE
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, us.getUserName()); // TAKING VALUES FROM THE USER'S GETTER AND PUTTING IN THE DATABASE
            ps.setString(2, us.getUserPassword());
            ps.setString(3, us.getUserEmail());
            ps.setString(4, us.getUserProfession());
            ps.setString(5, us.getUserCollege());
            
            int rs = ps.executeUpdate();
            
            if(rs==1) //    WHEN THE INSERTION IS SUCCESSFUL
            {
                f = true;
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f; // WE RETURN TRUE OR FALSE

    }

    @Override
    public UserDetails userLogin(String email, String password) 
    {
        UserDetails us = null;
        
        try
        {
            String sql = "select * from user where userEmail=? and userPassword=?";  // CHECKING IF THE USER HAS REGISTERED
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1,email); // CHECKING IF THE DETAILS IN THE DATABASE MATCH WITH THE DATA THAT IS ENTERED IN THE LOGIN FORM
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                us = new UserDetails(); // STORING ALL THE USER'S DATA IN THE us OBJECT FOR FURTHER USE IN THE USERS HOME PAGE
                us.setUserId(rs.getInt(1));
                us.setUserName(rs.getString(2));
                us.setUserPassword(rs.getString(3));
                us.setUserEmail(rs.getString(4));
                us.setUserProfession(rs.getString(5));
                us.setUserCollege(rs.getString(6));          
            }
        
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return us; // RETURNING THIS us OBJECT WHICH CONTAINS ALL THE USERS DETAILS
    }

     // ------------------------------------------------ Count of Users --------------------------------------
    
    @Override
    public int getUsersCount() 
    {
        int count = 0;
        
        try 
        {
            String sql = "SELECT COUNT(userName) FROM user";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        } 
        
        catch (Exception e) 
        {
            System.out.println("There is error in UserDAOImpl - getUsersCount : "+e);
        }
        
        return count;
        
        
    }

    // --------------------------------------------------------- Gets the details of all the users -----------------------------------------------------------------
    
    @Override
    public List<UserDetails> getUsers() 
    {
        List<UserDetails> list = new ArrayList<UserDetails>();
        UserDetails us = null;
        
         try 
        {
            
            String sql = "SELECT * FROM user";
            PreparedStatement ps_getcategories = con.prepareStatement(sql);
            
            ResultSet rs = ps_getcategories.executeQuery();

            while (rs.next()) 
            {
                us = new UserDetails();
                us.setUserId(rs.getInt(1));
                us.setUserName(rs.getString(2));
                us.setUserPassword(rs.getString(3));
                us.setUserEmail(rs.getString(4));
                us.setUserProfession(rs.getString(5));
                us.setUserCollege(rs.getString(6));
                list.add(us);           
            }

        } 
        catch (Exception e) 
        {
            System.out.println("There is error in UserDAOImpl - getUsers : "+e);
        }

        return list;

    }
    
    // ---------------------------------------------------- Gets a particular users details from userid  ----------------------------------------------------

    @Override
    public UserDetails getUserById(int id) 
    {
        UserDetails us = null;
        
        try 
        {
            String sql = "SELECT * FROM user WHERE userId = ? ";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                us = new UserDetails();
                us.setUserId(rs.getInt(1));
                us.setUserName(rs.getString(2));
                us.setUserPassword(rs.getString(3));
                us.setUserEmail(rs.getString(4));
                us.setUserProfession(rs.getString(5));
                us.setUserCollege(rs.getString(6));
                
            }
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in UserDAOImpl - getUserById : "+e);
        }
        
        return us;
        
    }
    
    // --------------------------------------- Update user details based on user id ---------------------------------------------------------

    @Override
    public boolean updateEditUser(UserDetails us) 
    {
        boolean f = false;
        
        try 
        {
            String sql = "UPDATE user SET userName = ? , userPassword = ? , userEmail = ? , userProfession = ? , userCollege = ? WHERE userId = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, us.getUserName());
            ps.setString(2, us.getUserPassword());
            ps.setString(3, us.getUserEmail());
            ps.setString(4, us.getUserProfession());
            ps.setString(5, us.getUserCollege());
            ps.setInt(6, us.getUserId());
            
            int i = ps.executeUpdate();
            
            if(i>0)
           {
               f = true;
           }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in UserDAOImpl - updateEditUser : "+e);
        }
        
        return f;

    }

    
    // ------------------------------------------------------ Deletes user details using user id ----------------------------------------
    
    @Override
    public boolean deleteUser(int id) 
    {
        boolean f = false;
        
        try
        {
            String sql = "DELETE FROM user WHERE userId = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,id);
            int i = ps.executeUpdate();
            
            if(i>0)
            {
                f=true;
            }
            
        }
        catch(Exception e)
        {
            System.out.println("There is error in UserDAOImpl - deleteUser : "+e);
        }
        return f;
       
    }
      
    
}
