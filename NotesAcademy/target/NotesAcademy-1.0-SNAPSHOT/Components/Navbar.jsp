<%@page import="com.notesacademy.entities.Category"%>
<%@page import="com.notesacademy.DAO.CategoryDAOImpl"%>
<%@page import="com.notesacademy.entities.UserDetails"%>
<%@page import="com.notesacademy.entities.Course"%>
<%@page import="com.notesacademy.DAO.CourseDAOImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.notesacademy.DB.DBConnection"%>



<!-- -------------------------------------------------------------------------- Navbar ------------------------------------------------------------------------------------------------------------------------ -->

  <div class="container-fluid p-0">

    <nav class="navbar navbar-expand-lg fixed-top navbar-dark">
        <div class="container-fluid">
            
          <!-- <a class="navbar-brand" href="#">Notes Academy</a>
           RESPONSIVE BUTTON 
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNav"> -->

            <!-- Three lines button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#Navbar">
              <span class="navbar-toggler-icon"></span>
            </button>

            <a class="navbar-brand me-auto ms-2 notes-academy" href="index.jsp"><b>Notes Academy</b></a>

          <div class=" collapse navbar-collapse" id="Navbar">  
            
            <!-- SEARCH BAR -->
            
            <form class="d-flex ms-0 ms-lg-3 mt-3 mt-lg-0" action="search.jsp" method="post">
                <input id="search-input" class="form-control me-2" type="search" placeholder="Search for notes..." aria-label="Search" name="ch">

                  <button class="btn btn-outline-light" type="submit"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search mb-1" viewBox="0 0 16 16">
                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
              </svg></button>
            </form>

            <div class="me-auto"></div> <!--THIS SHIFTS THE LINKS TO THE RIGHT-->
            
            <ul class="navbar-nav">
               
              <!--HOME-->
              <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
              </li>

              <!-- CATEGORIES -->

              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">Categories</a>

                <ul class="dropdown-menu shadow-lg">  
                  
                  <!--Category and Course Classes-->
                        <% CategoryDAOImpl daocat2 = new CategoryDAOImpl(DBConnection.getConnection());
                            CourseDAOImpl daocou2 = new CourseDAOImpl(DBConnection.getConnection());

  //                        Loop 1 - Categories loop
                            List<Category> listcat2 = daocat2.getCategories();
                            for (Category d : listcat2) {
                        %>
                  
                  <li class="dropstart">
                    <a href="#" class="dropdown-item dropdown-toggle" data-bs-toggle="dropdown" aria-labelledby="navbarDropdownMenuLink"><%= d.getCategoryName() %></a>
                    <ul class="dropdown-menu shadow-lg">
                        
                            <!--Loop 2 - Courses loop inside Category loop -->
                            <% List<Course> listcou2 = daocou2.getCourses(d.getCategoryId());
                                for (Course e : listcou2) {
                            %>
                       
                                    <li><a class="dropdown-item" href="subjects.jsp?category=<%=d.getCategoryName()%>&courseid=<%=e.getCourseId()%>&course=<%=e.getCourseName().replaceAll("\\s+", "-")%>"><%= e.getCourseName() %></a></li>
                      
                      
<!--                      <li><a class="dropdown-item" href="">Bachelor of Science</a>
                      <li><a class="dropdown-item" href="bachelor_of_science_computer_science.jsp">Bachelor of Science Computer Science</a>
                      <li><a class="dropdown-item" href="">Bachelor of Science Information Technology</a>
                      <li><a class="dropdown-item" href="">Bachelor of Architecture</a>
                      <li><a class="dropdown-item" href="">Bachelor of Computer Applications</a>
                      <li><a class="dropdown-item" href="">Bachelor of Technology</a>-->
    
                    <% } %> <!-- Loop 2 end-->
                    </ul>
                      
                  </li>
                  <% } %> <!-- Loop 1 end-->
                </ul>
                  

                  <!-- COMMERCE -->
<!--                  <li class="dropstart">
                    <a href="#" class="dropdown-item dropdown-toggle" data-bs-toggle="dropdown" data-bs-auto-close="outside">Commerce</a>
                    <ul class="dropdown-menu shadow-lg">
                      <li><a class="dropdown-item" href="">First Year Junior College</a></li>
                      <li><a class="dropdown-item" href="">Second Year Junior College</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Commerce</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Economics</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Accounting and Finance</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Commerce in Banking and Insurance </a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Commerce in Financial Market</a></li> 
                      <li><a class="dropdown-item" href="">Company Secretary</a></li>
                      <li><a class="dropdown-item" href="">Chartered Accountancy</a></li>                       
                    </ul>
                  </li>-->

                  <!-- ARTS -->
