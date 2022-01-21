<%-- 
    Document   : display_categories
    Created on : 14 Jan, 2022, 7:02:42 PM
    Author     : nivek
--%>

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
        <title>Admin | Categories</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/display_categories.css">
        
    </head>
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <div class="container">
            <div class="row">      
                <h1 class="text-center" id="tabletitle">Add - Edit - Delete Categories</h1>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-success">
                          <tr>
                            <th scope="col">No.</th>
                            <th scope="col">Category name</th>
                            <th scope="col">Action</th>                     
                          </tr>
                        </thead>
                        <tbody>
                            <!--Dynamically display Categories -->
                            <% CategoryDAOImpl daocat = new CategoryDAOImpl(DBConnection.getConnection());
                                int categoryNo=1;
      //                        Loop 1 - Categories loop
                                List<Category> listcat = daocat.getCategoriesWithoutImg();
                                for (Category b : listcat) {
                            %>
                            <tr>
                            <th><%= categoryNo++ %></th>
                            <td><%= b.getCategoryName() %></td>
                            <td>
                                <!-- BUTTON -->    
                                    <a href="edit_category.jsp?id=<%=b.getCategoryId() %>"  class="btn btn-success col-7 col-sm-4 col-lg-2">Edit</a>                        
                                    <a href="DeleteCategoryServlet?id=<%=b.getCategoryId() %>" class="btn btn-dark col-7 col-sm-4 col-lg-2 ms-0 ms-sm-2 mt-1 mt-sm-0" style="background-color: black;">Delete</a>                                   
                            </td>     
                          </tr> 
                          <%    }
                           %>
                        </tbody>
                    </table>
                </div>
                <a id="addcategorybtn" class="btn px-4 py-2 mt-4 mx-auto" data-bs-toggle="modal"  data-bs-target="#addCategoryModal"><b><span>Add category </span></b></a>
                
            </div>
        </div>
                        
         <!-- -----------------------------------------------------------ADD CATEGORY MODAL------------------------------------------------------------------------------------------------------------------------ -->

        <div class="modal fade" id="addCategoryModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
            <div class="modal-dialog">
              <div class="modal-content">

                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">ADD CATEGORY</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                
                    
                       <!-- ADD CATEGORY FORM -->
                    <form action="AddCategoryServlet" method="post" enctype="multipart/form-data">
                        
                    <div class="form-group row align-items-center">
                        <!-- NOTE TITLE -->
                        <div class="form-group col-12">                     
                            <input type="text" class="form-control form-control-sm" id="CategoryName" placeholder="Enter category name" name="catname" required="required">
                        </div>
                              
                        <!-- UPLOAD PDF -->
                        <div class="col-12 mt-3">
                            <span id="datalistInline" class="form-text">
                              Upload Image
                            </span>
                          </div>

                        <!-- FILE UPLOAD -->
                        <div class="form-group col-12  mt-1">                    
                            <input type="file" class="form-control-file " name="catimage" id="file" accept="image/*" required="required" />
                        </div>
                        <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->          

                        <!-- BUTTON -->
                        <div class="form-group d-flex justify-content-center">

                                <button type="submit" class="btn btn-primary col-5 col-sm-3 mt-4">Add</button>                        
                                <button type="button" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;" data-bs-dismiss="modal">Cancel</button>         

                        </div>

                    </div>
                  </form>

                </div>

              </div>
            </div>
          </div>
           <!--Add category Model end-->
           
  
    <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
    </body>
</html>
<%    }
%>
