<%-- 
    Document   : subjects
    Created on : 29 Dec, 2021, 2:42:09 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Subject"%>
<%@page import="com.notesacademy.DAO.SubjectDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");%>
<%
    UserDetails us = (UserDetails) session.getAttribute("userdetails");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Subjects | <%= request.getParameter("course").replaceAll("-", " ")%></title>

        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/subjects.css">

    </head>
    <body>

        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>

        <!--Getting the category name , course id and course name from the url sent from the index page-->
        <%            
            String categoryname = request.getParameter("category");
            int courseid = Integer.parseInt(request.getParameter("courseid"));
            String coursename = request.getParameter("course").replaceAll("-", " ");
        %> 

        <!-- ----------------------------------------------------------------------FY SY TY FY----------------------------------------------------------------------------------------------------------------------- -->

        <div class="container">
            <div class="row text-center" style="margin-top:4em;">
                <h2 class="mb-4 mt-3"><b><%=coursename%></b></h2><br><br>

                <div class="cards"> 
                    <div class="d-flex flex-row justify-content-around flex-wrap">

                        <!--Subject Class-->
                        <%
                            SubjectDAOImpl daosub = new SubjectDAOImpl(DBConnection.getConnection());

//                         Loop 1 - First Year
                            List<Subject> listsub1 = daosub.getFirstYearSubjects(courseid);
                            if (listsub1.isEmpty()) {

                            } else {

                        %>

                        <div class="card" style="width: 24rem; border-color: #6B9B8A;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body" style="background-color: #6B9B8A;">
                                <h3 class="card-title ct-bg" >First Year</h3>
                            </div>

                            <ul class="list-group list-group-flush">
                                <%                               
                                    for (Subject b : listsub1) {
                                %>
                                <!--Sending category name , course name , subject id and subject name to notes.jsp through the url-->
                                <a href="notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=b.getSubjectId()%>&subjectyear=First-Year&subject=<%=b.getSubjectName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=b.getSubjectName()%></li></a>

                                <!--                                <li class="list-group-item"><a href="#" class="card-link">DISCRETE MATHEMATICS</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">PROGRAMMING WITH C</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>-->
                                <% } %>
                            </ul>          
                        </div>
                        <% } %>
                        <!--Loop 1 - First Year end-->

                        <%
//                         Loop 2 - Second Year
                            List<Subject> listsub2 = daosub.getSecondYearSubjects(courseid);
                            if (listsub2.isEmpty()) {

                            } else {

                        %>
            
                        <div class="card  mt-3 mt-lg-0" style="width: 24rem;border-color: #6B9B8A;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body" style="background-color: #6B9B8A;">
                                <h3 class="card-title">Second Year</h3>
                            </div>
                            
                            <ul class="list-group list-group-flush">
                                <%                                    
                                    for (Subject c : listsub2) {
                                %>

                                <a href="notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=c.getSubjectId()%>&subjectyear=Second-Year&subject=<%=c.getSubjectName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=c.getSubjectName()%></li></a>


                                <!--                                <li class="list-group-item"><a href="#" class="card-link">OPERATING SYSTEMS</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">CORE JAVA</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">FUNDAMENTALS OF ALGORITHMS</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>-->

                                <% } %>
                            </ul>
                        </div>
                        <% } %>
                        <!--Loop 2 - Second Year end-->

                        <%
//                         Loop 3 - Third Year
                            List<Subject> listsub3 = daosub.getThirdYearSubjects(courseid);
                            if (listsub3.isEmpty()) {

                            } else {

                        %>                            

                        <div class="card mt-3 mt-xl-0" style="width: 24rem;border-color: #6B9B8A;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body" style="background-color: #6B9B8A;">
                                <h3 class="card-title">Third Year</h3>
                            </div>
                            
                            <ul class="list-group list-group-flush">
                                <%                                    
                                    for (Subject d : listsub3) {
                                %>

                                <a href="notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=d.getSubjectId()%>&subjectyear=Third-Year&subject=<%=d.getSubjectName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=d.getSubjectName()%></li></a>

                                <!--                                <li class="list-group-item"><a href="#" class="card-link">ARTIFICIAL INTELLIGENCE</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">GAME PROGRAMMING</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">CLOUD COMPUTING</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>-->
                                <% } %>
                            </ul>
                        </div>
                        <% } %>
                        <!--Loop 3 - Third Year end-->
                        

                        <%
//                         Loop 4 - Fourth Year
                            List<Subject> listsub4 = daosub.getFourthYearSubjects(courseid);
                            if (listsub4.isEmpty()) {

                            } else {

                        %>                            

                        <div class="card mt-3 mt-xl-0" style="width: 24rem;border-color: #6B9B8A;"> <!--BOOTSTRAP CARD-->

                            <div class="card-body" style="background-color: #6B9B8A;">
                                <h3 class="card-title">Fourth Year</h3>
                            </div>
                            
                            <ul class="list-group list-group-flush">

                                <%                                    
                                    for (Subject e : listsub4) {
                                %>

                                <a href="notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=e.getSubjectId()%>&subjectyear=Fourth-Year&subject=<%=e.getSubjectName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=e.getSubjectName()%></li></a>

                                <!--                                <li class="list-group-item"><a href="#" class="card-link">ARTIFICIAL INTELLIGENCE</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">GAME PROGRAMMING</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">CLOUD COMPUTING</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">---</a></li>-->
                                <% } %>
                            </ul>
                        </div>
                        <% }%>    
                        <!--Loop 4 - Fourth Year end-->

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
    
    <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>

</body>
</html>
