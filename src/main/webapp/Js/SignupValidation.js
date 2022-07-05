//          Ajax for bootstrap alert when clicking on Add notes
            src = "https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" >

function verifyPassword()
                    {
                        var pw = document.getElementById("signupPassword").value;
                        console.log(pw);


                        if (pw.length < 8)
                        {
                            document.getElementById("passwordInline").innerHTML = "More than 8 numbers required!";
                            return false;
                        } else if (pw.length > 20)
                        {
                            document.getElementById("passwordInline").innerHTML = "Less than 20 numbers required!";
                            return false;
                        } else
                        {
                            document.getElementById("passwordInline").innerHTML = "Password format correct!";
                            return true;
                        }
                    };
                    
                     // For Bootstrap alert when add notes button is clicked
            function showAlert()
            {
                if ($("#myAlert2").length == 0) {
                    $("#myAlert2").append("<div class='alert alert-warning alert-dismissible fade show mt-5' id='myAlert2' role='alert'> <button type='button' class='btn-close' data-bs-dismiss='alert'  aria-hidden='true'></button>Kindly signup login to add notes!</div>");
                }
                $("#myAlert2").css("display", "");
            }

