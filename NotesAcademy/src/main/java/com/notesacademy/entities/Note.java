
package com.notesacademy.entities;

public class Note 
{
    private int noteId;
    private String noteTitle;
    private String noteDescription;
    private String categoryName;
    private String courseName;
    private String subjectYear;
    private String subjectName;
    private String noteDate;
    private String userName;
    private String userProfession;
    private String userCollege;
    private String filePath;
    private int subject_id;

    public int getNoteId() {
        return noteId;
    }

    public void setNoteId(int noteId) {
        this.noteId = noteId;
    }

    public String getNoteTitle() {
        return noteTitle;
    }

    public void setNoteTitle(String noteTitle) {
        this.noteTitle = noteTitle;
    }

    public String getNoteDescription() {
        return noteDescription;
    }

    public void setNoteDescription(String noteDescription) {
        this.noteDescription = noteDescription;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getSubjectYear() {
        return subjectYear;
    }

    public void setSubjectYear(String subjectYear) {
        this.subjectYear = subjectYear;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getNoteDate() {
        return noteDate;
    }

    public void setNoteDate(String noteDate) {
        this.noteDate = noteDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserProfession() {
        return userProfession;
    }

    public void setUserProfession(String userProfession) {
        this.userProfession = userProfession;
    }

    public String getUserCollege() {
        return userCollege;
    }

    public void setUserCollege(String userCollege) {
        this.userCollege = userCollege;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public int getSubject_id() {
        return subject_id;
    }

    public void setSubject_id(int subject_id) {
        this.subject_id = subject_id;
    }

    public Note() {
    }

    public Note(int noteId, String noteTitle, String noteDescription, String categoryName, String courseName, String subjectYear, String subjectName, String noteDate, String userName, String userProfession, String userCollege, String filePath, int subject_id) {
        this.noteId = noteId;
        this.noteTitle = noteTitle;
        this.noteDescription = noteDescription;
        this.categoryName = categoryName;
        this.courseName = courseName;
        this.subjectYear = subjectYear;
        this.subjectName = subjectName;
        this.noteDate = noteDate;
        this.userName = userName;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
        this.filePath = filePath;
        this.subject_id = subject_id;
    }

//    Without id
    public Note(String noteTitle, String noteDescription, String categoryName, String courseName, String subjectYear, String subjectName, String noteDate, String userName, String userProfession, String userCollege, String filePath, int subject_id) {
        this.noteTitle = noteTitle;
        this.noteDescription = noteDescription;
        this.categoryName = categoryName;
        this.courseName = courseName;
        this.subjectYear = subjectYear;
        this.subjectName = subjectName;
        this.noteDate = noteDate;
        this.userName = userName;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
        this.filePath = filePath;
        this.subject_id = subject_id;
    }
    

    @Override
    public String toString() {
        return "Note{" + "noteId=" + noteId + ", noteTitle=" + noteTitle + ", noteDescription=" + noteDescription + ", categoryName=" + categoryName + ", courseName=" + courseName + ", subjectYear=" + subjectYear + ", subjectName=" + subjectName + ", noteDate=" + noteDate + ", userName=" + userName + ", userProfession=" + userProfession + ", userCollege=" + userCollege + ", filePath=" + filePath + ", subject_id=" + subject_id + '}';
    }
    
}
