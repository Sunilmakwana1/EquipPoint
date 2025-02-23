package com.equip.point.model;

import java.time.LocalDateTime;

public class EmailLog {
    private int id;
    private String recipientEmail;
    private String subject;
    private String message;
    private String status; // sent, failed, pending
    private String errorMessage;
    private LocalDateTime createdAt;

    public EmailLog() {
        this.createdAt = LocalDateTime.now();
    }

    public EmailLog(int id, String recipientEmail, String subject, String message, String status, String errorMessage, LocalDateTime createdAt) {
        this.id = id;
        this.recipientEmail = recipientEmail;
        this.subject = subject;
        this.message = message;
        this.status = status;
        this.errorMessage = errorMessage;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRecipientEmail() {
        return recipientEmail;
    }

    public void setRecipientEmail(String recipientEmail) {
        this.recipientEmail = recipientEmail;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}

