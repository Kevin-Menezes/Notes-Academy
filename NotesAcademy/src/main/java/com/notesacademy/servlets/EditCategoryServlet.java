/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.notesacademy.DAO.CategoryDAOImpl;
import com.notesacademy.DAO.UserDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Category;
import com.notesacademy.entities.Message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EditCategoryServlet extends HttpServlet 
{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        try 
        {
            HttpSession session = request.getSession(); // WE CREATE A SESSION
            String categoryName = request.getParameter("catname");
            int categoryId = Integer.parseInt(request.getParameter("catid"));
   
            Category c = new Category();
            c.setCategoryName(categoryName);
            c.setCategoryId(categoryId);
  
            CategoryDAOImpl dao = new CategoryDAOImpl(DBConnection.getConnection()); // WE CONNECT THE DATABASE BY CALLING THE DAOImpl FUNCTION
            boolean f = dao.updateEditCategory(c);
            
            if(f)
            {
                Message msg = new Message("Category edited successfully!", "success", "alert-success");
                session.setAttribute("message", msg);  
                response.sendRedirect("display_categories.jsp"); // DIRECT IT TO THE USERS HOMEPAGE
            }
            else
            {
                Message msg = new Message("Error in updation! Kindly retry!", "error", "alert-danger");
                session.setAttribute("message", msg); 
                response.sendRedirect("display_categories.jsp"); 
            }
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in EditCategoryServlet : "+e);
        }
       
    }

}
