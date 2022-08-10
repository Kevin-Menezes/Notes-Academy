
package com.notesacademy.entities;


public class UserDetails 
{
    private int userId; // FIRST DECLARE ALL THE VARIABLES THEN U CAN AUTOMATICALLY GENERATE THE GETTER SETTER ...(RIGHT CLICK >> INSERT CODE) 
    private String userName;
    private String userPassword;
    private String userEmail; 
    private String userProfession;
    private String userCollege;
    private int userLikeCount;
    private int userDownloadCount;
    private int userViewCount;
    private int userRank;
    private String Role;

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

    public int getUserLikeCount() {
        return userLikeCount;
    }

    public void setUserLikeCount(int userLikeCount) {
        this.userLikeCount = userLikeCount;
    }

    public int getUserDownloadCount() {
        return userDownloadCount;
    }

    public void setUserDownloadCount(int userDownloadCount) {
        this.userDownloadCount = userDownloadCount;
    }

    public int getUserViewCount() {
        return userViewCount;
    }

    public void setUserViewCount(int userViewCount) {
        this.userViewCount = userViewCount;
    }

    public int getUserRank() {
        return userRank;
    }

    public void setUserRank(int userRank) {
        this.userRank = userRank;
    }

    public String getRole() {
        return Role;
    }

    public void setRole(String Role) {
        this.Role = Role;
    }
     
    //Constructors
    public UserDetails() {
    }

    public UserDetails(int userId, String userName, String userPassword, String userEmail, String userProfession, String userCollege, int userLikeCount) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
        this.userLikeCount = userLikeCount;
    }

      // All
    public UserDetails(int userId, String userName, String userPassword, String userEmail, String userProfession, String userCollege, int userLikeCount, int userDownloadCount, int userViewCount, int userRank,String Role) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
        this.userLikeCount = userLikeCount;
        this.userDownloadCount = userDownloadCount;
        this.userViewCount = userViewCount;
        this.userRank = userRank;
        this.Role = Role;
    }
    
    
    public UserDetails(int userId, String userName, String userPassword, String userEmail, String userProfession, String userCollege, int userLikeCount, int userDownloadCount, int userViewCount) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
        this.userLikeCount = userLikeCount;
        this.userDownloadCount = userDownloadCount;
        this.userViewCount = userViewCount;
    }
    
    // Without id and like count
    public UserDetails(String userName, String userPassword, String userEmail, String userProfession, String userCollege) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
    }

    public UserDetails(String userName, String userPassword, String userEmail, String userProfession, String userCollege, int userLikeCount) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
        this.userLikeCount = userLikeCount;
    }

    public UserDetails(String userName, String userPassword, String userEmail, String userProfession, String userCollege, int userLikeCount, int userDownloadCount, int userViewCount) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userProfession = userProfession;
        this.userCollege = userCollege;
        this.userLikeCount = userLikeCount;
        this.userDownloadCount = userDownloadCount;
        this.userViewCount = userViewCount;
    }
    
    // To String
    @Override
    public String toString() {
        return "UserDetails{" + "userId=" + userId + ", userName=" + userName + ", userPassword=" + userPassword + ", userEmail=" + userEmail + ", userProfession=" + userProfession + ", userCollege=" + userCollege + ", userLikeCount=" + userLikeCount + ", userDownloadCount=" + userDownloadCount + ", userViewCount=" + userViewCount + ", userRank=" + userRank + ", Role=" + Role + '}';
    }
           
}
