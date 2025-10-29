package models.user.certification;

import java.time.LocalDate;

public class Certification {

  private int idUser; // Reference to the course's ID
  private int idInscription; // Reference to the user's ID
  private int idCertification; // Unique identifier for the certification
  private int codeVerification; // Unique code for verification

  private String courseName;
  private String userName;

  private LocalDate creationDate;

  public Certification(int idCertification, int idUser, int idInscription, int codeVerification, String courseName, String userName, LocalDate creationDate) {
      this.idCertification = idCertification;
      this.idUser = idUser;
      this.idInscription = idInscription;
      this.codeVerification = codeVerification;
      this.courseName = courseName;
      this.userName = userName;
      this.creationDate = creationDate;
  }

  // Getters and setters...
  public String getCertificationData(){
    return String.format(
			"Certification ID: %d, User ID: %d, Inscription ID: %d, Verification Code: %d, Course: %s, User: %s, Date: %s",
      idCertification, idUser, idInscription, codeVerification, courseName, userName, creationDate.toString()
		);
  }
}