<%-- 
    Document   : display_notes_selectedcourse
    Created on : 20 Jan, 2022, 9:17:01 AM
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
        <link rel="stylesheet" href="Stylesheets/display_subjects.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/AdminNavbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!--Getting the category name , course id and course name from the url sent from the display_notes page-->
        <%            
            String categoryname = request.getParameter("category");
            int courseid = Integer.parseInt(request.getParameter("courseid"));
            String coursename = request.getParameter("course").replaceAll("-", " ");
        %> 
        
        <!-- Subjects Available start -->
        <div class="container">
            <div class="row text-center">
                <h2 class="mb-2 subjects-available" >Select subject to go to note</h2>

                <div class="cards"> 
                    <div class="d-flex flex-row justify-content-around flex-wrap">

                        <!-- Subjects --> 
                        <!--Loop 1 - First Year-->
                        <% SubjectDAOImpl daosub = new SubjectDAOImpl(DBConnection.getConnection());

                            // Loop 1 - First Year
                            List<Subject> listsub1 = daosub.getFirstYearSubjects(courseid);                     
                            if (listsub1.isEmpty()) {

                            } else {

                        %>

                        <div class="card mt-4 shadow-lg" style="width: 24rem;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body">
                                <h5 class="card-title" >First Year</h5>        
                            </div>
                            <%                               
                                    for (Subject b : listsub1) {
                             %>

                            <ul class="list-group list-group-flush">
                                <!--Sending category name , course name , subject name and subject id to subject.jsp through the url-->
                                <a href="display_notes_selectedsubject.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=b.getSubjectId()%>&subjectyear=First-Year&subject=<%=b.getSubjectName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=b.getSubjectName() %></li></a>
                            </ul>
                            <% } %> 
                        </div>
                        <% }%> <!-- Loop 1 end-->
     
<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
                        
                        <!--Loop 2 - Second Year-->
                        <% 
                            List<Subject> listsub2 = daosub.getSecondYearSubjects(courseid);                     
                            if (listsub2.isEmpty()) {

                            } else {
                        %>

                        <div class="card mt-4 shadow-lg" style="width: 24rem;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body">
                                <h5 class="card-title" >Second Year</h5>        
                            </div>
                            <%                               
                                    for (Subject b : listsub2) {
                             %>

                            <ul class="list-group list-group-flush">
                                <!--Sending category name , course name , subject name and subject id to subject.jsp through the url-->
                                <a href="display_notes_selectedsubject.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=b.getSubjectId()%>&subjectyear=Second-Year&subject=<%=b.getSubjectName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=b.getSubjectName() %></li></a>
                            </ul>
                            <% } %> 
                        </div>
                        <% }%> <!-- Loop 2 end-->
                        
<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
                        
                        <!--Loop 3 - Third Year-->
                        <% 
                            List<Subject> listsub3 = daosub.getThirdYearSubjects(courseid);                     
                            if (listsub3.isEmpty()) {

                            } else {
                        %>

                        <div class="card mt-4 shadow-lg" style="width: 24rem;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body">
                                <h5 class="card-title" >Third Year</h5>        
                            </div>
                            <%                               
                                    for (Subject b : listsub3) {
                             %>

                            <ul class="list-group list-group-flush">
                                <!--Sending category name , course name , subject name and subject id to subject.jsp through the url-->
                                <a href="display_notes_selectedsubject.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=b.getSubjectId()%>&subjectyear=Third-Year&subject=<%=b.getSubjectName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=b.getSubjectName() %></li></a>
                            </ul>
                            <% } %> 
                        </div>
                        <% }%> <!-- Loop 3 end-->
                        
<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
                        
                        <!--Loop 4 - Fourth Year-->
                        <% 
                            List<Subject> listsub4 = daosub.getFourthYearSubjects(courseid);                     
                            if (listsub4.isEmpty()) {

                            } else {
                        %>

                        <div class="card mt-4 shadow-lg" style="width: 24rem;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body">
                                <h5 class="card-title" >Fourth Year</h5>        
                            </div>
                            <%                               
                                    for (Subject b : listsub4) {
                             %>

                            <ul class="list-group list-group-flush">
                                <!--Sending category name , course name , subject name and subject id to subject.jsp through the url-->
                                <a href="display_notes_selectedsubject.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=b.getSubjectId()%>&subjectyear=Fourth-Year&subject=<%=b.getSubjectName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=b.getSubjectName() %></li></a>
                            </ul>
                            <% } %> 
                        </div>
                        <% }%> <!-- Loop 4 end-->
                
                    </div>
                </div>
                        
            </div>
        </div>
    <!-- Subjects Available end -->

    <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
    </body>
</html>
<%    }
%>