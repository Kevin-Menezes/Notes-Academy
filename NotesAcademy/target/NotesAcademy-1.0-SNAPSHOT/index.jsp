<%-- 
    Document   : index
    Created on : 15 Oct, 2021, 8:24:21 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Category"%>
<%@page import="com.notesacademy.DAO.CategoryDAOImpl"%>
<%@page import="com.notesacademy.DB.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    UserDetails us = (UserDetails) session.getAttribute("userdetails");
        
        if(us!=null)
        {
            response.sendRedirect("home.jsp");
        }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Notes Academy</title>

        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/index.css">
    </head>

    <body>

        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>

        <!-- Alert when add notes button is clicked -->
        <div class="alert alert-warning alert-dismissible fade show mt-5" id="myAlert2" style="display:none;" role="alert">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-hidden="true" ></button>
            Kindly signup or login to add notes!
        </div>

        <!-- Header start -->
        <header class="jumbotron">
            <div class="container">

                <div class="row row-header">
                    <div class="col-12 col-sm-6 heading">
                        <h1 class="lets-note-it">Let's note it together.</h1>
                        <h5>College notes available here</h5>
                        <a id="addnotesbtn" class="btn px-4 py-2 mt-4"  onclick="showAlert();"><b><span>Add notes </span></b></a>
                        <a id="recentnotesbtn" class="btn  px-4 py-2 mt-4"><b><span>View recent posts </span></b></a>
                    </div>  
                    <div class="col col-sm"></div>

                    <!--      IMAGE              <div class="col col-sm mt-3 mt-md-0 ">
                                            <img src="Stylesheets/Notebook.jpg" class="img-fluid rounded float-end" alt="...">
                                        </div> Here we put col-sm which means that the remaining extra columns from top(6 columns) will be automatically occupied here     -->

                </div>

            </div>
        </header>
        <!-- Header end -->

        <!-- Subjects Available start -->
        <div class="container">
            <div class="row text-center">
                <h2 class="mb-2 mt-5 subjects-available" >Subjects Available</h2>

                <div class="cards"> 
                    <div class="d-flex flex-row justify-content-around flex-wrap">

                        <!--Category and Course Classes-->
                        <% CategoryDAOImpl daocat = new CategoryDAOImpl(DBConnection.getConnection());
                            CourseDAOImpl daocou = new CourseDAOImpl(DBConnection.getConnection());

  //                         Loop 1 - Categories loop
                            List<Category> listcat = daocat.getCategories();
                            for (Category b : listcat) {
                        %>

                        <div class="card mt-4  shadow-lg" style="width: 24rem;"> <!--BOOTSTRAP CARD-->
                            <img src="data:image/jpg;base64, <%= b.getCategoryImgString()%>" class="card-img-top img-fluid" alt="img">

                            <!--                          <div class="card-body">
                                                            <h5 class="card-title">Science</h5>
                                                            <p class="card-text">Some text will come here afterwards</p>
                                                        </div>-->

                            <!--Loop 2 - Courses loop inside Category loop -->
                            <% List<Course> listcou = daocou.getCourses(b.getCategoryId());
                                for (Course c : listcou) {
                            %>
                            <ul class="list-group list-group-flush">
                                <!--Sending category name , course id and course name to subject.jsp through the url-->
                                <a href="subjects.jsp?category=<%=b.getCategoryName()%>&courseid=<%=c.getCourseId()%>&course=<%=c.getCourseName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=c.getCourseName()%></li></a>


                                <!--                                <li class="list-group-item"><a href="#" class="card-link">SYJC</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BSc</a></li>
                                                                <li class="list-group-item"><a href="bachelor_of_science_computer_science.jsp" class="card-link">BSc CS</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BSc IT</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BSc Arch</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BCA</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BTech</a></li>-->
                            </ul>
                            <% } %> <!-- Loop 2 end-->
                        </div>
                        <% }%> <!-- Loop 1 end-->
                        
                        <!-- COMMERCE -->
                        <!--                        <div class="card mt-3 mt-lg-0 shadow-lg" style="width: 24rem;"> BOOTSTRAP CARD
                                                    <img src="Stylesheets/Commerce.png" class="card-img-top" alt="Commerce based img" height="256">
                                                    
                                                    <ul class="list-group list-group-flush">
                                                        <li class="list-group-item"><a href="#" class="card-link">FYJC</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">SYJC</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BCom</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BBA</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">CA</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">CS</a></li>
                        
                                                    </ul>
                                                </div>-->

                        <!-- ARTS -->
                        <!--                        <div class="card mt-3 mt-xl-0 shadow-lg" style="width: 24rem;"> BOOTSTRAP CARD
                                                    <img src="Stylesheets/Arts.jpeg" class="card-img-top" alt="Arts based img" height="256">
                                                   
                                                    <ul class="list-group list-group-flush">
                                                        <li class="list-group-item"><a href="#" class="card-link">FYJC</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">SYJC</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BA</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BMS</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BFA</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BEM</a></li>
                                                    </ul>
                                                </div>-->

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Subjects Available end -->

    <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
    
    <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>
        
     
    

</body>

</html>