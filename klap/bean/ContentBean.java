/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jk.klap.bean;

/**
 *
 * @author Mahadev
 */


public class ContentBean {
    private int contentId;
    private int categoryId;
    private String imagePath;
    private String textContent;
    private String volumeLevel;

    // Getters & Setters
    public int getContentId() {
        return contentId;
    }
    public void setContentId(int contentId) {
        this.contentId = contentId;
    }
    public int getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    public String getTextContent() {
        return textContent;
    }
    public void setTextContent(String textContent) {
        this.textContent = textContent;
    }
    public String getVolumeLevel() {
        return volumeLevel;
    }
    public void setVolumeLevel(String volumeLevel) {
        this.volumeLevel = volumeLevel;
    }

//    public void setCategoryName(String string) {
//        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
//    }
}
