
package com.notesacademy.entities;


public class UserDetails 
{
    private int userId; // FIRST DECLARE ALL THE VARIABLES THEN U CAN AUTOMATICALLY GENERATE THE GETTER SETTER ...(RIGHT CLICK >> INSERT CODE) 
    private String userName;
    private String userPassword;
    private String userEmail; 
    private String userProfession;
    private String userCollege;

    // Getter Setter
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserProfession() {
        return userProfession;
    }

    public void setUserProfession(String userProfession) {
        this.userProfession = userProfession;
    }

    public String getUserCollege() {
        return userCollege;
    }

    public void setUserCollege(String userCollege) {
        this.userCollege = userCollege;
    }
    
    //Constructors

    public UserDetails() {
    }

    public UserDetails(int userId, String userName, String userPassword, String userEmail, String userProfession, String userCollege) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
    }

    // Constructor without userId
    public UserDetails(String userName, String userPassword, String userEmail, String userProfession, String userCollege) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
    }

    // To String
    @Override
    public String toString() {
        return "UserDetails{" + "userId=" + userId + ", userName=" + userName + ", userPassword=" + userPassword + ", userEmail=" + userEmail + ", userProfession=" + userProfession + ", userCollege=" + userCollege + '}';
    }
    
}
