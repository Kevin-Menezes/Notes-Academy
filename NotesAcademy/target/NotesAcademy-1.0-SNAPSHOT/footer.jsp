<%-- 
    Document   : footer
    Created on : 12 Feb, 2022, 11:51:12 AM
    Author     : nivek
--%>

<div class="container mt-lg-5 text-white pt-3 pt-sm-5 pb-3 ">
    <div class="row">
        <div class="col-12 col-lg-6">
            <h3 style="color: var(--green)">About us</h3>
            <p>Notes Academy is a platform that manages and provides free study notes which can be accessed by any college student. You can also upload your notes which will be beneficial to others in need of notes.</p>
        </div>
        
        <div class="col-12 col-sm-6 col-lg-2">
            <h3 style="color: var(--green)">Links</h3>
            <ul style="list-style-type: none; text-decoration: none;" class="ps-0">
                <li><a href="index.jsp" style="text-decoration: none;">Home</a></li>
                <li><a href="contact.jsp" style="text-decoration: none;">Contact</a></li>
                <li><a href="create_pdf.jsp" style="text-decoration: none;">Create PDF</a></li>
                <%
                    if (us == null) {
                %>
                <li><a onclick="showAlert();" href="#BackToTop" style="text-decoration: none;">Add notes</a></li>
                <%
                    }
                    else {
                %>
                <li><a data-bs-toggle="modal"  href="#sendnotesModal" style="text-decoration: none;">Add notes</a></li>
                <%
                    }
                %>
            </ul>
        </div>
        
        <div class="col-12 col-sm-6 col-lg-4">
            <h3 style="color: var(--green)">Address</h3>
            <div class="place">
              <span class="fas fa-map-marker-alt"></span>
              <span class="text">SIES College</span>
            </div>
            <div class="phone">
              <span class="fas fa-phone-alt"></span>
              <span class="text">+91 9987558802</span>
            </div>
            <div class="email">
              <span class="fas fa-envelope"></span>
              <span class="text">enotesprojects@gmail.com</span>
            </div>
            
        </div>
    </div>
</div>