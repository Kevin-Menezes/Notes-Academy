<%-- 
    Document   : home
    Created on : 11 Nov, 2021, 10:50:41 AM
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
<%@page import="com.notesacademy.entities.Message"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- NEEDED FOR JSTL -->
<%@page isELIgnored = "false" %> <!-- NEEDED FOR JSTL -->
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");

        HttpSession s = request.getSession();
        UserDetails us = (UserDetails) session.getAttribute("userdetails");
        
        int UserTotalRank = 1;

        if(us==null)
        {
            Message msg = new Message("Please Login First!", "error", "alert-danger");
            s.setAttribute("message", msg);
           response.sendRedirect("index.jsp");
        }
        else
        {
            // Checks if user's rank has increased or not
            UserDAOImpl udao = new UserDAOImpl(DBConnection.getConnection());
            int UserId = us.getUserId();
            UserDetails f = udao.getUserById(UserId);
            
            int userRank = f.getUserRank();
            int userRankFormula = (userRank + 1)*10;   
            
            if((f.getUserLikeCount()>=userRankFormula && f.getUserDownloadCount()>=userRankFormula) && (f.getUserViewCount()>=userRankFormula))
            {
                
                boolean t = udao.updateUserRank(UserId);
                
                if(t)
                {
                    
                    Message msg = new Message("Congrats! You have leveled up!", "success", "alert-success");
                    session.setAttribute("message", msg);  
                    response.sendRedirect("user_notes.jsp"); 
                    
                }
                
            }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home | Notes Academy</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/home.css">
         
    </head>
    <body>
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!-- Header start -->
        <header class="jumbotron">
            <div class="container">

                <div class="row row-header">
                    <div class="col-12 col-sm-6 heading">
                        <h1 class="lets-note-it">Let's note it together.</h1>
                        <h5>College notes available here</h5>
                        <a id="addnotesbtn" class="btn px-4 py-2 mt-4" data-bs-toggle="modal"  data-bs-target="#sendnotesModal"><b><span>Add notes </span></b></a>
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
        
<!-- -----------------------------------------------------------SEND NOTES MODAL------------------------------------------------------------------------------------------------------------------------ -->

        <div class="modal fade" id="sendnotesModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
            <div class="modal-dialog">
              <div class="modal-content">

                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">ADD NOTE</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                
                    
                 <!-- SEND NOTES FORM -->
                 <form  action="SendNotesServlet" onsubmit="mydata()" id="Items"  method="post"  enctype="multipart/form-data">
                        
                    <div class="form-group row align-items-center">
                        <!-- NOTE TITLE -->
                        <div class="form-group col-12">                     
                            <input type="text" class="form-control form-control-sm" id="addnoteTitle" placeholder="Enter note title (max 40 words)" required="required" name="ntitle" minlength="3" maxlength="40">
                        </div>


                        <!-- NOTE DESCRIPTION -->
                        <div class="form-group col-12 mt-3">                     
                            <textarea class="form-control form-control-sm" id="addnoteDescription" rows="3" placeholder="Enter note description (max 100 words) (optional)" name="ndescription" maxlength="100"></textarea>
                        </div>

                        <!-- NOTES CATEGORY NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="catname" value="catname" required="required">
                                <option value="" disabled selected hidden>Select Category</option>                               
                            </select>
                        </div>

                        <!-- NOTES COURSE NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example"  id="couname" value="couname" required="required">
                                <option value="" disabled selected hidden>Select Course</option>
                            </select>
                        </div>

                        <!-- NOTES COURSE YEAR -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="cyear" value="cyear" required="required">
                                <option value="" disabled selected hidden>Select Course Year</option>
                            </select>
                        </div>

                        <!-- NOTES SUBJECT NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="sname" value="sname" required="required">
                                <option value="" disabled selected hidden>Select Subject</option>

                            </select>
                        </div>
                        
                        <% 
                                // This is to give price to the note when the user has a total of more than 3 likes
                                if(us.getUserRank()>=UserTotalRank)
                                { 
                                    
                            %>
                            
                            <div class="form-group col-12 mt-3">      
                                Enter note price in ₹
                                <input type="number" class="form-control form-control-sm" id="addnotePrice" placeholder="Enter note price in rupees" required="required" name="nprice" value="0" min="0" oninvalid="this.setCustomValidity('Enter price as 0 or greater than 0')" oninput="this.setCustomValidity('')">
                            </div>
                            
                            <div class="form-group col-12 mt-3">                     
                                <input type="text" class="form-control form-control-sm" id="addnoteRazor" placeholder="Enter razorpay key" name="nrazor">
                            </div>
                            
                            <%
                                }
                             %>
           
                        <!-- HIDDEN VALUES SENT  -->
                        
                        <!--Hidden data sending all the selected options-->
                        <input type="hidden" name="selectedCategory" id="selectedCategory"/>
                        <input type="hidden" name="selectedCourse" id="selectedCourse"/>
                        <input type="hidden" name="selectedSubjectYear" id="selectedSubjectYear"/>
                        <input type="hidden" name="selectedSubject" id="selectedSubject"/>
                        <input type="hidden" name="selectedSubjectId" id="selectedSubjectId"/>
                        
                        <input type="hidden"  name="uid" value="<%= us.getUserId() %>">
                        <input type="hidden"  name="uname" value="<%= us.getUserName() %>">
                        <input type="hidden"  name="uprofession" value="<%= us.getUserProfession() %>">
                        <input type="hidden"  name="ucollege" value="<%= us.getUserCollege() %>">
                        <input type="hidden"  name="nprice" value="0">
                        <input type="hidden"  name="urank" value="<%= us.getUserRank() %>">
              
                        <!-- UPLOAD PDF -->
                        <div class="col-12 mt-3">
                            <span id="datalistInline" class="form-text">
                              Upload PDF (Please put only letters in your file name. Do not use numbers or special characters.)
                            </span>
                          </div>

                        <!-- FILE UPLOAD -->
                        <div class="form-group col-12  mt-1">                    
                                <input type="file" class="form-control-file " name="pdf" id="file" accept="application/pdf" required="required"/>
                        </div>
                        <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->  
                        

                        <!-- BUTTON -->
                        <div class="form-group d-flex justify-content-center">

                            <button type="submit" onclick="addNoteValidate()" class="btn btn-primary col-5 col-sm-3 mt-4">Add</button>                        
                            <button type="button" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;" data-bs-dismiss="modal">Cancel</button>         

                        </div>

                    </div>
                  </form>

                </div>

              </div>
            </div>
          </div>
           <!--Send Notes Model end-->
           
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

                        <div class="card mt-4 shadow-lg" style="width: 24rem;" id="subjectcard"> <!--BOOTSTRAP CARD-->
<!--                            <img src="data:image/jpg;base64, <%= b.getCategoryImgString()%>" class="card-img-top img-fluid" alt="img">-->
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
                            <ul class="list-group list-group-flush">
                                <!--Sending category name , course id and course name to subject.jsp through the url-->
                                <a href="subjects.jsp?category=<%=b.getCategoryName()%>&courseid=<%=c.getCourseId()%>&course=<%=c.getCourseName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=c.getCourseName()%></li></a>
                        
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
                                    <a href="DownloadServlet?fileName=<%= b.getFilePath() %>&noteId=<%= b.getNoteId() %>&userId=<%= us.getUserId() %>&nuserId=<%= b.getUserId() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>

                                    <ul class="list-group list-group-flush mt-2">
                                        <li class="list-group-item text-end" id="notesitem" style="padding:8px 0 8px 0px"><span style="float: left;"><a href="" onclick="doLike(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                            <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                            <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                            <small class="text-muted"><%= b.getNoteDate() %></small>
                                        </li>     

                                        <a href="show_pdf.jsp?fileName=<%= b.getFilePath() %>&noteId=<%= b.getNoteId() %>&userId=<%= us.getUserId() %>&nuserId=<%= b.getUserId() %>" onclick="doView(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm">View Note</a>

                                        <li class="list-group-item text-center text-muted" id="notesdesc"><span class="badge bg-warning text-dark me-2 " ><%= b.getUserRank() %>&nbsp;<i class="fa fa-star"></i></span><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                                    </ul>
                            
                            <%
                                }
                                else
                                {
                             %>
                                    <!--Razorpay signed in-->
                                    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
                                    <a onclick="razorPopup(<%= b.getNotePrice() %>,'<%= b.getNoteRazor() %>','<%= b.getFilePath() %>','<%= b.getUserName() %>','<%= b.getNoteTitle() %>','<%= us.getUserName() %>','<%= us.getUserEmail() %>',<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-danger rounded-pill col-4  p-1" style="margin: auto">Pay ₹<%= b.getNotePrice() %></a>

                                    <ul class="list-group list-group-flush mt-2">
                                        <li class="list-group-item text-end" id="notesitem" style="padding:8px 0 8px 0px"><span style="float: left;"><a href="" onclick="doLike(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                            <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                            <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                            <small class="text-muted "><%= b.getNoteDate() %></small>
                                        </li> 

                                        <a href="show_paid_pdf.jsp?fileName=<%= b.getFilePath() %>&noteId=<%= b.getNoteId() %>&userId=<%= us.getUserId() %>&nuserId=<%= b.getUserId() %>&userName=<%= us.getUserName() %>&userEmail=<%= us.getUserEmail() %>" onclick="doView(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm">View Note</a>
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
            <div class="action"  onClick="actionToggle();">
                <span class="justify-content-center"><i class="fa fa-plus mt-3" style="font-size: 20px;"></i></span>
                <ul>
                    <li> <a href="create_pdf.jsp">Create Pdf</a></li>            
                    <li style="color:white"><a data-bs-toggle="modal"  data-bs-target="#sendnotesModal">Add notes</a></li>     
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
   
    <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
 
    <!--JQuery and Ajax for Asynchronous Add Notes (JQuery should always be used after the document has been loaded)-->
     <script type="text/javascript" src="Js/AddNotes.js"></script>
     
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
         <script src="Js/RazorPay.js"></script>
         
    </body>
</html>
<%    }
%>
