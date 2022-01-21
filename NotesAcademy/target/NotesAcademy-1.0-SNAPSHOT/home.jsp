<%-- 
    Document   : home
    Created on : 11 Nov, 2021, 10:50:41 AM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Category"%>
<%@page import="com.notesacademy.DAO.CategoryDAOImpl"%>
<%@page import="com.notesacademy.entities.Message"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- NEEDED FOR JSTL -->
<%@page isELIgnored = "false" %> <!-- NEEDED FOR JSTL -->
<%  response.setHeader("cache-Control", "no-cache,no-store,must-revalidate");

        HttpSession s = request.getSession();
        UserDetails us = (UserDetails) session.getAttribute("userdetails");
        
        if(us==null)
        {
            Message msg = new Message("Please Login First!", "error", "alert-danger");
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
        <title>Home | Notes Academy</title>
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/home.css">
   
    </head>
    <body>
        <!-- Navbar -->
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <!-- Header start -->
        <header class="jumbotron">
            <div class="container">

                <div class="row row-header">
                    <div class="col-12 col-sm-6 heading">
                        <h1 class="lets-note-it">Let's note it together.</h1>
                        <h5>College notes available here</h5>
                        <a id="addnotesbtn" class="btn px-4 py-2 mt-4" data-bs-toggle="modal"  data-bs-target="#sendnotesModal"><b><span>Add notes </span></b></a>
                        <a id="recentnotesbtn" class="btn  px-4 py-2 mt-4"><b><span>View recent posts </span></b></a>
                    </div>  
                    <div class="col col-sm"></div>

                    <!--      IMAGE              <div class="col col-sm mt-3 mt-md-0 ">
                                            <img src="Stylesheets/Notebook.jpg" class="img-fluid rounded float-end" alt="...">
                                        </div> Here we put col-sm which means that the remaining extra columns from top(6 columns) will be automatically occupied here     -->

                </div>

            </div>
        </header>
        <!-- Header end -->
        
<!-- -----------------------------------------------------------SEND NOTES MODAL------------------------------------------------------------------------------------------------------------------------ -->

        <div class="modal fade" id="sendnotesModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
            <div class="modal-dialog">
              <div class="modal-content">

                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">ADD NOTE</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                
                    
                       <!-- SEND NOTES FORM -->
                       <form action="SendNotesServlet" id="Items" method="post"  enctype="multipart/form-data">
                        
                    <div class="form-group row align-items-center">
                        <!-- NOTE TITLE -->
                        <div class="form-group col-12">                     
                            <input type="text" class="form-control form-control-sm" id="addnoteTitle" placeholder="Enter note title" name="ntitle" required="required">
                        </div>


                        <!-- NOTE DESCRIPTION -->
                        <div class="form-group col-12 mt-3">                     
                            <textarea class="form-control form-control-sm" id="addnoteDescription" rows="3" placeholder="Enter note description" name="ndescription" required="required"></textarea>
                        </div>

                        <!-- NOTES CATEGORY NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="catname" value="catname" required="required">
                                <option value="" disabled selected hidden>Select Category</option>                               
<!--                                <option value="Science">Science</option>
                                <option value="Commerce">Commerce</option>
                                <option value="Arts">Arts</option>-->
                            </select>
                        </div>

                        <!-- NOTES COURSE NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example"  id="couname" value="couname" required="required">
                                <option value="" disabled selected hidden>Select Course</option>
<!--                                <option value="FYJC">FYJC</option>
                                <option value="SYJC">SYJC</option>
                                <option value="BSC">BSC</option>
                                <option value="BSC CS">BSC CS</option>-->

                            </select>
                        </div>

                        <!-- NOTES COURSE YEAR -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="cyear" value="cyear" required="required">
                                <option value="" disabled selected hidden>Select Course Year</option>
<!--                                <option value="First Year">First Year</option>
                                <option value="Second Year">Second Year</option>
                                <option value="Third Year">Third Year</option>-->
                            </select>
                        </div>

                        <!-- NOTES SUBJECT NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="sname" value="sname" required="required">
                                <option value="" disabled selected hidden>Select Subject</option>

                            </select>
                        </div>
           
                        <!-- HIDDEN VALUES SENT  -->
                        
                        <!--Hidden data sending all the selected options-->
                        <input type="hidden" name="selectedCategory" id="selectedCategory"/>
                        <input type="hidden" name="selectedCourse" id="selectedCourse"/>
                        <input type="hidden" name="selectedSubjectYear" id="selectedSubjectYear"/>
                        <input type="hidden" name="selectedSubject" id="selectedSubject"/>
                        <input type="hidden" name="selectedSubjectId" id="selectedSubjectId"/>
                        
                        <input type="hidden"  name="uname" value="<%= us.getUserName() %>">
                        <input type="hidden"  name="uprofession" value="<%= us.getUserProfession() %>">
                        <input type="hidden"  name="ucollege" value="<%= us.getUserCollege() %>">
              
                        <!-- UPLOAD PDF -->
                        <div class="col-12 mt-3">
                            <span id="datalistInline" class="form-text">
                              Upload PDF
                            </span>
                          </div>

                        <!-- FILE UPLOAD -->
                        <div class="form-group col-12  mt-1">                    
                                <input type="file" class="form-control-file " name="pdf" id="file" accept="application/pdf" required="required"/>
                        </div>
                        <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->  
                        

                        <!-- BUTTON -->
                        <div class="form-group d-flex justify-content-center">

                            <button type="submit" onclick="mydata()" class="btn btn-primary col-5 col-sm-3 mt-4">Add</button>                        
                            <button type="button" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;" data-bs-dismiss="modal">Cancel</button>         

                        </div>

                    </div>
                  </form>

                </div>

              </div>
            </div>
          </div>
           <!--Send Notes Model end-->
           
           <!-- Subjects Available start -->
        <div class="container">
            <div class="row text-center">
                <h2 class="mb-2 mt-5 subjects-available" >Subjects Available</h2>

                <div class="cards"> 
                    <div class="d-flex flex-row justify-content-around flex-wrap">

                        <!--Category and Course Classes-->
                        <% CategoryDAOImpl daocat = new CategoryDAOImpl(DBConnection.getConnection());
                            CourseDAOImpl daocou = new CourseDAOImpl(DBConnection.getConnection());

  //                         Loop 1 - Categories loop
                            List<Category> listcat = daocat.getCategories();
                            for (Category b : listcat) {
                        %>

                        <div class="card mt-4 shadow-lg" style="width: 24rem;"> <!--BOOTSTRAP CARD-->
                            <img src="data:image/jpg;base64, <%= b.getCategoryImgString()%>" class="card-img-top img-fluid" alt="img">

                            <!--                          <div class="card-body">
                                                            <h5 class="card-title">Science</h5>
                                                            <p class="card-text">Some text will come here afterwards</p>
                                                        </div>-->

                            <!--Loop 2 - Courses loop inside Category loop -->
                            <% List<Course> listcou = daocou.getCourses(b.getCategoryId());
                                for (Course c : listcou) {
                            %>
                            <ul class="list-group list-group-flush">
                                <!--Sending category name , course id and course name to subject.jsp through the url-->
                                <a href="subjects.jsp?category=<%=b.getCategoryName()%>&courseid=<%=c.getCourseId()%>&course=<%=c.getCourseName().replaceAll("\\s+", "-")%>" class="card-link"><li class="list-group-item"><%=c.getCourseName()%></li></a>


                                <!--                                <li class="list-group-item"><a href="#" class="card-link">SYJC</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BSc</a></li>
                                                                <li class="list-group-item"><a href="bachelor_of_science_computer_science.jsp" class="card-link">BSc CS</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BSc IT</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BSc Arch</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BCA</a></li>
                                                                <li class="list-group-item"><a href="#" class="card-link">BTech</a></li>-->
                            </ul>
                            <% } %> <!-- Loop 2 end-->
                        </div>
                        <% }%> <!-- Loop 1 end-->
                        
                        <!-- COMMERCE -->
                        <!--                        <div class="card mt-3 mt-lg-0 shadow-lg" style="width: 24rem;"> BOOTSTRAP CARD
                                                    <img src="Stylesheets/Commerce.png" class="card-img-top" alt="Commerce based img" height="256">
                                                    
                                                    <ul class="list-group list-group-flush">
                                                        <li class="list-group-item"><a href="#" class="card-link">FYJC</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">SYJC</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BCom</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BBA</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">CA</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">CS</a></li>
                        
                                                    </ul>
                                                </div>-->

                        <!-- ARTS -->
                        <!--                        <div class="card mt-3 mt-xl-0 shadow-lg" style="width: 24rem;"> BOOTSTRAP CARD
                                                    <img src="Stylesheets/Arts.jpeg" class="card-img-top" alt="Arts based img" height="256">
                                                   
                                                    <ul class="list-group list-group-flush">
                                                        <li class="list-group-item"><a href="#" class="card-link">FYJC</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">SYJC</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BA</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BMS</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BFA</a></li>
                                                        <li class="list-group-item"><a href="#" class="card-link">BEM</a></li>
                                                    </ul>
                                                </div>-->

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Subjects Available end -->
        

    <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
 
    <!--JQuery and Ajax for Asynchronous Add Notes (JQuery should always be used after the document has been loaded)-->
     <script type="text/javascript" src="Js/AddNotes.js"></script>
   
    </body>
</html>
<%    }
%>
