
package com.notesacademy.DAO;


public interface ViewDAO 
{
    public boolean insertView(int noteId, int userId, int nuserId);
    
    public int countView(int noteId); 
    
    public boolean alreadyViewedByUser(int noteId , int userId); // To avoid view count to get incremented when user clicks on download many times
    
    public int getMostViewedNote(int subjectId); // Returns the most viewed number
    
    public int getMostViewedNoteSearch(String ch); // Returns the most viewed number search
    
}
