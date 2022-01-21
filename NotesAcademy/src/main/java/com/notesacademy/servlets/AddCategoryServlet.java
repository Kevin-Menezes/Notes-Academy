/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.notesacademy.DAO.CategoryDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Category;
import com.notesacademy.entities.Message;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 65536)//64kb
public class AddCategoryServlet extends HttpServlet 
{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        try
        {
            HttpSession session = request.getSession(); // WE CREATE A SESSION
            String catname = request.getParameter("catname");
            Part part = request.getPart("catimage");
            
            if(part!=null)
            {
                    // Converting part to byte array
                    InputStream input = part.getInputStream();
                    ByteArrayOutputStream output = new ByteArrayOutputStream();
                    byte[] buffer = new byte[10240];
                    for (int length = 0; (length = input.read(buffer)) > 0;) output.write(buffer, 0, length);

                    Category c = new Category();
                    c.setCategoryName(catname);
                    c.setCategoryImage(output.toByteArray());

                    CategoryDAOImpl dao = new CategoryDAOImpl(DBConnection.getConnection()); // WE CONNECT THE DATABASE BY CALLING THE DAOImpl FUNCTION
                    boolean f = dao.insertCategory(c);

                    if(f)
                    {
                        Message msg = new Message("Category added successfully!", "success", "alert-success");
                        session.setAttribute("message", msg);  
                        response.sendRedirect("display_categories.jsp"); // DIRECT IT TO THE USERS HOMEPAGE
                    }
                    else
                    {
                        Message msg = new Message("Error in adding category! Kindly retry!", "error", "alert-danger");
                        session.setAttribute("message", msg); 
                        response.sendRedirect("display_categories.jsp"); 
                    }
            }
            else
                {
                    Message msg = new Message("Error in adding category! Kindly retry!", "error", "alert-danger");
                    session.setAttribute("message", msg); 
                    response.sendRedirect("display_categories.jsp"); 
                }
            
        }
        catch(Exception e)
        {
            System.out.println("There is error in AddCategoryServlet : "+e);
        }
        
    }

}
