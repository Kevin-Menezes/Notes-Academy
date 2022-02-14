<%-- 
    Document   : mostliked_notes_search
    Created on : 14 Feb, 2022, 2:38:20 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Note"%>
<%@page import="com.notesacademy.DAO.LikeDAOImpl"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");

        UserDetails us = (UserDetails) session.getAttribute("userdetails");

%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Notes Search | <%=request.getParameter("ch") %></title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/notes.css">
        
    </head>
    <body>
        
        <%
        if(us!=null)
        {
           
%>

        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!--Ebooks API-->
        <nav class="cnavbar navbar-expand-lg navbar-light bg-light" style="margin-top:4em;">
            <div class="container-fluid">
                <script async src="https://cse.google.com/cse.js?cx=ae993f79ad6bb5f7f"></script>
                <div class="gcse-search"></div>   
            </div>
        </nav>
        
        <%           
            String ch = request.getParameter("ch");
        %> 
        
        <!--------------------------------------------------------------------HEADER AND NOTES------------------------------------------------------------------>

        <div class="container">
            <div class="row text-center" style="margin-top:2em;">
                <h2 class="mb-4 text-start"><b>Showing results for " <%= ch %> "</b><a id="addnotebtn" class="btn px-3 py-2 ms-1 ms-sm-4 mt-1 mt-sm-0" data-bs-toggle="modal"  data-bs-target="#sendnotesModal"><b><span>Add note </span></b></a></h2><br><br>

                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                      Most Liked notes
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="background-color: white; border: 1px solid green;">
                        <li><a class="dropdown-item" href="search.jsp?ch=<%=request.getParameter("ch") %>" style="background-color: white">Old notes</a></li>
                      <li><a class="dropdown-item" href="recent_notes_search.jsp?ch=<%=request.getParameter("ch") %>" style="background-color: white">Recent notes</a></li>
                    </ul>
              </div>
                
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    List<Note> list = dao.getMostLikedSearchNotes(ch);
                    for(Note b : list){
                %>
                
                <div class="col-lg-3  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text"><%= b.getNoteDescription() %></p>
                            <a href="DownloadServlet?fileName=<%= b.getFilePath() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>
                            <ul class="list-group list-group-flush mt-2">
                                <li class="list-group-item text-end"><span style="float: left;"><a href="#" onclick="doLike(<%= b.getNoteId() %>,<%= us.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span><small class="text-muted"><%= b.getNoteDate() %></small></li>       
                                <a href="show_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                        </div>
                    </div>
                </div>
                                <% } %>
            </div>

        </div>
            
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
                       <form action="SendNotesServlet" id="Items" method="post"  enctype="multipart/form-data">
                        
                    <div class="form-group row align-items-center">
                        <!-- NOTE TITLE -->
                        <div class="form-group col-12">                     
                            <input type="text" class="form-control form-control-sm" id="addnoteTitle" placeholder="Enter note title" name="ntitle" required="required">
                        </div>


                        <!-- NOTE DESCRIPTION -->
                        <div class="form-group col-12 mt-3">                     
                            <textarea class="form-control form-control-sm" id="addnoteDescription" rows="3" placeholder="Enter note description" name="ndescription" required="required"></textarea>
                        </div>

                        <!-- NOTES CATEGORY NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="catname" value="catname" required="required">
                                <option value="" disabled selected hidden>Select Category</option>                               
<!--                                <option value="Science">Science</option>
                                <option value="Commerce">Commerce</option>
                                <option value="Arts">Arts</option>-->
                            </select>
                        </div>

                        <!-- NOTES COURSE NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example"  id="couname" value="couname" required="required">
                                <option value="" disabled selected hidden>Select Course</option>
<!--                                <option value="FYJC">FYJC</option>
                                <option value="SYJC">SYJC</option>
                                <option value="BSC">BSC</option>
                                <option value="BSC CS">BSC CS</option>-->

                            </select>
                        </div>

                        <!-- NOTES COURSE YEAR -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="cyear" value="cyear" required="required">
                                <option value="" disabled selected hidden>Select Course Year</option>
<!--                                <option value="First Year">First Year</option>
                                <option value="Second Year">Second Year</option>
                                <option value="Third Year">Third Year</option>-->
                            </select>
                        </div>

                        <!-- NOTES SUBJECT NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="sname" value="sname" required="required">
                                <option value="" disabled selected hidden>Select Subject</option>

                            </select>
                        </div>
           
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
              
                        <!-- UPLOAD PDF -->
                        <div class="col-12 mt-3">
                            <span id="datalistInline" class="form-text">
                              Upload PDF
                            </span>
                          </div>

                        <!-- FILE UPLOAD -->
                        <div class="form-group col-12  mt-1">                    
                                <input type="file" class="form-control-file " name="pdf" id="file" accept="application/pdf" required="required"/>
                        </div>
                        <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->  
                        

                        <!-- BUTTON -->
                        <div class="form-group d-flex justify-content-center">

                            <button type="submit" onclick="mydata()" class="btn btn-primary col-5 col-sm-3 mt-4">Add</button>                        
                            <button type="button" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;" data-bs-dismiss="modal">Cancel</button>         

                        </div>

                    </div>
                  </form>

                </div>

              </div>
            </div>
          </div>
           <!--Send Notes Model end-->

           
           <!------------------------------------------------------------------------------- ELSE ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
            
    <% } 
