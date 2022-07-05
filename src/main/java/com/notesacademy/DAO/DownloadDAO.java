
package com.notesacademy.DAO;


public interface DownloadDAO 
{
    public boolean insertDownload(int noteId, int userId, int nuserId);
    
    public int countDownload(int noteId); 
    
    public boolean alreadyDownloadedByUser(int noteId , int userId); // To avoid download count to get incremented when user clicks on download many times
    
    public int getMostDownloadedNote(int subjectId); // Returns the most downloaded number from that particular subject
    
    public int getMostDownloadedPaidNote(int subjectId); // Returns the most paid downloaded number from that particular subject
    
    public int getMostDownloadedNoteSearch(String ch); // Returns the most downloaded number from that searched string
    
    public int getMostDownloadedPaidNoteSearch(String ch); // Returns the most paid downloaded number from that searched string
    
}
