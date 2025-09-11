/* Import course attributes */
package models.course;

import java.time.LocalDate;

public class Course {

  private int idCourse;
  private int hourseDuration; // Duration in hours
  private int idDocent; // Reference to the docent's ID

  private String title; // Course title
  private String status; // e.g., "active", "inactive"
  private String description; // Course description

  private LocalDate datePublication; // Date the course was published

  public Course(int idCourse, String title, int idDocent) {
      this.idCourse = idCourse;
      this.title = title;
      this.idDocent = idDocent;
  }

  // Getters and setters...
  public void setHoursDuration(int newHoursDuration, String newTitle, String newDescription) {
    this.hourseDuration = newHoursDuration;
    this.title = newTitle;
    this.description = newDescription;
  }
  public int getIdCourse() {
      return idCourse;
  }
  public void getInfoCourse(){
    System.out.println(String.format(
      "ID Course: %d, Title: %s, Description: %s, Hours Duration: %d, Status: %s, Date of Publication: %s, ID Docent: %d", 
      idCourse, title, description, hourseDuration, status, datePublication, idDocent
    ));
  }
  
}
