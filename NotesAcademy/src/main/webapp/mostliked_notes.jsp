
<%@page import="java.util.List"%>
<%@page import="com.notesacademy.DB.DBConnection"%>
<%@page import="com.notesacademy.DAO.LikeDAOImpl"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page import="com.notesacademy.entities.Note"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");

        UserDetails us = (UserDetails) session.getAttribute("userdetails");
        int UserTotalLikes = 3;

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
            String categoryname = request.getParameter("category");
            String coursename = request.getParameter("course").replaceAll("-", " ");
            int subjectid = Integer.parseInt(request.getParameter("subjectid"));
            String subjectyear = request.getParameter("subjectyear").replaceAll("-", " ");
            String subjectname = request.getParameter("subject").replaceAll("-", " ");
        %> 
        
        <!--------------------------------------------------------------------HEADER AND NOTES------------------------------------------------------------------>

        <div class="container">
            <div class="row text-center" style="margin-top:1em;">
                <h2 class="mb-4 text-start"><b><%= request.getParameter("subject").replaceAll("-", " ")%></b><a id="addnotebtn" class="btn px-3 py-2 ms-1 ms-sm-4 mt-1 mt-sm-0" data-bs-toggle="modal"  data-bs-target="#addNoteModal"><b><span>Add note </span></b></a>

                    <div class="dropdown" style="display: inline-block;">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                            Most Liked notes
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="background-color: white; border: 1px solid green;">
                            <li><a class="dropdown-item" href="notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=subjectid %>&subjectyear=<%=subjectyear.replaceAll("\\s+", "-") %>&subject=<%=subjectname.replaceAll("\\s+", "-")%>"" style="background-color: white">Old notes</a></li>
                          <li><a class="dropdown-item" href="recent_notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=subjectid %>&subjectyear=<%=subjectyear.replaceAll("\\s+", "-") %>&subject=<%=subjectname.replaceAll("\\s+", "-")%>" style="background-color: white">Recent notes</a></li>
                        </ul>
                    </div>
                </h2>
                
                 <!--Unpaid notes start-->
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    List<Note> list = dao.getMostLikedNotes(subjectid);
                    
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
                                <li class="list-group-item text-end"><span style="float: left;"><a href="#" onclick="doLike(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span><small class="text-muted"><%= b.getNoteDate() %></small></li>       
                                <a href="show_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                        </div>
                    </div>
                </div>
                                <% }} %>
                 <!--Unpaid notes end-->
                
                <hr class="mt-5">
                 <h2 class="mb-2 mt-2 text-start"><b>Paid notes</b></h2><br><br>
                
                <!--Paid notes start-->
                <%
                    List<Note> list1 = dao.getMostLikedNotes(subjectid);
                    for(Note b : list1){
                        if(b.getNotePrice()>0)
                        {
                %>
                <div class="col-lg-3  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text"><%= b.getNoteDescription() %></p>
                            
                            <!--Razorpay signed in-->
                                    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
                                   <a onclick="razorPopup(<%= b.getNotePrice() %>,'<%= b.getNoteRazor() %>','<%= b.getFilePath() %>','<%= b.getUserName() %>','<%= b.getNoteTitle() %>','<%= us.getUserName() %>','<%= us.getUserEmail() %>')" class="btn btn-outline-danger rounded-pill col-4  p-1" style="margin: auto">Pay ₹<%= b.getNotePrice() %></a>


                            <ul class="list-group list-group-flush mt-2">
                                <li class="list-group-item text-end"><span style="float: left;"><a href="#" onclick="doLike(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span><small class="text-muted"><%= b.getNoteDate() %></small></li>       
                                <a href="show_paid_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                        </div>
                    </div>
                </div>
                                <% }} %>
                <!--Paid notes end-->
                
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
                        
                        <% 
                                // This is to give price to the note when the user has a total of more than 3 likes
                                if(us.getUserLikeCount()>=UserTotalLikes)
                                { 
                                    
                            %>
                            
                            <div class="form-group col-12 mt-3">  
                                Enter note price in ₹
                                <input type="number" class="form-control form-control-sm" id="addnotePrice" placeholder="Enter note price in rupees" name="nprice" value="0">
                            </div>
                            
                            <div class="form-group col-12 mt-3">                     
                                <input type="text" class="form-control form-control-sm" id="addnoteRazor" placeholder="Enter razorpay key" name="nrazor">
                            </div>
                            
                            <%
                                }
                             %>

           
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
                        <input type="hidden"  name="nprice" value="0">
              
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
           

