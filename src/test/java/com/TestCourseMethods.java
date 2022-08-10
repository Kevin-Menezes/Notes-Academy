package com;

import com.notesacademy.DAO.CourseDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Course;
import static org.hamcrest.CoreMatchers.is;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;

public class TestCourseMethods {
    
    CourseDAOImpl cdao; 
    
    @Before
    public void setup(){
        
        cdao = new CourseDAOImpl(DBConnection.getConnection());
    }
    
    // Fetch courses based on particular category
    @Test
    public void testFetchCourses()
    {     
        assertNotNull(cdao.getCourses(1));
    }
    
    // Get count of total courses
    @Test
    public void testFetchCoursesCount()
    {
        assertThat(cdao.getCoursesCount(),is(24));
    }
    
    // Fetch a particular course details
    @Test
    public void testFetchCourseDetails()
    {
        assertNotNull(cdao.getCourseById(1));
    }
    
    // Edit particular course details
    @Test
    @Ignore
    public void testEditCourseDetails(){
        
        Course c = new Course();
        c.setCourseName("Bachelor of Graphic Design");
        c.setCourseId(24);
        
        assertTrue(cdao.updateEditCourse(c));
    }
    
    // Delete particular course
    @Test
    @Ignore
    public void testDeleteCourse()
    {
        assertTrue(cdao.deleteCourse(23));    
    }
    
    // Insert course in particular category
    @Test
    @Ignore
    public void testInsertCourse(){
        
        Course c = new Course();
        c.setCourseName("Bachelor of Science Data Science");
        c.setCategory_id(1);
        assertTrue(cdao.insertCourse(c));
    }
    
}
