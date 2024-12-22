package com.equip.point.util;

import java.time.ZonedDateTime;

public class CommonDateTimeAndDeleted {

    public ZonedDateTime createdAt;

    public ZonedDateTime updatedAt;

    public Boolean isDeleted;

    public ZonedDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(ZonedDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public ZonedDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(ZonedDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Boolean getDeleted() {
        return isDeleted;
    }

    public void setDeleted(Boolean deleted) {
        isDeleted = deleted;
    }

    public CommonDateTimeAndDeleted(ZonedDateTime createdAt, ZonedDateTime updatedAt, Boolean isDeleted) {
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isDeleted = isDeleted;
    }

    public CommonDateTimeAndDeleted() {
    }

    @Override
    public String toString() {
        return "CommonDateTimeAndDeleted{" +
                "createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", isDeleted=" + isDeleted +
                '}';
    }
}
