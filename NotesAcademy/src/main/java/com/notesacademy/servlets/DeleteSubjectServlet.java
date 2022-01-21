/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.notesacademy.DAO.SubjectDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteSubjectServlet extends HttpServlet 
{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        HttpSession session = request.getSession(); // WE CREATE A SESSION 
        int subjectId = Integer.parseInt(request.getParameter("id"));
        
        SubjectDAOImpl dao = new SubjectDAOImpl(DBConnection.getConnection()); // WE CONNECT THE DATABASE BY CALLING THE DAOImpl FUNCTION
        boolean f = dao.deleteSubject(subjectId);
        
         if(f)
            {
                Message msg = new Message("Subject deleted successfully!", "success", "alert-success");
                session.setAttribute("message", msg);  
                response.sendRedirect("display_subjects.jsp"); 
            }
            else
            {
                Message msg = new Message("Error in deletion! Kindly retry!", "error", "alert-danger");
                session.setAttribute("message", msg); 
                response.sendRedirect("display_subjects.jsp"); 
            }
    }

}
