<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <link rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
      integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr"
      crossorigin="anonymous"/>
    
    <link rel="stylesheet" href="style.css" />
    <title>PDF Viewer</title>
  </head>
  <body>
    <div class="top-bar">
        <div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v12.0" nonce="Lllttsp4"></script>
      <button class="btn" id="prev-page">
        <i class="fas fa-arrow-circle-left"></i> Prev Page
      </button>
      <button class="btn" id="next-page">
        Next Page <i class="fas fa-arrow-circle-right"></i>
        
      </button>

      <span class="page-info">
          Page <span id="page-num"></span> of <span id="page-count">
              
              
          </span>
      </span>
    </div>
      <div class="fb-comments" data-href="http://localhost:8080/NotesAcademy/Comments.jsp" data-width="" data-numposts="10"></div>
      

    <canvas id="pdf-render"></canvas>

    <script src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>
    <script src="main.js"></script>
  </body>
</html>
