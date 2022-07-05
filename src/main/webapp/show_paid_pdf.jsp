<%-- 
    Document   : show_paid_pdf
    Created on : 28 Feb, 2022, 12:38:49 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Note"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");%>
<%
    UserDetails us = (UserDetails) session.getAttribute("userdetails");
    String fn = request.getParameter("fileName");
    String fileName = fn.replace(" \\ " , " /  "); // To replace it so that it matches with the requirement for the browser
    
    int noteId = Integer.parseInt(request.getParameter("noteId"));
    int userId = Integer.parseInt(request.getParameter("userId"));
    int nuserId = Integer.parseInt(request.getParameter("nuserId"));
    String userName = request.getParameter("userName");
    String userEmail = request.getParameter("userEmail");
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pdf Info | <%= request.getParameter("fileName").substring(14)%></title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/show_pdf.css">
        
        <!--Javascript for Likes-->
        <script src="Js/Like.js"></script>

    </head>
    <body>
        
        <!--Facebook comment plugin-->
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v12.0" nonce="Lllttsp4"></script>
       
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!--To send the file name to the js page (to get value by id)-->
        <input type="text" id="filename" value="<%=fileName %>" style="display: none" />
        
        <div class="container">
            <div class="row col-12">
                
                <h4 style="margin-top: 3em;" class="border border-dark ms-2 p-2 rounded text-center " >For paid notes only the first 4 pages will be displayed for users to check the quality of notes</h4>
                
                
                <div class="top-bar py-3" >
                    <button class="btnpdf p-2 mb-2" id="prev-page">
                      <i class="fas fa-arrow-circle-left"></i> Prev Page
                    </button>
                    <button class="btnpdf mt-2 mt-md-0 p-2 mb-2" id="next-page">
                      Next Page <i class="fas fa-arrow-circle-right"></i>
                    </button>
                    
                    <% 
                            NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                            Note b = dao.getNoteById(noteId);
                            
                        %>
                        
                        <a href="" onclick="doLike(<%= noteId %>,<%= userId %>,<%= nuserId %>)" class="btn btn-outline-dark ms-2 mb-1 me-1"><i class="far fa-thumbs-up"></i>&nbsp; <%= b.getLikeCount() %></a>
                    
                        <!--Razorpay signed in-->
                                    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
                                   <a onclick="razorPopup(<%= b.getNotePrice() %>,'<%= b.getNoteRazor() %>','<%= b.getFilePath() %>','<%= b.getUserName() %>','<%= b.getNoteTitle() %>','<%= userName %>','<%= userEmail %>',<%= b.getNoteId() %>,<%= userId %>,<%= b.getUserId() %>)" class="btn btn-outline-danger rounded-pill  px-4 py-2" style="margin: auto">Pay ₹<%= b.getNotePrice() %></a>
                        
                        <div class="d-flex justify-content-end mt-2">
                            <span class="btn btn-outline-success btn-sm disabled me-2 mb-2 " ><i class="fa fa-download"></i>&nbsp; <%= b.getDownloadCount() %></span>
                            <span class="btn btn-outline-success btn-sm disabled mb-2 " ><i class="fa fa-eye"></i>&nbsp; <%= b.getViewCount() %></span>
                        </div>
                        
                        
                    <br>
                    <span class="page-info ms-0 ms-md-2" style="font-weight: 700;">
                      Page <span id="page-num"></span> of <span id="page-count"></span>
                    </span>
                </div>
                
                <canvas id="pdf-render"></canvas>
               
            </div>
            
       
            
        </div>
        
        <div class="fb-comments" data-href="http://localhost:8080/NotesAcademy/show_pdf.jsp?fileName=resourcesmain\Advance%20Java%20Unit%201.pdf" data-width="10" data-numposts="5"></div>
        
        <script src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>
   
        <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        

        <!--Display the pdf-->
        <script type="text/javascript" src="Js/ShowPaidPdf.js"></script>
        
        <!--Razorpay javascript-->
        <script src="Js/RazorPay.js"></script>
         <script src="Js/RazorPayNotSignedIn.js"></script>
    
        <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>
        
        
        
    </body>
</html>

