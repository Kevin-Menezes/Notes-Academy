/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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


public class EditUserServlet extends HttpServlet 
{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        try 
        {
            HttpSession session = request.getSession(); // WE CREATE A SESSION
            String userName = request.getParameter("uname");
            String userPassword = request.getParameter("upass");
            String userEmail = request.getParameter("uemail");
            String userProfession = request.getParameter("uprof");
            String userCollege = request.getParameter("uclg");
            
            int userId = Integer.parseInt(request.getParameter("uid"));

            UserDetails us = new UserDetails();
            us.setUserName(userName);
            us.setUserPassword(userPassword);
            us.setUserEmail(userEmail);
            us.setUserProfession(userProfession);
            us.setUserCollege(userCollege);
            us.setUserId(userId);
  
            UserDAOImpl dao = new UserDAOImpl(DBConnection.getConnection()); // WE CONNECT THE DATABASE BY CALLING THE DAOImpl FUNCTION
            boolean f = dao.updateEditUser(us);
            
            if(f)
            {
                Message msg = new Message("User edited successfully!", "success", "alert-success");
                session.setAttribute("message", msg);  
                response.sendRedirect("display_users.jsp"); // DIRECT IT TO THE USERS HOMEPAGE
            }
            else
            {
                Message msg = new Message("Error in updation! Kindly retry!", "error", "alert-danger");
                session.setAttribute("message", msg); 
                response.sendRedirect("display_users.jsp"); 
            }
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in EditUserServlet : "+e);
        }

    }

}
