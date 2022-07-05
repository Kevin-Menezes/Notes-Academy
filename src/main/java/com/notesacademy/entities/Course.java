
package com.notesacademy.entities;

public class Course 
{
    private int courseId;
    private String courseName;
    private int category_id;

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public Course() {
    }

    public Course(int courseId, String courseName, int category_id) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.category_id = category_id;
    }

    @Override
    public String toString() {
        return "Course{" + "courseId=" + courseId + ", courseName=" + courseName + ", category_id=" + category_id + '}';
    }
    
}
