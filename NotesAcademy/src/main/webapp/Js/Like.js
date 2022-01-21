function doLike(noteId,userId)
{
    console.log(noteId + " , " + userId)
    
// Creating variable and sending details to the servlet   
    const d = {
        noteId: noteId,
        userId: userId,
        operation: 'like'
    }
    
//  Using ajax   
    $.ajax({
        url: "LikeServlet",
        data: d,
        
//     Success
        success: function (data, textStatus, jqXHR){
            console.log(data);
            
            window.location.reload(); // This is for reloading the likes
           
        },
        
//      Error
        error: function (jqXHR, textStatus, errorThrown){
            console.log(data);
        }
    })
}


