/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author FAQIHAH
 */
public class Product {
    private String productName;
    private String brandName;
    private double matchPercentage;
    
    

    public Product(String productName, String brandName, double matchPercentage) {
        this.productName = productName;
        this.brandName = brandName;
        this.matchPercentage = matchPercentage;
    }

    public String getProductName() {
        return productName;
    }

    public String getBrandName() {
        return brandName;
    }

    public double getMatchPercentage() {
        return Math.round(matchPercentage); //untuk round off kan percentage
    }
}
