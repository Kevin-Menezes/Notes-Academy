
package com.notesacademy.DAO;

import com.notesacademy.entities.Course;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CourseDAOImpl implements CourseDAO
{
    
     private Connection con;
    
    public CourseDAOImpl(Connection con)
    {
        super();
        this.con = con;
    }

    // ------------------------------------------------ Retrieve the list of all course names based on a particular id --------------------------------------
    
    @Override
    public List<Course> getCourses(int categoryId) 
    {
        List<Course> list = new ArrayList<Course>();
        Course c = null;
        
        try 
        {
            String sql = "SELECT * FROM course WHERE category_id = ?";
            PreparedStatement ps_getcourses = con.prepareStatement(sql);
            ps_getcourses.setInt(1,categoryId);
            
            ResultSet rs = ps_getcourses.executeQuery();
            while(rs.next())
            {
                c = new Course();
                c.setCourseId(rs.getInt(1));
                c.setCourseName(rs.getString(2));
                c.setCategory_id(rs.getInt(3));

                list.add(c);  
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CourseDAOImpl - getCourses : "+e);
        }
        
        System.out.println("Courses : "+list);
        return list;
       
    }
    
    // ------------------------------------------------ Count of Courses --------------------------------------

    @Override
    public int getCoursesCount() 
    {
        int count = 0;
        
        try 
        {
            String sql = "SELECT COUNT(courseName) FROM course";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        } 
        
        catch (Exception e) 
        {
            System.out.println("There is error in CourseDAOImpl - getCourseCount : "+e);
        }
        
        return count;
        
    }

    // ------------------------------------------------ To get a particular course details based on the course id --------------------------------------
    
    @Override
    public Course getCourseById(int id) 
    {
        Course c = null;
        
        try 
        {
            String sql = "SELECT * FROM course WHERE courseId = ? ";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                c = new Course();
                c.setCourseId(rs.getInt(1));
                c.setCourseName(rs.getString(2));
            }
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CourseDAOImpl - getCourseById : "+e);
        }
        
        return c;
        
    }

    // ------------------------------------------------ Updates the course name based on the course id --------------------------------------
    
    @Override
    public boolean updateEditCourse(Course c) 
    {
        boolean f = false;
        
        try 
        {
            String sql = "UPDATE course SET courseName = ? WHERE courseId = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, c.getCourseName());
            ps.setInt(2, c.getCourseId());
            
            int i = ps.executeUpdate();
            
            if(i>0)
           {
               f = true;
           }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CourseDAOImpl - updateEditCourse : "+e);
        }
        
        return f;

    }

    // -------------------------------------------------- Deletes the course based on the course id ----------------------------------------------
    
    @Override
    public boolean deleteCourse(int id) 
    {
        boolean f = false;
        
        try
        {
            String sql = "DELETE FROM course WHERE courseId = ?";
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
            System.out.println("There is error in CourseDAOImpl - deleteCourse : "+e);
        }
        return f;
        
    }

    // ---------------------------------- Inserts course details in the db along with the category id as foreign key -----------------------------
    
    @Override
    public boolean insertCourse(Course c) 
    {
        boolean f = false;
        try 
        {
            String sql = "INSERT INTO course(courseName,category_id) VALUES (?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,c.getCourseName());       
            ps.setInt(2,c.getCategory_id());
            
            int i = ps.executeUpdate();
            if(i>0)
            {
                f=true;
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CourseDAOImpl - insertCourse : "+e);
        }
        
        
        return f;
        
    }
    
    
    
  
}
