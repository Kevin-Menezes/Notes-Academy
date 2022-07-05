<%-- 
    Document   : contact
    Created on : 29 Jan, 2022, 2:52:41 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");%>
<%
    UserDetails us = (UserDetails) session.getAttribute("userdetails");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact us</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%> 
        <link rel="stylesheet" href="Stylesheets/contact.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <section id="heading">
            <div class="container heading-grid">
                <div class="heading-wrap">
                    <h1 class="text-dark mt-4"><b>Get in Touch</b></h1>
                    <p class="text-dark">Do you need more information or notes? Feel absolutely free to approach us!</p>
                </div>
            </div>
        </section>

        <section id="form-box" class="animated jackInTheBox">
            <div class="container">
                <div class="form-box form-box-grid">
                    <div class="form-info">
                        <h3>Our information</h3>
                        <ul style="padding-left: 0px">
                            <li><i class="fas fa-map-marker-alt"></i>SIES College</li>
                            <li><i class="fas fa-mobile-alt"></i>+91 9987558802</li>
                            <li><i class="fas fa-envelope"></i>enotesprojects@gmail.com</li>
                        </ul>
                    </div>

                    <%
                        if(us!=null)
                        {
                    %>
                    <!--If user has signed in -->
                    <div class="form-input">
                        <h3>Send us a message</h3>
                        <form name="frm" action="ContactFormServlet" method="post">
                            <p class="full">
                                <label for="first_name">Full Name</label>
                                <input type="text" name="uname" value="<%=us.getUserName() %>" required>
                            </p>
                            <p class="full">
                                <label for="Email"> Email address</label>
                                <input type="email"  name="uemail" value="<%=us.getUserEmail() %>"  required>
                            </p>
                            <!--            <p class="full">
                                          <label for="number" maxlength="1">Mobile </label>
                                          <input   type="text"  name="t3"  pattern ="[0-9]{10}"  placeholder="..." maxlength = "10"  required >
                                        </p>-->
                            <p class="full">
                                <label for="message">Your message</label>
                                <textarea  name="message" placeholder="Enter your message..." required></textarea>
                            </p>
                            <p class="full">
                                <button type="submit">Send Message</button>
                            </p>
                        </form>
                    </div>
                            
                    <%
                        }
                        else
                        {
                    %>
                    <!--If user has not signed in -->
                        <div class="form-input">
                        <h3>Send us a message</h3>
                        <form name="frm" action="ContactFormServlet" method="post">
                            <p class="full">
                                <label for="first_name">Full Name</label>
                                <input type="text" name="uname" required>
                            </p>
                            <p class="full">
                                <label for="Email"> Email address</label>
                                <input type="email"  name="uemail" required>
                            </p>
                            <!--            <p class="full">
                                          <label for="number" maxlength="1">Mobile </label>
                                          <input   type="text"  name="t3"  pattern ="[0-9]{10}"  placeholder="..." maxlength = "10"  required >
                                        </p>-->
                            <p class="full">
                                <label for="message">Your message</label>
                                <textarea   name="message" placeholder="Enter your message..." required></textarea>
                            </p>
                            <p class="full">
                                <button type="submit">Send Message</button>
                            </p>
                        </form>
                    </div>
                    <%
                        }
                    %>
                    
                </div>
            </div>
        </section>
                    
        <div class="bg-dark">
                <%@include file="footer.jsp" %>
        </div>    

        <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
  
    </body>
</html>