else{
        int userId = 0;

    %>
    
    <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!-- Alert when add notes button is clicked -->
        <div class="alert alert-warning alert-dismissible fade show mt-5" id="myAlert2" style="display:none;" role="alert">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-hidden="true" ></button>
            Kindly signup or login to add notes!
        </div>
        
        <!--Ebooks API-->
        <nav class="cnavbar navbar-expand-lg navbar-light bg-light" style="margin-top:4em;">
            <div class="container-fluid">
                <script async src="https://cse.google.com/cse.js?cx=ae993f79ad6bb5f7f"></script>
                <div class="gcse-search"></div>   
            </div>
        </nav>
        
        <%           
            String ch = request.getParameter("ch");
        %> 
        
        <!--------------------------------------------------------------------HEADER AND NOTES------------------------------------------------------------------>

        <div class="container">
            <div class="row text-center" style="margin-top:2em;">
                <h2 class="mb-4 text-start"><b>Showing results for " <%= ch %> "</b><a id="addnotebtn" class="btn px-3 py-2 ms-1 ms-sm-4 mt-1 mt-sm-0" onclick="showAlert();"><b><span>Add note </span></b></a></h2><br><br>

                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                      Most Liked notes
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="background-color: white; border: 1px solid green;">
                        <li><a class="dropdown-item" href="search.jsp?ch=<%=request.getParameter("ch") %>" style="background-color: white">Old notes</a></li>
                      <li><a class="dropdown-item" href="recent_notes_search.jsp?ch=<%=request.getParameter("ch") %>" style="background-color: white">Recent notes</a></li>
                    </ul>
              </div>
                
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    List<Note> list = dao.getMostLikedSearchNotes(ch);
                    for(Note b : list){
                %>
                
                <div class="col-lg-3  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text"><%= b.getNoteDescription() %></p>
                            <a href="DownloadServlet?fileName=<%= b.getFilePath() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>
                            <ul class="list-group list-group-flush mt-2">
                                <li class="list-group-item text-end"><span style="float: left;"><a href="#" onclick="doLike(<%= b.getNoteId() %>,<%= userId %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span><small class="text-muted"><%= b.getNoteDate() %></small></li>       
                                <a href="show_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                        </div>
                    </div>
                </div>
                                <% } %>
            </div>

        </div>
        <% } %>
    
           
        <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
        <!--Javascript for Likes-->
        <script src="Js/Like.js"></script>
        
        <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>
        
    </body>
</html>
