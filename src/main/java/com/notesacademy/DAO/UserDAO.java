
package com.notesacademy.DAO;

// THIS IS ONLY AN INTERFACE WHERE WE WE ONLY WRITE THE FUNCTION DECLARATION

import com.notesacademy.entities.Feedback;
import com.notesacademy.entities.UserDetails;
import java.util.List;

// THEN FOR EACH FUNCTION WE WILL LINK IT TO THE DATABASE IN THE UserDAOImpl.java FILE
public interface UserDAO 
{
    // USER SIGNUP (TRUE OR FALSE IS RETURNED) (WHETHER DATA IS INSERTED OR NOT)
    public boolean userSignup(UserDetails us);
    
    // USER LOGIN (USERS DETAILS ARE RETURNED IF THE USER HAS SIGNED UP FIRST)
    public UserDetails userLogin(String email, String password);
    
    public int getUsersCount(); // Total number of users
    
    public int getAdminsCount(); // Total number of users
    
    List<UserDetails> getUsers(); // Gets the details of all the users
    
    List<UserDetails> getAdmins(); // Gets the details of all the admins
    
    public UserDetails getUserById(int id); // Gets a particular users details from userid  
    
     public boolean updateEditUser(UserDetails us); // Updates user details based on user id
     
     public boolean deleteUser(int id); //  Deletes the user based on the user id
     
     public boolean sendFeedback(Feedback f); // Sends feedback from contact page to the user
     
     public boolean updateUserRank(int uid); // Updates user rank based on user id
    
}
