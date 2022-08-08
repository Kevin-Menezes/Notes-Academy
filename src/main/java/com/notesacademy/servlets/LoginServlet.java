
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

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        try
        {
            HttpSession session = req.getSession(); // WE CREATE A SESSION
            
            UserDAOImpl dao = new UserDAOImpl(DBConnection.getConnection()); // WE CONNECT THE DATABASE BY CALLING THE DAOImpl FUNCTION
           
            String email = req.getParameter("email"); // THIS WE TAKE FROM THE LOGIN FORM
            String password = req.getParameter("password");
            
            UserDetails us = dao.userLogin(email, password);  // WE CALL THE LOGIN FUNCTION WHICH IS IN THE DAO CLASS USING THE dao OBJECT CREATED ABOVE 
            
            if(us!=null && us.getRole().equals("Admin")) // FOR ADMIN SIDE LOGIN
            { 
                session.setAttribute("admindetails", us);
                resp.sendRedirect("admin_home.jsp"); // WE REDIRECT IT TO THE HOME PAGE OF THE ADMIN
            }
            else
            {
                
                if(us!=null && us.getRole().equals("User")) // IF THAT FUNCTION RETURNS ALL USERS DETAILS
                {
                    Message msg = new Message("Login successful!", "success", "alert-success");
                    session.setAttribute("message", msg); 
                    session.setAttribute("userdetails", us);
                    resp.sendRedirect("home.jsp"); // DIRECT IT TO THE USERS HOMEPAGE
                }
                else
                {
                    Message msg = new Message("Error! Invalid username and password!", "error", "alert-danger");
                    session.setAttribute("message", msg); 
                    resp.sendRedirect("index.jsp"); 
                    
                }
                
               
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
    }


}
