package com;

import com.notesacademy.DAO.UserDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Feedback;
import com.notesacademy.entities.UserDetails;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.junit.Ignore;
import static org.junit.jupiter.api.Assertions.assertEquals;


public class TestUserMethods {

    UserDAOImpl udao = null;
    
    @Before
    public void setup(){
        
        udao = new UserDAOImpl(DBConnection.getConnection());
    }
    
    // ==================================== Signup =================================
    
    // Run again to check for duplicate entry
    @Test
    @Ignore
    public void testUserSignup() {
        
        UserDetails us = new UserDetails();
        us.setUserName("Larry");
        us.setUserPassword("Larry12345");
        us.setUserEmail("larry@gmail.com");
        us.setUserProfession("Student");
        us.setUserCollege("SIES");
        us.setRole("User");
        
        assertTrue(udao.userSignup(us));
    
    }
    
    // Run again to check for duplicate entry
    @Test
    @Ignore
    public void testAdminSignup() {
        
        UserDetails us = new UserDetails();
        us.setUserName("Jack");
        us.setUserPassword("Jack12345");
        us.setUserEmail("jack@gmail.com");
        us.setUserProfession("");
        us.setUserCollege("");
        us.setRole("Admin");
        
        assertTrue(udao.userSignup(us));
    
    }
    
    // ==================================== Login =================================
    
    @Test
    public void testUserLogin()
    {
        assertNotNull(udao.userLogin("ben@gmail.com","stokes12345"));
    }
    
    @Test
    public void testAdminLogin()
    {
        assertNotNull(udao.userLogin("admin@gmail.com","admin12345"));
    }
    
    // ==================================== Fetch Count =================================
    
    @Test
    public void testUsersCount(){
        
        //assertEquals(18,udao.getUsersCount());
        assertThat(udao.getUsersCount(),is(18));
    }
    
    @Test
    public void testAdminsCount(){
        
        //assertEquals(3,udao.getAdminsCount());
        assertThat(udao.getAdminsCount(),is(3));
    }
    
    // ==================================== Fetch Details =================================
    
    @Test
    public void testFetchAllUsersDetails()
    {    
        assertNotNull(udao.getUsers());
    }
    
    @Test
    public void testFetchAllAdminsDetails()
    {
        assertNotNull(udao.getAdmins());
    }
    
    @Test
    public void testFetchSingleUserDetails()
    {
        assertNotNull(udao.getUserById(19));
    }
    
    // ==================================== Edit Details =================================
    
    @Test
    @Ignore
    public void testEditUserDetails(){
        
        UserDetails us = new UserDetails();
        us.setUserName("Ashwin");
        us.setUserPassword("Ash12345");
        us.setUserEmail("ash@gmail.com");
        us.setUserProfession("Teacher");
        us.setUserCollege("KJ Somaiya");
        us.setUserId(27);
        
        assertTrue(udao.updateEditUser(us));
    }
    
    // ==================================== Delete User =================================
    
    @Test
    @Ignore
    public void testDeleteUser(){
        
        assertTrue(udao.deleteUser(12));
    }
    
    // =========================== Send Feedback from contact page ============================
    
    @Test
    @Ignore
    public void testSendFeedback(){
        
        Feedback f = new Feedback();
        f.setUserName("Stokes");
        f.setUserEmail("ben@gmail.com");
        f.setFeedbackMessage("Benefitting from this website!");
        
        assertTrue(udao.sendFeedback(f));
    }
    
    // ================================ Update user rank ==============================
    
    @Test
    @Ignore
    public void testUpdateUserRank(){
        
        assertTrue(udao.updateUserRank(1));
    }
}
