/* Import user attributes */
package User;

import java.time.LocalDate;

public class User {

  private int idUser; // Unique identifier for the user

  private String name; 
  private String lastName;
  private String email;
  private String password;
  private String role; // e.g., "student", "docent", "admin"

  private LocalDate dateRegistration; // Date when the user registered

  public User(int idUser, String name, String lastName, String email, String password, String role, LocalDate dateRegistration) {
    this.idUser = idUser;
    this.name = name;
    this.lastName = lastName;
    this.email = email;
    this.password = password;
    this.role = role;
    this.dateRegistration = dateRegistration;
  }

    public User(String nombre, String parameter, String email, String passwordHash) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

  public boolean signUp(){
    return true;
  }

  public boolean signIn(){
    return true;
  }

  /* getters and setters */
  public void setUpdateProfile(String newName, String newLastName, String newEmail, String newPassword){
    this.name = newName;
    this.lastName = newLastName;
    this.email = newEmail;
    this.password = newPassword;
  }
  public String getInfoProfile(){
    return String.format(
      "Id User; %s,  Name: %s, Last Name: %s, Email: %s, Role: %s, Date of Registration: %s, Password: %s", 
      idUser, name, lastName, email, role, dateRegistration, password
    );
  }
}
