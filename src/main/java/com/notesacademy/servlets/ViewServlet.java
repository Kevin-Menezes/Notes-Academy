
package com.notesacademy.servlets;

import com.notesacademy.DAO.ViewDAOImpl;
import com.notesacademy.DB.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ViewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            // Fetching operation from Like.js
            String operation = request.getParameter("operation");
 
            int noteId = Integer.parseInt(request.getParameter("noteId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int nuserId = Integer.parseInt(request.getParameter("nuserId"));
            System.out.println(noteId);
            System.out.println(userId);
            System.out.println(nuserId);
            
           
//            out.println("data from server");
//            out.println("operation");
//            out.println(userId);
//            out.println(noteId);

            ViewDAOImpl vdao = new ViewDAOImpl(DBConnection.getConnection());
            if(operation.equals("view"))
            {    
                if(vdao.alreadyViewedByUser(noteId, userId))
                    {
                        
                    }
                    else
                    {
                        boolean f = vdao.insertView(noteId, userId, nuserId);
                        System.out.println(f);                    
                    }
                
            }
            // Here out.println prints in console

        }

    }


}