<!--                  <li class="dropstart">
                    <a href="#" class="dropdown-item dropdown-toggle" data-bs-toggle="dropdown">Arts</a>
                    <ul class="dropdown-menu shadow-lg">
                      <li><a class="dropdown-item" href="">First Year Junior College</a></li>
                      <li><a class="dropdown-item" href="">Second Year Junior College</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Arts</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Business Management</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Fine Arts</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Hotel Management</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Event Management</a></li>
                      <li><a class="dropdown-item" href="">Bachelor of Management Science </a></li>                     
                    </ul>
                  </li>
                </ul>
              </li>-->

              <!-- CONTACT -->
              <li class="nav-item">
                <a class="nav-link" href="contact.jsp">Contact</a>
              </li>

              <%
                    if (us == null) {
                %>
              
              <!-- PROFILE -->
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">Profile</a>
                  
                <ul class="dropdown-menu shadow-lg" aria-labelledby="navbarDropdownMenuLink">
                  <li><a class="dropdown-item" data-bs-toggle="modal"  href="#loginModal" >Log in</a></li>
                  <li><a class="dropdown-item"  data-bs-toggle="modal"  href="#signupModal" >Sign up</a></li>               
                </ul>
              </li>
              
              <%      
    }
    else 
    {
%>
        <!-- PROFILE -->
        <li class="nav-item dropdown" style="padding-right: 5em;">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">Profile</a>
                  
                <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                    <li class="dropdown-item">Hello <%= us.getUserName() %></li>
                    <li class="dropdown-item"><a href="LogoutServlet" style="color: black; text-decoration: none;">Log out</a></li>               
                </ul>
              </li>
            
    <% } %>

            </ul>

          </div>
        </div>
      </nav>

  </div>

<!-- --------------------------------------------------------------------------MODALS------------------------------------------------------------------------------------------------------------------------ -->

<!-------------------------------------------- Login Modal -------------------------------------------------->
<div class="modal fade" id="loginModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Login</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
          
          <form action="LoginServlet" method="post">
          <div class="form-group row align-items-center">
              <!-- EMAIL -->
              <div class="form-group col-sm-6">                     
                  <input type="email" class="form-control form-control-sm" id="loginEmail" placeholder="Enter email" required="required" name="email">
              </div>
              <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->

              <!-- PASSWORD -->
              <div class="form-group col-sm-6 mt-3">                     
                  <input type="password" class="form-control form-control-sm" id="loginPassword" placeholder="Enter password" aria-describedby="passwordHelpInline" required="required" minlength="8" maxlength="20" name="password">
              </div>
              <div class="col-sm mt-sm-3">
                <span id="passwordHelpInline" class="form-text">
                  Must be 8-20 characters long!
                </span>
              </div>

              <!-- BUTTON -->
              <div class="form-group row">
                <div class="mt-3  col-md" data-bs-toggle="buttons">
                    <button type="submit" class="btn btn-primary col-5 col-sm-3 ">Login</button>
                    
                </div>
            </div>
          </div>
        </form>
      
      </div>

      <div class="modal-footer">
        <div class="col-7 col-sm-6 col-md-4">
          <span class="form-text" style="float: right;">
            Don't have an account?
          </span>
        </div>
        <button class="btn btn-dark"  data-bs-dismiss="modal" data-bs-toggle="modal"  href="#signupModal" >Sign Up</button>
      </div>
    </div>
  </div>
</div>

<!--------------------------------------------------------------------------------------------------------- -->

<!------------------------------------------- Sign Up Modal ------------------------------------------------>
<div class="modal fade" id="signupModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Sign Up</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">

              
        <form action="SignUpServlet" method="post" onsubmit ="return verifyPassword()">
          <div class="form-group row align-items-center">
              <!-- USERNAME -->
              <div class="form-group col-sm-6">                     
                  <input type="text" class="form-control form-control-sm" id="signupUsername" placeholder="Enter username" required="required" name="uname">
              </div>
              <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->

              <!-- PASSWORD -->
              <div class="form-group col-sm-6 mt-3">                     
                  <input type="password" class="form-control form-control-sm" id="signupPassword" placeholder="Enter password" aria-describedby="passwordHelpInline" required="required" minlength="8" maxlength="20" name="upass">
              </div>
              <div class="col-sm mt-sm-3">
                <span id="passwordInline"  class="form-text">Must be 8-20 characters long!</span>
              </div>

              <!-- EMAIL -->
              <div class="form-group col-sm-6 mt-3">                     
                  <input type="email" class="form-control form-control-sm" id="signupEmail" placeholder="Enter email" required="required" name="uemail">
              </div>
              <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->
              
              <!-- PROFESSION -->
              <div class="form-group col-sm-6 mt-3">
                  <input class="form-control form-control-sm" list="datalistOptions" id="exampleDataList" placeholder="Enter your profession" aria-describedby="passwordHelpInline" name="uprof">
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
                  <input type="text" class="form-control form-control-sm" id="signupClg" placeholder="Enter college/institute name" name="uclg">
              </div>
              <div class="col-sm"></div> <!--THIS IS FOR THE EXTRA SPACE-->

              <!-- BUTTON -->
              <div class="form-group row">
                <div class="mt-3  col-md" data-bs-toggle="buttons">
                    <button type="submit" class="btn btn-primary col-5 col-sm-3 ">Sign Up</button>
                    
                </div>
            </div>
          </div>
        </form>
      
      </div>

      <div class="modal-footer">
        <div class="col-7 col-sm-6 col-md-4">
          <span class="form-text" style="float: right;">
            Already have an account?
          </span>
        </div>
        <button class="btn btn-dark" data-bs-dismiss="modal"  data-bs-toggle="modal"  href="#loginModal">Login</button>
      </div>
    </div>
  </div>
</div>


    
    
