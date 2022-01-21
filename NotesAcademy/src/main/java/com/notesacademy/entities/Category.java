
package com.notesacademy.entities;

import java.sql.Blob;

public class Category 
{
    private int categoryId;
    private String categoryName;
    private Blob categoryImg;
    private byte[] categoryImage;
    private String categoryImgString;

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

    public Blob getCategoryImg() {
        return categoryImg;
    }

    public void setCategoryImg(Blob categoryImg) {
        this.categoryImg = categoryImg;
    }

    public byte[] getCategoryImage() {
        return categoryImage;
    }

    public void setCategoryImage(byte[] categoryImage) {
        this.categoryImage = categoryImage;
    }

    public String getCategoryImgString() {
        return categoryImgString;
    }

    public void setCategoryImgString(String categoryImgString) {
        this.categoryImgString = categoryImgString;
    }

    public Category() {
    }

    public Category(int categoryId, String categoryName, Blob categoryImg, byte[] categoryImage, String categoryImgString) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryImg = categoryImg;
        this.categoryImage = categoryImage;
        this.categoryImgString = categoryImgString;
    }

    @Override
    public String toString() {
        return "Category{" + "categoryId=" + categoryId + ", categoryName=" + categoryName + ", categoryImg=" + categoryImg + ", categoryImage=" + categoryImage + ", categoryImgString=" + categoryImgString + '}';
    }

    
    
}
