<%-- 
    Document   : user_notes
    Created on : 9 Mar, 2022, 10:06:31 AM
    Author     : nivek
--%>

<%@page import="com.notesacademy.DAO.UserDAOImpl"%>
<%@page import="com.notesacademy.DAO.ViewDAOImpl"%>
<%@page import="com.notesacademy.DAO.DownloadDAOImpl"%>
<%@page import="com.notesacademy.DAO.LikeDAOImpl"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
<%@page import="com.notesacademy.entities.Note"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
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
            UserDAOImpl udao = new UserDAOImpl(DBConnection.getConnection());
            int UserId = us.getUserId();
            UserDetails c = udao.getUserById(UserId);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My notes | <%= us.getUserName() %></title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/notes.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <div class="container mb-4">
            
            <!-- Number cards start -->
            <div class="row text-center" style="margin-top: 4em;">
                <h2 class="mb-0 mt-4 subjects-available" ><b><%= us.getUserName() %>'s Dashboard</b></h2>
                <div class="counter-up">
                    <div class="content">
                      <div class="box shadow-lg">
                        <div class="icon"><i class="fa fa-eye"></i></div>
                        <div class="counter" data-animateDuration="5000"><%=c.getUserViewCount() %></div>
                        <div class="text">Total Views</div>
                      </div>
                      <div class="box shadow-lg">
                        <div class="icon"><i class="fa fa-download"></i></div>
                        <div  class="counter" data-animateDuration="5000"><%=c.getUserDownloadCount() %></div>
                        <div class="text">Total Downloads</div>
                      </div>
                      <div class="box shadow-lg">
                        <div class="icon"><i class="far fa-thumbs-up"></i></div>
                        <div class="counter" data-animateDuration="5000"><%=c.getUserLikeCount() %></div>
                        <div class="text">Total Likes</div>
                      </div>
                      <div class="box shadow-lg">
                        <div class="icon"><i class="fa fa-star"></i></div>
                        <div class="counter" data-animateDuration="5000"><%=c.getUserRank() %></div>
                        <div class="text">Your Rank</div>
                      </div>
                    </div>
                </div>
            </div>
            <!-- Number cards end -->
            
            <div class="row text-center">
                <h4 class="mb-2">Rank increases as the total number of views, downloads and likes increases in multiples of 10</h4>
                <hr class="mt-2">
                <h2 class="mb-2 text-start"><b>Notes Uploaded</b><a id="addnotebtn" class="btn px-3 py-2 ms-1 ms-sm-4 mt-1 mt-sm-0 shadow" data-bs-toggle="modal"  data-bs-target="#sendnotesModal"><b><span>Add note </span></b></a></h2>
                
                    <!--Unpaid notes start-->
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    DownloadDAOImpl ddao = new DownloadDAOImpl(DBConnection.getConnection());
                    ViewDAOImpl vdao = new ViewDAOImpl(DBConnection.getConnection());  
           
                    List<Note> list = dao.getNotesByUserId(UserId);
                    
                    if(list.isEmpty())
                    {
                        
                %>
                
                <h1 class="text-center mt-5">No notes uploaded. Feel free to upload some!</h1>
                
                <%  
                    }
                    else
                    {   
                    for(Note b : list){
                        if(b.getNotePrice()==0)
                        {
                %>
                
                <div class="col-xl-3 col-lg-4  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">  
               
                            <p class="card-text"><%= b.getNoteDescription() %></p>

                            <ul class="list-group list-group-flush mt-2">
                                <li class="list-group-item text-end" style="padding:8px 0 8px 0px"><span style="float: left;"><a href="" class="btn btn-outline-dark disabled btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                    <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                    <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                    <small class="text-muted"><%= b.getNoteDate() %></small></li>     
                                
                                <a href="show_admin_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">View Note</a>
     
                            </ul>
                            
                        </div>
                    </div>
                </div>
                                <% }} %>
                <!--Unpaid notes end-->
                
                <hr class="mt-5">
                 <h2 class="mb-2 mt-1 text-start"><b>Paid notes</b></h2><br><br>
                
                <!--Paid notes start-->
                <%
              
                    List<Note> list1 = dao.getNotesByUserId(UserId);
                    for(Note b : list1){
                        if(b.getNotePrice()>0)
                        {
                %>
                <div class="col-xl-3 col-lg-4  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
        
                            <p class="card-text"><%= b.getNoteDescription() %></p>
                            
                            <a class="btn btn-outline-danger rounded-pill col-4  p-1 disabled" style="margin: auto">Cost ₹<%= b.getNotePrice() %></a>

                            <ul class="list-group list-group-flush mt-2">
                                <li class="list-group-item text-end" style="padding:8px 0 8px 0px"><span style="float: left;"><a href="" class="btn btn-outline-dark disabled btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                    <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                    <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                    <small class="text-muted"><%= b.getNoteDate() %></small></li> 
                                
                                <a href="show_admin_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">View Note</a>         
                            </ul>
                            
                        </div>
                    </div>
                </div>
                                <% }} %>
                <!--Paid notes end-->
                          
            <% } %>
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
                                    // This is to give price to the note when the user has a total of more than 10 ranks
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
               <!--------------Send Notes Model end------------>
  
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
        
        <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>

        <!--JQuery and Ajax for Asynchronous Add Notes (JQuery should always be used after the document has been loaded)-->
        <script type="text/javascript" src="Js/AddNotes.js"></script>
        
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
<% } %>