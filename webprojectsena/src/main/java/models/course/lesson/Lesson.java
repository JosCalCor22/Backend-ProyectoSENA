package models.course.lesson;
public class Lesson {
  private int idLesson; // Unique identifier for the lesson
  private int idModule; // Reference to the module's ID
  private int orderLesson; // Order of the lesson within the module

  private String title;
  private String content;
  private String typeContent;

  public Lesson(int idLesson, int idModule, int orderLesson, String title, String content, String typeContent) {
    this.idLesson = idLesson;
    this.idModule = idModule;
    this.orderLesson = orderLesson;
    this.title = title;
    this.content = content;
    this.typeContent = typeContent;
  }

  // Getters and setters...
  public void setLesson(String newTitle, String newContent, String newTypeContent) {
    this.title = newTitle;
    this.content = newContent;
    this.typeContent = newTypeContent;
  }
  public String getLesson(){
    return String.format(
      "Id Lesson: %s, Id Module: %s, Order Lesson: %s, Title: %s, Content: %s, Type: %s", 
      idLesson, idModule, orderLesson, title, content, typeContent
    );
  }
}
