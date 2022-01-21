<%-- 
    Document   : edit_note
    Created on : 20 Jan, 2022, 12:40:04 PM
    Author     : nivek
--%>

<%@page import="com.notesacademy.entities.Note"%>
<%@page import="com.notesacademy.DAO.NoteDAOImpl"%>
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
        <title>Admin | Edit Note</title>
        
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
        <%@include file="Components/Navbar.jsp" %>
        <%@include file="Components/Message.jsp" %>
        
        <div class="container">
            <div class="row col-xl-4 col-lg-6 col-md-8 col-sm-10 col-12 ms-auto me-auto" style="margin-top:6em;">
                <div class="card p-0">
                    <h3 class="card-header  text-white" style="background-color: var(--green); ">EDIT NOTE</h3>
                    <div class="card-body">
                        
                        <%
                            
                            int id = Integer.parseInt(request.getParameter("id"));
                            NoteDAOImpl dao = new NoteDAOImpl(DBConnection.getConnection());
                            Note b = dao.getNoteById(id);
                        %>
                        
                        <!-- SEND NOTES FORM -->
                       <form action="EditNoteServlet" id="Items" method="post"  enctype="multipart/form-data">
                        
                    <div class="form-group row align-items-center">
                        <!-- NOTE TITLE -->
                        <div class="form-group col-12">                     
                            <input type="text" class="form-control form-control-sm" id="addnoteTitle" placeholder="Enter note title" name="ntitle"  value="<%=b.getNoteTitle() %>">
                        </div>

                        <!-- NOTE DESCRIPTION -->
                        <div class="form-group col-12 mt-3">                     
                            <input type="text" class="form-control form-control-sm" id="addnoteDescription" rows="3" placeholder="Enter note description" name="ndescription" value="<%= b.getNoteDescription() %>">
                        </div>

                        <!-- NOTES CATEGORY NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="catname" value="catname" required="required">
                                <option value="<%=b.getCategoryName() %>" disabled selected hidden><%=b.getCategoryName() %></option>                               
<!--                                <option value="Science">Science</option>
                                <option value="Commerce">Commerce</option>
                                <option value="Arts">Arts</option>-->
                            </select>
                        </div>

                        <!-- NOTES COURSE NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example"  id="couname" value="couname" required="required">
                                <option value="<%=b.getCourseName() %>" disabled selected hidden><%=b.getCourseName() %></option>
<!--                                <option value="FYJC">FYJC</option>
                                <option value="SYJC">SYJC</option>
                                <option value="BSC">BSC</option>
                                <option value="BSC CS">BSC CS</option>-->

                            </select>
                        </div>

                        <!-- NOTES COURSE YEAR -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="cyear" value="cyear" required="required">
                                <option value="<%=b.getSubjectYear() %>" disabled selected hidden><%=b.getSubjectYear() %></option>
<!--                                <option value="First Year">First Year</option>
                                <option value="Second Year">Second Year</option>
                                <option value="Third Year">Third Year</option>-->
                            </select>
                        </div>

                        <!-- NOTES SUBJECT NAME -->
                        <div class="form-group col-12  mt-3">
                            <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="sname" value="sname" required="required">
                                <option value="<%=b.getSubjectName() %>" disabled selected hidden><%=b.getSubjectName() %></option>

                            </select>
                        </div>
           
                        <!-- HIDDEN VALUES SENT  -->
                        
                        <!--Hidden data sending all the selected options-->
                        <input type="hidden" name="selectedCategory" id="selectedCategory"/>
                        <input type="hidden" name="selectedCourse" id="selectedCourse"/>
                        <input type="hidden" name="selectedSubjectYear" id="selectedSubjectYear"/>
                        <input type="hidden" name="selectedSubject" id="selectedSubject"/>
                        <input type="hidden" name="selectedSubjectId" id="selectedSubjectId"/> 
                        <input type="hidden" name="nid" value="<%= b.getNoteId() %>">
                        
                        <!-- UPLOAD PDF -->
                        <div class="col-12 mt-3">
                            <span id="datalistInline" class="form-text">
                              Change PDF - <%= b.getFilePath() %>
                            </span>
                          </div>

                        <!-- FILE UPLOAD -->
                        <div class="form-group col-12  mt-1">                    
                            <input type="file" class="form-control-file " name="pdf" id="file" accept="application/pdf" required="required" value="<%= b.getFilePath() %>"/>
                        </div>
                        <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->  
                        

                        <!-- BUTTON -->
                        <div class="form-group d-flex justify-content-center">

                            <button type="submit" onclick="mydata()" class="btn btn-success col-5 col-sm-3 mt-4">Update</button>                        
                            <a  onclick="history.back()" class="btn btn-dark col-5 col-sm-3 mt-4 ms-2" style="background-color: black;">Cancel</a>      

                        </div>

                    </div>
                  </form>
                                
                    </div>
                </div>
            </div>
        </div>

        <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>
        
    <!--JQuery and Ajax for Asynchronous Add Notes (JQuery should always be used after the document has been loaded)-->
     <script type="text/javascript" src="Js/AddNotes.js"></script>
    
    </body>
</html>
<%    }
%>