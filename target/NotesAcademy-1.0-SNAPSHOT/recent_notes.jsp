<%-- 
    Document   : recent_notes
    Created on : 31 Jan, 2022, 11:20:50 AM
    Author     : nivek
--%>


<%@page import="com.notesacademy.DAO.UserDAOImpl"%>
<%@page import="com.notesacademy.DAO.ViewDAOImpl"%>
<%@page import="com.notesacademy.DAO.DownloadDAOImpl"%>
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

%>
<!DOCTYPE html>
<html id="BackToTop">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Notes | <%= request.getParameter("subject").replaceAll("-", " ")%></title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/notes.css">
        
    </head>
    
    <body class="d-flex flex-column min-vh-100">
        
        <%
        int UserTotalRank = 1;
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

        <div class="container mb-4">
            <div class="row text-center" style="margin-top:1em;">
                <h2 class="mb-2 text-start"><b><%= request.getParameter("subject").replaceAll("-", " ")%></b><a id="addnotebtn" class="btn px-3 py-2 ms-1 ms-sm-4 mt-4 mt-sm-0 shadow" data-bs-toggle="modal"  data-bs-target="#addNoteModal"><b><span>Add note </span></b></a>

                    <div class="dropdown" style="display: inline-block;">
                        <button class="btn btn-outline-success dropdown-toggle mt-4 mt-sm-0" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                          Most recent
                        </button>
                        
                        <ul class="dropdown-menu dropdown-menu-dark"  style="background-color: black" aria-labelledby="dropdownMenuButton1" >
                            <li><a class="dropdown-item" href="notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=subjectid %>&subjectyear=<%=subjectyear.replaceAll("\\s+", "-") %>&subject=<%=subjectname.replaceAll("\\s+", "-")%>">No filter</a></li>
                            <li><a class="dropdown-item" href="mostliked_notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=subjectid %>&subjectyear=<%=subjectyear.replaceAll("\\s+", "-") %>&subject=<%=subjectname.replaceAll("\\s+", "-")%>" >Most liked</a></li>
                        </ul>
                        
                    </div>
                </h2>
                        
                <!----------------Unpaid notes start----------------->
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    DownloadDAOImpl ddao = new DownloadDAOImpl(DBConnection.getConnection());
                    ViewDAOImpl vdao = new ViewDAOImpl(DBConnection.getConnection());
                    UserDAOImpl udao = new UserDAOImpl(DBConnection.getConnection());
           
                    List<Note> list = dao.getRecentNotes(subjectid);
                    
                    int mostdownloaded = ddao.getMostDownloadedNote(subjectid);
                    int mostliked = ldao.getMostLikedNote(subjectid);
                    int mostviewed = vdao.getMostViewedNote(subjectid);
                    
                    if(list.isEmpty())
                    {
                        
                  %>
                
                        <h1 class="text-center mt-5">Notes unavailable!</h1>
                        <h3 class="text-center mt-3">Kindly search in the search bar or feel free to upload some!</h3>
                
                <%  
                    }
                    else
                    {   
                        for(Note b : list){
                            if(b.getNotePrice()==0)
                            {
                %>
                
                                <div class="col-xl-3 col-lg-4  mt-4">
                                    <div class="card shadow">
                                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                                        <div class="card-body">  

                                            <!--For doing classification based on a particular subject -->
                                            <% 
                                                System.out.println("-------------------------------------------------------"+mostliked+"  "+b.getLikeCount());

                                                    // (((1&2) || (1&3)) || (2&3))    ||      (((1&2) & (1&3)) & (2&3))
                                                    if( (((mostdownloaded==b.getDownloadCount() && mostliked==b.getLikeCount())  || (mostdownloaded==b.getDownloadCount() && mostviewed==b.getViewCount())) || (mostliked==b.getLikeCount() && mostviewed==b.getViewCount() ))     ||     (((mostdownloaded==b.getDownloadCount() && mostliked==b.getLikeCount()) && (mostdownloaded==b.getDownloadCount() && mostviewed==b.getViewCount())) && (mostliked==b.getLikeCount() && mostviewed==b.getViewCount() ))  )                                    
                                                    {
                                                        if((b.getDownloadCount()>0 && b.getLikeCount()>0) && b.getViewCount()>0)
                                                        {
                                               %>

                                                        <span class="badge bg-info text-dark" style="float: left;">Best value</span>

                                               <%     
                                                        }
                                                    }
                                                    else if ((mostdownloaded==b.getDownloadCount()) && (b.getDownloadCount()>0))
                                                    {
                                             %>

                                                        <span class="badge bg-warning text-dark" style="float: left;">Most downloaded</span>

                                            <% 
                                                    }
                                                    else if ((mostliked==b.getLikeCount()) && (b.getLikeCount()>0))
                                                    { 
                                             %>

                                                        <span class="badge bg-dark" style="float: left;">Best liked</span>

                                             <% 
                                                    }
                                                    else if ((mostviewed==b.getViewCount()) && (b.getViewCount()>0))
                                                    { 
                                             %>

                                                        <span class="badge bg-success" style="float: left;">Most used</span>

                                             <% 
                                                    }
                                                    else 
                                                    { }
                                             %>


                                            <p class="card-text"><%= b.getNoteDescription() %></p>
                                            <a href="DownloadServlet?fileName=<%= b.getFilePath() %>&noteId=<%= b.getNoteId() %>&userId=<%= us.getUserId() %>&nuserId=<%= b.getUserId() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>

                                            <ul class="list-group list-group-flush mt-2">
                                                <li class="list-group-item text-end" style="padding:8px 0 8px 0px"><span style="float: left;"><a href="" onclick="doLike(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                                    <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                                    <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                                    <small class="text-muted"><%= b.getNoteDate() %></small>
                                                </li>     

                                                <a href="show_pdf.jsp?fileName=<%= b.getFilePath() %>&noteId=<%= b.getNoteId() %>&userId=<%= us.getUserId() %>&nuserId=<%= b.getUserId() %>" onclick="doView(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm">View Note</a>

                                                <li class="list-group-item text-center text-muted"><span class="badge bg-warning text-dark me-2 " ><%= b.getUserRank() %>&nbsp;<i class="fa fa-star"></i></span><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                                            </ul>

                                        </div>
                                    </div>
                                </div>
                                <% }} %>
                <!--------------------Unpaid notes end----------------------->
                
                <hr class="mt-5">
                <h2 class="mb-1 mt-2 text-start"><b>Paid notes</b></h2><br><br>
                
                <!--------------------Paid notes start------------------------->
                <%
                    
                    int mostdownloadedpaid = ddao.getMostDownloadedPaidNote(subjectid);
                    int mostlikedpaid = ldao.getMostLikedPaidNote(subjectid);
                    
                    List<Note> list1 = dao.getRecentNotes(subjectid);
                    for(Note b : list1){
                        if(b.getNotePrice()>0)
                        {
                %>
                            <div class="col-xl-3 col-lg-4  mt-4">
                                <div class="card shadow" >
                                    <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                                    <div class="card-body">           

                                        <% 
                                               
                                                if (mostdownloadedpaid==b.getDownloadCount() && mostlikedpaid==b.getLikeCount())
                                                {
                                                    if((b.getDownloadCount()>0 && b.getLikeCount()>0))
                                                        {

                                         %>
                                                        
                                                    <span class="badge bg-info text-dark" style="float: left;">Value for money</span>

                                        <% 
                                                        }
                                                }

                                                else if ((mostdownloadedpaid==b.getDownloadCount()) && (b.getDownloadCount()>0))
                                                {
                                         %>

                                                    <span class="badge bg-warning text-dark" style="float: left;">Best Seller</span>

                                        <% 
                                                }
                                                else if ((mostlikedpaid==b.getLikeCount()) && (b.getLikeCount()>0))
                                                {
                                        %>   

                                                    <span class="badge bg-dark" style="float: left;">Most liked</span>

                                        <% 
                                                }
                                                else{}
                                        %>   

                                        <p class="card-text"><%= b.getNoteDescription() %></p>

                                        <!--Razorpay signed in-->
                                        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
                                        <a onclick="razorPopup(<%= b.getNotePrice() %>,'<%= b.getNoteRazor() %>','<%= b.getFilePath() %>','<%= b.getUserName() %>','<%= b.getNoteTitle() %>','<%= us.getUserName() %>','<%= us.getUserEmail() %>',<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-danger rounded-pill col-4  p-1" style="margin: auto">Pay ₹<%= b.getNotePrice() %></a>

                                        <ul class="list-group list-group-flush mt-2">
                                            <li class="list-group-item text-end" style="padding:8px 0 8px 0px"><span style="float: left;"><a href="" onclick="doLike(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                                <small class="text-muted "><%= b.getNoteDate() %></small>
                                            </li> 

                                            <a href="show_paid_pdf.jsp?fileName=<%= b.getFilePath() %>&noteId=<%= b.getNoteId() %>&userId=<%= us.getUserId() %>&nuserId=<%= b.getUserId() %>&userName=<%= us.getUserName() %>&userEmail=<%= us.getUserEmail() %>" onclick="doView(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm">View Note</a>
                                            <li class="list-group-item text-center text-muted"><span class="badge bg-warning text-dark me-2 " ><%= b.getUserRank() %>&nbsp;<i class="fa fa-star"></i></span><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                                        </ul>

                                    </div>
                                </div>
                            </div>
                                <% }} %>
                <!-------------------Paid notes end--------------------->
                             
                <% } %> <!--End of else-->
            </div>  
        </div>
            
        <!-------------------Floating Button start------------------>
       <div class="action"  onClick="actionToggle();">
           <span class="justify-content-center"><i class="fa fa-plus mt-3" style="font-size: 20px;"></i></span>
           <ul>
               <li> <a href="create_pdf.jsp">Create Pdf</a></li>            
               <li style="color:white"><a data-bs-toggle="modal"  data-bs-target="#addNoteModal">Add notes</a></li>     
               <li><a href="contact.jsp">Request notes</a></li>      
           </ul>        
       </div>
       <!-------------------Floating Button end------------------>
            
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
                   <form action="SendNotesServlet"  id="Items" method="post"  enctype="multipart/form-data">

                        <div class="form-group row align-items-center">
                            <!-- NOTE TITLE -->
                            <div class="form-group col-12">                     
                                <input type="text" class="form-control form-control-sm" id="addnoteTitle" placeholder="Enter note title (max 40 words)" name="ntitle" required="required" minlength="3" maxlength="40">
                            </div>

                            <!-- NOTE DESCRIPTION -->
                            <div class="form-group col-12 mt-3">                     
                                <textarea class="form-control form-control-sm" id="addnoteDescription" rows="3" placeholder="Enter note description (max 100 words) (optional)" name="ndescription" maxlength="100" ></textarea>
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

            
<!------------------------------------------------------------------------------- ELSE ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
            
    <% } 
          else
          {

    %>
    
            <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!-- Alert when add notes button is clicked -->
        <div class="alert alert-warning alert-dismissible fade show mt-5" id="myAlert2" style="display:none;" role="alert">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-hidden="true" ></button>
            Kindly signup or login to add, view and download notes and also give likes!
        </div>
       
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

        <div class="container mb-4">
            <div class="row text-center" style="margin-top:1em;">
                <h2 class="mb-2 text-start"><b><%= request.getParameter("subject").replaceAll("-", " ")%></b><a id="addnotebtn" class="btn px-3 py-2 ms-1 ms-sm-4 mt-4 mt-sm-0 shadow" onclick="showAlert();" href="#BackToTop"><b><span>Add note </span></b></a>

                    <div class="dropdown" style="display: inline-block;">
                        <button class="btn btn-outline-success dropdown-toggle mt-4 mt-sm-0" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                          Most recent
                        </button>
                        
                        <ul class="dropdown-menu dropdown-menu-dark"  style="background-color: black" aria-labelledby="dropdownMenuButton1" >
                            <li><a class="dropdown-item" href="notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=subjectid %>&subjectyear=<%=subjectyear.replaceAll("\\s+", "-") %>&subject=<%=subjectname.replaceAll("\\s+", "-")%>">No filter</a></li>
                            <li><a class="dropdown-item" href="mostliked_notes.jsp?category=<%=categoryname%>&course=<%=coursename.replaceAll("\\s+", "-")%>&subjectid=<%=subjectid %>&subjectyear=<%=subjectyear.replaceAll("\\s+", "-") %>&subject=<%=subjectname.replaceAll("\\s+", "-")%>" >Most liked</a></li>
                        </ul>
                        
                    </div>
                </h2>
                        
                <!----------------Unpaid notes start----------------->
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    DownloadDAOImpl ddao = new DownloadDAOImpl(DBConnection.getConnection());
                    ViewDAOImpl vdao = new ViewDAOImpl(DBConnection.getConnection());
                    UserDAOImpl udao = new UserDAOImpl(DBConnection.getConnection());
           
                    List<Note> list = dao.getRecentNotes(subjectid);
                    
                    int mostdownloaded = ddao.getMostDownloadedNote(subjectid);
                    int mostliked = ldao.getMostLikedNote(subjectid);
                    int mostviewed = vdao.getMostViewedNote(subjectid);
                    
                    if(list.isEmpty())
                    {
                        
                %>
                
                        <h1 class="text-center mt-5">Notes unavailable!</h1>
                        <h3 class="text-center mt-3">Kindly search in the search bar or feel free to upload some!</h3>
                
                <%  
                    }
                    else
                    {   
                        for(Note b : list){
                            if(b.getNotePrice()==0)
                            {
                %>
                
                                <div class="col-xl-3 col-lg-4  mt-4">
                                    <div class="card shadow">
                                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                                        <div class="card-body">  

                                            <!--For doing classification based on a particular subject -->
                                            <% 
                                                System.out.println("-------------------------------------------------------"+mostliked+"  "+b.getLikeCount());

                                                    // (((1&2) || (1&3)) || (2&3))    ||      (((1&2) & (1&3)) & (2&3))
                                                    if( (((mostdownloaded==b.getDownloadCount() && mostliked==b.getLikeCount())  || (mostdownloaded==b.getDownloadCount() && mostviewed==b.getViewCount())) || (mostliked==b.getLikeCount() && mostviewed==b.getViewCount() ))     ||     (((mostdownloaded==b.getDownloadCount() && mostliked==b.getLikeCount()) && (mostdownloaded==b.getDownloadCount() && mostviewed==b.getViewCount())) && (mostliked==b.getLikeCount() && mostviewed==b.getViewCount() ))  )                                    
                                                    {
                                                        if((b.getDownloadCount()>0 && b.getLikeCount()>0) && b.getViewCount()>0)
                                                        {
                                               %>

                                                        <span class="badge bg-info text-dark" style="float: left;">Best value</span>

                                               <%     
                                                        }
                                                    }
                                                    else if ((mostdownloaded==b.getDownloadCount()) && (b.getDownloadCount()>0))
                                                    {
                                             %>

                                                        <span class="badge bg-warning text-dark" style="float: left;">Most downloaded</span>

                                            <% 
                                                    }
                                                    else if ((mostliked==b.getLikeCount()) && (b.getLikeCount()>0))
                                                    { 
                                             %>

                                                        <span class="badge bg-dark" style="float: left;">Best liked</span>

                                             <% 
                                                    }
                                                    else if ((mostviewed==b.getViewCount()) && (b.getViewCount()>0))
                                                    { 
                                             %>

                                                        <span class="badge bg-success" style="float: left;">Most used</span>

                                             <% 
                                                    }
                                                    else 
                                                    { }
                                             %>


                                            <p class="card-text"><%= b.getNoteDescription() %></p>
                                            <a onclick="showAlert();" href="#BackToTop" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>

                                            <ul class="list-group list-group-flush mt-2">
                                                <li class="list-group-item text-end" style="padding:8px 0 8px 0px"><span style="float: left;"><a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                                    <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                                    <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                                    <small class="text-muted"><%= b.getNoteDate() %></small>
                                                </li>     

                                                <a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-dark btn-sm">View Note</a>

                                                <li class="list-group-item text-center text-muted"><span class="badge bg-warning text-dark me-2 " ><%= b.getUserRank() %>&nbsp;<i class="fa fa-star"></i></span><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                                            </ul>

                                        </div>
                                    </div>
                                </div>
                    <% }} %>
                <!--------------------Unpaid notes end----------------------->
                
                <hr class="mt-5">
                <h2 class="mb-1 mt-2 text-start"><b>Paid notes</b></h2><br><br>
                
                <!--------------------Paid notes start------------------------->
                <%
                    
                    int mostdownloadedpaid = ddao.getMostDownloadedPaidNote(subjectid);
                    int mostlikedpaid = ldao.getMostLikedPaidNote(subjectid);
                    
                    List<Note> list1 = dao.getRecentNotes(subjectid);
                    for(Note b : list1){
                        if(b.getNotePrice()>0)
                        {
                %>
                            <div class="col-xl-3 col-lg-4  mt-4">
                                <div class="card shadow" >
                                    <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                                    <div class="card-body">           

                                        <% 
                                               
                                                if (mostdownloadedpaid==b.getDownloadCount() && mostlikedpaid==b.getLikeCount())
                                                {
                                                    if((b.getDownloadCount()>0 && b.getLikeCount()>0))
                                                        {

                                         %>
                                                        
                                                    <span class="badge bg-info text-dark" style="float: left;">Value for money</span>

                                        <% 
                                                        }
                                                }

                                                else if ((mostdownloadedpaid==b.getDownloadCount()) && (b.getDownloadCount()>0))
                                                {
                                         %>

                                                    <span class="badge bg-warning text-dark" style="float: left;">Best Seller</span>

                                        <% 
                                                }
                                                else if ((mostlikedpaid==b.getLikeCount()) && (b.getLikeCount()>0))
                                                {
                                        %>   

                                                    <span class="badge bg-dark" style="float: left;">Most liked</span>

                                        <% 
                                                }
                                                else{}
                                        %>   

                                        <p class="card-text"><%= b.getNoteDescription() %></p>

                                        <a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-danger rounded-pill col-4  p-1" style="margin: auto">Pay ₹<%= b.getNotePrice() %></a>

                                        <ul class="list-group list-group-flush mt-2">
                                            <li class="list-group-item text-end" style="padding:8px 0 8px 0px"><span style="float: left;"><a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                                <small class="text-muted "><%= b.getNoteDate() %></small>
                                            </li> 

                                            <a onclick="showAlert();" href="#BackToTop" class="btn btn-outline-dark btn-sm">View Note</a>
                                            <li class="list-group-item text-center text-muted"><span class="badge bg-warning text-dark me-2 " ><%= b.getUserRank() %>&nbsp;<i class="fa fa-star"></i></span><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                                        </ul>

                                    </div>
                                </div>
                            </div>
                    <% }} %>
                <!-------------------Paid notes end--------------------->
                             
                <% } %> <!--End of else-->
            </div>  
        </div>

        <!-------------------Floating Button start------------------>
          <div class="action"  onClick="actionToggle();">
              <span class="justify-content-center"><i class="fa fa-plus mt-3" style="font-size: 20px;"></i></span>
              <ul>
                  <li> <a href="create_pdf.jsp">Create Pdf</a></li>            
                  <li style="color:white"><a onclick="showAlert();" href="#BackToTop">Add notes</a></li>     
                  <li><a href="contact.jsp">Request notes</a></li>      
              </ul>        
          </div>
      <!-------------------Floating Button end------------------>
    <%            
        }
    %>
   
         <%@include file="footer_small.jsp" %>
            
         <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
        <!--Javascript for Likes-->
        <script src="Js/Like.js"></script>
        
        <!--JQuery and Ajax for Asynchronous Add Notes (JQuery should always be used after the document has been loaded)-->
        <script type="text/javascript" src="Js/AddNotes.js"></script>
        
        <!--For the floating button toggle-->
        <script type="text/javascript">
            
            function actionToggle()
            {
                var action=document.querySelector('.action');
                action.classList.toggle('active');
            }
            
            window.onload = function(){
                        document.getElementById('gsc-i-id1').placeholder = '                                  E-books search...';
                    };
                    
       </script>
        
        <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>
        
        <!--Razorpay javascript-->
        <script src="Js/RazorPay.js"></script>

    </body>
</html>

