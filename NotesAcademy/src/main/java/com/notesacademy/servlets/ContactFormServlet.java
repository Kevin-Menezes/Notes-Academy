
package com.notesacademy.servlets;

import com.notesacademy.DAO.UserDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Feedback;
import com.notesacademy.entities.Message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



public class ContactFormServlet extends HttpServlet 
{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        try
        {
            HttpSession session = request.getSession(); // WE CREATE A SESSION 
        
            String userName = request.getParameter("uname"); 
            String userEmail = request.getParameter("uemail"); 
            String feedbackMessage = request.getParameter("message"); 
            
            Feedback f = new Feedback();
            f.setUserName(userName);
            f.setUserEmail(userEmail);
            f.setFeedbackMessage(feedbackMessage);
            
            UserDAOImpl dao = new UserDAOImpl(DBConnection.getConnection()); // WE CONNECT THE DATABASE BY CALLING THE DAOImpl FUNCTION
            boolean flag = dao.sendFeedback(f);
            
            if(flag)
                    {
                        Message msg = new Message("Message sent successfully!", "success", "alert-success");
                        session.setAttribute("message", msg);  
                        response.sendRedirect("contact.jsp"); // DIRECT IT TO THE USERS HOMEPAGE
                    }
                    else
                    {
                        Message msg = new Message("Error in sending message! Kindly retry!", "error", "alert-danger");
                        session.setAttribute("message", msg); 
                        response.sendRedirect("contact.jsp"); 
                    }

            
        }
        catch(Exception e)
        {
            System.out.println("There is error in ContactFormServlet : "+e);
        }
        
        
       
       
    }


}
