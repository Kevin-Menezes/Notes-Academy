<%-- 
    Document   : admin_home
    Created on : 14 Jan, 2022, 11:26:50 AM
    Author     : nivek
--%>

<%@page import="com.notesacademy.DAO.UserDAOImpl"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
<%@page import="com.notesacademy.DAO.SubjectDAOImpl"%>
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
        <title>Admin | Notes Academy</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/admin_home.css">
        
         <style>
            .card-header{
                background-color: #6B9B8A; 
                color: white;          
            }
            
            .card:hover{
                box-shadow: none; 
                opacity: 1;
                background-color: #6B9B8A; 
            }  
        </style>
        
    </head>
    
    <body>
        
        <!-- Navbar -->
        <%@include file="Components/AdminNavbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
<!-- ----------------------------------------------------------------ADMIN CARDS------------------------------------------------------------------------------------------------------------------------ -->
 
    <!-- CATEGORIES -->
    
     <% CategoryDAOImpl daocat = new CategoryDAOImpl(DBConnection.getConnection());
            int catcount = daocat.getCategoriesCount();
     %>
    <div class="container">
            <div class="row adminhome-Cards">
                <div class="col-lg-3">
                    <div class="card">
                        <div class="card-body text-center">
                            <h1><%= catcount %></h1>
                            <h4 class="card-title ">CATEGORIES</h4>
                            <p class="card-text">Add - Edit - Delete categories</p>
                            <a href="display_categories.jsp" class="btn btn-dark">Make changes</a>
                        </div>
                    </div>
                </div>
                
    <!-- COURSES -->
    
    <% CourseDAOImpl daocou = new CourseDAOImpl(DBConnection.getConnection());
            int coucount = daocou.getCoursesCount();
     %>
                <div class="col-lg-3 mt-lg-0 mt-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <h1><%= coucount %></h1>
                            <h4 class="card-title ">COURSES</h4>
                            <p class="card-text">Add - Edit - Delete courses</p>
                            <a href="display_courses.jsp" class="btn btn-dark">Make changes</a>
                        </div>
                    </div>
                </div>
    
    <!-- SUBJECTS -->
    <% SubjectDAOImpl daosub = new SubjectDAOImpl(DBConnection.getConnection());
            int subcount = daosub.getSubjectsCount();
     %>
                <div class="col-lg-3 mt-lg-0 mt-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <h1><%= subcount %></h1>
                            <h4 class="card-title ">SUBJECTS</h4>
                            <p class="card-text">Add - Edit - Delete subjects</p>
                            <a href="display_subjects.jsp" class="btn btn-dark">Make changes</a>
                        </div>
                    </div>
                </div>
    
    <!-- NOTES -->
    <% NoteDAOImpl daonote = new NoteDAOImpl(DBConnection.getConnection());
            int notecount = daonote.getNotesCount();
     %>
                <div class="col-lg-3 mt-lg-0 mt-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <h1><%= notecount %></h1>
                            <h4 class="card-title ">NOTES</h4>
                            <p class="card-text">Add - Edit - Delete notes</p>
                            <a href="display_notes.jsp" class="btn btn-dark">Make changes</a>
                        </div>
                    </div>
                </div>
                
                <!-- APPROVE NOTES -->
                <div class="col-lg-4 mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">APPROVE NOTES</h4>
                            <p class="card-text">Upload the notes sent by the user</p>
                            <a href="approve_notes.jsp" class="btn btn-dark">Check notes</a>
                        </div>
                    </div>
                </div>
                
                <!-- ADD NOTES -->
                <div class="col-lg-4 mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">ADD NOTES</h4>
                            <p class="card-text">Add notes in various subjects</p>
                            <a data-bs-toggle="modal"  data-bs-target="#addnotesModal" class="btn btn-dark">Add notes</a>
                        </div>
                    </div>
                </div>
                
                <!-- DELETE UNUSED NOTES -->
                <div class="col-lg-4 mt-4">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">DELETE UNUSED NOTES</h4>
                            <p class="card-text">Delete notes whose views are <10</p>
                            <a href="delete_unused_notes.jsp" class="btn btn-dark">Delete notes</a>
                        </div>
                    </div>
                </div>
                
                <!-- USERS -->
                <% UserDAOImpl daouser = new UserDAOImpl(DBConnection.getConnection());
                      int usercount = daouser.getUsersCount();
                %>
                <div class="col-lg-3 mt-4 mx-auto">
                    <div class="card">
                        <div class="card-body text-center">
                            <h1><%= usercount %></h1>
                            <h4 class="card-title ">USERS</h4>
                            <p class="card-text">Edit - Remove Users</p>
                            <a href="display_users.jsp" class="btn btn-dark">Make changes</a>
                        </div>
                    </div>
                </div>
                            
                 <!-- ADMINS -->
                 <% 
                      int admincount = daouser.getAdminsCount();
                %>
                <div class="col-lg-3 mt-4 mx-auto">
                    <div class="card">
                        <div class="card-body text-center">
                            <h1><%= admincount %></h1>
                            <h4 class="card-title ">ADMINS</h4>
                            <p class="card-text">Add - Edit - Remove Admins</p>
                            <a href="display_admins.jsp" class="btn btn-dark">Make changes</a>
                        </div>
                    </div>
                </div>           

            </div>
                            
            <!--Floating Button start-->
            <div class="action"  onClick="actionToggle();">
                <span class="justify-content-center"><i class="fa fa-plus mt-3" style="font-size: 20px;"></i></span>
                <ul>
                    <li> <a href="create_pdf.jsp">Create Pdf</a></li>            
                    <li style="color:white"><a data-bs-toggle="modal"  data-bs-target="#addnotesModal">Add notes</a></li>     
                    <li><a href="contact.jsp">Request notes</a></li>      
                </ul>        
            </div>
            <!--Floating Button end-->
            
            
                            
        </div>

                            
