package com;

import com.notesacademy.DAO.SubjectDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Subject;
import static org.hamcrest.CoreMatchers.is;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;

public class TestSubjectMethods {
    
    SubjectDAOImpl sdao; 
    
    @Before
    public void setup(){
        
        sdao = new SubjectDAOImpl(DBConnection.getConnection());
    }
    
    // Fetch First Year subjects based on a particular course
    @Test
    public void testFetchFirstYearSubjects(){
        
        assertNotNull(sdao.getFirstYearSubjects(2));
    }
    
    // Fetch Second Year subjects based on a particular course
    @Test
    public void testFetchSecondYearSubjects(){
        
        assertNotNull(sdao.getSecondYearSubjects(10));
    }
    
    // Fetch Third Year subjects based on a particular course
    @Test
    public void testFetchThirdYearSubjects(){
        
        assertNotNull(sdao.getThirdYearSubjects(2));
    }
    
    // Fetch Fourth Year subjects based on a particular course
    @Test
    public void testFetchFourthYearSubjects(){
        
        assertNotNull(sdao.getFourthYearSubjects(0));
        
    }
    
    // Get number of years present in each particular course
    @Test
    public void testgetNoOfYears()
    {
        assertNotNull(sdao.getNoOfYears(2));
    }
    
    // Fetch subjects based on the particular course and its year
    @Test
    public void testFetchSubjects()
    {
        assertNotNull(sdao.getSubjects(2, "Third Year"));
    }
    
    // Get count of total subjects
    @Test
    public void testFetchSubjectsCount()
    {
        assertThat(sdao.getSubjectsCount(),is(130));
    }
    
    // Fetch a particular subject details
    @Test
    public void testFetchSubjectDetails()
    {
        assertNotNull(sdao.getSubjectById(5));
    }
    
    // Edit particular subject details
    @Test
    @Ignore
    public void testEditSubjectDetails()
    {
        Subject s = new Subject();
        s.setSubjectName("EVS");
        s.setSubjectYear("First Year");
        s.setSubjectId(2);
        
        assertTrue(sdao.updateEditSubject(s));
    }
    
    // Delete particular subject
    @Test
    @Ignore
    public void testDeleteSubject()
    {
        assertTrue(sdao.deleteSubject(135));    
    }
    
    // Insert subject in a particular course
    @Test
    @Ignore
    public void testInsertSubject(){
        
        Subject s = new Subject();
        s.setSubjectName("New Subject");
        s.setSubjectYear("Third Year");
        s.setCourse_id(18);
        
        assertTrue(sdao.insertSubject(s));
    }
            
    
}
