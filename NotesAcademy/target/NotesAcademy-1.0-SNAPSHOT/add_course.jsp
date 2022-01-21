<%-- 
    Document   : add_course
    Created on : 16 Jan, 2022, 10:44:14 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Message"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");

        HttpSession s = request.getSession();
        UserDetails us = (UserDetails) session.getAttribute("admindetails");
        
        if(us==null)
        {
            Message msg = new Message("Please Login First!", "error", "alert-danger");
            s.setAttribute("message", msg);
           response.sendRedirect("index.jsp");
        }
        else if(!"admin@gmail.com".equals(us.getUserEmail()) && !"admin13579".equals(us.getUserPassword()))
        {
            Message msg = new Message("User not allowed in Admin section!", "error", "alert-danger");
            s.setAttribute("message", msg);
            response.sendRedirect("home.jsp");
        }
        else
        {

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin | Add Course</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/display_categories.css">
        
        <style>
            
            .card{
                box-shadow: 0px 2px 45px 0px rgba(0, 0, 0, 0.1);
                border-color: var(--green);
            }
            
            .card-header{ 
                color: white;   
            }
    
            .card:hover{
                box-shadow: none; 
                background-color: wheat;
                opacity: 1;
              
            }  
        </style>
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <div class="container">
            <div class="row col-xl-4 col-lg-6 col-md-8 col-sm-10 col-12 ms-auto me-auto" style="margin-top:6em;">
                <div class="card p-0">
                    <h3 class="card-header  text-white" style="background-color: var(--green); ">ADD COURSE</h3>
                    <div class="card-body">
                        
                        <%
                            
                            int catid = Integer.parseInt(request.getParameter("catid"));

                        %>
                        
                        <!--Edit Category form-->
                        <form action="AddCourseServlet" method="post">

                            <div class="form-group row align-items-center">
                                    
                                <div class="form-group col-12">   
                                    <label for="addCourse" class="form-label">Course name</label>
                                    <input type="text" class="form-control form-control-sm" id="addCourseName" placeholder="Enter Course name" name="couname">
                                    <input type="hidden" name="catid" value="<%= catid %>">
                                </div>
                                
                                <!-- BUTTON -->
                                <div class="form-group d-flex justify-content-center">

                                    <button type="submit" class="btn btn-success col-5 col-sm-3 mt-4">Add</button>                        
                                    <a href="display_courses.jsp" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;">Cancel</a>         

                                </div>
                                
                            </div>
                                
                        </form>
                                
                    </div>
                </div>
            </div>
        </div>

        <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>

    </body>
</html>
<%    }
%>