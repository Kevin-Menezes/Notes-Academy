<%-- 
    Document   : display_users
    Created on : 18 Jan, 2022, 11:23:23 AM
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
        <title>Admin | User details</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/display_categories.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/AdminNavbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <div class="container">
            <div class="row">      
                <h1 class="text-center" id="tabletitle">Edit - Delete Users</h1>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-success">
                          <tr>
                            <th scope="col">No.</th>
                            <th scope="col">Name</th>
                            <th scope="col">Password</th>
                            <th scope="col">Email</th>
                            <th scope="col">Profession</th>
                            <th scope="col">College</th>
                            <th scope="col">Action</th>                     
                          </tr>
                        </thead>
                        <tbody>
                            <!--Dynamically display Users -->
                            <% UserDAOImpl dao = new UserDAOImpl(DBConnection.getConnection());
                                int userNo=1;
      //                        Loop 1 - Users loop
                                List<UserDetails> list = dao.getUsers();
                                for (UserDetails b : list) {
                            %>
                            <tr>
                            <th><%= userNo++ %></th>
                            <td><a href="admin_user_notes.jsp?uid=<%=b.getUserId() %>" class="text-decoration-none"><%= b.getUserName() %></a></td>
                            <td><%= b.getUserPassword() %></td>
                            <td><%= b.getUserEmail() %></td>
                            <td><%= b.getUserProfession() %></td>
                            <td><%= b.getUserCollege() %></td>
                            <td>
                                <!-- BUTTON -->    
                                    <a href="edit_user.jsp?id=<%=b.getUserId() %>"  class="btn btn-success col-12 col-lg-5">Edit</a>                        
                                    <a href="DeleteUserServlet?id=<%=b.getUserId() %>" class="btn btn-dark col-12 col-lg-5 ms-0 ms-lg-2 mt-1 mt-lg-0" style="background-color: black;">Delete</a>                                   
                            </td>     
                          </tr> 
                          <%    }
                           %>
                        </tbody>
                    </table>
                </div>
                <!--<a id="addcategorybtn" class="btn px-4 py-2 mt-4 mx-auto" data-bs-toggle="modal"  data-bs-target="#addCategoryModal"><b><span>Add category </span></b></a>-->
                
            </div>
        </div>
                        
     <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
 
    </body>
</html>
<%    }
%>
