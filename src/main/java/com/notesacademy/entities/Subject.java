
package com.notesacademy.entities;

public class Subject 
{
    private int subjectId;
    private String subjectName;
    private String subjectYear;
    private int course_id;

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getSubjectYear() {
        return subjectYear;
    }

    public void setSubjectYear(String subjectYear) {
        this.subjectYear = subjectYear;
    }

    public int getCourse_id() {
        return course_id;
    }

    public void setCourse_id(int course_id) {
        this.course_id = course_id;
    }

    public Subject() {
    }

    public Subject(int subjectId, String subjectName, String subjectYear, int course_id) {
        this.subjectId = subjectId;
        this.subjectName = subjectName;
        this.subjectYear = subjectYear;
        this.course_id = course_id;
    }

    @Override
    public String toString() {
        return "Subject{" + "subjectId=" + subjectId + ", subjectName=" + subjectName + ", subjectYear=" + subjectYear + ", course_id=" + course_id + '}';
    }
  
}
