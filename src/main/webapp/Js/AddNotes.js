// Making the variables global
var categoryName;
var courseName;
var courseYear;
var subjectName;
var subjectid;

// This function gets executed onclick of submit button
function mydata()
         {      
             var hiddenSelectedCategory = document.getElementById("selectedCategory");
             hiddenSelectedCategory.value = categoryName;
             
             var hiddenSelectedCourse = document.getElementById("selectedCourse");
             hiddenSelectedCourse.value = courseName;
             
             var hiddenSelectedSubjectYear = document.getElementById("selectedSubjectYear");
             hiddenSelectedSubjectYear.value = courseYear;
             
             var hiddenSelectedSubject = document.getElementById("selectedSubject");
             hiddenSelectedSubject.value = subjectName;
             
             var hiddenSelectedSubjectId = document.getElementById("selectedSubjectId");
             hiddenSelectedSubjectId.value = subjectid;
             
//             if(addNoteValidate()==true)
//             {
//                 // Submit the form using javascript
//                var form = document.getElementById("Items");
//                form.submit();
//                 
//             }
             
            
         }
         

// JQuery should always be used after the document has been loaded
$(document).ready(function () {

                // Categories start
                $.ajax({
                    url: "GetCategoryCourseYearSubjectServlet",
                    method: "GET",
                    data: {operation: 'category'},
                    
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        let obj = $.parseJSON(data);
                        console.log(obj);
                        
//                     We take key-value coz it is Json
                        $.each(obj, function (key, value) {
                            $("#catname").append('<option name="' + value.categoryId + '"  value="' + value.categoryName + '">' + value.categoryName + '</option>');
                        });        
                        $("#catname").select();
                       
                    },
                    
                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#catname").append('<option>Category Unavailable</option>');
                    },
                    cache: false
                });
                
         });
                // Categories end

//-------------------------------------------------------------------------------------------------------------------------------------------------

                // When categories changes reset the rest of the options
                $("#catname").change(function () {
                    $("#couname").find('option').remove();
                    $("#couname").append('<option value="" disabled selected hidden>Select Course</option>'); 
                    $("#cyear").find('option').remove();
                    $("#cyear").append('<option value="" disabled selected hidden>Select Course Year</option>');
                    $("#sname").find('option').remove();
                    $("#sname").append('<option value="" disabled selected hidden>Select Subject </option>');

                    categoryName = $("#catname").val();
                    console.log("Selected category : "+categoryName);

                    let categoryid = $("#catname option:selected").attr("name");
                    console.log(categoryid);

                    // Courses start
                    $.ajax({
                        url: "GetCategoryCourseYearSubjectServlet",
                        method: "GET",
                        data: {
                        operation: 'course',
                        id: categoryid
                        },
                        
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            let obj = $.parseJSON(data);
                            console.log(obj);
                            $.each(obj, function (key, value) {
                                $('#couname').append('<option name="' + value.courseId + '"  value="' + value.courseName + '">' + value.courseName + '</option>');
                            });
                            $('select').click();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#couname').append('<option>Course Unavailable</option>');
                        },
                        cache: false
                    });
                });
                // Courses end
                
//-------------------------------------------------------------------------------------------------------------------------------------------------                
                
                // When courses changes reset the rest of the options
                $('#couname').change(function () {
                    $('#cyear').find('option').remove();
                    $('#cyear').append('<option value="" disabled selected hidden>Select Course Year</option>');
                    $('#sname').find('option').remove();
                    $('#sname').append('<option value="" disabled selected hidden>Select Subject</option>');

                    courseName = $("#couname").val();
                    console.log("Selected course : "+courseName);

                    let courseid = $("#couname option:selected").attr("name");

                    // Subject Year start
                    $.ajax({      
                        url: "GetCategoryCourseYearSubjectServlet",
                        method: "GET",
                        data: {
                        operation: "year",
                        id: courseid
                        },
                        
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            let obj = $.parseJSON(data);
                            console.log(obj);
                            $.each(obj, function (key, value) {               
                                $('#cyear').append('<option name="' + ++key + '"  value="' + value + '">' + value + '</option>');
                            });
                            $('select').click();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#cyear').append('<option>Year Unavailable</option>');
                        },
                        cache: false
                    });
                });
                // Subject Year end
                
//-------------------------------------------------------------------------------------------------------------------------------------------------

                // When course year changes reset the rest of the options
                    $('#cyear').change(function () {
                    $('#sname').find('option').remove();
                    $('#sname').append('<option value="" disabled selected hidden>Select Subject</option>');
                    
                    let courseid = $("#couname option:selected").attr("name");
                    courseYear = $("#cyear").val();
                    console.log("Selected courseYear : "+courseYear);
                    
                    // Subject start
                    $.ajax({      
                        url: "GetCategoryCourseYearSubjectServlet",
                        method: "GET",
                        data: {
                        operation: "subject",
                        id: courseid,
                        cyear: courseYear             
                        },
                        
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            let obj = $.parseJSON(data);
                            console.log(obj);
                            $.each(obj, function (key, value) {               
                                $("#sname").append('<option name="' + value.subjectId + '" value="' + value.subjectName + '">' + value.subjectName + '</option>');
                            });
                            $('select').click();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#sname").append('<option>Subject Unavailable</option>');
                        },
                        cache: false
                    });
                });
                // Subject end
                
//-------------------------------------------------------------------------------------------------------------------------------------------------

                // When subject changes 
                    $('#sname').change(function () {
                        
                    subjectName = $("#sname").val();
                    console.log("Selected subjectName : "+subjectName);
                
                    subjectid = $("#sname option:selected").attr("name");
                    console.log("Selected subjectId : "+subjectid);

                });
         
// -------------------------------------------------------------------------------------------------------------------------------------------------

function addNoteValidate()
{

    let nPrice = $("#addnotePrice").val();
    let nRazor = $("#addnoteRazor").val();
    
    if(nPrice>0 && nRazor =="")
    {
        document.getElementById("addnoteRazor").required = true;
        return false;
    }
    else
    {
        document.getElementById("addnoteRazor").required = false;
        return true;
        
    }

}


