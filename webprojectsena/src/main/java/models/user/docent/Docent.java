package models.user.docent;

import User.User;
import java.time.LocalDate;

public class Docent extends User {

  private int idDocent; // Unique identifier for the docent

  private String specialization; // Area of expertise
  private String bio; // Short biography of the docent

  /* Constructor */
  public Docent(int idUser, String name, String lastName, String email, String password, String role, LocalDate dateRegistration) {
    super(idUser, name, lastName, email, password, role, dateRegistration);
  }

  /* Getters and setters */
  public void setInfoDocent(String newBio, String newSpecialization){
    this.bio = newBio;
    this.specialization = newSpecialization;
  }
  public String getInfoDocent(){
    return String.format(
      "Name: %s, Last Name: %s, Email: %s, Role: %s, Date of Registration: %s, Specialization: %s, Bio: %s, ID Docent: %d", 
      super.getInfoProfile(), specialization, bio, idDocent
    );
  }
}
