
package com.notesacademy.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class ViewDAOImpl implements ViewDAO
{
    private Connection con;

    public ViewDAOImpl(Connection con) 
    {
        super();
        this.con = con;
    }

    @Override
    public boolean insertView(int noteId, int userId, int nuserId) 
    {
        boolean f = false;
        try 
        {
            String sql = "INSERT INTO views(note_id,user_id) VALUES(?,?)";
            PreparedStatement ps_insertView = con.prepareStatement(sql);
            ps_insertView.setInt(1,noteId);
            ps_insertView.setInt(2,userId);
            ps_insertView.executeUpdate();
            
            String sql1 = "UPDATE note SET viewCount = viewCount + 1 WHERE noteId = ?";
            PreparedStatement ps_incViewCount = con.prepareStatement(sql1);
            ps_incViewCount.setInt(1,noteId);
            ps_incViewCount.executeUpdate();
            
            String sql2 = "UPDATE user SET userViewCount = userViewCount + 1 WHERE userId = ?";
            PreparedStatement ps_incUserViewCount = con.prepareStatement(sql2);
            ps_incUserViewCount.setInt(1,nuserId);
            ps_incUserViewCount.executeUpdate();
            
            f=true;
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in ViewDAOImpl - insertView : "+e);
        }
        return f;
        
    }

    @Override
    public int countView(int noteId)
    {
        int count = 0;
        try
        {
            String sql = "SELECT COUNT(*) FROM views WHERE note_id=?";
            PreparedStatement ps_countView = con.prepareStatement(sql);
            ps_countView.setInt(1,noteId);
            
            ResultSet rs = ps_countView.executeQuery();
            if(rs.next())
            {
                count = rs.getInt(1);
            }
        }
        catch(Exception e)
        {
            System.out.println("There is error in ViewDAOImpl - countView : "+e);
        }

        return count;
        
    }

    @Override
    public boolean alreadyViewedByUser(int noteId, int userId) 
    {
        boolean f =false;
        
        try 
        {
            String sql = "SELECT * FROM views WHERE note_id = ? AND user_id = ?";
            PreparedStatement ps_alreadyViewedByUser = con.prepareStatement(sql);
            ps_alreadyViewedByUser.setInt(1,noteId);
            ps_alreadyViewedByUser.setInt(2,userId);
            
            ResultSet rs = ps_alreadyViewedByUser.executeQuery();
            if(rs.next())
            {
                f = true;
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in ViewDAOImpl - alreadyViewedByUser : "+e);
        }
        
        return f;
        
    }

    // ---------------------------- Returns the most viewed number -------------------------------------
    
    @Override
    public int getMostViewedNote(int subjectId) 
    {
        int max = 0;
        
        try
        {
            String sql = "SELECT MAX(viewCount) as most_viewed FROM note WHERE subject_id=? AND notePrice=0";
            PreparedStatement ps_maxViewed = con.prepareStatement(sql);
            ps_maxViewed.setInt(1,subjectId);
            
            ResultSet rs = ps_maxViewed.executeQuery();
            if(rs.next())
            {
                max = rs.getInt(1);
            }
        }
        catch(Exception e)
        {
            System.out.println("There is error in ViewedDAOImpl - getMostViewedNote : "+e);
        }

        return max;
        
    }

    
    // ------------------------------------------------ Returns the most viewed number search ---------------------------------------------
    
    @Override
    public int getMostViewedNoteSearch(String ch) 
    {
        int max = 0;
        
        try
        {
            String sql = "SELECT MAX(viewCount) as most_viewed FROM note WHERE categoryName like ? or courseName like ? or subjectName like ? or noteTitle like ? AND notePrice=0";
            PreparedStatement ps1 = con.prepareStatement(sql);
            ps1.setString(1, "%"+ch+"%"); // We use % to search for  all words that has the character in them either before or after
            ps1.setString(2, "%"+ch+"%");
            ps1.setString(3, "%"+ch+"%");
            ps1.setString(4, "%"+ch+"%");
            
            ResultSet rs = ps1.executeQuery();
            if(rs.next())
            {
                max = rs.getInt(1);
            }
        }
        catch(Exception e)
        {
            System.out.println("There is error in ViewedDAOImpl - getMostViewedNoteSearch : "+e);
        }

        return max;
        
    }
    
}
