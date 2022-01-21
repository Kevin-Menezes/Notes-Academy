package com.notesacademy.DAO;

import com.notesacademy.entities.Course;
import java.util.List;

public interface CourseDAO {

    public List<Course> getCourses(int categoryId); // To display a list of course names based on the respective category

    public int getCoursesCount();

    public Course getCourseById(int id); // To get a particular course details based on the course id

    public boolean updateEditCourse(Course c); // Updates the course name based on the course id

    public boolean deleteCourse(int id); // Deletes the course based on the course id 

    public boolean insertCourse(Course c); // Inserts course details in the db along with the category id as foreign key
}
