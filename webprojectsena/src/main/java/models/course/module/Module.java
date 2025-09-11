/* Import module attributes */
package models.course.module;

public class Module {

  private int idCourse; // Unique identifier for the course
  private int idDocent;
  private int orderCourse; // Order of the course in a sequence

  private String nameCourse;

  public Module(int idCourse, int orderCourse, String nameCourse) {
    this.idCourse = idCourse;
    this.orderCourse = orderCourse;
    this.nameCourse = nameCourse;
  }

  // Getters and setters...
  public void setNameCourse(String newNameCourse) {
    this.nameCourse = newNameCourse;
  }
  public void getInfoModule(){
    System.out.println(String.format(
      "ID Course: %d, Name Course: %s, Order Course: %d, ID Docent: %d", 
      idCourse, nameCourse, orderCourse, idDocent
    ));
  }
}
