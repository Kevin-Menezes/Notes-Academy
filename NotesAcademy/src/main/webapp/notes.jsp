<%-- 
    Document   : notes
    Created on : 30 Dec, 2021, 11:42:35 AM
    Author     : nivek
--%>

<%@page import="com.notesacademy.DAO.LikeDAOImpl"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page import="com.notesacademy.entities.Note"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");

        UserDetails us = (UserDetails) session.getAttribute("userdetails");
        int userId =0;
        if(us!=null)
        {
            userId = us.getUserId();
        }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Notes | <%= request.getParameter("subject").replaceAll("-", " ")%></title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/notes.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <%           
            String categoryname = request.getParameter("category");
            String coursename = request.getParameter("course").replaceAll("-", " ");
            int subjectid = Integer.parseInt(request.getParameter("subjectid"));
            String subjectyear = request.getParameter("subjectyear").replaceAll("-", " ");
            String subjectname = request.getParameter("subject").replaceAll("-", " ");
        %> 
        
        <!--------------------------------------------------------------------HEADER AND NOTES------------------------------------------------------------------>

        <div class="container">
            <div class="row text-center" style="margin-top:6em;">
                <h2 class="mb-4 text-start"><b><%= request.getParameter("subject").replaceAll("-", " ")%></b><a id="addnotebtn" class="btn px-3 py-2 ms-1 ms-sm-4 mt-1 mt-sm-0" data-bs-toggle="modal"  data-bs-target="#addNoteModal"><b><span>Add note </span></b></a></h2><br><br>

                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    List<Note> list = dao.getNotes(subjectid);
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
                                <a href="#" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                        </div>
                    </div>
                </div>
                                <% } %>
            </div>
        </div>
            
            <!-- -----------------------------------------------------------ADD NOTES MODAL------------------------------------------------------------------------------------------------------------------------ -->

        <div class="modal fade" id="addNoteModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
            <div class="modal-dialog">
              <div class="modal-content">

                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">ADD NOTE</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                
                    
                       <!-- ADD NOTES FORM -->
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

           
                        <!-- HIDDEN VALUES SENT  -->
                        
                        <!--Hidden data sending all the selected options-->
                        <input type="hidden" name="selectedCategory" id="selectedCategory" value="<%=categoryname %>"/>
                        <input type="hidden" name="selectedCourse" id="selectedCourse" value="<%=coursename %>"/>
                        <input type="hidden" name="selectedSubjectYear" id="selectedSubjectYear" value="<%=subjectyear %>"/>
                        <input type="hidden" name="selectedSubject" id="selectedSubject" value="<%=subjectname %>"/>
                        <input type="hidden" name="selectedSubjectId" id="selectedSubjectId" value="<%=subjectid %>"/>
                        
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

                            <button type="submit" class="btn btn-primary col-5 col-sm-3 mt-4">Add</button>                        
                            <button type="button" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;" data-bs-dismiss="modal">Cancel</button>         

                        </div>

                    </div>
                  </form>

                </div>

              </div>
            </div>
          </div>
           <!--Send Notes Model end-->

        
<!--        <h1><%=categoryname %></h1>
        <h1><%=coursename %></h1>
        <h1><%=subjectid %></h1>
        <h1><%=subjectname %></h1>
        -->
        
         <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
        <!--Javascript for Likes-->
        <script src="Js/Like.js"></script>
        
        <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>
        
        
        
        <!--      This is the long cut for sending variables to the like servlet  
        <form action="LikeServlet" method="post">
                                    <input type="hidden" value="" name="noteId"/>
                                    <input type="hidden" value="<%= userId %>" name="userId"/>
                                    
                                    <input type="hidden" value="<%=categoryname %>" name="categoryname"/>
                                    <input type="hidden" value="<%= coursename %>" name="coursename"/>
                                    <input type="hidden" value="<%= subjectid %>" name="subjectid"/>
                                    <input type="hidden" value="<%= subjectname %>" name="subjectname"/>
                                    
                                    
             
                                <li class="list-group-item text-end"><span style="float: left;"><button type="submit"  class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao %></button></span><small class="text-muted"></small></li>
                                </form>
        -->
        
    </body>
</html>
