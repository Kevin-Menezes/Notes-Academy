
package com.notesacademy.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DownloadDAOImpl implements DownloadDAO
{
    private Connection con;

    public DownloadDAOImpl(Connection con) 
    {
        super();
        this.con = con;
    }

    @Override
    public boolean insertDownload(int noteId, int userId, int nuserId) 
    {
        boolean f = false;
        try 
        {
            String sql = "INSERT INTO downloads(note_id,user_id) VALUES(?,?)";
            PreparedStatement ps_insertDownload = con.prepareStatement(sql);
            ps_insertDownload.setInt(1,noteId);
            ps_insertDownload.setInt(2,userId);
            ps_insertDownload.executeUpdate();
            
            String sql1 = "UPDATE note SET downloadCount = downloadCount + 1 WHERE noteId = ?";
            PreparedStatement ps_incDownloadCount = con.prepareStatement(sql1);
            ps_incDownloadCount.setInt(1,noteId);
            ps_incDownloadCount.executeUpdate();
            
            String sql2 = "UPDATE user SET userDownloadCount = userDownloadCount + 1 WHERE userId = ?";
            PreparedStatement ps_incUserDownloadCount = con.prepareStatement(sql2);
            ps_incUserDownloadCount.setInt(1,nuserId);
            ps_incUserDownloadCount.executeUpdate();
            
            f=true;
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in DownloadDAOImpl - insertDownload : "+e);
        }
        return f;
        
    }

    @Override
    public int countDownload(int noteId) 
    {
        int count = 0;
        try
        {
            String sql = "SELECT COUNT(*) FROM downloads WHERE note_id=?";
            PreparedStatement ps_countDownload = con.prepareStatement(sql);
            ps_countDownload.setInt(1,noteId);
            
            ResultSet rs = ps_countDownload.executeQuery();
            if(rs.next())
            {
                count = rs.getInt(1);
            }
        }
        catch(Exception e)
        {
            System.out.println("There is error in DownloadDAOImpl - countDownload : "+e);
        }

        return count;
       
    }
    
    // ------------- Checks if the same user has already downloaded this note so as to not increment the total download count in the main user table --------------

    @Override
    public boolean alreadyDownloadedByUser(int noteId, int userId) 
    {
        boolean f =false;
        
        try 
        {
            String sql = "SELECT * FROM downloads WHERE note_id = ? AND user_id = ?";
            PreparedStatement ps_alreadyDownloadedByUser = con.prepareStatement(sql);
            ps_alreadyDownloadedByUser.setInt(1,noteId);
            ps_alreadyDownloadedByUser.setInt(2,userId);
            
            ResultSet rs = ps_alreadyDownloadedByUser.executeQuery();
            if(rs.next())
            {
                f = true;
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in DownloadDAOImpl - alreadyDownloadedByUser : "+e);
        }
        
        return f;
      
    }
    
    // ------------------------------------------------ Returns the most downloaded number -----------------------------------
    @Override
    public int getMostDownloadedNote(int subjectId) 
    {
        int max = 0;
        
        try
        {
            String sql = "SELECT MAX(downloadCount) as most_downloaded FROM note WHERE subject_id=? AND notePrice=0";
            PreparedStatement ps_maxDownload = con.prepareStatement(sql);
            ps_maxDownload.setInt(1,subjectId);
            
            ResultSet rs = ps_maxDownload.executeQuery();
            if(rs.next())
            {
                max = rs.getInt(1);
            }
        }
        catch(Exception e)
        {
            System.out.println("There is error in DownloadDAOImpl - getMostDownloadedNote : "+e);
        }

        return max;
       
    }

    // ------------------------------------------------ Returns the most downloaded paid number -----------------------------------
    
    @Override
    public int getMostDownloadedPaidNote(int subjectId)
    {
        int max = 0;
        
        try
        {
            String sql = "SELECT MAX(downloadCount) as most_downloaded FROM note WHERE subject_id=? AND notePrice>0";
            PreparedStatement ps_maxDownload = con.prepareStatement(sql);
            ps_maxDownload.setInt(1,subjectId);
            
            ResultSet rs = ps_maxDownload.executeQuery();
            if(rs.next())
            {
                max = rs.getInt(1);
            }
        }
        catch(Exception e)
        {
            System.out.println("There is error in DownloadDAOImpl - getMostDownloadedPaidNote : "+e);
        }

        return max;
        
    }
    
    // ----------------------------------------------  Returns the most downloaded number from that searched string --------------------------------------

    @Override
    public int getMostDownloadedNoteSearch(String ch) 
    {
        int max = 0;
        
        try
        {
            String sql = "SELECT MAX(downloadCount) as most_downloaded FROM note WHERE categoryName like ? or courseName like ? or subjectName like ? or noteTitle like ? AND notePrice=0";
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
            System.out.println("There is error in DownloadDAOImpl - getMostDownloadedNoteSearch : "+e);
        }

        return max;
    }

     // ----------------------------------------------  Returns the most downloaded paid number from that searched string --------------------------------------
    
    @Override
    public int getMostDownloadedPaidNoteSearch(String ch) 
    {
        int max = 0;
        
        try
        {
            String sql = "SELECT MAX(downloadCount) as most_downloaded FROM note WHERE categoryName like ? or courseName like ? or subjectName like ? or noteTitle like ? AND notePrice>0";
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
            System.out.println("There is error in DownloadDAOImpl - getMostDownloadedPaidNoteSearch : "+e);
        }

        return max;
    }
    
}