<!------------------------------------------------------------------------------- ELSE ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
            
    <% } 
else{
        int userId = 0;

    %>
    
        <!-- Alert when add notes button is clicked -->
        <div class="alert alert-warning alert-dismissible fade show mt-5" id="myAlert2" style="display:none;" role="alert">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-hidden="true" ></button>
            Kindly signup or login to add notes!
        </div>
    
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
            String categoryname = request.getParameter("category");
            String coursename = request.getParameter("course").replaceAll("-", " ");
            int subjectid = Integer.parseInt(request.getParameter("subjectid"));
            String subjectyear = request.getParameter("subjectyear").replaceAll("-", " ");
            String subjectname = request.getParameter("subject").replaceAll("-", " ");
        %> 
        
        <!--------------------------------------------------------------------HEADER AND NOTES------------------------------------------------------------------>

        <div class="container">
            <div class="row text-center" style="margin-top:1em;">
                <h2 class="mb-4 text-start"><b><%= request.getParameter("subject").replaceAll("-", " ")%></b><a id="addnotebtn" class="btn px-3 py-2 ms-1 ms-sm-4 mt-1 mt-sm-0" onclick="showAlert();"><b><span>Add note </span></b></a>

                    <div class="dropdown" style="display: inline-block;">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                            Most Liked notes
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="background-color: white; border: 1px solid green;">
                            <li><a class="dropdown-item" href="notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=subjectid %>&subjectyear=<%=subjectyear.replaceAll("\\s+", "-") %>&subject=<%=subjectname.replaceAll("\\s+", "-")%>"" style="background-color: white">Old notes</a></li>
                          <li><a class="dropdown-item" href="recent_notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=subjectid %>&subjectyear=<%=subjectyear.replaceAll("\\s+", "-") %>&subject=<%=subjectname.replaceAll("\\s+", "-")%>" style="background-color: white">Recent notes</a></li>
                        </ul>
                  </div>
                </h2>

                <!--Unpaid notes start-->
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    List<Note> list = dao.getMostLikedNotes(subjectid);
                    
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
                        </div>
                    </div>
                </div>
                                <% }} %>
                 <!--Unpaid notes end-->
                
                <hr class="mt-5">
                 <h2 class="mb-2 mt-2 text-start"><b>Paid notes</b></h2><br><br>
                
                <!--Paid notes start-->
                <%
                    List<Note> list1 = dao.getMostLikedNotes(subjectid);
                    for(Note b : list1){
                        if(b.getNotePrice()>0)
                        {
                %>
                <div class="col-lg-3  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text"><%= b.getNoteDescription() %></p>
                            
                            <!--Razorpay not signed in-->
                                    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
                                   <a onclick="razorPopupNS(<%= b.getNotePrice() %>,'<%= b.getNoteRazor() %>','<%= b.getFilePath() %>','<%= b.getUserName() %>','<%= b.getNoteTitle() %>')" class="btn btn-outline-danger rounded-pill col-4  p-1" style="margin: auto">Pay ₹<%= b.getNotePrice() %></a>


                            <ul class="list-group list-group-flush mt-2">
                                <li class="list-group-item text-end"><span style="float: left;"><a href="#" onclick="doLike(<%= b.getNoteId() %>,<%= userId %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span><small class="text-muted"><%= b.getNoteDate() %></small></li>       
                                <a href="show_paid_pdf.jsp?fileName=<%= b.getFilePath() %>" class="btn btn-outline-dark btn-sm">More Info</a>
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                        </div>
                    </div>
                </div>
                                <% }} %>
                <!--Paid notes end-->
                
            <% } %>                      
            </div>  
        </div>

            <% } %>
         <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
        <!--Javascript for Likes-->
        <script src="Js/Like.js"></script>
        
        <!--Placeholder for e-book search api-->
        <script>
         window.onload = function(){
                        document.getElementById('gsc-i-id1').placeholder = '                                  Search for e-books...';
                    };
       </script>
        
        <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>
        
        <!--Razorpay javascript-->
        <script src="Js/RazorPay.js"></script>
         <script src="Js/RazorPayNotSignedIn.js"></script>

    </body>
</html>