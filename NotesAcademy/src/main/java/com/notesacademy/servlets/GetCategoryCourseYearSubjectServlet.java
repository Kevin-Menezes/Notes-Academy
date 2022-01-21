/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.google.gson.Gson;
import com.notesacademy.DAO.CategoryDAOImpl;
import com.notesacademy.DAO.CourseDAOImpl;
import com.notesacademy.DAO.SubjectDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Category;
import com.notesacademy.entities.Course;
import com.notesacademy.entities.Subject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class GetCategoryCourseYearSubjectServlet extends HttpServlet 
{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        try (PrintWriter out = response.getWriter()) 
        {

            CategoryDAOImpl catdao = new CategoryDAOImpl(DBConnection.getConnection());
            CourseDAOImpl coudao = new CourseDAOImpl(DBConnection.getConnection());
            SubjectDAOImpl subdao = new SubjectDAOImpl(DBConnection.getConnection());
            String op = request.getParameter("operation");
            
            if (op.equals("category")) {
                List<Category> catlist = catdao.getCategoriesWithoutImg();
                Gson json = new Gson();
                String categoryList = json.toJson(catlist);
                System.out.println("This is json Category List : "+categoryList);
                response.setContentType("text/html");
                response.getWriter().write(categoryList);
            }
            
            if (op.equals("course")) {
                int categoryId = Integer.parseInt(request.getParameter("id"));
                List<Course> coulist = coudao.getCourses(categoryId);
                Gson json = new Gson();
                String courseList = json.toJson(coulist);
                System.out.println("This is json Course List : "+coulist);
                response.setContentType("text/html");
                response.getWriter().write(courseList);
            }
            
            if (op.equals("year")) {
                int courseId = Integer.parseInt(request.getParameter("id"));
                List<String> yearslist = subdao.getNoOfYears(courseId);
                Gson json = new Gson();
                String yearList = json.toJson(yearslist);
                System.out.println("This is json Years List : "+yearList);
                response.setContentType("text/html");
                response.getWriter().write(yearList);
            }
            
            if (op.equals("subject")) {
                int courseId = Integer.parseInt(request.getParameter("id"));
                String courseYear = request.getParameter("cyear");
                List<Subject> sublist = subdao.getSubjects(courseId, courseYear);
                Gson json = new Gson();
                String subjectList = json.toJson(sublist);
                System.out.println("This is json Years List : "+subjectList);
                response.setContentType("text/html");
                response.getWriter().write(subjectList);
            }
            
        }
            
    }

}
