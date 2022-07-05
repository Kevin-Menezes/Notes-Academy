<%-- 
    Document   : index
    Created on : 15 Oct, 2021, 8:24:21 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.DAO.ViewDAOImpl"%>
<%@page import="com.notesacademy.DAO.DownloadDAOImpl"%>
<%@page import="com.notesacademy.DAO.UserDAOImpl"%>
<%@page import="com.notesacademy.DAO.SubjectDAOImpl"%>
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
<html id="BackToTop">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Notes Academy</title>

        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%> 
        <link rel="stylesheet" href="Stylesheets/index.css">    
         <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>

    <body>
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>

        <!-- Alert when add notes button is clicked -->
        <div class="alert alert-warning alert-dismissible fade show mt-5" id="myAlert2" style="display:none;" role="alert">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-hidden="true" ></button>
            Kindly signup or login to add, view and download notes and also give likes!
        </div>

        <!-- Header start -->
        <header class="jumbotron">
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
                            int coucount = daocou.getCoursesCount();

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
              
                            </ul>
                            <% } %> <!-- Loop 2 end-->
                        </div>
                        <% }%> <!-- Loop 1 end-->

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
                    DownloadDAOImpl ddao = new DownloadDAOImpl(DBConnection.getConnection());
                    ViewDAOImpl vdao = new ViewDAOImpl(DBConnection.getConnection());
                    
                    List<Note> list = dao.getAllNotes();
                    for(Note b : list){
                %>
                
                <div class="col-xl-3 col-lg-4 mt-4" >
                    <div class="card shadow-lg">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text" style="padding: 0;"><%= b.getNoteDescription() %></p>
                            
                            <%
                                if(b.getNotePrice()==0)
                                {
                              %>
                 
                                    <a onclick="showAlert();" href="#BackToTop"  class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>

                                        <ul class="list-group list-group-flush mt-2">
                                            <li class="list-group-item text-end" id="notesitem" style="padding:8px 0 8px 0px"><span style="float: left;"><a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                                <small class="text-muted"><%= b.getNoteDate() %></small>
                                            </li>     

                                            <a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-dark btn-sm">View Note</a>
                                            <li class="list-group-item text-center text-muted" id="notesdesc"><span class="badge bg-warning text-dark me-2 " ><%= b.getUserRank() %>&nbsp;<i class="fa fa-star"></i></span><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                                        </ul>
                            <%
                                }
                                else
                                {
                             %>

                                   <a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-danger rounded-pill col-4  p-1" style="margin: auto">Pay ₹<%= b.getNotePrice() %></a>

                                    <ul class="list-group list-group-flush mt-2">
                                            <li class="list-group-item text-end" id="notesitem" style="padding:8px 0 8px 0px"><span style="float: left;"><a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                                <small class="text-muted"><%= b.getNoteDate() %></small>
                                            </li>     

                                            <a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-dark btn-sm">View Note</a>
                                            <li class="list-group-item text-center text-muted" id="notesdesc"><span class="badge bg-warning text-dark me-2 " ><%= b.getUserRank() %>&nbsp;<i class="fa fa-star"></i></span><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                                        </ul>
                            <%
                                }
                             %>
                            
                        </div>
                    </div>
                </div>
                                <% } %>
                                <!--Recent notes end-->
 
            </div>
               
             <!--Floating Button start-->
             <div class="action"  onClick="actionToggle();" style="z-index: 1">
                 <span class="justify-content-center"><i class="fa fa-plus mt-3" style="font-size: 20px;"></i></span>
                <ul>
                    <li> <a href="create_pdf.jsp">Create Pdf</a></li>            
                    <li style="color:white"><a onclick="showAlert(); " href="#BackToTop">Add notes</a></li>     
                    <li><a href="contact.jsp">Request notes</a></li>      
                </ul>        
            </div>
            <!--Floating Button end-->
            
            <% 
                 SubjectDAOImpl daosub = new SubjectDAOImpl(DBConnection.getConnection());
                 int subcount = daosub.getSubjectsCount();
                 
                 NoteDAOImpl daonote = new NoteDAOImpl(DBConnection.getConnection());
                 int notecount = daonote.getNotesCount();
                 
                 UserDAOImpl daouser = new UserDAOImpl(DBConnection.getConnection());
                 int usercount = daouser.getUsersCount();

             %>
            <!-- Number cards start -->
            <div class="row text-center">
                <h2 class="mb-0 mt-5 subjects-available" >Main Highlights</h2>
                <div class="counter-up">
                    <div class="content">
                      <div class="box shadow-lg">
                        <div class="icon"><i class="fas fa-graduation-cap"></i></div>
                        <div id="counter" data-animateDuration="5000"><%=coucount %></div>
                        <div class="text">Courses Listed</div>
                      </div>
                      <div class="box shadow-lg">
                        <div class="icon"><i class="fas fa-folder-open"></i></div>
                        <div  id="counter" data-animateDuration="5000"><%=subcount %></div>
                        <div class="text">Subjects Available</div>
                      </div>
                      <div class="box shadow-lg">
                        <div class="icon"><i class="fas fa-book-open"></i></div>
                        <div id="counter" data-animateDuration="5000"><%=notecount %></div>
                        <div class="text">Notes Uploaded</div>
                      </div>
                      <div class="box shadow-lg">
                        <div class="icon"><i class="fas fa-users"></i></div>
                        <div id="counter" data-animateDuration="5000"><%=usercount %></div>
                        <div class="text">Benefitted Users</div>
                      </div>
                    </div>
                </div>
            </div>
            <!-- Number cards end -->
  
        </div>
              
        <!--Footer-->
        <div class="bg-dark">
                <%@include file="footer.jsp" %>
        </div>                       
        
 <!-- Number count animation using javascript -->                                                              
<script>

        const initAnimatedCounts = () => {
          const ease = (n) => {
            // https://github.com/component/ease/blob/master/index.js
            return --n * n * n + 1;
          };
          const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry) => {
              if (entry.isIntersecting) {
                // Once this element is in view and starts animating, remove the observer,
                // because it should only animate once per page load.
                observer.unobserve(entry.target);
                const countToString = entry.target.getAttribute('data-countTo');
                const countTo = parseFloat(countToString);
                const duration = parseFloat(entry.target.getAttribute('data-animateDuration'));
                const countToParts = countToString.split('.');
                const precision = countToParts.length === 2 ? countToParts[1].length : 0;
                const startTime = performance.now();
                const step = (currentTime) => {
                  const progress = Math.min(ease((currentTime  - startTime) / duration), 1);
                  entry.target.textContent = (progress * countTo).toFixed(precision);
                  if (progress < 1) {
                    animationFrame = window.requestAnimationFrame(step);
                  } else {
                    window.cancelAnimationFrame(animationFrame);
                  }
                };
                let animationFrame = window.requestAnimationFrame(step);
              }
            });
          });
          document.querySelectorAll('[data-animateDuration]').forEach((target) => {
            target.setAttribute('data-countTo', target.textContent);
            target.textContent = '0';
            observer.observe(target);
          });
        };
        initAnimatedCounts();

  </script>

    <!-- JQUERY , POPPER , BOOTSTRAP - USE SAME ORDER -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>

 
    <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>
        
        <!--Javascript for Likes-->
        <script src="Js/Like.js"></script>

        <!--For the floating button toggle-->
        <script type="text/javascript">
            function actionToggle()
            {
                var action=document.querySelector('.action');
                action.classList.toggle('active');
            }
       </script>
       
       <!--Razorpay javascript-->
         <script src="Js/RazorPayNotSignedIn.js"></script>
       

</body>
</html>