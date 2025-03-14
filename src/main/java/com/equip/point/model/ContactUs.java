package com.equip.point.model;

import com.equip.point.util.EquipPointUtil;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import static com.equip.point.util.AppConstant.DD_MM_YYYY;

public class ContactUs {

    private Long id;

    private String fullName;

    private String email;

    private String subject;

    private String message;

    private Boolean approvedStatus = Boolean.FALSE;

    private Date approvedDate = new Date();

    private User approvedBy;

    private String replyMessage;

    private Date replyDate = new Date();

    private User repliedBy;

    private Boolean repliedStatus = Boolean.FALSE;

    private Boolean progressStatus = Boolean.FALSE;

    private ZonedDateTime createdDate = ZonedDateTime.now();

    private String createdDateStr;

    private Boolean isNotified = Boolean.FALSE;

    public ContactUs() {

    }

    public ContactUs(Long id, String fullName, String email, String subject, String message, Boolean approvedStatus, Date approvedDate, User approvedBy, String replyMessage, Date replyDate, User repliedBy, Boolean repliedStatus, Boolean progressStatus) {
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

    public Date getApprovedDate() {
        return approvedDate;
    }

    public void setApprovedDate(Date approvedDate) {
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

    public Date getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Date replyDate) {
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
        if (EquipPointUtil.isNotNull(createdDate)) {
            String format = createdDate.format(DateTimeFormatter.ofPattern(DD_MM_YYYY));
            this.createdDateStr = format;
        }
        this.createdDate = createdDate;
    }

    public String getCreatedDateStr() {
        return createdDateStr;
    }

    public void setCreatedDateStr(String createdDateStr) {
        this.createdDateStr = createdDateStr;
    }

    public Boolean getNotified() {
        return isNotified;
    }

    public void setNotified(Boolean notified) {
        isNotified = notified;
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
