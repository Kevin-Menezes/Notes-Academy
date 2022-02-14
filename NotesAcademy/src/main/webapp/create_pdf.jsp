<%-- 
    Document   : create_pdf
    Created on : 29 Jan, 2022, 10:42:28 AM
    Author     : nivek
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <!-- Bootstrap and Font Awesome links -->
        <%@ include file="Components/Bootstrap.jsp"%>
        <link rel="stylesheet" href="Stylesheets/create_pdf.css">
        
        <script src="https://unpkg.com/pdf-lib@1.4.0"></script>
        <script src="https://unpkg.com/downloadjs@1.4.7"></script>   
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <title>Create PDF</title>
    </head>
    <body>

           <div class="container">
                <div class="nav">
                    <span class="logo">
                    <i class="fa fa-file-pdf-o"></i> IMG TO PDF
                    </span>
                    <div>
                        <button onClick={embedImages()} id="convertBtn" convertBtn={convertBtn} class="mt-sm-0 mt-2">SAVE AS PDF</button>
                    <button onClick={embedImages()} id="download">DOWNLOAD</button>
                    <h4 id="upload-msg"></h4>
                    </div>
                </div>

                <div class="input-page" id="input-page" class="row">
                    <div class="choose-file">          
                        <div class="add-more-files">
                            <div class="inp-container ">
                                <input type="file"  id="upload-file" onChange={encodeImageFileAsURL(this)} multiple accept="image/*"/>
                                <h4 class="drop">
                                    DRAG & DROP OR
                                </h4>
                                <p >
                                    <i class="fa fa-file-image-o fa-4x img-icon"></i>

                                </p>
                                <label htmlFor="upload-file" id="custom-file">CHOOSE FILES</label>
                            </div>
                        </div>            
                    </div>
                </div>

                <div class="pdf-page" id="pdf-page">             
                    <div class="create-pdf" id="create-pdf"> 

                    </div>
                </div>
               
           </div>
               
        <script type="text/javascript" src="Js/create_pdf.js"></script>
        
    <!-- JQuery - Popper - Bootstrap -->
    <%@include file="Components/JqueryPopperBootstrap.jsp" %>

    </body>
</html>
