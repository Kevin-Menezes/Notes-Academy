<%-- 
    Document   : error_page
    Created on : 27 Dec, 2021, 8:10:16 PM
    Author     : nivek
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
    </head>
    <body>
        <h1>Oops! Something went wrong!</h1>
        <h2><%= exception%></h2>
    </body>
</html>