<!-- -----------------------------------------------------------SEND NOTES MODAL------------------------------------------------------------------------------------------------------------------------ -->

        <div class="modal fade" id="addnotesModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
            <div class="modal-dialog">
              <div class="modal-content">

                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">ADD NOTE</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                
                    
                       <!-- SEND NOTES FORM -->
                       <form action="AddNotesServlet" onsubmit="mydata()" id="Items" method="post"  enctype="multipart/form-data">
                        
                    <div class="form-group row align-items-center">
                        <!-- NOTE TITLE -->
                        <div class="form-group col-12">                     
                            <input type="text" class="form-control form-control-sm" id="addnoteTitle" placeholder="Enter note title (max 40 words)" name="ntitle" required="required" minlength="3" maxlength="40">
                        </div>


                        <!-- NOTE DESCRIPTION -->
                        <div class="form-group col-12 mt-3">                     
                            <textarea class="form-control form-control-sm" id="addnoteDescription" rows="3" placeholder="Enter note description (max 100 words) (optional)" name="ndescription"  maxlength="100"></textarea>
                        </div>

                        <!-- NOTES CATEGORY NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="catname" value="catname" required="required">
                                <option value="" disabled selected hidden>Select Category</option>                               
                            </select>
                        </div>

                        <!-- NOTES COURSE NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example"  id="couname" value="couname" required="required">
                                <option value="" disabled selected hidden>Select Course</option>
                            </select>
                        </div>

                        <!-- NOTES COURSE YEAR -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="cyear" value="cyear" required="required">
                                <option value="" disabled selected hidden>Select Course Year</option>
                            </select>
                        </div>

                        <!-- NOTES SUBJECT NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="sname" value="sname" required="required">
                                <option value="" disabled selected hidden>Select Subject</option>

                            </select>
                        </div>
           
                        <div class="form-group col-12 mt-3">  
                                Enter note price in ₹
                                <input type="number" class="form-control form-control-sm" id="addnotePrice" placeholder="Enter note price in rupees" required="required" name="nprice" value="0" min="0" oninvalid="this.setCustomValidity('Enter price as 0 or greater than 0')" oninput="this.setCustomValidity('')">
                            </div>
                            
                            <div class="form-group col-12 mt-3">                     
                                <input type="text" class="form-control form-control-sm" id="addnoteRazor" placeholder="Enter razorpay key" name="nrazor">
                            </div>
                        
                        <!-- HIDDEN VALUES SENT  -->
                        
                        <!--Hidden data sending all the selected options-->
                        <input type="hidden" name="selectedCategory" id="selectedCategory"/>
                        <input type="hidden" name="selectedCourse" id="selectedCourse"/>
                        <input type="hidden" name="selectedSubjectYear" id="selectedSubjectYear"/>
                        <input type="hidden" name="selectedSubject" id="selectedSubject"/>
                        <input type="hidden" name="selectedSubjectId" id="selectedSubjectId"/>
                        
                        <input type="hidden"  name="uid" value="<%= us.getUserId() %>">
                        <input type="hidden"  name="uname" value="<%= us.getUserName() %>">
                        <input type="hidden"  name="uprofession" value="<%= us.getUserProfession() %>">
                        <input type="hidden"  name="ucollege" value="<%= us.getUserCollege() %>">
                        <input type="hidden"  name="urank" value="<%= us.getUserRank() %>">
        
                        <!-- UPLOAD PDF -->
                        <div class="col-12 mt-3">
                            <span id="datalistInline" class="form-text">
                              Upload PDF (Please put only letters in your file name. Do not use numbers or special characters.)
                            </span>
                          </div>

                        <!-- FILE UPLOAD -->
                        <div class="form-group col-12  mt-1">                    
                                <input type="file" class="form-control-file " name="pdf" id="file" accept="application/pdf" required="required"/>
                        </div>
                        <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->  
                        

                        <!-- BUTTON -->
                        <div class="form-group d-flex justify-content-center">

                            <button type="submit" onclick="addNoteValidate()" class="btn btn-primary col-5 col-sm-3 mt-4">Add</button>                        
                            <button type="button" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;" data-bs-dismiss="modal">Cancel</button>         

                        </div>

                    </div>
                  </form>

                </div>

              </div>
            </div>
          </div>
           <!--Send Notes Model end-->
                
        
        <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
 
    <!--JQuery and Ajax for Asynchronous Add Notes (JQuery should always be used after the document has been loaded)-->
     <script type="text/javascript" src="Js/AddNotes.js"></script>
     
     <!--For the floating button toggle-->
        <script type="text/javascript">
            function actionToggle()
            {
                var action=document.querySelector('.action');
                action.classList.toggle('active')
            }
       </script>
        
    </body>
</html>
<%    }
%>