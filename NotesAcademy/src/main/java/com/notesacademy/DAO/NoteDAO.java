
package com.notesacademy.DAO;

import com.notesacademy.entities.Note;
import java.util.List;

public interface NoteDAO 
{
    public List<Note> getNotes(int subjectId) ; // Fetching notes from the db
    
    public List<Note> getNotesBySearch(String ch); // Fetching notes according to search
    
    public boolean sendNotes(Note n); // User sends notes to tempnotes
    
    public int getNotesCount();
    
    public List<Note> approveNotes(); // Displays notes which are in tempnotes table
    
    public Note getTempNoteById(int id); // Get details of a particular note based on id 
    
    public boolean addNote(Note n); // Adding the note to the note table
    
    public boolean deleteTempNote(int id); // Deleting note from tempnotes table
    
    public Note getNoteById(int id); // Get details of main notes from note table based on noteid 
    
    public boolean updateEditNote(Note n); // Edits details of a particular note
    
    public boolean deleteNote(int id); // Delete note based on noteid
    
    public List<Note> getRecentNotes(int subjectId) ; // Fetching recent notes from the db based on a particular subject
    
    public List<Note> getAllNotes() ; // Fetching all notes from the db
    
    public List<Note> getRecentSearchNotes(String ch) ; // Fetching recent notes from the db based on a particular search
   
    public List<Note> getMostLikedNotes(int subjectId); // Fetching most liked notes from the db based on a particular subject
    
    public List<Note> getMostLikedSearchNotes(String ch) ; // Fetching most liked notes from the db based on a particular search
    
}
