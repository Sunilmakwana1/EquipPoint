package com.equip.point.model;

public class History {

    private Long id;
    private String tableName;
    private Long recordId;
    private String action;
    private String oldData;
    private String newData;
    private String status;
    private String performedBy;
    private String performedAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Long getRecordId() {
        return recordId;
    }

    public void setRecordId(Long recordId) {
        this.recordId = recordId;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getOldData() {
        return oldData;
    }

    public void setOldData(String oldData) {
        this.oldData = oldData;
    }

    public String getNewData() {
        return newData;
    }

    public void setNewData(String newData) {
        this.newData = newData;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPerformedBy() {
        return performedBy;
    }

    public void setPerformedBy(String performedBy) {
        this.performedBy = performedBy;
    }

    public String getPerformedAt() {
        return performedAt;
    }

    public void setPerformedAt(String performedAt) {
        this.performedAt = performedAt;
    }

    public History() {
    }

    public History(String tableName, Long id, Long recordId, String action, String oldData, String newData, String status, String performedBy, String performedAt) {
        this.tableName = tableName;
        this.id = id;
        this.recordId = recordId;
        this.action = action;
        this.oldData = oldData;
        this.newData = newData;
        this.status = status;
        this.performedBy = performedBy;
        this.performedAt = performedAt;
    }

    @Override
    public String toString() {
        return "History{" +
                "id=" + id +
                ", tableName='" + tableName + '\'' +
                ", recordId=" + recordId +
                ", action='" + action + '\'' +
                ", oldData='" + oldData + '\'' +
                ", newData='" + newData + '\'' +
                ", status='" + status + '\'' +
                ", performedBy='" + performedBy + '\'' +
                ", performedAt='" + performedAt + '\'' +
                '}';
    }


    @Override
    public int hashCode() {
        return super.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        return super.equals(obj);
    }
}
