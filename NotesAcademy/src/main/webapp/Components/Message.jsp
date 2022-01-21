<%@page import="com.notesacademy.entities.Message"%>
<%
    Message mess = (Message) session.getAttribute("message");
    if (mess != null) {
        //print
%>


<div class="alert <%= mess.getCssClass()%> alert-dismissible fade show mt-5" role="alert">
    <strong><%= mess.getContent() %></strong>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
      
  </button>
</div>


<%              session.removeAttribute("message");
   
    }
%>  
