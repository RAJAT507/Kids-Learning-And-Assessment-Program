package com.jk.klap.bean;

import java.sql.Timestamp;

public class CategoryBean {
    private int categoryId;
    private String categoryName;
    private Timestamp createdAt;  // ✅ Added for created_at column

    // Getters & Setters
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Timestamp getCreatedAt() {   // ✅ Getter for createdAt
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {  // ✅ Setter for createdAt
        this.createdAt = createdAt;
    }
}
