package models.exam;

public class Exam {
  private int idExam; // Unique identifier for the exam
  private int idModule; // Reference to the course's ID
  private int minuteDuration; // Duration in minutes

  private String title;
  private String description;

  private double approveScore; // e.g., 70.0 for 70%

  public Exam(int idExam, int idModule, int minuteDuration, String title, String description, double approveScore) {
    this.idExam = idExam;
    this.idModule = idModule;
    this.minuteDuration = minuteDuration;
    this.title = title;
    this.description = description;
    this.approveScore = approveScore;
  }

  /* Getters and setters */
  public void setExamStructure(int newMinuteDuration, String newTitle, String newDescription, double newApproveScore) {
    this.minuteDuration = newMinuteDuration;
    this.title = newTitle;
    this.description = newDescription;
    this.approveScore = newApproveScore;
  }
  public String getInfoExam() {
    return String.format(
      "ID: %d, Module ID: %d, Duration: %d mins, Title: %s, Description: %s, Approve Score: %.2f%%",
      idExam, idModule, minuteDuration, title, description, approveScore
    );
  }
}
