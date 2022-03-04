
package com.notesacademy.DAO;

import com.notesacademy.entities.Note;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NoteDAOImpl implements NoteDAO
{
    private Connection con;
    
    public NoteDAOImpl(Connection con)
    {
        super();
        this.con = con;
    }

//    --------------------------------------------------- Displaying notes in the main website based on the subject id -----------------------------------------
    
    @Override
    public List<Note> getNotes(int subjectId) 
    {
       List<Note> list = new ArrayList<Note>();
       Note n = null;
       
        try 
        {
            String sql = "SELECT * FROM note WHERE subject_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,subjectId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserName(rs.getString(9));
                n.setUserProfession(rs.getString(10));
                n.setUserCollege(rs.getString(11));
                n.setFilePath(rs.getString(12));
                n.setSubject_id(rs.getInt(13));
                n.setUserId(rs.getInt(15));
                n.setNotePrice(rs.getInt(16));
                n.setNoteRazor(rs.getString(17));
                
                
                System.out.println(n);
                list.add(n);
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - getNotes : "+e);
        }
        
        System.out.println("Notes : "+list);
        return list;
       
    }
    
    
    // --------------------------------------------- Fetch notes by the character that is typed in the  Search bar ----------------------------------------------------

    @Override
    public List<Note> getNotesBySearch(String ch) 
    {
        List<Note> list = new ArrayList<Note>();
        Note n = null;
        
        try 
        {
            String sql = "SELECT * FROM note WHERE categoryName like ? or courseName like ? or subjectName like ? or noteTitle like ? ";
            PreparedStatement ps1 = con.prepareStatement(sql);
            
            ps1.setString(1, "%"+ch+"%"); // We use % to search for  all words that has the character in them either before or after
            ps1.setString(2, "%"+ch+"%");
            ps1.setString(3, "%"+ch+"%");
            ps1.setString(4, "%"+ch+"%");
            
            ResultSet rs = ps1.executeQuery();
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserName(rs.getString(9));
                n.setUserProfession(rs.getString(10));
                n.setUserCollege(rs.getString(11));
                n.setFilePath(rs.getString(12));
                n.setSubject_id(rs.getInt(13));
                n.setUserId(rs.getInt(15));
                n.setNotePrice(rs.getInt(16));
                n.setNoteRazor(rs.getString(17));
                
                System.out.println(n);
                list.add(n);
            }

        } 
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - getNotesBySearch : "+e);
        }
        
         System.out.println("Notes : "+list);
        return list;
       
    }
    
    // ------------------------------------------- User sends notes to the temporary database for approval --------------------------------------------

    @Override
    public boolean sendNotes(Note n) 
    {
        boolean f = false;
        
        try
        {
         String sql = "INSERT INTO tempnotes(noteTitle,noteDescription,categoryName,courseName,subjectYear,subjectName,noteDate,userId,userName,userProfession,userCollege,pdfPath,subject_id,notePrice,noteRazor) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"; 
       
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1,n.getNoteTitle());
            ps.setString(2,n.getNoteDescription());                
            ps.setString(3,n.getCategoryName());
            ps.setString(4,n.getCourseName());
            ps.setString(5,n.getSubjectYear());
            ps.setString(6,n.getSubjectName());
            ps.setString(7,n.getNoteDate());
            ps.setInt(8,n.getUserId());
            ps.setString(9,n.getUserName());
            ps.setString(10,n.getUserProfession());
            ps.setString(11,n.getUserCollege());
        
            ps.setString(12,n.getFilePath());
            ps.setInt(13,n.getSubject_id());
            //ps.setBytes(13,bytes);
            ps.setInt(14,n.getNotePrice());
            ps.setString(15,n.getNoteRazor());
        
            int i = ps.executeUpdate();
            
            if(i>0)
            {
                f=true;
            }
            
        }
        catch(SQLException e)
        {
            System.out.println("There is error in NoteDAOImpl - sendNotes : "+e);
        } 
 
        return f;
        
    }

     // ------------------------------------------------ Count of Notes --------------------------------------
    
    @Override
    public int getNotesCount() 
    {
        int count = 0;
        
        try 
        {
            String sql = "SELECT COUNT(noteTitle) FROM note";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        } 
        
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - getNotesCount : "+e);
        }
        
        return count;
        
    }
    
    // ---------------------------------------------- Displays notes which are in tempnotes table -------------------------------------------

    @Override
    public List<Note> approveNotes() 
    {
        List<Note> list = new ArrayList<Note>();
        
        Note n = null;
        
        try
        {
            String sql = "SELECT * FROM tempnotes ORDER BY noteId DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ResultSet rs = ps.executeQuery();
          
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));       
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserId(rs.getInt(9));
                n.setUserName(rs.getString(10));
                n.setUserProfession(rs.getString(11));
                n.setUserCollege(rs.getString(12));
                //Blob blob = rs.getBlob(14);
                n.setFilePath(rs.getString(13));
                n.setSubject_id(rs.getInt(14));
                n.setNotePrice(rs.getInt(15));
                n.setNoteRazor(rs.getString(16));
                list.add(n);
         
                //System.out.println(blob+"This is blob");
                //byte[] byteArray = blob.getBytes(1,(int)blob.length());
          
            }
            
        }
        catch (Exception e)
        {
           System.out.println("There is error in NoteDAOImpl - approveNotes : "+e);
        }
        
        return list;
       
    }

    // -------------------------------------------- Get details of a particular note based on its id -------------------------------------------
    
    @Override
    public Note getTempNoteById(int id) 
    {
        Note n = null;
        
         try
        {
            String sql = "SELECT * FROM tempnotes WHERE noteId=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserId(rs.getInt(9));
                n.setUserName(rs.getString(10));
                n.setUserProfession(rs.getString(11));
                n.setUserCollege(rs.getString(12));  
                //Blob blob = rs.getBlob(12);
                n.setFilePath(rs.getString(13));
                n.setSubject_id(rs.getInt(14));
                n.setNotePrice(rs.getInt(15));
                n.setNoteRazor(rs.getString(16));

                
  
            }
            
        }
         catch(Exception e)
         {
             System.out.println("There is error in NoteDAOImpl - getTempNoteById : "+e);
         }
        
        return n;
        
    }
    
    // ---------------------------------------------------------------- Adding the note to the note table ------------------------------------

    @Override
    public boolean addNote(Note n) 
    {
        boolean f = false;
        
        try
        {
         String sql = "INSERT INTO note(noteTitle,noteDescription,categoryName,courseName,subjectYear,subjectName,noteDate,userName,userProfession,userCollege,pdfPath,subject_id,userId,notePrice,noteRazor) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"; 
       
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1,n.getNoteTitle());
            ps.setString(2,n.getNoteDescription());     
            ps.setString(3,n.getCategoryName());
            ps.setString(4,n.getCourseName());
            ps.setString(5,n.getSubjectYear());
            ps.setString(6,n.getSubjectName());
            ps.setString(7,n.getNoteDate());
            ps.setString(8,n.getUserName());
            ps.setString(9,n.getUserProfession());
            ps.setString(10,n.getUserCollege());
            ps.setString(11,n.getFilePath());
            ps.setInt(12,n.getSubject_id());
            ps.setInt(13, n.getUserId());
            ps.setInt(14,n.getNotePrice());
            ps.setString(15,n.getNoteRazor());
            //ps.setBytes(13,bytes);
        
            int i = ps.executeUpdate();
            
            if(i>0)
            {
                f=true;
            }
            
        }
        catch(SQLException e)
        {
            System.out.println("There is error in NoteDAOImpl - addNote : "+e);
        } 
 
        return f;
    }
    
    // --------------------------------------------- Deleting note from the tempnotes table -------------------------------------------

    @Override
    public boolean deleteTempNote(int id) 
    {
        boolean f = false;
       
        try 
        {
            String sql = "DELETE FROM tempnotes WHERE noteId=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,id);
            
            int i = ps.executeUpdate();
            if(i==1)
            {
                f=true;
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - deleteTempNote : "+e);
        }
       
   
       return f;
        
    }

//  ----------------------------------------  Get details of main notes from note table based on noteid ----------------------------------------------
    
    @Override
    public Note getNoteById(int id) 
    {
        Note n = null;
        
         try
        {
            String sql = "SELECT * FROM note WHERE noteId=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserName(rs.getString(9));
                n.setUserProfession(rs.getString(10));
                n.setUserCollege(rs.getString(11));  
                //Blob blob = rs.getBlob(12);
                n.setFilePath(rs.getString(12));
                n.setSubject_id(rs.getInt(13));
                n.setUserId(rs.getInt(15));
  
            }
            
        }
         catch(Exception e)
         {
             System.out.println("There is error in NoteDAOImpl - getNoteById : "+e);
         }
        
        return n;
        
    }

    
    //  --------------------------------------------------------  Edits details of a particular note ----------------------------------------------
    
    @Override
    public boolean updateEditNote(Note n) 
    {
        boolean f = false;
       
       try
       {
           String sql = "UPDATE note SET noteTitle=?,noteDescription=?,categoryName=?,courseName=?,subjectYear=?,subjectName=?,pdfPath=? WHERE noteId=?";
           PreparedStatement ps = con.prepareStatement(sql);
           
           ps.setString(1,n.getNoteTitle());
           ps.setString(2,n.getNoteDescription());  
           ps.setString(3,n.getCategoryName());
           ps.setString(4,n.getCourseName());
           ps.setString(5,n.getSubjectYear());
           ps.setString(6,n.getSubjectName());
           ps.setString(7,n.getFilePath());
           ps.setInt(8,n.getNoteId());
           
           int i = ps.executeUpdate();
           
           if(i>0)
           {
               f=true;
           }
       
       
       }
       catch(Exception e)
       {
           System.out.println("There is error in NoteDAOImpl - updateEditNote : "+e);
       }
       
       return f;
    }

    // ----------------------------------------------------------- Delete a note based on note id -------------------------------------------------------------------
    
    @Override
    public boolean deleteNote(int id) 
    {
        boolean f = false;
        
        try
        {
            String sql = "DELETE FROM note WHERE noteId = ?";
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
            System.out.println("There is error in NoteDAOImpl - deleteNote : "+e);
        }
        return f;

    }
    
    
    // ----------------------------------------------------------- Get recent notes based on particular subject -------------------------------------------------------------------

    @Override
    public List<Note> getRecentNotes(int subjectId) 
    {
        List<Note> list = new ArrayList<Note>();
       Note n = null;
       
        try 
        {
            String sql = "SELECT * FROM note WHERE subject_id = ? ORDER BY noteId DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,subjectId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserName(rs.getString(9));
                n.setUserProfession(rs.getString(10));
                n.setUserCollege(rs.getString(11));
                n.setFilePath(rs.getString(12));
                n.setSubject_id(rs.getInt(13));
                n.setUserId(rs.getInt(15));
                n.setNotePrice(rs.getInt(16));
                n.setNoteRazor(rs.getString(17));
                
                System.out.println(n);
                list.add(n);
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - getRecentNotes : "+e);
        }
        
        System.out.println("Notes : "+list);
        return list;
 
    }
    
    // ----------------------------------------------------------- Get all notes (recent notes index.jsp page)  -------------------------------------------------------------------

    @Override
    public List<Note> getAllNotes() 
    {
        List<Note> list = new ArrayList<Note>();
       Note n = null;
       
        try 
        {
            String sql = "SELECT * FROM note ORDER BY noteId DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            int i = 1; 
            while(rs.next() && i<=4)
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserName(rs.getString(9));
                n.setUserProfession(rs.getString(10));
                n.setUserCollege(rs.getString(11));
                n.setFilePath(rs.getString(12));
                n.setSubject_id(rs.getInt(13));
                n.setUserId(rs.getInt(15));
                n.setNotePrice(rs.getInt(16));
                n.setNoteRazor(rs.getString(17));
                i++;
                
                System.out.println(n);
                list.add(n);
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - getAllNotes : "+e);
        }
        
        System.out.println("Notes : "+list);
        return list;
        
    }

    // ------------------------------------------------------------- Recent Notes from search bar ----------------------------------------------------------------------
    @Override
    public List<Note> getRecentSearchNotes(String ch) 
    {
        List<Note> list = new ArrayList<Note>();
        Note n = null;
        
        try 
        {
            String sql = "SELECT * FROM note WHERE categoryName like ? or courseName like ? or subjectName like ? or noteTitle like ? ORDER BY noteId DESC";
            PreparedStatement ps1 = con.prepareStatement(sql);
            
            ps1.setString(1, "%"+ch+"%"); // We use % to search for  all words that has the character in them either before or after
            ps1.setString(2, "%"+ch+"%");
            ps1.setString(3, "%"+ch+"%");
            ps1.setString(4, "%"+ch+"%");
            
            ResultSet rs = ps1.executeQuery();
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserName(rs.getString(9));
                n.setUserProfession(rs.getString(10));
                n.setUserCollege(rs.getString(11));
                n.setFilePath(rs.getString(12));
                n.setSubject_id(rs.getInt(13));
                n.setUserId(rs.getInt(15));
                n.setNotePrice(rs.getInt(16));
                n.setNoteRazor(rs.getString(17));
                
                System.out.println(n);
                list.add(n);
            }

        } 
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - getNotesBySearch : "+e);
        }
        
         System.out.println("Notes : "+list);
        return list;
       
    }
    
    // ------------------------------------------------------------- Mostliked notes ----------------------------------------------------------------------

    @Override
    public List<Note> getMostLikedNotes(int subjectId) 
    {
        List<Note> list = new ArrayList<Note>();
       Note n = null;
       
        try 
        {
            String sql = "SELECT * FROM note WHERE subject_id = ? ORDER BY likeCount DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,subjectId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserName(rs.getString(9));
                n.setUserProfession(rs.getString(10));
                n.setUserCollege(rs.getString(11));
                n.setFilePath(rs.getString(12));
                n.setSubject_id(rs.getInt(13));
                n.setUserId(rs.getInt(15));
                n.setNotePrice(rs.getInt(16));
                n.setNoteRazor(rs.getString(17));
                
                System.out.println(n);
                list.add(n);
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - getRecentNotes : "+e);
        }
        
        System.out.println("Notes : "+list);
        return list;
  
    }

    // -------------------------------- Fetching most liked notes from the db based on a particular search ----------------------------
    
    @Override
    public List<Note> getMostLikedSearchNotes(String ch) 
    {
        List<Note> list = new ArrayList<Note>();
        Note n = null;
        
        try 
        {
            String sql = "SELECT * FROM note WHERE categoryName like ? or courseName like ? or subjectName like ? or noteTitle like ? ORDER BY likeCount DESC";
            PreparedStatement ps1 = con.prepareStatement(sql);
            
            ps1.setString(1, "%"+ch+"%"); // We use % to search for  all words that has the character in them either before or after
            ps1.setString(2, "%"+ch+"%");
            ps1.setString(3, "%"+ch+"%");
            ps1.setString(4, "%"+ch+"%");
            
            ResultSet rs = ps1.executeQuery();
            while(rs.next())
            {
                n = new Note();
                n.setNoteId(rs.getInt(1));
                n.setNoteTitle(rs.getString(2));
                n.setNoteDescription(rs.getString(3));
                n.setCategoryName(rs.getString(4));
                n.setCourseName(rs.getString(5));
                n.setSubjectYear(rs.getString(6));
                n.setSubjectName(rs.getString(7));
                n.setNoteDate(rs.getString(8));
                n.setUserName(rs.getString(9));
                n.setUserProfession(rs.getString(10));
                n.setUserCollege(rs.getString(11));
                n.setFilePath(rs.getString(12));
                n.setSubject_id(rs.getInt(13));
                n.setUserId(rs.getInt(15));
                n.setNotePrice(rs.getInt(16));
                n.setNoteRazor(rs.getString(17));
                
                System.out.println(n);
                list.add(n);
            }

        } 
        catch (Exception e) 
        {
            System.out.println("There is error in NoteDAOImpl - getMostLikedSearchNotes : "+e);
        }
        
         System.out.println("Notes : "+list);
        return list;
        
    }

}
