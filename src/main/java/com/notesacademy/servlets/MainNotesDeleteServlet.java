/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.notesacademy.DAO.NoteDAOImpl;
import com.notesacademy.DB.DBConnection;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nivek
 */
public class MainNotesDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        
        HttpSession session = request.getSession(); // WE CREATE A SESSION 
        int noteId = Integer.parseInt(request.getParameter("nid"));
        String filePath = request.getParameter("nfile"); 

        String to = request.getParameter("uemail"); 
        String subject = request.getParameter("emailsubject"); 
        String messg = request.getParameter("emailmessage"); 
        
//        String folderName = "resourcesmain";
        String deletePath = request.getServletContext().getRealPath("") + File.separator + filePath;
        
        // Sender's email ID and password needs to be mentioned
        final String from = "enotesprojects@gmail.com";
        final String pass = "ENotesProjects";

        // Defining the gmail host
        String host = "smtp.gmail.com";

        // Creating Properties object
        Properties props = new Properties();

        // Defining properties
        props.put("mail.smtp.host", host);

        props.put("mail.transport.protocol", "smtp");

        props.put("mail.smtp.auth", "true");

        props.put("mail.smtp.starttls.enable", "true");

        props.put("mail.user", from);

        props.put("mail.password", pass);

        props.put("mail.port", "443");

        // Authorized the Session object.
        Session mailSession = Session.getInstance(props, new Authenticator() 
        {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() 
            {
                return new PasswordAuthentication(from, pass);
            }

        });
 
        //Step 2 : compose the message [text,multi media]
    
        // Create a default MimeMessage object.
        MimeMessage message = new MimeMessage(mailSession);

        try 
        {
            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set Subject: header field
            message.setSubject(subject);

            // Now set the actual message
            message.setText(messg);

            // Send message
            Transport.send(message);
            
            System.out.println("Email sent success...................");

        } 
        catch (MessagingException mex) 
        {
            System.out.println("There is error in MainNotesDeleteServlet : "+mex);
        }   
        
        
        try 
        {

            
            NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection()); // CONNECTS TO THE DATABASE
            
            boolean f = dao.deleteMainNote(noteId);
            
            
            if(f)
            {
                try{
                    Files.deleteIfExists(Paths.get(deletePath));
                   
                }
                catch(Exception e)
                {
                    System.out.println("There is error in MainNotesDeleteServlet : "+e);
                }
                
                    System.out.println("Message sent - Note deleted");
                    response.sendRedirect("display_notes.jsp"); 
            }
            else
            {
                    System.out.println("Message not sent - Note not deleted");
                    response.sendRedirect("display_notes.jsp"); 
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in MainNotesDeleteServlet : "+e);
        }
   
    }


}
