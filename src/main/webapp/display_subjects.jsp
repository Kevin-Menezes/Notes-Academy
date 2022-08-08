<%-- 
    Document   : display_subjects
    Created on : 17 Jan, 2022, 9:33:58 AM
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
        <title>Admin | Courses</title>

        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/display_subjects.css">

    </head>
    <body>

        <!-- Navbar -->
        <%@include file="Components/AdminNavbar.jsp" %>
        <%@include file="Components/Message.jsp" %>

        <!-- Subjects Available start -->
        <div class="container">
            <div class="row text-center">
                <h2 class="mb-2 subjects-available" >Select course to go to subjects</h2>

                <div class="cards"> 
                    <div class="d-flex flex-row justify-content-around flex-wrap">

                        <!--Category and Course Classes-->
                        <% CategoryDAOImpl daocat = new CategoryDAOImpl(DBConnection.getConnection());
                            CourseDAOImpl daocou = new CourseDAOImpl(DBConnection.getConnection());

                            // Loop 1 - Categories loop
                            List<Category> listcat = daocat.getCategories();
                            for (Category b : listcat) {
                        %>

                        <div class="card mt-4 shadow-lg" style="width: 24rem;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body">
                                <h5 class="card-title" ><%=b.getCategoryName() %></h5>
                                
                            </div>

                            <!--Loop 2 - Courses loop inside Category loop -->
                            <% List<Course> listcou = daocou.getCourses(b.getCategoryId());
                                for (Course c : listcou) {
                            %>
                            <ul class="list-group list-group-flush">
                                <!--Sending category name , course id and course name to subject.jsp through the url-->
                                <a href="display_subjects_selected.jsp?category=<%=b.getCategoryName()%>&courseid=<%=c.getCourseId()%>&course=<%=c.getCourseName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=c.getCourseName()%></li></a>

                            </ul>
                            <% } %> <!-- Loop 2 end-->
                        </div>
                        <% }%> <!-- Loop 1 end-->
                
                    </div>
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