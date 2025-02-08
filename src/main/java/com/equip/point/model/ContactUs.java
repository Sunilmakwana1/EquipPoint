package com.equip.point.model;

import java.time.ZonedDateTime;

public class ContactUs {

    private Long id;

    private String fullName;

    private String email;

    private String subject;

    private String message;

    private Boolean approvedStatus = Boolean.FALSE;

    private ZonedDateTime approvedDate = ZonedDateTime.now();

    private User approvedBy;

    private String replyMessage;

    private ZonedDateTime replyDate = ZonedDateTime.now();

    private User repliedBy;

    private Boolean repliedStatus = Boolean.FALSE;

    private Boolean progressStatus = Boolean.FALSE;

    private ZonedDateTime createdDate = ZonedDateTime.now();

    public ContactUs() {

    }

    public ContactUs(Long id, String fullName, String email, String subject, String message, Boolean approvedStatus, ZonedDateTime approvedDate, User approvedBy, String replyMessage, ZonedDateTime replyDate, User repliedBy, Boolean repliedStatus, Boolean progressStatus) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.subject = subject;
        this.message = message;
        this.approvedStatus = approvedStatus;
        this.approvedDate = approvedDate;
        this.approvedBy = approvedBy;
        this.replyMessage = replyMessage;
        this.replyDate = replyDate;
        this.repliedBy = repliedBy;
        this.repliedStatus = repliedStatus;
        this.progressStatus = progressStatus;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public Boolean getApprovedStatus() {
        return approvedStatus;
    }

    public void setApprovedStatus(Boolean approvedStatus) {
        this.approvedStatus = approvedStatus;
    }

    public ZonedDateTime getApprovedDate() {
        return approvedDate;
    }

    public void setApprovedDate(ZonedDateTime approvedDate) {
        this.approvedDate = approvedDate;
    }

    public User getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(User approvedBy) {
        this.approvedBy = approvedBy;
    }

    public String getReplyMessage() {
        return replyMessage;
    }

    public void setReplyMessage(String replyMessage) {
        this.replyMessage = replyMessage;
    }

    public ZonedDateTime getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(ZonedDateTime replyDate) {
        this.replyDate = replyDate;
    }

    public User getRepliedBy() {
        return repliedBy;
    }

    public void setRepliedBy(User repliedBy) {
        this.repliedBy = repliedBy;
    }

    public Boolean getRepliedStatus() {
        return repliedStatus;
    }

    public void setRepliedStatus(Boolean repliedStatus) {
        this.repliedStatus = repliedStatus;
    }

    public Boolean getProgressStatus() {
        return progressStatus;
    }

    public void setProgressStatus(Boolean progressStatus) {
        this.progressStatus = progressStatus;
    }

    public ZonedDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(ZonedDateTime createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "ContactUs{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", subject='" + subject + '\'' +
                ", message='" + message + '\'' +
                ", approvedStatus=" + approvedStatus +
                ", approvedDate=" + approvedDate +
                ", approvedBy=" + approvedBy +
                ", replyMessage='" + replyMessage + '\'' +
                ", replyDate=" + replyDate +
                ", repliedBy=" + repliedBy +
                ", repliedStatus=" + repliedStatus +
                ", progressStatus=" + progressStatus +
                ", createdDate=" + createdDate +
                '}';
    }
}
