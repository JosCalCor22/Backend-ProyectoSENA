package models.exam.question;

public class Question {
  private int idQuestion;  // Unique identifier for the question
  private int idExam; // Reference to the exam's ID

  private String textQuestion;
  private String typeQuestion; // e.g., "multiple-choice", "true-false", "short-answer"
  private String questionCol;

  private double score; // Score assigned to the question

  public Question(int idQuestion, int idExam, String textQuestion, String typeQuestion, double score) {
    this.idQuestion = idQuestion;
    this.idExam = idExam;
    this.textQuestion = textQuestion;
    this.typeQuestion = typeQuestion;
    this.score = score;
  }

  /* Getters and setters */
  public void setQuestionDetails(String newTextQuestion, String newTypeQuestion, double newScore) {
    this.textQuestion = newTextQuestion;
    this.typeQuestion = newTypeQuestion;
    this.score = newScore;
  }
  public String getInfoQuestion() {
    return String.format(
      "ID: %d, Exam ID: %d, Text: %s, Type: %s, Score: %.2f, Question: %s",
      idQuestion, idExam, textQuestion, typeQuestion, score, questionCol
    );
  }
}
