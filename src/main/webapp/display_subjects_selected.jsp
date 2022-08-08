<%-- 
    Document   : display_subjects_selected
    Created on : 17 Jan, 2022, 9:43:49 AM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Subject"%>
<%@page import="com.notesacademy.DAO.SubjectDAOImpl"%>
<%@page import="com.notesacademy.entities.Message"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");

        HttpSession s = request.getSession();
        UserDetails us = (UserDetails) session.getAttribute("admindetails");
        
        if(us==null)
        {
            Message msg = new Message("User not allowed in Admin section! Please Login First!", "error", "alert-danger");
            s.setAttribute("message", msg);
           response.sendRedirect("index.jsp");
        }
        else
        {

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin | Subjects : <%= request.getParameter("course").replaceAll("-", " ")%></title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/display_subjects_selected.css">

    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/AdminNavbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!--Getting the category name , course id and course name from the url sent from the display_subjects page-->
        <%            
            String categoryname = request.getParameter("category");
            int courseid = Integer.parseInt(request.getParameter("courseid"));
            String coursename = request.getParameter("course").replaceAll("-", " ");
        %> 

        <div class="container">
            <div class="row">       
                <h1 class="text-center" id="tabletitle">Add - Edit - Delete Subjects from <%=coursename%></h1>
                
                <!-- Subjects -->
                        <% SubjectDAOImpl daosub = new SubjectDAOImpl(DBConnection.getConnection());

                            // Loop 1 - First Year
                            List<Subject> listsub1 = daosub.getFirstYearSubjects(courseid);
                             int subjectNo = 1;
                            if (listsub1.isEmpty()) {
                                
                          %>
                          
                          <a href="add_subject.jsp?couid=<%=courseid %>&syear=First-Year" id="addsubjectsbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add subject in First Year</span></b></a>
                          
                          <%

                            } else {

                        %>
                
                        <h2 class="mt-4"><b>First Year</b></h2>
     
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-success">
                                  <tr>
                                    <th scope="col">No.</th>
                                    <th scope="col">Subject name</th>
                                    <th scope="col">Action</th>                     
                                  </tr>
                                </thead>
                                <tbody>
                                    <%                               
                                    for (Subject b : listsub1) {
                                    %>
                                    <tr>
                                    <th><%= subjectNo++ %></th>
                                    <td><%= b.getSubjectName() %></td>
                                    <td>
                                        <!-- BUTTON -->    
                                            <a href="edit_subject.jsp?id=<%=b.getSubjectId() %>"  class="btn btn-success col-10 col-sm-7 col-md-6 col-lg-4">Edit</a>                        
                                            <a href="DeleteSubjectServlet?id=<%=b.getSubjectId() %>" class="btn btn-dark col-10 col-sm-7 col-md-6 col-lg-4  ms-0 ms-lg-2 mt-1 mt-lg-0" style="background-color: black;">Delete</a>                                   
                                    </td>     
                                  </tr> 
                                  <%    }
                                   %>
                                </tbody>
                            </table>
                        </div>
                                   <a href="add_subject.jsp?couid=<%=courseid %>&syear=First-Year" id="addsubjectsbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add subject in First Year</span></b></a>
                                   <div class="mx"></div>
                                   <hr class=" mx-auto mt-5">
                                   <%    }
                                   %>
                                   <!--Loop 1 - First Year end-->
                                   
 <!------------------------------------------------------------------------------------------------------------------------------------------------------------------->                             
                        <%      
                            // Loop 2 - Second Year
                            List<Subject> listsub2 = daosub.getSecondYearSubjects(courseid);
                            subjectNo = 1;
                            if (listsub2.isEmpty()) {
                                
                                 %>
                          
                          <a href="add_subject.jsp?couid=<%=courseid %>&syear=Second-Year" id="addsubjectsbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add subject in Second Year</span></b></a>
                          
                          <%

                            } else {

                        %>
                
                        <h2 class="mt-3"><b>Second Year</b></h2>
     
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-success">
                                  <tr>
                                    <th scope="col">No.</th>
                                    <th scope="col">Subject name</th>
                                    <th scope="col">Action</th>                     
                                  </tr>
                                </thead>
                                <tbody>
                                    <%                               
                                    for (Subject c : listsub2) {
                                    %>
                                    <tr>
                                    <th><%= subjectNo++ %></th>
                                    <td><%= c.getSubjectName() %></td>
                                    <td>
                                        <!-- BUTTON -->    
                                            <a href="edit_subject.jsp?id=<%=c.getSubjectId() %>"  class="btn btn-success col-10 col-sm-7 col-md-6 col-lg-4">Edit</a>                        
                                            <a href="DeleteSubjectServlet?id=<%=c.getSubjectId() %>" class="btn btn-dark col-10 col-sm-7 col-md-6 col-lg-4  ms-0 ms-lg-2 mt-1 mt-lg-0" style="background-color: black;">Delete</a>                                   
                                    </td>     
                                  </tr> 
                                  <%    }
                                   %>
                                </tbody>
                            </table>
                        </div>
                                   <a href="add_subject.jsp?couid=<%=courseid %>&syear=Second-Year" id="addsubjectsbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add subject in Second Year</span></b></a>
                                   <div class="mx"></div>
                                   <hr class=" mx-auto mt-5">
                                   <%    }
                                   %>
                                   <!--Loop 2 - Second Year end-->
                                   
<!------------------------------------------------------------------------------------------------------------------------------------------------------------------->                                                                
                                   
                        <%      
                            // Loop 3 - Third Year
                            List<Subject> listsub3 = daosub.getThirdYearSubjects(courseid);
                            subjectNo = 1;
                            if (listsub3.isEmpty()) {
                                
                                 %>
                          
                          <a href="add_subject.jsp?couid=<%=courseid %>&syear=Third-Year" id="addsubjectsbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add subject in Third Year</span></b></a>
                          
                          <%
                                
                            } else {

                        %>
                
                        <h2 class="mt-3"><b>Third Year</b></h2>
     
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-success">
                                  <tr>
                                    <th scope="col">No.</th>
                                    <th scope="col">Subject name</th>
                                    <th scope="col">Action</th>                     
                                  </tr>
                                </thead>
                                <tbody>
                                    <%                               
                                    for (Subject d : listsub3) {
                                    %>
                                    <tr>
                                    <th><%= subjectNo++ %></th>
                                    <td><%= d.getSubjectName() %></td>
                                    <td>
                                        <!-- BUTTON -->    
                                            <a href="edit_subject.jsp?id=<%=d.getSubjectId() %>"  class="btn btn-success col-10 col-sm-7 col-md-6 col-lg-4">Edit</a>                        
                                            <a href="DeleteSubjectServlet?id=<%=d.getSubjectId() %>" class="btn btn-dark col-10 col-sm-7 col-md-6 col-lg-4  ms-0 ms-lg-2 mt-1 mt-lg-0" style="background-color: black;">Delete</a>                                   
                                    </td>     
                                  </tr> 
                                  <%    }
                                   %>
                                </tbody>
                            </table>
                        </div>
                                   <a href="add_subject.jsp?couid=<%=courseid %>&syear=Third-Year" id="addsubjectsbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add subject in Third Year</span></b></a>
                                   <div class="mx"></div>
                                   <hr class=" mx-auto mt-5">
                                   <%    }
                                   %>
                                   <!--Loop 3 - Third Year end-->
                                   
<!------------------------------------------------------------------------------------------------------------------------------------------------------------------->                                                                
                        <%      
                            // Loop 4 - Fourth Year
                            List<Subject> listsub4 = daosub.getFourthYearSubjects(courseid);
                            subjectNo = 1;
                            if (listsub4.isEmpty()) {
                                
                                 %>
                          
                          <a href="add_subject.jsp?couid=<%=courseid %>&syear=Fourth-Year" id="addsubjectsbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add subject in Fourth Year</span></b></a>
                          
                          <%

                            } else {

                        %>
                
                        <h2 class="mt-3"><b>Fourth Year</b></h2>
     
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-success">
                                  <tr>
                                    <th scope="col">No.</th>
                                    <th scope="col">Subject name</th>
                                    <th scope="col">Action</th>                     
                                  </tr>
                                </thead>
                                <tbody>
                                    <%                               
                                    for (Subject e : listsub4) {
                                    %>
                                    <tr>
                                    <th><%= subjectNo++ %></th>
                                    <td><%= e.getSubjectName() %></td>
                                    <td>
                                        <!-- BUTTON -->    
                                            <a href="edit_subject.jsp?id=<%=e.getSubjectId() %>"  class="btn btn-success col-10 col-sm-7 col-md-6 col-lg-4">Edit</a>                        
                                            <a href="DeleteSubjectServlet?id=<%=e.getSubjectId() %>" class="btn btn-dark col-10 col-sm-7 col-md-6 col-lg-4  ms-0 ms-lg-2 mt-1 mt-lg-0" style="background-color: black;">Delete</a>                                   
                                    </td>     
                                  </tr> 
                                  <%    }
                                   %>
                                </tbody>
                            </table>
                        </div>
                                   <a href="add_subject.jsp?couid=<%=courseid %>&syear=Fourth-Year" id="addsubjectsbtn" class="btn px-4 py-2 mt-4 mx-auto"><b><span>Add subject in Fourth Year</span></b></a>
                                   <div class="mx"></div>
                                   <hr class=" mx-auto mt-5">
                                   <%    }
                                   %>
                                   <!--Loop 4 - Fourth Year end-->                                                    
            </div>
        </div>
 
    <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>

      
    </body>
</html>
<%    }
%>