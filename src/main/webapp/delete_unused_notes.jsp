<%-- 
    Document   : delete_unused_notes
    Created on : 10 Mar, 2022, 10:13:00 AM
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

        HttpSession s = request.getSession();
        UserDetails us = (UserDetails) session.getAttribute("admindetails");

    if (us == null) {
        Message msg = new Message("Please Login First!", "error", "alert-danger");
        s.setAttribute("message", msg);
        response.sendRedirect("index.jsp");
    } else if (!"admin@gmail.com".equals(us.getUserEmail()) && !"admin13579".equals(us.getUserPassword())) {
        Message msg = new Message("User not allowed in Admin section!", "error", "alert-danger");
        s.setAttribute("message", msg);
        response.sendRedirect("home.jsp");
    } else {

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin | Unused Notes</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/notes.css">
        
    </head>
    <body>
        
        
        <!-- Navbar -->
        <%@include file="Components/AdminNavbar.jsp" %>
        <%@include file="Components/Message.jsp" %>

        <!--------------------------------------------------------------------HEADER AND NOTES------------------------------------------------------------------>

        <div class="container">
            <div class="row text-center" style="margin-top:6em;">
                <h2 class="mb-4 text-start"><b>Delete unused notes</b></h2><br><br>
                     
                <!----------------Unpaid notes start----------------->
                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                    LikeDAOImpl ldao = new LikeDAOImpl(DBConnection.getConnection());
                    DownloadDAOImpl ddao = new DownloadDAOImpl(DBConnection.getConnection());
                    ViewDAOImpl vdao = new ViewDAOImpl(DBConnection.getConnection());
                    UserDAOImpl udao = new UserDAOImpl(DBConnection.getConnection());
           
                    List<Note> list = dao.getUnusedNotes();
                    
                    if(list.isEmpty())
                    {
                        
                %>
                
                        <h1 class="text-center mt-5">Good going! All notes are of use!</h1>
                
                <%  
                    }
                    else
                    {   
                        for(Note b : list){
                            if(b.getNotePrice()==0)
                            {
                %>
                
                                <div class="col-xl-3 col-lg-4  mt-4">
                                    <div class="card " style="border-color: #6B9B8A;">
                                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                                        <div class="card-body">  

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
                                            
                                            <!-- BUTTON -->
                                            <div class="form-group d-flex justify-content-center">                                                    
                                                <a href="email_delete_unused_note.jsp?nid=<%= b.getNoteId() %>&uid=<%= b.getUserId() %>&nfile=<%= b.getFilePath() %>" class="btn btn-dark col-5 col-sm-3 col-lg-5 mt-2 ms-2" style="background-color: black;">Delete</a>         
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <% }} %>
                <!--------------------Unpaid notes end----------------------->
                
                <hr class="mt-5">
                <h2 class="mb-2 mt-2 text-start"><b>Paid notes</b></h2><br><br>
                
                <!--------------------Paid notes start------------------------->
                <%                   
                    List<Note> list1 = dao.getUnusedNotes();
                    for(Note b : list1){
                        if(b.getNotePrice()>0)
                        {
                %>
                            <div class="col-xl-3 col-lg-4  mt-4">
                                <div class="card " style="border-color: #6B9B8A;">
                                    <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                                    <div class="card-body">           
                                        
                                        <p class="card-text"><%= b.getNoteDescription() %></p>
                                        <p class="card-text p-1 border border-danger text-danger rounded-pill col-4 mb-2 " style="margin: auto;">₹ <%= b.getNotePrice() %></p>

                                        <a href="DownloadServlet?fileName=<%= b.getFilePath() %>&noteId=<%= b.getNoteId() %>&userId=<%= us.getUserId() %>&nuserId=<%= b.getUserId() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a>
                                        <ul class="list-group list-group-flush mt-2">
                                            <li class="list-group-item text-end" style="padding:8px 0 8px 0px"><span style="float: left;"><a href="" onclick="doLike(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm"><i class="far fa-thumbs-up"></i>&nbsp; <%= ldao.countLike(b.getNoteId()) %></a></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-download"></i>&nbsp; <%= ddao.countDownload(b.getNoteId()) %></span>
                                                <span style="float: left;" class="btn btn-outline-success btn-sm disabled ms-2" ><i class="fa fa-eye"></i>&nbsp; <%= vdao.countView(b.getNoteId()) %></span>
                                                <small class="text-muted "><%= b.getNoteDate() %></small>
                                            </li> 

                                            <a href="show_admin_pdf.jsp?fileName=<%= b.getFilePath() %>" onclick="doView(<%= b.getNoteId() %>,<%= us.getUserId() %>,<%= b.getUserId() %>)" class="btn btn-outline-dark btn-sm">View Note</a>
                                            <li class="list-group-item text-center text-muted"><span class="badge bg-warning text-dark me-2 " ><%= b.getUserRank() %>&nbsp;<i class="fa fa-star"></i></span><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                                        </ul>
                                        <!-- BUTTON -->
                                        <div class="form-group d-flex justify-content-center">                               
                                            <a href="email_delete_unused_note.jsp?nid=<%= b.getNoteId() %>&uid=<%= b.getUserId() %>&nfile=<%= b.getFilePath() %>" class="btn btn-dark col-5 col-sm-3 col-lg-5 mt-2 ms-2" style="background-color: black;">Delete</a>             
                                        </div>

                                    </div>
                                </div>
                            </div>
                                <% }} %>
                <!-------------------Paid notes end--------------------->
                             
                <% } %> <!--End of else-->
            </div>       
        
        </div>
            
            <%@include file="footer_small.jsp" %>
            
         <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
        <!--Javascript for Likes-->
        <script src="Js/Like.js"></script>
        
        <!--JQuery and Ajax for Asynchronous Add Notes (JQuery should always be used after the document has been loaded)-->
        <script type="text/javascript" src="Js/AddNotes.js"></script>
        
    </body>
</html>
<% } %>
