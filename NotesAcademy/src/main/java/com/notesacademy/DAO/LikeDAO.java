
package com.notesacademy.DAO;


public interface LikeDAO 
{
    public boolean insertLike( int noteId , int userId, int nuserId ); // Clicking like button and inserting the note id and user id in db
    
    public int countLike(int noteId); // Getting number of likes on a particular note

    public boolean alreadyLikedByUser(int noteId , int userId); // To check the like button if user has already liked some note

    public boolean deleteLike(int noteId , int userId, int nuserId); // To delete the like from the db if the user unclicks the like button again
    
}
