package models.answer;

public class Answer {
  private int idAnswer;
  private int idQuestion;

  private String textAnswer;

  private boolean correctAnswer;

  public Answer(int idAnswer, int idQuestion, String textAnswer, boolean correctAnswer) {
    this.idAnswer = idAnswer;
    this.idQuestion = idQuestion;
    this.textAnswer = textAnswer;
    this.correctAnswer = correctAnswer;
  }

  /* Getters and setters */
  public void setAnswerDetails(String newTextAnswer) {
    this.textAnswer = newTextAnswer;
  }
  public String getAnswerExam() {
    return String.format(
      "ID: %d, Question ID: %d, Text: %s, Correct: %b",
      idAnswer, idQuestion, textAnswer, correctAnswer
    );
  }
}
