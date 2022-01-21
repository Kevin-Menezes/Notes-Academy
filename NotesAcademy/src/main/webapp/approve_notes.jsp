<%-- 
    Document   : approve_notes
    Created on : 19 Jan, 2022, 6:38:34 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Note"%>
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

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin | Approve notes</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/notes.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!--------------------------------------------------------------------HEADER AND NOTES------------------------------------------------------------------>

        <div class="container">
            <div class="row text-center" style="margin-top:6em;">
                <h2 class="mb-4 text-start"><b>Check the notes sent by user</b></h2><br><br>

                <%
                    NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection()); 
                    List<Note> list = dao.approveNotes();
                    for(Note b : list){
                %>
                
                <div class="col-lg-3  mt-4">
                    <div class="card" style="border-color: #6B9B8A;">
                        <div class="card-header" style="background-color: #6B9B8A; color: white; "><%= b.getNoteTitle() %></div>
                        <div class="card-body">           
                            <p class="card-text"><%= b.getNoteDescription() %></p>
                    
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item text-center"><a href="DownloadServlet?fileName=<%= b.getFilePath() %>" class="btn btn-primary btn-sm"><i class="fas fa-download"></i>&nbsp; Download notes</a><small class="text-muted ms-2"><%= b.getNoteDate() %></small></li>
                                <li class="list-group-item text-center text-muted"><%= b.getCategoryName()%> -> <%= b.getCourseName()%> -> <%= b.getSubjectYear() %> -> <b><%= b.getSubjectName() %></b></li>                                  
                                <li class="list-group-item text-center text-muted"><%= b.getUserName() %> - <%= b.getUserProfession() %> - <%= b.getUserCollege() %></li>        
                            </ul>
                            <!-- BUTTON -->
                                <div class="form-group d-flex justify-content-center">
                                    <a href="ApproveNotesServlet?id=<%= b.getNoteId() %>"  class="btn btn-success col-5 col-sm-3 col-lg-5  mt-2">Add</a>                        
                                    <a href="TempNotesDeleteServlet?id=<%= b.getNoteId() %>" class="btn btn-dark col-5 col-sm-3 col-lg-5 mt-2 ms-2" style="background-color: black;">Delete</a>        
                                </div>
                        </div>
                    </div>
                </div>
                                <% } %>
            </div>
        </div>
            
            <!-- JQuery - Popper - Bootstrap -->
            <%@include file="Components/JqueryPopperBootstrap.jsp" %>

    </body>
</html>
<%    }
%>