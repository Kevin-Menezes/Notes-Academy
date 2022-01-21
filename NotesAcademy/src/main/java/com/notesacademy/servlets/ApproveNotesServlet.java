/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.notesacademy.DAO.NoteDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Message;
import com.notesacademy.entities.Note;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1000, //10mb...this
        maxFileSize = 1024 * 1024 * 1000, //1gb
        maxRequestSize = 1024 * 1024 * 1000) //1gb
public class ApproveNotesServlet extends HttpServlet 
{
    PrintWriter out = null; // these 2
    HttpSession session = null;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        resp.setContentType("text/plain;charset = UTF-8"); // this
        
        try
        {
            out = resp.getWriter();  // these 7
            session = req.getSession(false);
            String sourcefolderName = "resourcestemp";
            String folderName = "resourcesmain";
            String sourcePath = req.getServletContext().getRealPath("") + File.separator + sourcefolderName;
            String uploadPath = req.getServletContext().getRealPath("") + File.separator + folderName;
            
            File dir = new File(uploadPath);
            if(!dir.exists())
            {
                dir.mkdirs();
            }
   
         int noteId = Integer.parseInt(req.getParameter("id"));
  
         NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection()); // CONNECTS TO THE DATABASE
            
         Note b = dao.getTempNoteById(noteId); // GETTING NOTES BY ID
         
         String noteTitle = b.getNoteTitle();
         String noteDescription = b.getNoteDescription();
         String categoryName = b.getCategoryName();
         String courseName = b.getCourseName();
         String subjectYear = b.getSubjectYear();
         String subjectName = b.getSubjectName();
         String noteDate = b.getNoteDate();
         String userName = b.getUserName();
         String userProfession = b.getUserProfession();
         String userCollege = b.getUserCollege();
         String filePath = b.getFilePath();
         
         String fileName = filePath.substring(14);
         int subjectId = b.getSubject_id();

            String path = folderName + File.separator + fileName;
            System.out.println("FileName in NotesAddServlet:  "+fileName);
            System.out.println("Path: NotesAddServlet:  " + uploadPath);
  
            Files.copy(Paths.get(sourcePath + File.separator +fileName),Paths.get(uploadPath + File.separator +fileName) , StandardCopyOption.REPLACE_EXISTING);
            
            Note n = new Note(noteTitle, noteDescription, categoryName, courseName, subjectYear, subjectName, noteDate,userName,userProfession, userCollege,path,subjectId);
 
            boolean f = dao.addNote(n); // Adding the note to the main database
 
            if(f)
            {
                boolean t = dao.deleteTempNote(noteId);
                if(t)
                {
                    Message msg = new Message("Note approved successfully!", "success", "alert-success");
                    session.setAttribute("message", msg);  
                    resp.sendRedirect("approve_notes.jsp"); 
                    
                }
                else
                {
                    Message msg = new Message("Error in approving note! Kindly retry!", "error", "alert-danger");
                    session.setAttribute("message", msg); 
                    resp.sendRedirect("approve_notes.jsp"); 
                }
                
            }
            else
                {
                    Message msg = new Message("Error in approving note! Kindly retry!", "error", "alert-danger");
                    session.setAttribute("message", msg); 
                    resp.sendRedirect("approve_notes.jsp"); 
                }

        }
        catch(Exception e)
        {
            System.out.println("There is error in ApproveNotesServlet : "+e);
        }
      
    }


}
