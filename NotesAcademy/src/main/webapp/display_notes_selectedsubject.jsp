<%-- 
    Document   : display_notes_selectedsubject
    Created on : 20 Jan, 2022, 10:19:27 AM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Note"%>
<%@page import="com.notesacademy.DAO.LikeDAOImpl"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
<%@page import="com.notesacademy.entities.Message"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");

        HttpSession s = request.getSession();
        UserDetails us = (UserDetails) session.getAttribute("admindetails");
        
        if(us==null)
        {
            Message msg = new Message("Please Login First!", "error", "alert-danger");
            s.setAttribute("message", msg);
           response.sendRedirect("index.jsp");
        }
        else if(!"admin@gmail.com".equals(us.getUserEmail()) && !"admin13579".equals(us.getUserPassword()))
        {
            Message msg = new Message("User not allowed in Admin section!", "error", "alert-danger");
            s.setAttribute("message", msg);
            response.sendRedirect("home.jsp");
        }
        else
        {
            int userId = us.getUserId();

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin | Notes : <%= request.getParameter("subject").replaceAll("-", " ")%></title>
        
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
                
                <!--Unpaid notes start-->
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    List<Note> list = dao.getNotes(subjectid);
                    
                    if(list.isEmpty())
                    {
                        
                %>
                
                <h1 class="text-center mt-5">Notes unavailable!</h1>
                
                <%  
                    }
                    else
                    {   
                    for(Note b : list){
                        if(b.getNotePrice()==0)
                        {
                %>
                
                <div class="col-lg-3  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text"><%= b.getNoteDescription() %></p>
                            <a href="DownloadServlet?fileName=<%= b.getFilePath() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>
                            <ul class="list-group list-group-flush mt-2">
                                <li class="list-group-item text-end"><span style="float: left;"><a href="#" onclick="doLike(<%= b.getNoteId() %>,<%= userId %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span><small class="text-muted"><%= b.getNoteDate() %></small></li>       
                                <a href="show_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                            <!-- BUTTON -->
                                <div class="form-group d-flex justify-content-center">
                                    <a  href="edit_note.jsp?id=<%= b.getNoteId() %>" class="btn btn-success col-5 col-sm-3 col-lg-5  mt-2">Edit</a>                        
                                    <a  href="DeleteNoteServlet?id=<%= b.getNoteId() %> " class="btn btn-dark col-5 col-sm-3 col-lg-5  mt-2 ms-2" >Delete</a>        
                                </div>
                        </div>
                    </div>
                </div>
                                <% }} %>
                 <!--Unpaid notes end-->
                
                <hr class="mt-5">
                 <h2 class="mb-2 mt-2 text-start"><b>Paid notes</b></h2><br><br>
                
                <!--Paid notes start-->
                <%
                    List<Note> list1 = dao.getNotes(subjectid);
                    for(Note b : list1){
                        if(b.getNotePrice()>0)
                        {
                %>
                <div class="col-lg-3  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text"><%= b.getNoteDescription() %></p>
                            <p class="card-text p-1 border border-danger text-danger rounded-pill col-4 mb-2 " style="margin: auto;">₹ <%= b.getNotePrice() %></p>
                            
                            <a href="DownloadServlet?fileName=<%= b.getFilePath() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>
                            <ul class="list-group list-group-flush mt-2">
                                <li class="list-group-item text-end"><span style="float: left;"><a href="#" onclick="doLike(<%= b.getNoteId() %>,<%= userId %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span><small class="text-muted"><%= b.getNoteDate() %></small></li>       
                                <a href="show_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                            
                            <!-- BUTTON -->
                                <div class="form-group d-flex justify-content-center">
                                    <a  href="edit_note.jsp?id=<%= b.getNoteId() %>" class="btn btn-success col-5 col-sm-3 col-lg-5  mt-2">Edit</a>                        
                                    <a  href="DeleteNoteServlet?id=<%= b.getNoteId() %> " class="btn btn-dark col-5 col-sm-3 col-lg-5  mt-2 ms-2" >Delete</a>        
                                </div>
                        </div>
                    </div>
                </div>
                                <% }} %>
                <!--Paid notes end-->
                
                <% } %>
                
            </div>
            
            <!--Floating Button start-->
            <div class="action"  onClick="actionToggle();">
                <span class="justify-content-center">+</span>
                <ul>
                    <li> <a href="create_pdf.jsp">Create Pdf</a></li>            
                    <li style="color:white"><a data-bs-toggle="modal"  data-bs-target="#addNoteModal">Add notes</a></li>     
                    <li><a href="contact.jsp">Request notes</a></li>      
                </ul>        
            </div>
            <!--Floating Button end-->
            
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
                       <form action="AddNotesServlet" id="Items" method="post"  enctype="multipart/form-data">
                        
                    <div class="form-group row align-items-center">
                        <!-- NOTE TITLE -->
                        <div class="form-group col-12">                     
                            <input type="text" class="form-control form-control-sm" id="addnoteTitle" placeholder="Enter note title" name="ntitle" required="required">
                        </div>

                        <!-- NOTE DESCRIPTION -->
                        <div class="form-group col-12 mt-3">                     
                            <textarea class="form-control form-control-sm" id="addnoteDescription" rows="3" placeholder="Enter note description" name="ndescription" required="required"></textarea>
                        </div>

                            <div class="form-group col-12 mt-3">  
                                Enter note price in ₹
                                <input type="number" class="form-control form-control-sm" id="addnotePrice" placeholder="Enter note price in rupees" name="nprice" value="0">
                            </div>
                            
                            <div class="form-group col-12 mt-3">                     
                                <input type="text" class="form-control form-control-sm" id="addnoteRazor" placeholder="Enter razorpay key" name="nrazor">
                            </div>

                        <!-- HIDDEN VALUES SENT  -->
                        
                        <!--Hidden data sending all the selected options-->
                        <input type="hidden" name="selectedCategory" id="selectedCategory" value="<%=categoryname %>"/>
                        <input type="hidden" name="selectedCourse" id="selectedCourse" value="<%=coursename %>"/>
                        <input type="hidden" name="selectedSubjectYear" id="selectedSubjectYear" value="<%=subjectyear %>"/>
                        <input type="hidden" name="selectedSubject" id="selectedSubject" value="<%=subjectname %>"/>
                        <input type="hidden" name="selectedSubjectId" id="selectedSubjectId" value="<%=subjectid %>"/>
                        
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

                            <button type="submit" class="btn btn-primary col-5 col-sm-3 mt-4">Add</button>                        
                            <button type="button" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;" data-bs-dismiss="modal">Cancel</button>         

                        </div>

                    </div>
                  </form>

                </div>

              </div>
            </div>
          </div>
           <!--add Notes Model end-->
            
            
        
<!--        <h1><%=categoryname %></h1>
        <h1><%=coursename %></h1>
        <h1><%=subjectid %></h1>
        <h1><%=subjectyear %></h1>
        <h1><%=subjectname %></h1>
        -->
        
         <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
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
        
        
    </body>
</html>
<%    }
%>