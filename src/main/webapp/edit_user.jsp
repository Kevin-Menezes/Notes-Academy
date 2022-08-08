<%-- 
    Document   : edit_user
    Created on : 18 Jan, 2022, 12:32:28 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.DAO.UserDAOImpl"%>
<%@page import="com.notesacademy.entities.Message"%>
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

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin | Edit User</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/display_categories.css">
        
        <style>
            
            .card{
                box-shadow: 0px 2px 45px 0px rgba(0, 0, 0, 0.1);
                border-color: var(--green);
            }
            
            .card-header{ 
                color: white;   
            }
    
            .card:hover{
                box-shadow: none; 
                background-color: wheat;
                opacity: 1;
              
            }  
        </style>
        
    </head>
    <body>
         <!-- Navbar -->
        <%@include file="Components/AdminNavbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <div class="container">
            <div class="row col-xl-4 col-lg-6 col-md-8 col-sm-10 col-12 ms-auto me-auto" style="margin-top:6em;">
                <div class="card p-0">
                    <h3 class="card-header  text-white" style="background-color: var(--green); ">EDIT USER</h3>
                    <div class="card-body">
                        
                        <%
                            
                            int id = Integer.parseInt(request.getParameter("id"));
                            UserDAOImpl dao = new UserDAOImpl(DBConnection.getConnection());
                            UserDetails b = dao.getUserById(id);
                        %>
                        
                        <!--Edit Category form-->
                        <form action="EditUserServlet" method="post">

                            <div class="form-group row align-items-center">
                                
                                <!-- USERNAME -->    
                                <div class="form-group col-sm-6">      
                                    <label for="Username" class="form-label">Username</label>
                                    <input type="text" class="form-control form-control-sm" id="Username" placeholder="Enter username"  name="uname" required="required" value="<%=b.getUserName() %>" pattern="[A-Za-z\s]{3,30}" oninvalid="this.setCustomValidity('Enter 3 to 30 characters. No numbers & special characters allowed!')" oninput="this.setCustomValidity('')">
                                </div>
                                <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->

                                <!-- PASSWORD -->
                                <div class="form-group col-sm-6 mt-3">                
                                    <label for="Password" class="form-label">Password</label>
                                    <input type="text" class="form-control form-control-sm" id="Password" placeholder="Enter password" aria-describedby="passwordHelpInline" required="required" minlength="8" maxlength="20" name="upass" value="<%=b.getUserPassword() %>">
                                </div>
                                <div class="col-sm mt-sm-5">
                                  <span id="passwordInline"  class="form-text">Must be 8-20 characters long!</span>
                                </div>

                                <!-- EMAIL -->
                                <div class="form-group col-sm-6 mt-3"> 
                                    <label for="Email" class="form-label">Email</label>
                                    <input type="email" class="form-control form-control-sm" id="Email" placeholder="Enter email" required="required" name="uemail" value="<%=b.getUserEmail() %>">
                                </div>
                                <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->

                                <!-- PROFESSION -->
                                <div class="form-group col-sm-6 mt-3">
                                    <label for="Profession" class="form-label">Profession</label>
                                    <input class="form-control form-control-sm" list="datalistOptions" id="Profession" placeholder="Enter your profession" aria-describedby="passwordHelpInline" name="uprof" value="<%=b.getUserProfession() %>" pattern="[A-Za-z\s]{3,20}" oninvalid="this.setCustomValidity('Enter 3 to 20 characters. No numbers & special characters allowed!')" oninput="this.setCustomValidity('')">
                                  <datalist id="datalistOptions">
                                    <option value="Student">
                                    <option value="Teacher">
                                    <option value="Librarian">
                                    <option value="Educational Institute">
                                  </datalist>
                                </div>
                                <div class="col-sm mt-sm-5">
                                  <span id="datalistInline" class="form-text">
                                    Type if not in options!
                                  </span>
                                </div>

                                 <!-- COLLEGENAME -->
                                <div class="form-group col-sm-6 mt-3">  
                                    <label for="Clg " class="form-label">College name</label>
                                    <input type="text" class="form-control form-control-sm" id="Clg" placeholder="Enter college/institute name" name="uclg" value="<%=b.getUserCollege() %>" pattern="[A-Za-z\s]{3,30}" oninvalid="this.setCustomValidity('Enter 3 to 30 characters. No numbers & special characters allowed!')" oninput="this.setCustomValidity('')">
                                </div>
                                
                                <div class="col-sm mt-sm-3">
                                    <span id="clgnameInline" class="form-text">
                                      Short form preferred!
                                    </span>
                                 </div>
                                
                                <input type="hidden" name="uid" value="<%= b.getUserId() %>">
                                <input type="hidden" name="role" value="<%= b.getRole() %>">

                                <!-- BUTTON -->
                                <div class="form-group d-flex justify-content-center">
                                    <button type="submit" class="btn btn-success col-5 col-sm-3 mt-4">Update</button>                        
                                    <a onclick="history.back()" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;">Cancel</a>         
                                </div>
                                
                            </div>
                                
                        </form> 
                    </div>
                </div>
            </div>
        </div>

        <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>

    </body>
</html>
<%    }
%>