
package com.notesacademy.entities;

public class Feedback
{
    private int feedbackId;
    private String userName;
    private String userEmail;
    private String feedbackMessage;

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getFeedbackMessage() {
        return feedbackMessage;
    }

    public void setFeedbackMessage(String feedbackMessage) {
        this.feedbackMessage = feedbackMessage;
    }

    public Feedback() {
    }

    public Feedback(int feedbackId, String userName, String userEmail, String feedbackMessage) {
        this.feedbackId = feedbackId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.feedbackMessage = feedbackMessage;
    }

    // Without feedbackId
    public Feedback(String userName, String userEmail, String feedbackMessage) {
        this.userName = userName;
        this.userEmail = userEmail;
        this.feedbackMessage = feedbackMessage;
    }
    

    @Override
    public String toString() {
        return "Feedback{" + "feedbackId=" + feedbackId + ", userName=" + userName + ", userEmail=" + userEmail + ", feedbackMessage=" + feedbackMessage + '}';
    }
    
    
    
    
}
