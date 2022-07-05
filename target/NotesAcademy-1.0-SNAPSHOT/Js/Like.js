// Likes
function doLike(noteId,userId,nuserId)
{
    console.log(noteId + " , " + userId)
    
// Creating variable and sending details to the servlet   
    const d = {
        noteId: noteId,
        userId: userId,
        nuserId: nuserId,
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

// Views
function doView(noteId,userId,nuserId)
{
    console.log(noteId + " , " + userId)
    
// Creating variable and sending details to the servlet   
    const d = {
        noteId: noteId,
        userId: userId,
        nuserId: nuserId,
        operation: 'view'
    }
    
//  Using ajax   
    $.ajax({
        url: "ViewServlet",
        data: d,
        
//     Success
        success: function (data, textStatus, jqXHR){
            console.log(data);
            
            //window.location.reload(); // This is for reloading the likes
           
        },
        
//      Error
        error: function (jqXHR, textStatus, errorThrown){
            console.log(data);
        }
    })
}

