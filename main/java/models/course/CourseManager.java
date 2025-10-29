package models.course;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class CourseManager {

  private List<Course> courses = new ArrayList<>();

  public void addCourse(Course course) {
      courses.add(course);
  }

  public boolean deleteCourseById(int idCourse) {
      Iterator<Course> iterator = courses.iterator();
      while (iterator.hasNext()) {
          Course course = iterator.next();
          if (course.getIdCourse() == idCourse) {
              iterator.remove();
              return true; // Deleted successfully
          }
      }
      return false; // Not found
  }

  // Optional: getter for courses
  public List<Course> getCourses() {
      return courses;
  }
}
