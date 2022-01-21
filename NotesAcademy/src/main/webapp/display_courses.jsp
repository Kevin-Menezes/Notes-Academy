<%-- 
    Document   : display_courses
    Created on : 15 Jan, 2022, 11:55:48 PM
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
        <title>Admin | Courses</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/display_courses.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <div class="container">
            <div class="row">       
                <h1 class="text-center" id="tabletitle">Add - Edit - Delete Courses</h1>
                <!--Category and Course Classes-->
                        <% CategoryDAOImpl daocat = new CategoryDAOImpl(DBConnection.getConnection());
                            CourseDAOImpl daocou = new CourseDAOImpl(DBConnection.getConnection());

  //                         Loop 1 - Categories loop
                            List<Category> listcat = daocat.getCategories();
                            for (Category b : listcat) {
                        %>
                
                        <h2 class="mt-3"><b><%=b.getCategoryName() %></b></h2>
                
                
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-success">
                                  <tr>
                                    <th scope="col">No.</th>
                                    <th scope="col">Course name</th>
                                    <th scope="col">Action</th>                     
                                  </tr>
                                </thead>
                                <tbody>
                                    <!--Loop 2 - Courses loop inside Category loop -->
                                    <% List<Course> listcou = daocou.getCourses(b.getCategoryId());
                                    int courseNo=1;
                                        for (Course c : listcou) {
                                    %>
                                    <tr>
                                    <th><%= courseNo++ %></th>
                                    <td><%= c.getCourseName() %></td>
                                    <td>
                                        <!-- BUTTON -->    
                                            <a href="edit_course.jsp?id=<%=c.getCourseId() %>"  class="btn btn-success col-10 col-sm-7 col-md-6 col-lg-4">Edit</a>                        
                                            <a href="DeleteCourseServlet?id=<%=c.getCourseId() %>" class="btn btn-dark col-10 col-sm-7 col-md-6 col-lg-4  ms-0 ms-lg-2 mt-1 mt-lg-0" style="background-color: black;">Delete</a>                                   
                                    </td>     
                                  </tr> 
                                  <%    }
                                   %>
                                </tbody>
                            </table>
                        </div>
                                   <a href="add_course.jsp?catid=<%=b.getCategoryId() %>" id="addcoursesbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add course in <%=b.getCategoryName() %> </span></b></a>
                                   <div class="mx"></div>
                                   <hr class=" mx-auto mt-5">
                                   <%    }
                                   %>
            </div>
        </div>
 
    <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>

    </body>
</html>
<%    }
%>