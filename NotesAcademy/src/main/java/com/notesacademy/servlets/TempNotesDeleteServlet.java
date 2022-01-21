/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.notesacademy.DAO.NoteDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class TempNotesDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException 
    {
        try 
        {
            int noteId = Integer.parseInt(req.getParameter("id"));
            
            NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection()); // CONNECTS TO THE DATABASE
            
            boolean f = dao.deleteTempNote(noteId);
            
            HttpSession session = req.getSession();
            
            if(f)
            {
                    Message msg = new Message("Note deleted successfully!", "success", "alert-success");
                    session.setAttribute("message", msg);  
                    resp.sendRedirect("approve_notes.jsp"); 
            }
            else
            {
                    Message msg = new Message("Error in deleting note! Kindly retry!", "error", "alert-danger");
                    session.setAttribute("message", msg); 
                    resp.sendRedirect("approve_notes.jsp"); 
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in TempNotesDeleteServlet : "+e);
        }
    }


}
