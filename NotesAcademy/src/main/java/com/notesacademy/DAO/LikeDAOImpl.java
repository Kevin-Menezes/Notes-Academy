
package com.notesacademy.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDAOImpl implements LikeDAO
{
    
    private Connection con;

    public LikeDAOImpl(Connection con) 
    {
        super();
        this.con = con;
    }

    @Override
    public boolean insertLike(int noteId, int userId) 
    {
        boolean f = false;
        try 
        {
            String sql = "INSERT INTO likes(note_id,user_id) VALUES(?,?)";
            PreparedStatement ps_insertLike = con.prepareStatement(sql);
            ps_insertLike.setInt(1,noteId);
            ps_insertLike.setInt(2,userId);
            ps_insertLike.executeUpdate();
            f=true;
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in LikeDAOImpl - insertLike : "+e);
        }
        return f;
    }

// --------------------------------------------------------------------------------
    @Override
    public int countLike(int noteId) 
    {

        int count = 0;
        try
        {
            String sql = "SELECT COUNT(*) FROM likes WHERE note_id=?";
            PreparedStatement ps_countLike = con.prepareStatement(sql);
            ps_countLike.setInt(1,noteId);
            
            ResultSet rs = ps_countLike.executeQuery();
            if(rs.next())
            {
                count = rs.getInt(1);
            }
        }
        catch(Exception e)
        {
            System.out.println("There is error in LikeDAOImpl - countLike : "+e);
        }

        return count;
    }

// --------------------------------------------------------------------------------  
    @Override
    public boolean alreadyLikedByUser(int noteId , int userId) 
    {
        boolean f =false;
        
        try 
        {
            String sql = "SELECT * FROM likes WHERE note_id = ? AND user_id = ?";
            PreparedStatement ps_alreadyLikedByUser = con.prepareStatement(sql);
            ps_alreadyLikedByUser.setInt(1,noteId);
            ps_alreadyLikedByUser.setInt(2,userId);
            
            ResultSet rs = ps_alreadyLikedByUser.executeQuery();
            if(rs.next())
            {
                f = true;
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in LikeDAOImpl - alreadyLikedByUser : "+e);
        }
        
        return f;
    }

// --------------------------------------------------------------------------------
    
    @Override
    public boolean deleteLike(int noteId, int userId) 
    {
        boolean f = false;
        
        try 
        {
            String sql = "DELETE FROM likes WHERE note_id = ? AND user_id = ?";
            PreparedStatement p_deleteLike = con.prepareStatement(sql);
            p_deleteLike.setInt(1,noteId);
            p_deleteLike.setInt(2,userId);
            p_deleteLike.executeUpdate();
            
            f = true;
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in LikeDAOImpl - deleteLike : "+e);
        }

        return f;
    }
    
}
