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
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1000, //10mb...this
        maxFileSize = 1024 * 1024 * 1000, //1gb
        maxRequestSize = 1024 * 1024 * 1000) //1gb

public class AddNotesServlet extends HttpServlet
{
    PrintWriter out = null; // these 2
    HttpSession session = null;
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException 
    {
        resp.setContentType("text/plain;charset = UTF-8"); // this
       
        try
        {
            
            out = resp.getWriter();  // these 7
            session = req.getSession(false);
            String folderName = "resourcesmain";
            String uploadPath = req.getServletContext().getRealPath("") + File.separator + folderName;
            
            File dir = new File(uploadPath);
            if(!dir.exists())
            {
                dir.mkdirs();
            }

            String noteTitle  = req.getParameter("ntitle");
            String noteDescription  = req.getParameter("ndescription");
            
            int notePrice = Integer.parseInt(req.getParameter("nprice"));
            System.out.println("This is notePrice : "+notePrice);
            
            String noteRazor = req.getParameter("nrazor");
            System.out.println("This is noteRazor : "+noteRazor);
            
            String categoryName  = req.getParameter("selectedCategory");
            System.out.println("This is category name : "+categoryName);
            
            String courseName  = req.getParameter("selectedCourse");
            System.out.println("This is course name : "+courseName);
            
            String subjectYear  = req.getParameter("selectedSubjectYear");
            System.out.println("This is subject year : "+subjectYear);
            
            String subjectName  = req.getParameter("selectedSubject");
            System.out.println("This is subject name : "+subjectName);

            int subjectId = Integer.parseInt(req.getParameter("selectedSubjectId"));
            System.out.println("This is subjectId : "+subjectId);
    
            int userId = Integer.parseInt(req.getParameter("uid"));
            String userName  = req.getParameter("uname");
            String userProfession  = req.getParameter("uprofession");
            String userCollege  = req.getParameter("ucollege");
            int userRank = Integer.parseInt(req.getParameter("urank"));
        
            LocalDate ndate = LocalDate.now(); // DATE
            String noteDate = ndate.format(DateTimeFormatter.ofPattern("d-MMM-uuuu"));
            
            final Part filePart = req.getPart("pdf"); // PDF FILE

            String fileName = filePart.getSubmittedFileName();  // these 5
            String path = folderName + File.separator + fileName;
            System.out.println("FileName in NotesAddServlet:  "+fileName);
            System.out.println("Path: NotesAddServlet:  " + uploadPath);
            
            InputStream is = filePart.getInputStream();
            Files.copy(is, Paths.get(uploadPath + File.separator +fileName), StandardCopyOption.REPLACE_EXISTING);
            
            // WITHOUT ID
            Note n = new Note(noteTitle, noteDescription, categoryName, courseName, subjectYear, subjectName, noteDate,userId,userName,userProfession, userCollege,path,subjectId,notePrice,noteRazor,userRank);        
            NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection()); // CONNECTS TO THE DATABASE 
            
            boolean f = dao.addNote(n);
            
             if(f)
            {
                //session.setAttribute("sendnotessuccessMsg", "Note sent for verification successfully!");
                //session.setAttribute("fileName",fileName);
                Message msg = new Message("Note added successfully", "success", "alert-success");
                session.setAttribute("message", msg); 
                System.out.println("Note added");             
                resp.sendRedirect("admin_home.jsp");
            }
            else
            {
                Message msg = new Message("Oops! An error occured! Kindly retry adding the note!", "error", "alert-danger");
                session.setAttribute("message", msg);
                System.out.println("Error in adding note");
                resp.sendRedirect("admin_home.jsp");
            }
                     
        }
        catch(Exception e)
        {
            System.out.println("There is error in AddNotesServlet : "+e);
        }
        
    }

}
