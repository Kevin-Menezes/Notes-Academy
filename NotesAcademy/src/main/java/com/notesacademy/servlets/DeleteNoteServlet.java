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


public class DeleteNoteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        HttpSession session = request.getSession(); // WE CREATE A SESSION 
        int noteId = Integer.parseInt(request.getParameter("id"));
        
        NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection()); // WE CONNECT THE DATABASE BY CALLING THE DAOImpl FUNCTION
        boolean f = dao.deleteNote(noteId);
        
         if(f)
            {
                Message msg = new Message("Note deleted successfully!", "success", "alert-success");
                session.setAttribute("message", msg);  
                response.sendRedirect("display_notes.jsp"); 
            }
            else
            {
                Message msg = new Message("Error in deletion! Kindly retry!", "error", "alert-danger");
                session.setAttribute("message", msg); 
                response.sendRedirect("display_notes.jsp"); 
            }
    }

}
