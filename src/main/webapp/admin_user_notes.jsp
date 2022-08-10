<%-- 
    Document   : admin_user_notes
    Created on : 15 Mar, 2022, 2:31:04 PM
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
        UserDetails us = (UserDetails) session.getAttribute("admindetails");
        
        if(us==null)
        {
            Message msg = new Message("User not allowed in Admin section! Please Login First!", "error", "alert-danger");
            s.setAttribute("message", msg);
           response.sendRedirect("index.jsp");
        }
        else
        {
            UserDAOImpl udao = new UserDAOImpl(DBConnection.getConnection());
            int UserId = Integer.parseInt(request.getParameter("uid"));
            UserDetails c = udao.getUserById(UserId);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User notes | <%= c.getUserName() %></title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/notes.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/AdminNavbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <div class="container mb-4">
            
            <!-- Number cards start -->
            <div class="row text-center" style="margin-top: 4em;">
                <h2 class="mb-0 mt-4 subjects-available" ><b><%= c.getUserName() %>'s Dashboard</b></h2>
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
                
                <hr class="mt-2">
                <h2 class="mb-2 text-start"><b>Notes Uploaded</b></h2>
                
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
                
                <h1 class="text-center mt-5">No notes uploaded!</h1>
                
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

        
    </body>
</html>
<% } %>
