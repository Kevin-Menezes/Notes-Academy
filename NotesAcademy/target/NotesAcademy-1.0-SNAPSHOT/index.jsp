<%-- 
    Document   : index
    Created on : 15 Oct, 2021, 8:24:21 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Note"%>
<%@page import="com.notesacademy.DAO.LikeDAOImpl"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
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
         <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.1/jquery.waypoints.min.js"></script>     
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Counter-Up/1.0.0/jquery.counterup.min.js"></script>
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
        <header class="jumbotron" id="BackToTop">
            <div class="container">

                <div class="row row-header">
                    <div class="col-12 col-sm-6 heading">
                        <h1 class="lets-note-it">Let's note it together.</h1>
                        <h5>College notes available here</h5>
                        <a id="addnotesbtn" class="btn px-4 py-2 mt-4"  onclick="showAlert();"><b><span>Add notes </span></b></a>
                        <a href="#recentsection" id="recentnotesbtn" class="btn  px-4 py-2 mt-4"><b><span>View recent posts </span></b></a>
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

                        <div class="card mt-4  shadow-lg" style="width: 24rem;" id="subjectcard"> <!--BOOTSTRAP CARD-->
<!--                            <img src="data:image/jpg;base64, " class="card-img-top img-fluid" alt="img">-->
                            <div class="card-body" id="cardbody">
                                <h5 class="card-title" style="padding: 6px 20px 6px 20px;"><%=b.getCategoryName() %></h5>                   
                            </div>

                            <!--                          <div class="card-body">
                                                            <h5 class="card-title">Science</h5>
                                                            <p class="card-text">Some text will come here afterwards</p>
                                                        </div>-->

                            <!--Loop 2 - Courses loop inside Category loop -->
                            <% List<Course> listcou = daocou.getCourses(b.getCategoryId());
                                for (Course c : listcou) {
                            %>
                            <ul class="list-group list-group-flush ">
                                <!--Sending category name , course id and course name to subject.jsp through the url-->
                                <a href="subjects.jsp?category=<%=b.getCategoryName()%>&courseid=<%=c.getCourseId()%>&course=<%=c.getCourseName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item listitem"><%=c.getCourseName()%></li></a>


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
                <!-- Subjects Available end -->
                
            <!--Recent notes start-->
            <br >
            <div id="recentsection"></div>

            <h2  class="mb-2 mt-5 subjects-available" >Recently added notes</h2>
            <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());

                    List<Note> list = dao.getAllNotes();
                    for(Note b : list){
                %>
                
                <div class="col-lg-3  mt-4" >
                    <div class="card shadow-lg">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text" style="padding: 0;"><%= b.getNoteDescription() %></p>
                            <a href="DownloadServlet?fileName=<%= b.getFilePath() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>
                            
                            <ul class="list-group list-group-flush mt-2 ">
                                <li class="list-group-item text-end" id="notesitem"><span style="float: left;"><a href="#" onclick="doLike(<%= b.getNoteId() %>,0)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span><small class="text-muted"><%= b.getNoteDate() %></small></li>       
                                <a href="show_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted" id="notesdesc"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                            
                        </div>
                    </div>
                </div>
                                <% } %>
                                <!--Recent notes end-->
 
            </div>
               
             <!--Floating Button start-->
             <div class="action"  onClick="actionToggle();" style="z-index: 1">
                <span class="justify-content-center">+</span>
                <ul>
                    <li> <a href="create_pdf.jsp">Create Pdf</a></li>            
                    <li style="color:white"><a onclick="showAlert(); " href="#BackToTop">Add notes</a></li>     
                    <li><a href="contact.jsp">Request notes</a></li>      
                </ul>        
            </div>
            <!--Floating Button end-->
            
            <!-- Number cards start -->
            <div class="row text-center">
                <h2 class="mb-0 mt-4 subjects-available" >Main Highlights</h2>
                <div class="counter-up">
                    <div class="content">
                      <div class="box">
                        <div class="icon"><i class="fas fa-history"></i></div>
                        <div class="counter">724</div>
                        <div class="text">Working Hours</div>
                      </div>
                      <div class="box">
                        <div class="icon"><i class="fas fa-gift"></i></div>
                        <div class="counter">508</div>
                        <div class="text">Completed Projects</div>
                      </div>
                      <div class="box">
                        <div class="icon"><i class="fas fa-users"></i></div>
                        <div class="counter">436</div>
                        <div class="text">Happy Clients</div>
                      </div>
                      <div class="box">
                        <div class="icon"><i class="fas fa-award"></i></div>
                        <div class="counter">120</div>
                        <div class="text">Awards Received</div>
                      </div>
                    </div>
                </div>
            </div>
  
        </div>
              
        <div class="bg-dark">
                <%@include file="footer.jsp" %>
        </div>                       
        
                                
                                
                                <script>
  $(document).ready(function(){
        $('.counter').counterUp({
          delay: 10,
          time: 1200
        });
        
  });
  </script>

    <!-- JQUERY , POPPER , BOOTSTRAP - USE SAME ORDER -->


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>


    
    <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>

        <!--For the floating button toggle-->
        <script type="text/javascript">
            function actionToggle()
            {
                var action=document.querySelector('.action');
                action.classList.toggle('active');
            }
       </script>

</body>

</html>