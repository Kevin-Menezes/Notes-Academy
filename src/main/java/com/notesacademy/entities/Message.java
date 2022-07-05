
package com.notesacademy.entities;

public class Message 
{
    private String content;
    private String type;
    private String cssClass;

    // Getter Setter
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCssClass() {
        return cssClass;
    }

    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }

    // Constructor
    public Message() {
    }

    public Message(String content, String type, String cssClass) {
        this.content = content;
        this.type = type;
        this.cssClass = cssClass;
    }

    @Override
    public String toString() {
        return "Message{" + "content=" + content + ", type=" + type + ", cssClass=" + cssClass + '}';
    }
    
    
}
