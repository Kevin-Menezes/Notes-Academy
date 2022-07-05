<%-- 
    Document   : show_admin_pdf
    Created on : 9 Mar, 2022, 9:59:27 AM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");%>
<%
    UserDetails us = (UserDetails) session.getAttribute("userdetails");
    String fn = request.getParameter("fileName");
    String fileName = fn.replace(" \\ " , " /  "); // To replace it so that it matches with the requirement for the browser
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
                <div class="top-bar py-3" style="margin-top: 5em;">
                    <button class="btnpdf p-2" id="prev-page">
                      <i class="fas fa-arrow-circle-left"></i> Prev Page
                    </button>
                    <button class="btnpdf mt-2 mt-md-0 p-2" id="next-page">
                      Next Page <i class="fas fa-arrow-circle-right"></i>
                    </button>
                    <br>
                    <span class="page-info ms-0 ms-md-2" style="font-weight: 700;">
                      Page <span id="page-num"></span> of <span id="page-count"></span>
                    </span>
                </div>
                
                <canvas id="pdf-render"></canvas>
               
            </div>
            
            <a href="Comments.jsp" >link</a>
            
            
        </div>
        
        <div class="fb-comments" data-href="http://localhost:8080/NotesAcademy/show_pdf.jsp?fileName=resourcesmain\Advance%20Java%20Unit%201.pdf" data-width="10" data-numposts="5"></div>
        
        <script src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>
   
        <!-- JQUERY - POPPER - BOOTSTRAP  LINKS IN A SEPARATE FILE -->
        <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        

        <!--Display the pdf-->
        <script type="text/javascript" src="Js/ShowPdf.js"></script>
        
        
    
        <!--Javascript validation for Signup Password and the alert for add notes-->
        <script type="text/javascript" src="Js/SignupValidation.js"></script>
        
        
        
    </body>
</html>

