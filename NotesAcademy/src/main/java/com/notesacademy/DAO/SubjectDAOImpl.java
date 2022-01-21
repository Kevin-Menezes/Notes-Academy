
package com.notesacademy.DAO;

import com.notesacademy.entities.Subject;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAOImpl implements SubjectDAO
{
    private Connection con;
    
    public SubjectDAOImpl(Connection con)
    {
        super();
        this.con = con;
    }

    @Override
    public List<Subject> getFirstYearSubjects(int courseId) 
    {
        List<Subject> list = new ArrayList<Subject>();
        Subject s = null;
        
        try
        {
            String sql = "SELECT * FROM subject WHERE course_id = ? AND subjectYear = 'First Year' ";
            PreparedStatement ps_getFirstYearSubject = con.prepareStatement(sql);
            ps_getFirstYearSubject.setInt(1, courseId);
            ResultSet rs =  ps_getFirstYearSubject.executeQuery();
            
            while(rs.next())
            {
                s = new Subject();
                s.setSubjectId(rs.getInt(1));
                s.setSubjectName(rs.getString(2));
                s.setSubjectYear(rs.getString(3));
                s.setCourse_id(rs.getInt(4));
                
                System.out.println(s);
                list.add(s);  
            }
            
        }
        catch(Exception e)
        {
            System.out.println("There is error in SubjectDAOImpl - getFirstYearSubjects : "+e);
        }
        
        System.out.println("Subjects : "+list);
        return list;
        
    }
    
// ----------------------------------------------------------------------------------------------------------------------------------------------------
    
    @Override
    public List<Subject> getSecondYearSubjects(int courseId) 
    {
        List<Subject> list = new ArrayList<Subject>();
        Subject s = null;
        
        try
        {
            String sql = "SELECT * FROM subject WHERE course_id = ? AND subjectYear = 'Second Year' ";
            PreparedStatement ps_getSecondYearSubject = con.prepareStatement(sql);
            ps_getSecondYearSubject.setInt(1, courseId);
            ResultSet rs =  ps_getSecondYearSubject.executeQuery();
            
            while(rs.next())
            {
                s = new Subject();
                s.setSubjectId(rs.getInt(1));
                s.setSubjectName(rs.getString(2));
                s.setSubjectYear(rs.getString(3));
                s.setCourse_id(rs.getInt(4));
                
                System.out.println(s);
                list.add(s);  
            }
            
        }
        catch(Exception e)
        {
            System.out.println("There is error in SubjectDAOImpl - getSecondYearSubjects : "+e);
        }
        
        System.out.println("Subjects : "+list);
        return list;

    }

// ----------------------------------------------------------------------------------------------------------------------------------------------------
    
    @Override
    public List<Subject> getThirdYearSubjects(int courseId) 
    {
        List<Subject> list = new ArrayList<Subject>();
        Subject s = null;
        
        try
        {
            String sql = "SELECT * FROM subject WHERE course_id = ? AND subjectYear = 'Third Year' ";
            PreparedStatement ps_getThirdYearSubject = con.prepareStatement(sql);
            ps_getThirdYearSubject.setInt(1, courseId);
            ResultSet rs =  ps_getThirdYearSubject.executeQuery();
            
            while(rs.next())
            {
                s = new Subject();
                s.setSubjectId(rs.getInt(1));
                s.setSubjectName(rs.getString(2));
                s.setSubjectYear(rs.getString(3));
                s.setCourse_id(rs.getInt(4));
                
                System.out.println(s);
                list.add(s);  
            }
            
        }
        catch(Exception e)
        {
            System.out.println("There is error in SubjectDAOImpl - getThirdYearSubjects : "+e);
        }
        
        System.out.println("Subjects : "+list);
        return list;
        
    }
    
// ----------------------------------------------------------------------------------------------------------------------------------------------------

    @Override
    public List<Subject> getFourthYearSubjects(int courseId) 
    {
        List<Subject> list = new ArrayList<Subject>();
        Subject s = null;
        
        try
        {
            String sql = "SELECT * FROM subject WHERE course_id = ? AND subjectYear = 'Fourth Year' ";
            PreparedStatement ps_getFourthYearSubject = con.prepareStatement(sql);
            ps_getFourthYearSubject.setInt(1, courseId);
            ResultSet rs =  ps_getFourthYearSubject.executeQuery();
            
            while(rs.next())
            {
                s = new Subject();
                s.setSubjectId(rs.getInt(1));
                s.setSubjectName(rs.getString(2));
                s.setSubjectYear(rs.getString(3));
                s.setCourse_id(rs.getInt(4));
                
                System.out.println(s);
                list.add(s);  
            }
            
        }
        catch(Exception e)
        {
            System.out.println("There is error in SubjectDAOImpl - getFirstYearSubjects : "+e);
        }
        
        System.out.println("Subjects : "+list);
        return list;
        
    }

   // ------------------------------------------------------ Get number of available years based on the course----------------------------------------------------------------------------------------
    
    @Override
    public List<String> getNoOfYears(int courseId) 
    {
        List<String> list = new ArrayList<String>();
        
        try 
        {
            String sql = "SELECT DISTINCT subjectYear FROM subject WHERE course_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
            {     
                list.add(rs.getString(1));
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in SubjectDAOImpl - getNoOfYears : "+e);
        }
        
        
        System.out.println("No. of Years : "+list);
        return list;
        
    }
    
    // -------------------------------------------------------- Get Subjects based on the courseId and courseYear ---------------------------------------------------------------------------------------

    @Override
    public List<Subject> getSubjects(int courseId, String courseYear) 
    {
         List<Subject> list = new ArrayList<Subject>();
        Subject s = null;
        
        try
        {
            String sql = "SELECT * FROM subject WHERE course_id = ? AND subjectYear = ? ";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            ps.setString(2,courseYear);
            ResultSet rs =  ps.executeQuery();
            
            while(rs.next())
            {
                s = new Subject();
                s.setSubjectId(rs.getInt(1));
                s.setSubjectName(rs.getString(2));
                s.setSubjectYear(rs.getString(3));
                s.setCourse_id(rs.getInt(4));
                
                System.out.println(s);
                list.add(s);  
            }
            
        }
        catch(Exception e)
        {
            System.out.println("There is error in SubjectDAOImpl - getSubjects : "+e);
        }
        
        System.out.println("Subjects : "+list);
        return list;
        
    }

    // ------------------------------------------------ Count of Subjects --------------------------------------
    
    @Override
    public int getSubjectsCount() 
    {
        int count = 0;
        
        try 
        {
            String sql = "SELECT COUNT(subjectName) FROM subject";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        } 
        
        catch (Exception e) 
        {
            System.out.println("There is error in SubjectDAOImpl - getSubjectCount : "+e);
        }
        
        return count;
        
    }

    // ------------------------------------------------ To get a particular subject details based on the subject id --------------------------------------
    
    @Override
    public Subject getSubjectById(int id) 
    {
        Subject s = null;
        
        try 
        {
            String sql = "SELECT * FROM subject WHERE subjectId = ? ";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                s = new Subject();
                s.setSubjectId(rs.getInt(1));
                s.setSubjectName(rs.getString(2));
                s.setSubjectYear(rs.getString(3));
            }
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in SubjectDAOImpl - getSubjectById : "+e);
        }
        
        return s;
        
    }
    
    // -------------------------------------------------- Updates the subject name  and subject year based on the subject id  ------------------------------------------

    @Override
    public boolean updateEditSubject(Subject s) 
    {
        boolean f = false;
        
        try 
        {
            String sql = "UPDATE subject SET subjectName = ? , subjectYear = ? WHERE subjectId = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, s.getSubjectName() );
            ps.setString(2, s.getSubjectYear());
            ps.setInt(3, s.getSubjectId());
            
            int i = ps.executeUpdate();
            
            if(i>0)
           {
               f = true;
           }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in SubjectDAOImpl - updateEditSubject : "+e);
        }
        
        return f;

    }

    // --------------------------------------------- Delete subject based on the subject id ----------------------------------------------------------------
    
    @Override
    public boolean deleteSubject(int id) 
    {
        boolean f = false;
        
        try
        {
            String sql = "DELETE FROM subject WHERE subjectId = ?";
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
            System.out.println("There is error in SubjectDAOImpl - deleteSubject : "+e);
        }
        return f;
        
    }

//    ------------------------------- Inserts subject details in the db along with the course id as foreign key -----------------------------------------------------
    
    @Override
    public boolean insertSubject(Subject s) 
    {
        boolean f = false;
        try 
        {
            String sql = "INSERT INTO subject(subjectName,subjectYear,course_id) VALUES (?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,s.getSubjectName());       
            ps.setString(2,s.getSubjectYear());
            ps.setInt(3,s.getCourse_id());
            
            int i = ps.executeUpdate();
            if(i>0)
            {
                f=true;
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in SubjectDAOImpl - insertSubject : "+e);
        }
        
        
        return f;
    }
    
    

}
