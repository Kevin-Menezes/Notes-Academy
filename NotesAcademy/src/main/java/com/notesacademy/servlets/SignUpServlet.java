
package com.notesacademy.servlets;

import com.notesacademy.DAO.UserDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Message;
import com.notesacademy.entities.UserDetails;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class SignUpServlet extends HttpServlet 
{
   
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException 
    {
        HttpSession session = req.getSession(); // SESSION
        
         try
         {
            String name = req.getParameter("uname"); // THIS uname IS TAKE FROM THE FORM KA name ATTRIBUTE
            String password = req.getParameter("upass");
            String email = req.getParameter("uemail");
            String profession = req.getParameter("uprof");
            String college = req.getParameter("uclg");
     
            // PUTTING THE USERS DETAILS IN THE SETTER IN User.java
            UserDetails us = new UserDetails();
            us.setUserName(name);
            us.setUserPassword(password);
            us.setUserEmail(email);
            us.setUserProfession(profession);
            us.setUserCollege(college);
            
            
            UserDAOImpl dao = new UserDAOImpl(DBConnection.getConnection()); // GETTING THE DB CONNECTION OBJECT FROM getConnection() FUNCTION AND THEN PUTTING IT IN THE UserDAOImpl constructor
            
            boolean f = dao.userSignup(us); // WE CALL THE REGISTER FUNCTION IN DAO CLASS

            if(f) // IF IT IS TRUE
            {
                Message msg = new Message("Sign up successful! Kindly login now!", "success", "alert-success");
                session.setAttribute("message", msg); 
                System.out.println("Signup successful");
                resp.sendRedirect("index.jsp");
            }
            else
            {
                Message msg = new Message("Error! Kindly retry with a different username or email!", "error", "alert-danger");
                session.setAttribute("message", msg);
                System.out.println("Error - Retry with different username");
                resp.sendRedirect("index.jsp");
            }
            
        }
        catch(Exception e)
        {
            Message msg = new Message("Something Went Wrong! Kindly retry with a different username!", "error", "alert-danger");
            session.setAttribute("message", msg);
            System.out.println("Something Went Wrong");
            resp.sendRedirect("index.jsp");
            e.printStackTrace();
        }
           
    }
    
}
