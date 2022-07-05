
package com.notesacademy.DAO;

import com.notesacademy.entities.Subject;
import java.util.List;

public interface SubjectDAO 
{
    public List<Subject> getFirstYearSubjects(int courseId);
    
    public List<Subject> getSecondYearSubjects(int courseId);
    
    public List<Subject> getThirdYearSubjects(int courseId);
    
    public List<Subject> getFourthYearSubjects(int courseId);
    
    public List<String> getNoOfYears(int courseId);
    
    public List<Subject> getSubjects(int courseId, String courseYear);
    
    public int getSubjectsCount();
    
     public Subject getSubjectById(int id); // To get a particular subject details based on the subject id 
     
     public boolean updateEditSubject(Subject c); // Updates the subject name  and subject year based on the subject id 
     
     public boolean deleteSubject(int id); // Delete subject based on the subject id
     
     public boolean insertSubject(Subject s);  // Inserts subject details in the db along with the course id as foreign key
    
}
