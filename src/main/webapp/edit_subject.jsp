<%-- 
    Document   : edit_subject
    Created on : 17 Jan, 2022, 1:05:23 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Subject"%>
<%@page import="com.notesacademy.DAO.SubjectDAOImpl"%>
<%@page import="com.notesacademy.DB.DBConnection"%>
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
        <title>Admin | Edit Subject</title>
        
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
                    <h3 class="card-header  text-white" style="background-color: var(--green); ">EDIT SUBJECT</h3>
                    <div class="card-body">
                        
                        <%
                            
                            int id = Integer.parseInt(request.getParameter("id"));
                            SubjectDAOImpl dao = new SubjectDAOImpl(DBConnection.getConnection());
                            Subject b = dao.getSubjectById(id);
                        %>
                        
                        <!--Edit Category form-->
                        <form action="EditSubjectServlet" method="post">

                            <div class="form-group row align-items-center">
                                    
                                <div class="form-group col-12">   
                                    <label for="editSubject" class="form-label">Subject name</label>
                                    <input type="text" class="form-control form-control-sm" id="editSubject" placeholder="Enter Subject name" required="required" name="subname" value="<%= b.getSubjectName() %>" pattern="[A-Za-z\s]{3,100}" oninvalid="this.setCustomValidity('Enter 3 to 100 characters. No numbers & special characters allowed!')" oninput="this.setCustomValidity('')">
                                    
                                    <label for="editSubjectYear" class="form-label mt-2">Subject year</label>
                                    <select name="subyear" class="form-select form-select-sm" id="editSubjectYear">     
                                        <option value="<%= b.getSubjectYear() %>" selected hidden><%= b.getSubjectYear() %></option>
                                        <option value="First Year">First Year</option>
                                        <option value="Second Year">Second Year</option>
                                        <option value="Third Year">Third Year</option>
                                        <option value="Fourth Year">Fourth Year</option>
                                        
                                    </select>
                                    
                                    <input type="hidden" name="subid" value="<%= b.getSubjectId() %>">
                                </div>
                                
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
