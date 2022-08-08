<%-- 
    Document   : display_admins
    Created on : 7 Aug, 2022, 8:06:28 PM
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
        <title>Admin | Admin details</title>
        
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
                <h1 class="text-center" id="tabletitle">Add - Edit - Delete Admins</h1>
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
      //                        Loop 1 - Admins loop
                                List<UserDetails> list = dao.getAdmins();
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
                                    <a href="DeleteUserServlet?id=<%=b.getUserId()%>&role=<%=b.getRole() %>" class="btn btn-dark col-12 col-lg-5 ms-0 ms-lg-2 mt-1 mt-lg-0" style="background-color: black;">Delete</a>                                   
                            </td>     
                          </tr> 
                          <%    }
                           %>
                        </tbody>
                    </table>
                </div>
                
                <a  id="addcategorybtn" class="btn px-4 py-2 mt-4 mx-auto" data-bs-toggle="modal"  data-bs-target="#addAdminModal"><b><span>Add admin </span></b></a>
                
                
                <!-- -----------------------------------------------------------ADD ADMIN MODAL------------------------------------------------------------------------------------------------------------------------ -->
                
                <!------------------------------------------- Add Admin Modal ------------------------------------------------>
                <div class="modal fade" id="addAdminModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
                  <div class="modal-dialog">
                    <div class="modal-content">

                      <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Admin</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>

                      <div class="modal-body">

                        <form action="AddAdminServlet" onsubmit ="return verifyPassword();" method="post" >
                          <div class="form-group row align-items-center">
                              <!-- USERNAME -->
                              <div class="form-group col-sm-6">                     
                                  <input type="text" class="form-control form-control-sm" id="signupUsername" placeholder="Enter username" required="required" name="uname" pattern="[A-Za-z\s]{3,30}" oninvalid="this.setCustomValidity('Enter 3 to 30 characters. No numbers & special characters allowed!')" oninput="this.setCustomValidity('')">
                              </div>
                              <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->

                              <!-- PASSWORD -->
                              <div class="form-group col-sm-6 mt-3">                     
                                  <input type="password" class="form-control form-control-sm" id="signupPassword" placeholder="Enter password" aria-describedby="passwordHelpInline" minlength="8" maxlength="20" required="required"  name="upass">
                              </div>
                              <div class="col-sm mt-sm-3">
                                <span id="passwordInline"  class="form-text">Must be 8 to 20 characters long!</span>
                              </div>

                              <!-- EMAIL -->
                              <div class="form-group col-sm-6 mt-3">                     
                                  <input type="email" class="form-control form-control-sm" id="signupEmail" placeholder="Enter email" required="required" name="uemail">
                              </div>
                              <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->

                              <!-- PROFESSION -->
                              <div class="form-group col-sm-6 mt-3">
                                  <input class="form-control form-control-sm" list="datalistOptions" id="exampleDataList" placeholder="Enter your profession" aria-describedby="passwordHelpInline" name="uprof" pattern="[A-Za-z\s]{3,30}" oninvalid="this.setCustomValidity('Enter 3 to 30 characters. No numbers & special characters allowed!')" oninput="this.setCustomValidity('')">
                                <datalist id="datalistOptions">
                                  <option value="Student">
                                  <option value="Teacher">
                                  <option value="Librarian">
                                  <option value="Educational Institute">
                                </datalist>
                              </div>
                              <div class="col-sm mt-sm-3">
                                <span id="datalistInline" class="form-text">
                                  Type if not in options!
                                </span>
                              </div>

                               <!-- COLLEGENAME -->
                              <div class="form-group col-sm-6 mt-3">                     
                                  <input type="text" class="form-control form-control-sm" id="signupClg" placeholder="Enter college/institute name" name="uclg" pattern="[A-Za-z\s]{3,30}" oninvalid="this.setCustomValidity('Enter 3 to 30 characters. No numbers & special characters allowed!')" oninput="this.setCustomValidity('')">
                              </div>
                               <div class="col-sm mt-sm-3">
                                <span id="clgnameInline" class="form-text">
                                  Short form preferred!
                                </span>
                              </div>

                              <!-- BUTTON -->
                              <div class="form-group row">
                                <div class="mt-3  col-md" data-bs-toggle="buttons">
                                    <button type="submit" class="btn btn-primary col-5 col-sm-3 ">Add</button>

                                </div>
                            </div>
                          </div>
                        </form>

                      </div>

                    </div>
                  </div>
                </div>
                
            </div>
        </div>
                        
     <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
    
    <script>
        function verifyPassword()
        {
            var pw = document.getElementById("signupPassword").value;
            console.log(pw);

            if (pw.length < 8)
            {
                document.getElementById("passwordInline").innerHTML = "More than 8 characters required!";
                document.getElementById("passwordInline").style.color = 'red';
                return false;
            } else if (pw.length > 20)
            {
                document.getElementById("passwordInline").innerHTML = "Less than 20 characters required!";
                document.getElementById("passwordInline").style.color = 'red';
                return false;
            } else
            {
                document.getElementById("passwordInline").innerHTML = "Password format correct!";
                return true;
            }
        };
                    
    </script>
 
    </body>
</html>
<%    }
%>

