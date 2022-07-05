
package com.notesacademy.servlets;

import com.notesacademy.entities.Message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        HttpSession s = request.getSession();
        s.removeAttribute("userdetails");
        
        Message msg = new Message("Logout successful!", "success", "alert-success");
        s.setAttribute("message", msg);
        response.sendRedirect("index.jsp");

    }

}
