/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.notesacademy.DAO.SubjectDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Message;
import com.notesacademy.entities.Subject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class AddSubjectServlet extends HttpServlet 
{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        try 
        {
            HttpSession session = request.getSession(); // WE CREATE A SESSION
            String subjectName = request.getParameter("subname");
            String subjectYear = request.getParameter("subyear");
            int courseId = Integer.parseInt(request.getParameter("couid"));
            
            Subject s = new Subject();
            s.setSubjectName(subjectName);
            s.setSubjectYear(subjectYear);
            s.setCourse_id(courseId);
            
            SubjectDAOImpl dao = new SubjectDAOImpl(DBConnection.getConnection()); // WE CONNECT THE DATABASE BY CALLING THE DAOImpl FUNCTION
            boolean f = dao.insertSubject(s);
            
            if(f)
            {
                Message msg = new Message("Subject added successfully!", "success", "alert-success");
                session.setAttribute("message", msg);  
                response.sendRedirect("display_subjects.jsp"); 
            }
            else
            {
                Message msg = new Message("Error in adding subject! Kindly retry!", "error", "alert-danger");
                session.setAttribute("message", msg); 
                response.sendRedirect("display_subjects.jsp"); 
            }
            
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in AddSubjectServlet : "+e);
        }
    }

}
