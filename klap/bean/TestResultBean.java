/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jk.klap.bean;

/**
 *
 * @author Mahadev
 */

public class TestResultBean {
    private int parentId;
    private int categoryId;
    private int totalQuestions;
    private int correctAnswers;
    private double percentage;
    private int supercoinAdded;
    private String pdfPath;

    // Getters and Setters
    public int getParentId() { return parentId; }
    public void setParentId(int parentId) { this.parentId = parentId; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }

    public int getCorrectAnswers() { return correctAnswers; }
    public void setCorrectAnswers(int correctAnswers) { this.correctAnswers = correctAnswers; }

    public double getPercentage() { return percentage; }
    public void setPercentage(double percentage) { this.percentage = percentage; }

    public int getSupercoinAdded() { return supercoinAdded; }
    public void setSupercoinAdded(int supercoinAdded) { this.supercoinAdded = supercoinAdded; }

    public String getPdfPath() { return pdfPath; }
    public void setPdfPath(String pdfPath) { this.pdfPath = pdfPath; }
}
