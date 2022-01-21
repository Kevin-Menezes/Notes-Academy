
package com.notesacademy.servlets;

import com.notesacademy.DAO.LikeDAOImpl;
import com.notesacademy.DB.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LikeServlet extends HttpServlet 
{
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
            System.out.println(noteId);
            System.out.println(userId);
            
           
//            out.println("data from server");
//            out.println("operation");
//            out.println(userId);
//            out.println(noteId);

            LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
            if(operation.equals("like"))
            {    
                if(ldao.alreadyLikedByUser(noteId, userId))
                {
                    boolean f = ldao.deleteLike(noteId, userId);
                    out.println(f);
                }
                else
                {
                    boolean f = ldao.insertLike(noteId, userId);
                    out.println(f);
                }
                
            }
            // Here out.println prints in console

        }
    }
}



//    This is the long cut for likes 
//
//package com.notesacademy.servlets;
//
//import com.notesacademy.DAO.LikeDAOImpl;
//import com.notesacademy.DB.DBConnection;
//import java.io.IOException;
//import java.io.PrintWriter;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//public class LikeServlet extends HttpServlet {
//
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) 
//        {
//            // Fetching operation from Like.js
////            String operation = request.getParameter("operation");
// 
//            int noteId = Integer.parseInt(request.getParameter("noteId"));
//            int userId = Integer.parseInt(request.getParameter("userId"));
//            String categoryname = (request.getParameter("categoryname"));
//            String coursename = (request.getParameter("coursename")).replaceAll("\\s+", "-");
//            int subjectid = Integer.parseInt(request.getParameter("subjectid"));
//            String subjectname = (request.getParameter("subjectname")).replaceAll("\\s+", "-");
//            
//            System.out.println(noteId);
//            System.out.println(userId);
//            
//           
////            out.println("data from server");
////            out.println("operation");
////            out.println(userId);
////            out.println(noteId);
//
//            LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
//            
//                boolean f = ldao.insertLike(noteId, userId);
//                out.println(f);
//                response.sendRedirect("notes.jsp?category="+categoryname+"&course="+coursename+"&subjectid="+subjectid+"&subject="+subjectname);
//            
//            
//            
//            
//
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
//
//    