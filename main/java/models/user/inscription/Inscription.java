/* Import Inscription attributes */
package models.user.inscription;

import java.time.LocalDate;

public class Inscription {
  
  private String state; // e.g., "active", "completed", "cancelled"

  private double progress; // e.g., "50%"

  private LocalDate dateInscription; // Date of inscription

  private int idInscription; // Unique identifier for the inscription
  private int idUser; // Reference to the user's ID
  private int idCourse; // Reference to the course's ID

  public Inscription(int idInscription, int idUser, int idCourse, String state, double progress) {
      this.idInscription = idInscription;
      this.idUser = idUser;
      this.idCourse = idCourse;
      this.state = state;
      this.progress = progress;
  }

  public String getInscriptionDetails() {
    return String.format(
      "Inscription ID: %d, User ID: %d, Course ID: %d, State: %s, Progress: %.2f%%, Date: %s",
      idInscription, idUser, idCourse, state, progress, dateInscription.toString()
    );
  }
}
